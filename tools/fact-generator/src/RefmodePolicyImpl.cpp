#include <sstream>
#include <map>
#include <boost/algorithm/string.hpp>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Metadata.h>
#include "RefmodePolicyImpl.hpp"

using std::string;
using namespace llvm;
using namespace boost::algorithm;


// Refmode for LLVM Values

refmode_t RefmodePolicy::Impl::refmodeOf(const Value * Val) const
{
    string rv;
    raw_string_ostream rso(rv);

    if (Val->hasName()) {
        rso << (isa<GlobalValue>(Val) ? '@' : '%')
            << Val->getName();
        goto print;
    }

    if (isa<Constant>(Val)) {
        Val->printAsOperand(rso, /* PrintType */ false);
        goto print;
    }

    if (Val->getType()->isVoidTy()) {
        Val->printAsOperand(rso, /* PrintType */ false);
        goto print;
    }

    if (Val->getType()->isMetadataTy()) {
        const MetadataAsValue *mv = cast<MetadataAsValue>(Val);
        const Metadata *meta = mv->getMetadata();
        meta->printAsOperand(rso, *slotTracker);

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
                    computeNumbering(cast<Function>(ctxt.anchor), ctxt.numbering);

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

refmode_t RefmodePolicy::Impl::refmodeOfFunction(const Function * func, bool prefix) const
{
    string functionName = string(func->getName());

    if (!prefix)
        return functionName;

    std::ostringstream refmode;

    withGlobalContext(refmode) << functionName;
    return refmode.str();
}


refmode_t RefmodePolicy::Impl::refmodeOfBasicBlock(const BasicBlock *bb, bool prefix) const
{
    string bbName = refmodeOf(bb);

    if (!prefix)
        return bbName;

    std::ostringstream refmode;

    withContext<Function>(refmode) << "[basicblock]" << bbName;
    return refmode.str();
}


refmode_t RefmodePolicy::Impl::refmodeOfInstruction(const Instruction *instr, unsigned index) const
{
    std::ostringstream refmode;

    // BasicBlock context is intented so as not to qualify instruction
    // id by its surrounding basic block's id

    withContext<Function>(refmode) << std::to_string(index);
    return refmode.str();
}


refmode_t RefmodePolicy::Impl::refmodeOfConstant(const llvm::Constant *c)
{
    std::ostringstream refmode;

    withContext<Instruction>(refmode)
        << constantIndex++ << ':' << refmodeOf(c);

    return refmode.str();
}


refmode_t RefmodePolicy::Impl::refmodeOfLocalValue(const llvm::Value *val, bool prefix) const
{
    if (const llvm::BasicBlock *bb = dyn_cast<llvm::BasicBlock>(val))
        return refmodeOfBasicBlock(bb, prefix);

    refmode_t id = refmodeOf(val);

    if (!prefix)
        return id;

    std::ostringstream refmode;

    withContext<Function>(refmode) << id;
    return refmode.str();
}


refmode_t RefmodePolicy::Impl::refmodeOfGlobalValue(const llvm::GlobalValue *val, bool prefix) const
{
    string id = refmodeOf(val);

    if (!prefix)
        return id;

    std::ostringstream refmode;

    withGlobalContext(refmode) << id;
    return refmode.str();
}


void RefmodePolicy::Impl::computeNumbering(
    const Function *func, std::map<const Value*,unsigned> &numbering)
{
    unsigned counter = 0;

    // Arguments get the first numbers.
    for (Function::const_arg_iterator
             ai = func->arg_begin(), ae = func->arg_end(); ai != ae; ++ai)
    {
        if (!ai->hasName())
            numbering[&*ai] = counter++;
    }

    // Walk the basic blocks in order.
    for (Function::const_iterator
             fi = func->begin(), fe = func->end(); fi != fe; ++fi)
    {
        if (!fi->hasName())
            numbering[&*fi] = counter++;

        // Walk the instructions in order.
        for (BasicBlock::const_iterator
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

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalValue::LinkageTypes LT) const {
    return enums::to_string(LT);
}

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalValue::VisibilityTypes Vis) const {
    return enums::to_string(Vis);
}

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalVariable::ThreadLocalMode TLM) const {
    return enums::to_string(TLM);
}

refmode_t RefmodePolicy::Impl::refmodeOf(CallingConv::ID CC) const {
    return enums::to_string(CC);
}

refmode_t RefmodePolicy::Impl::refmodeOf(AtomicOrdering AO) const {
    return enums::to_string(AO);
}


// Refmodes for LLVM Type

refmode_t RefmodePolicy::Impl::refmodeOf(const Type *type) const
{
    string type_str;
    raw_string_ostream rso(type_str);

    if (type->isStructTy()) {
        const StructType *STy = cast<StructType>(type);

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
