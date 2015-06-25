#include <boost/foreach.hpp>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>
#include <llvm/Support/CFG.h>
#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "TypeVisitor.hpp"
#include "TypeAccumulator.hpp"

#define foreach BOOST_FOREACH


using namespace llvm;
using namespace std;
using namespace boost;
namespace fs = boost::filesystem;
namespace pred = predicates;


void CsvGenerator::processModule(const Module * Mod, string& path)
{
    // Get data layout of this module
    std::string layoutRef = Mod->getDataLayout();
    DataLayout *layout = new DataLayout(layoutRef);

    // Cache the data layout so that it is available at the
    // postprocessing step of recording the encountered types

    layouts.insert(layout);

    InstructionVisitor IV(*this, Mod);

    // iterating over global variables in a module
    for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
        string refmode = getRefmodeForValue(Mod, gi, path);
        IV.visitGlobalVar(gi, refmode);
        types.insert(gi->getType());
    }

    // iterating over global alias in a module
    for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
        string refmode = getRefmodeForValue(Mod, ga, path);
        IV.visitGlobalAlias(ga, refmode);
        types.insert(ga->getType());
    }

    // iterating over functions in a module
    for (Module::const_iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
        string funcRef = "<" + path + ">:" + string(fi->getName());
        string instrId = funcRef + ":";
        IV.setInstrId(instrId);

        // Record function type
        types.insert(fi->getFunctionType());

        // Serialize function properties
        refmode_t visibility = refmodeOf(fi->getVisibility());
        refmode_t linkage = refmodeOf(fi->getLinkage());
        refmode_t typeSignature = refmodeOf(fi->getFunctionType());

        // Record function type signature
        writeFact(pred::function::type, funcRef, typeSignature);

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            writeFact(pred::function::linkage, funcRef, linkage);

        if (!visibility.empty())
            writeFact(pred::function::visibility, funcRef, visibility);

        if (fi->getAlignment())
            writeFact(pred::function::alignment, funcRef, fi->getAlignment());

        if (fi->hasGC())
            writeFact(pred::function::gc, funcRef, fi->getGC());

        // Record calling convection if it not defaults to C
        if (fi->getCallingConv() != CallingConv::C) {
            refmode_t cconv = refmodeOf(fi->getCallingConv());
            writeFact(pred::function::calling_conv, funcRef, cconv);
        }

        // Record function name
        writeFact(pred::function::name, funcRef, "@" + fi->getName().str());

        // Address not significant
        if (fi->hasUnnamedAddr())
            writeFact(pred::function::unnamed_addr, funcRef);

        // Record function attributes TODO
        const AttributeSet &Attrs = fi->getAttributes();

        if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
            writeFact(pred::function::ret_attr, funcRef,
                         Attrs.getAsString(AttributeSet::ReturnIndex));

        IV.writeFnAttributes(pred::function::attr, funcRef, Attrs);

        // Nothing more to do for function declarations
        if (fi->isDeclaration()) {
            writeFact(pred::function::id_decl, funcRef); // record function declaration
            continue;
        }

        // Record function definition entity
        writeFact(pred::function::id_defn, funcRef);

        // Record section
        if(fi->hasSection())
            writeFact(pred::function::section, funcRef, fi->getSection());

        // Record function parameters
        {
            int index = 0;

            for (Function::const_arg_iterator
                     arg = fi->arg_begin(), arg_end = fi->arg_end();
                 arg != arg_end; arg++)
            {
                string varId = instrId + refmodeOf(arg, Mod);

                writeFact(pred::function::param, funcRef, varId, index++);
                recordVariable(varId, arg->getType());
            }
        }

        int counter = 0;

        // iterating over basic blocks in a function
        //REVIEW: There must be a way to move this whole logic inside InstructionVisitor, i.e., visit(Module M)
        foreach (const llvm::BasicBlock &bb, *fi)
        {
            string funcPrefix = funcRef + ":";
            string bbRef = funcPrefix + refmodeOf(&bb, Mod);

            // Record basic block entry as a label
            writeFact(pred::variable::id, bbRef);
            writeFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            BasicBlock *tmpBB = const_cast<BasicBlock *>(&bb);

            for (pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                string predBB = funcPrefix + refmodeOf(*pi, Mod);
                writeFact(pred::basic_block::predecessor, bbRef, predBB);
            }

            // Store last instruction
            const llvm::Instruction &lastInstr = bb.back();

            // iterating over basic block instructions
            foreach (const llvm::Instruction &instr, bb)
            {
                // Compute instruction refmode
                string instrRef = instrId + std::to_string(counter++);

                // Record instruction target variable if such exists
                if (!instr.getType()->isVoidTy()) {
                    string targetVar = instrId + refmodeOf(&instr, Mod);

                    writeFact(pred::instruction::to, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    string nextInstrRef = instrId + std::to_string(counter);

                    // Record the instruction succession
                    writeFact(pred::instruction::next, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                writeFact(pred::instruction::function, instrRef, funcRef);

                // Record instruction's basic block entry (label)
                string bbEntry = instrId + refmodeOf(instr.getParent(), Mod);
                writeFact(pred::instruction::bb_entry, instrRef, bbEntry);

                // Instruction Visitor TODO
                IV.setInstrNum(instrRef);

                // Visit instruction
                IV.visit(const_cast<llvm::Instruction &>(instr));
            }
        }
    }
}


void CsvGenerator::writeVarsTypesAndImmediates()
{
    using llvm_extra::TypeAccumulator;
    using boost::unordered_set;

    // Record every constant encountered so far
    foreach (type_cache_t::value_type kv, constantTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record constant entity with its type
        writeFact(pred::constant::id, refmode);
        writeFact(pred::constant::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record variable entity with its type
        writeFact(pred::variable::id, refmode);
        writeFact(pred::variable::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Type accumulator that identifies simple types from complex ones
    TypeAccumulator<unordered_set<const llvm::Type *> > collector;

    // Set of all encountered types
    unordered_set<const llvm::Type *> collectedTypes = collector(types);

    // Add basic primitive types
    writeFact(pred::primitive_type::id, "void");
    writeFact(pred::primitive_type::id, "label");
    writeFact(pred::primitive_type::id, "metadata");
    writeFact(pred::primitive_type::id, "x86mmx");

    // Create type visitor
    TypeVisitor TV(*this);

    // Record each type encountered
    foreach (const Type *type, collectedTypes)
       TV.visitType(type);
}
