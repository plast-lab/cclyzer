#include <sstream>
#include <map>
#include <boost/algorithm/string.hpp>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Metadata.h>
#include "RefmodeEngineImpl.hpp"
#include "llvm_enums.hpp"

using cclyzer::RefmodeEngine;

using boost::algorithm::trim;
using llvm::cast;
using llvm::dyn_cast;
using llvm::isa;
using llvm::raw_string_ostream;
using std::string;

namespace enums = cclyzer::utils;


// Refmode for LLVM Values

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(const llvm::Value * Val) const
{
    string rv;
    raw_string_ostream rso(rv);

    if (Val->hasName()) {
        rso << (isa<llvm::GlobalValue>(Val) ? '@' : '%')
            << Val->getName();
        goto print;
    }

    if (isa<llvm::Constant>(Val)) {
        Val->printAsOperand(rso, /* PrintType */ false);
        goto print;
    }

    if (Val->getType()->isVoidTy()) {
        Val->printAsOperand(rso, /* PrintType */ false);
        goto print;
    }

    if (Val->getType()->isMetadataTy()) {
        const llvm::MetadataAsValue *mv = cast<llvm::MetadataAsValue>(Val);
        const llvm::Metadata *meta = mv->getMetadata();

        if (llvm::isa<llvm::MDNode>(meta)) {
            meta->printAsOperand(rso, *slotTracker);
        }
        else if (llvm::isa<llvm::MDString>(meta)) {
            meta->printAsOperand(rso, *slotTracker);
        }
        else {
            const llvm::ValueAsMetadata *v = cast<llvm::ValueAsMetadata>(meta);
            const llvm::Value *innerValue = v->getValue();
            const llvm::Type  *type = v->getType();

            if (llvm::isa<llvm::ConstantAsMetadata>(meta)) {
                meta->printAsOperand(rso, *slotTracker);
            }
            else {
                // For unknown reasons the printAsOperand() method is
                // super expensive for this particular metadata type,
                // at least for LLVM version 3.7.{0,1}. So instead, we
                // manually construct the refmodes ourselves.

                rso << refmodeOf(type) << " " << refmodeOf(innerValue);
            }
        }

        goto print;
    }

    // Handle unnamed variables
    {
        unsigned N = contexts.size();

        while (N > 0) {
            --N;
            RefContext &ctxt = const_cast<RefContext&>(contexts[N]);

            if (ctxt.isFunction) {

                if (ctxt.numbering.empty())
                    computeNumbering(
                        cast<llvm::Function>(ctxt.anchor), ctxt.numbering
                    );

                rso << '%' << ctxt.numbering[Val];
                goto print;
            }
        }
    }

    // Expensive
    Val->printAsOperand(rso, false, Mod);

print:
    // Trim external whitespace
    string ref = rso.str();
    trim(ref);

    return ref;
}


// Refmode for LLVM Functions

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfFunction(const llvm::Function * func, bool prefix) const
{
    string functionName = string(func->getName());

    if (!prefix)
        return functionName;

    std::ostringstream refmode;

    withGlobalContext(refmode) << functionName;
    return refmode.str();
}


cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfBasicBlock(const llvm::BasicBlock *bb, bool prefix) const
{
    string bbName = refmodeOf(bb);

    if (!prefix)
        return bbName;

    std::ostringstream refmode;

    withContext<llvm::Function>(refmode) << "[basicblock]" << bbName;
    return refmode.str();
}


cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfInstruction(const llvm::Instruction *instr, unsigned index) const
{
    std::ostringstream refmode;

    // BasicBlock context is intented so as not to qualify instruction
    // id by its surrounding basic block's id

    withContext<llvm::Function>(refmode) << std::to_string(index);
    return refmode.str();
}


cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfConstant(const llvm::Constant *c)
{
    std::ostringstream refmode;

    withContext<llvm::Instruction>(refmode)
        << constantIndex++ << ':' << refmodeOf(c);

    return refmode.str();
}


cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfLocalValue(const llvm::Value *val, bool prefix) const
{
    if (const llvm::BasicBlock *bb = dyn_cast<llvm::BasicBlock>(val))
        return refmodeOfBasicBlock(bb, prefix);

    refmode_t id = refmodeOf(val);

    if (!prefix)
        return id;

    std::ostringstream refmode;

    withContext<llvm::Function>(refmode) << id;
    return refmode.str();
}


cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOfGlobalValue(const llvm::GlobalValue *val, bool prefix) const
{
    string id = refmodeOf(val);

    if (!prefix)
        return id;

    std::ostringstream refmode;

    withGlobalContext(refmode) << id;
    return refmode.str();
}


void RefmodeEngine::Impl::computeNumbering(
    const llvm::Function *func, std::map<const llvm::Value*,unsigned> &numbering)
{
    unsigned counter = 0;

    // Arguments get the first numbers.
    for (llvm::Function::const_arg_iterator
             ai = func->arg_begin(), ae = func->arg_end(); ai != ae; ++ai)
    {
        if (!ai->hasName())
            numbering[&*ai] = counter++;
    }

    // Walk the basic blocks in order.
    for (llvm::Function::const_iterator
             fi = func->begin(), fe = func->end(); fi != fe; ++fi)
    {
        if (!fi->hasName())
            numbering[&*fi] = counter++;

        // Walk the instructions in order.
        for (llvm::BasicBlock::const_iterator
                 bi = fi->begin(), be = fi->end(); bi != be; ++bi)
        {
            // void instructions don't get numbers.
            if (!bi->hasName() && !bi->getType()->isVoidTy())
                numbering[&*bi] = counter++;
        }
    }

    assert(!numbering.empty() && "asked for numbering but numbering was no-op");
}


// Refmodes for LLVM Enums

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(llvm::GlobalValue::LinkageTypes LT) const {
    return enums::to_string(LT);
}

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const {
    return enums::to_string(Vis);
}

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const {
    return enums::to_string(TLM);
}

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(llvm::CallingConv::ID CC) const {
    return enums::to_string(CC);
}

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(llvm::AtomicOrdering AO) const {
    return enums::to_string(AO);
}


// Refmodes for LLVM Type

cclyzer::refmode_t
RefmodeEngine::Impl::refmodeOf(const llvm::Type *type) const
{
    string type_str;
    raw_string_ostream rso(type_str);

    if (type->isStructTy()) {
        const llvm::StructType *STy = cast<llvm::StructType>(type);

        if (STy->isLiteral()) {
            type->print(rso);
            return rso.str();
        }

        if (STy->hasName()) {
            rso << "%" << STy->getName();
            return rso.str();
        }
        rso << "%\"type " << STy << "\"";
    }
    else {
        type->print(rso);
    }
    return rso.str();
}
