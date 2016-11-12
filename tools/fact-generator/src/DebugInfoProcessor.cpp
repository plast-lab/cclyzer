#include <llvm/IR/Module.h>
#include "DebugInfoProcessor.hpp"
#include "DebugInfoProcessorImpl.hpp"

using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;

//------------------------------------------------------------------------------
// Opaque Pointer Idiom - Delegate to Implementation instance
//------------------------------------------------------------------------------

DebugInfoProcessor::DebugInfoProcessor(FactWriter& writer, RefmodeEngine& engine)
    : impl(new Impl(writer, engine))
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

refmode_t
DebugInfoProcessor::record_di_file(const llvm::DIFile& difile) {
    return Impl::record_di_file::record(difile, *impl);
}

refmode_t
DebugInfoProcessor::record_di_namespace(const llvm::DINamespace& dinamespace) {
    return Impl::record_di_namespace::record(dinamespace, *impl);
}

refmode_t
DebugInfoProcessor::record_di_scope(const llvm::DIScope& discope) {
    return Impl::record_di_scope::record(discope, *impl);
}

refmode_t
DebugInfoProcessor::record_di_type(const llvm::DIType& ditype) {
    return Impl::record_di_type::record(ditype, *impl);
}

refmode_t
DebugInfoProcessor::record_di_template_param(const llvm::DITemplateParameter& diparam) {
    return Impl::record_di_template_param::record(diparam, *impl);
}

refmode_t
DebugInfoProcessor::record_di_variable(const llvm::DIVariable& divariable) {
    return Impl::record_di_variable::record(divariable, *impl);
}

refmode_t
DebugInfoProcessor::record_di_subprogram(const llvm::DISubprogram& disubprogram) {
    return Impl::record_di_subprogram::record(disubprogram, *impl);
}

refmode_t
DebugInfoProcessor::record_di_enumerator(const llvm::DIEnumerator& dienumerator) {
    return Impl::record_di_enumerator::record(dienumerator, *impl);
}

refmode_t
DebugInfoProcessor::record_di_subrange(const llvm::DISubrange& disubrange) {
    return Impl::record_di_subrange::record(disubrange, *impl);
}

refmode_t
DebugInfoProcessor::record_di_imported_entity(const llvm::DIImportedEntity& diimport) {
    return Impl::record_di_imported_entity::record(diimport, *impl);
}

refmode_t
DebugInfoProcessor::record_di_location(const llvm::DILocation& dilocation) {
    return Impl::record_di_location::record(dilocation, *impl);
}
