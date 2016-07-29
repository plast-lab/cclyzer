#include <boost/make_unique.hpp>
#include <llvm/IR/Module.h>
#include "DebugInfoProcessor.hpp"
#include "DebugInfoProcessorImpl.hpp"

using boost::make_unique;
using cclyzer::DebugInfoProcessor;

//------------------------------------------------------------------------------
// Opaque Pointer Idiom - Delegate to Implementation instance
//------------------------------------------------------------------------------

DebugInfoProcessor::DebugInfoProcessor(FactWriter& writer, RefmodeEngine& engine)
    : impl(make_unique<Impl>(writer, engine))
{}

DebugInfoProcessor::~DebugInfoProcessor()
{}

void
DebugInfoProcessor::processModule(const llvm::Module& mod)
{
    return impl->processModule(mod);
}

void
DebugInfoProcessor::processDeclare(const llvm::Module& mod, const llvm::DbgDeclareInst *instr)
{
    return impl->processDeclare(mod, instr);
}

void
DebugInfoProcessor::processValue(const llvm::Module& mod, const llvm::DbgValueInst *instr)
{
    return impl->processValue(mod, instr);
}

void
DebugInfoProcessor::reset()
{
    return impl->reset();
}

void
DebugInfoProcessor::generateDebugInfo(const llvm::Module& mod, const std::string& path)
{
    return impl->generateDebugInfo(mod, path);
}
