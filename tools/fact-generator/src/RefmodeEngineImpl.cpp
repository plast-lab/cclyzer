#include <map>
#include <boost/algorithm/string.hpp>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Metadata.h>
#include "RefmodeEngineImpl.hpp"

using std::string;
using llvm::raw_string_ostream;
using llvm::cast;
using llvm::dyn_cast;
using llvm::isa;
using cclyzer::RefmodeEngine;
using cclyzer::refmode_t;

using boost::algorithm::trim;


// Refmode for LLVM Values

refmode_t
RefmodeEngine::Impl::refmodeOf(const llvm::Value * Val)
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

        appendMetadataId(rso, *meta);
        goto print;
    }

    // Handle unnamed variables
    for (ContextManager::reverse_iterator
             it = ctx->rbegin(); it != ctx->rend(); ++it)
    {
        ContextManager::context& ctxt = *it;

        if (ctxt.isFunction) {

            if (ctxt.numbering.empty())
                computeNumbering(
                    cast<llvm::Function>(ctxt.anchor), ctxt.numbering
                );

            rso << '%' << ctxt.numbering[Val];
            goto print;
        }
    }

    // Expensive
    Val->printAsOperand(rso, false, &ctx->module());

print:
    // Trim external whitespace
    string ref = rso.str();
    trim(ref);

    return ref;
}


void
RefmodeEngine::Impl::appendMetadataId(raw_string_ostream& rso, const llvm::Metadata& meta)
{
    if (llvm::isa<llvm::MDNode>(meta)) {
        meta.printAsOperand(rso, *slotTracker);
    }
    else if (llvm::isa<llvm::MDString>(meta)) {
        meta.printAsOperand(rso, *slotTracker);
    }
    else {
        const llvm::ValueAsMetadata& v = cast<llvm::ValueAsMetadata>(meta);
        const llvm::Value *innerValue = v.getValue();
        const llvm::Type  *type = v.getType();

        if (llvm::isa<llvm::ConstantAsMetadata>(meta)) {
            meta.printAsOperand(rso, *slotTracker);
        }
        else {
            // For unknown reasons the printAsOperand() method is
            // super expensive for this particular metadata type,
            // at least for LLVM version 3.7.{0,1}. So instead, we
            // manually construct the refmodes ourselves.

            rso << refmode<llvm::Type>(*type)
                << " " << refmodeOf(innerValue);
        }
    }
}

void
RefmodeEngine::Impl::computeNumbering(
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
