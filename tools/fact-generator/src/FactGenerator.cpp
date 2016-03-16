#include <algorithm>
#include <string>
#include <boost/foreach.hpp>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>
#include <llvm/IR/CFG.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "TypeVisitor.hpp"
#include "TypeAccumulator.hpp"

#define foreach BOOST_FOREACH


using cclyzer::FactGenerator;
using llvm::cast;
using llvm::isa;
namespace pred = cclyzer::predicates;


void
FactGenerator::processModule(const llvm::Module &Mod, const std::string& path)
{
    InstructionVisitor IV(*this, Mod);
    ModuleContext MC(*this, Mod, path);

    llvm::SmallVector<std::pair<unsigned, llvm::MDNode*>, 4> MDForInst;

    // iterate over named metadata
    for (llvm::Module::const_named_metadata_iterator
             it  = Mod.named_metadata_begin(),
             end = Mod.named_metadata_end(); it != end; ++it)
    {
        visitNamedMDNode(it);
    }

    // iterating over global variables in a module
    for (llvm::Module::const_global_iterator
             it = Mod.global_begin(), end = Mod.global_end(); it != end; ++it)
    {
        refmode_t refmode = refmodeOfGlobalValue(it);
        visitGlobalVar(it, refmode);
        types.insert(it->getType());
    }

    // iterating over global alias in a module
    for (llvm::Module::const_alias_iterator
             it = Mod.alias_begin(), end = Mod.alias_end(); it != end; ++it)
    {
        refmode_t refmode = refmodeOfGlobalValue(it);
        visitGlobalAlias(it, refmode);
        types.insert(it->getType());
    }

    // iterating over functions in a module
    for (llvm::Module::const_iterator
             it = Mod.begin(), end = Mod.end(); it != end; ++it)
    {
        const llvm::Function &func = *it;

        Context C(*this, func);
        refmode_t funcref = refmodeOfFunction(it);

        // Record function type
        types.insert(func.getFunctionType());

        // Serialize function properties
        refmode_t visibility = refmodeOf(func.getVisibility());
        refmode_t linkage = refmodeOf(func.getLinkage());
        refmode_t typeSignature = refmodeOf(func.getFunctionType());

        // Record function type signature
        writeFact(pred::function::type, funcref, typeSignature);

        // Record function signature (name plus type signature) after
        // unmangling
        writeFact(pred::function::signature, funcref, demangle(func.getName().data()));

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            writeFact(pred::function::linkage, funcref, linkage);

        if (!visibility.empty())
            writeFact(pred::function::visibility, funcref, visibility);

        if (func.getAlignment())
            writeFact(pred::function::alignment, funcref, func.getAlignment());

        if (func.hasGC())
            writeFact(pred::function::gc, funcref, func.getGC());

        if (func.hasPersonalityFn()) {
            llvm::Constant *pers_fn = func.getPersonalityFn();
            refmode_t pers_fn_ref = writeConstant(*pers_fn);

            writeFact(pred::function::pers_fn, funcref, pers_fn_ref);
        }

        // Record calling convection if it not defaults to C
        if (func.getCallingConv() != llvm::CallingConv::C) {
            refmode_t cconv = refmodeOf(func.getCallingConv());
            writeFact(pred::function::calling_conv, funcref, cconv);
        }

        // Record function name TODO
        writeFact(pred::function::name, funcref, "@" + func.getName().str());

        // Address not significant
        if (func.hasUnnamedAddr())
            writeFact(pred::function::unnamed_addr, funcref);

        // Record function attributes TODO
        const llvm::AttributeSet &Attrs = func.getAttributes();

        if (Attrs.hasAttributes(llvm::AttributeSet::ReturnIndex))
            writeFact(pred::function::ret_attr, funcref,
                      Attrs.getAsString(llvm::AttributeSet::ReturnIndex));

        writeFnAttributes<pred::function>(funcref, Attrs);

        // Nothing more to do for function declarations
        if (func.isDeclaration()) {
            writeFact(pred::function::id_decl, funcref); // record function declaration
            continue;
        }

        // Record function definition entity
        writeFact(pred::function::id_defn, funcref);

        // Record section
        if(func.hasSection())
            writeFact(pred::function::section, funcref, func.getSection());

        // Record function parameters
        {
            int index = 0;

            for (llvm::Function::const_arg_iterator
                     arg = func.arg_begin(), arg_end = func.arg_end();
                 arg != arg_end; arg++)
            {
                refmode_t varId = refmodeOfLocalValue(arg);

                writeFact(pred::function::param, funcref, index++, varId);
                recordVariable(varId, arg->getType());
            }
        }

        int counter = 0;

        // iterating over basic blocks in a function
        foreach (const llvm::BasicBlock &bb, func)
        {
            Context C(*this, bb);
            refmode_t bbRef = refmodeOfBasicBlock(&bb);

            // Record basic block entry as a label
            writeFact(pred::variable::id, bbRef);
            writeFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            llvm::BasicBlock *tmpBB = const_cast<llvm::BasicBlock *>(&bb);

            for (llvm::pred_iterator
                     pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                refmode_t predBB = refmodeOfBasicBlock(*pi);
                writeFact(pred::basic_block::predecessor, bbRef, predBB);
            }

            // Store last instruction
            const llvm::Instruction &lastInstr = bb.back();

            // iterating over basic block instructions
            foreach (const llvm::Instruction &instr, bb)
            {
                Context C(*this, instr);

                // Compute instruction refmode
                refmode_t instrRef = refmodeOfInstruction(&instr, counter++);

                // Record instruction target variable if such exists
                if (!instr.getType()->isVoidTy()) {
                    refmode_t targetVar = refmodeOfLocalValue(&instr);

                    writeFact(pred::instruction::to, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    refmode_t nextInstrRef = refmodeOfInstruction(nullptr, counter);

                    // Record the instruction succession
                    writeFact(pred::instruction::next, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                writeFact(pred::instruction::function, instrRef, funcref);

                // Record instruction's basic block entry (label)
                refmode_t bbEntry = refmodeOfBasicBlock(instr.getParent());
                writeFact(pred::instruction::bb_entry, instrRef, bbEntry);

                // Visit instruction
                IV.visit(const_cast<llvm::Instruction &>(instr));

                // Process metadata attached with this instruction.
                instr.getAllMetadata(MDForInst);
                for (unsigned i = 0, e = MDForInst.size(); i != e; ++i) {
                    const llvm::MDNode &mdNode = *MDForInst[i].second;

                    // TODO process metadata node
                    // Get debug location if available
                    if (const llvm::DebugLoc &location = instr.getDebugLoc()) {
                        unsigned line = location.getLine();
                        unsigned column = location.getCol();

                        writeFact(pred::instruction::pos, instrRef, line, column);
                    }
                }

                MDForInst.clear();

            }
        }
    }

    // Process any existing debug information
    debugInfoProcessor.postProcess(Mod, path);
}


template<typename PredGroup>
void FactGenerator::writeFnAttributes(
    const refmode_t &refmode,
    const llvm::AttributeSet allAttrs)
{
    using llvm::AttributeSet;

    for (unsigned i = 0; i < allAttrs.getNumSlots(); ++i)
    {
        unsigned index = allAttrs.getSlotIndex(i);

        // Write out each attribute for this slot
        for (AttributeSet::iterator
                 it = allAttrs.begin(i), end = allAttrs.end(i);
             it != end; ++it)
        {
            std::string attr = it->getAsString();
            attr.erase (std::remove(attr.begin(), attr.end(), '"'), attr.end());

            switch (index) {
              case AttributeSet::AttrIndex::ReturnIndex:
                  writeFact(PredGroup::ret_attr, refmode, attr);
                  break;
              case AttributeSet::AttrIndex::FunctionIndex:
                  writeFact(PredGroup::fn_attr, refmode, attr);
                  break;
              default:
                  writeFact(PredGroup::param_attr, refmode, i, attr);
                  break;
            }
        }
    }
}

// Instantiate template method

template void FactGenerator::writeFnAttributes<pred::function>(
    const refmode_t &refmode,
    const llvm::AttributeSet Attrs);

template void FactGenerator::writeFnAttributes<pred::call>(
    const refmode_t &refmode,
    const llvm::AttributeSet Attrs);

template void FactGenerator::writeFnAttributes<pred::invoke>(
    const refmode_t &refmode,
    const llvm::AttributeSet Attrs);


void
FactGenerator::writeVarsTypesAndConstants(const llvm::DataLayout &layout)
{
    using llvm_utils::TypeAccumulator;

    // Record every constant encountered so far
    foreach (type_cache_t::value_type kv, constantTypes) {
        refmode_t refmode = kv.first;
        const llvm::Type *type = kv.second;

        // Record constant entity with its type
        writeFact(pred::constant::id, refmode);
        writeFact(pred::constant::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        refmode_t refmode = kv.first;
        const llvm::Type *type = kv.second;

        // Record variable entity with its type
        writeFact(pred::variable::id, refmode);
        writeFact(pred::variable::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Add basic primitive types
    writeFact(pred::primitive_type::id, "void");
    writeFact(pred::primitive_type::id, "label");
    writeFact(pred::primitive_type::id, "metadata");
    writeFact(pred::primitive_type::id, "x86mmx");

    // Find types contained in the types encountered so far, but not
    // referenced directly

    TypeAccumulator alltypes;
    alltypes.accumulate(types.begin(), types.end());

    // Create type visitor
    TypeVisitor TV(*this, layout);

    // Record each type encountered
    for(TypeAccumulator::const_iterator
            it = alltypes.begin(), end = alltypes.end(); it != end; ++it)
    {
        TV.visitType(*it);
    }
}


void
FactGenerator::visitNamedMDNode(const llvm::NamedMDNode *NMD)
{
    for (unsigned i = 0, e = NMD->getNumOperands(); i != e; ++i) {
        // TODO
        ;
    }
}
