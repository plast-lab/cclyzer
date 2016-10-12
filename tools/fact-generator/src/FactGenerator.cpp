#include <string>
#include <boost/foreach.hpp>
#include <llvm/IR/Constants.h>
#include <llvm/IR/CFG.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"
#include "InstructionVisitor.hpp"

#define foreach BOOST_FOREACH


using cclyzer::FactGenerator;
using llvm::cast;
using llvm::isa;
namespace pred = cclyzer::predicates;


FactGenerator&
FactGenerator::getInstance(FactWriter & writer) {
    static FactGenerator thisInstance(writer);
    return thisInstance;
}


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
        visitNamedMDNode(*it);
    }

    // iterating over global variables in a module
    for (llvm::Module::const_global_iterator
             it = Mod.global_begin(), end = Mod.global_end(); it != end; ++it)
    {
        refmode_t id = refmode<llvm::GlobalValue>(*it);

        writeGlobalVar(*it, id);
    }

    // iterating over global alias in a module
    for (llvm::Module::const_alias_iterator
             it = Mod.alias_begin(), end = Mod.alias_end(); it != end; ++it)
    {
        refmode_t id = refmode<llvm::GlobalValue>(*it);

        writeGlobalAlias(*it, id);
    }

    // iterating over functions in a module
    for (llvm::Module::const_iterator
             it = Mod.begin(), end = Mod.end(); it != end; ++it)
    {
        const llvm::Function &func = *it;

        Context C(*this, func);
        refmode_t funcref = refmode<llvm::Function>(*it);

        // Process function and record its various attributes, but do
        // not examine its body
        writeFunction(func, funcref);

        // Previous instruction
        const llvm::Instruction *prev_instr = nullptr;
        refmode_t prev_iref;

        // iterating over basic blocks in a function
        foreach (const llvm::BasicBlock &bb, func)
        {
            Context C(*this, bb);
            refmode_t bbRef = refmode<llvm::BasicBlock>(bb);

            // Record basic block entry as a label
            writeFact(pred::variable::id, bbRef);
            writeFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            for (llvm::const_pred_iterator
                     pi = pred_begin(&bb), pi_end = pred_end(&bb);
                 pi != pi_end; ++pi)
            {
                refmode_t predBB = refmode<llvm::BasicBlock>(**pi);
                writeFact(pred::basic_block::predecessor, bbRef, predBB);
            }

            // iterating over basic block instructions
            foreach (const llvm::Instruction &instr, bb)
            {
                Context C(*this, instr);

                // Compute instruction refmode
                const refmode_t iref = refmode<llvm::Instruction>(instr);

                // Record instruction target variable if such exists
                if (!instr.getType()->isVoidTy()) {
                    refmode_t targetVar = refmode<llvm::Value>(instr);

                    writeFact(pred::instruction::to, iref, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (prev_instr)
                    writeFact(pred::instruction::next, prev_iref, iref);

                // Store the refmode of this instruction for next iteration
                prev_iref = iref;
                prev_instr = &instr;

                // Record instruction's container function
                writeFact(pred::instruction::function, iref, funcref);

                // Record instruction's basic block entry (label)
                const llvm::BasicBlock *bbEntry = instr.getParent();
                refmode_t bbEntryId = refmode<llvm::BasicBlock>(*bbEntry);
                writeFact(pred::instruction::bb_entry, iref, bbEntryId);

                // Visit instruction
                IV.visit(const_cast<llvm::Instruction &>(instr));

                // Process metadata attached with this instruction.
                instr.getAllMetadata(MDForInst);
                for (unsigned i = 0, e = MDForInst.size(); i != e; ++i) {
                    const llvm::MDNode &mdNode = *MDForInst[i].second;

                    // TODO process metadata node
                    // Get debug location if available
                    if (const llvm::DebugLoc& location = instr.getDebugLoc()) {
                        unsigned line = location.getLine();
                        unsigned column = location.getCol();

                        writeFact(pred::instruction::pos, iref, line, column);

                        refmode_t locref =
                            debugInfoProcessor.record_di_location(*location);

                        writeFact(pred::instruction::location, iref, locref);
                    }
                }

                MDForInst.clear();

            }
        }
    }

    // Process any existing debug information
    debugInfoProcessor.generateDebugInfo(Mod, path);
}


void
FactGenerator::visitNamedMDNode(const llvm::NamedMDNode& metadata)
{
    for (unsigned i = 0, e = metadata.getNumOperands(); i != e; ++i) {
        // TODO
        ;
    }
}
