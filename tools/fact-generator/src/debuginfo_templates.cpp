#include "DebugInfoProcessorImpl.hpp"
#include "debuginfo_predicate_groups.hpp"


using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
using llvm::cast;
using llvm::dyn_cast;
using std::string;
namespace pred = cclyzer::predicates;
namespace dwarf = llvm::dwarf;



//----------------------------------------------------------------------------
// Process Debug Info Template Parameters
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_tpl_param::write(
    const llvm::DITemplateParameter& diparam, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::DITemplateTypeParameter;
    using llvm::DITemplateValueParameter;

    proc.writeFact(pred::di_template_param::id, nodeId);

    const std::string name = diparam.getName();
    const llvm::DITypeRef& type = diparam.getType();

    // Record template parameter name
    if (!name.empty())
        proc.writeFact(pred::di_template_param::name, nodeId, name);

    // Record template parameter type
    proc.recordUnionAttribute<pred::di_template_param::type, write_di_type>(
        nodeId, type);

    if (const auto *tparam = dyn_cast<DITemplateTypeParameter>(&diparam)) {
        write_di_tpl_type_param::write(*tparam, nodeId, proc);
    } else {
        const auto *vparam = cast<DITemplateValueParameter>(&diparam);
        write_di_tpl_value_param::write(*vparam, nodeId, proc);
    }
}

void
DebugInfoProcessor::Impl::write_di_tpl_type_param::write(
    const llvm::DITemplateTypeParameter& diparam, const refmode_t& nodeId, DIProc& proc)
{
    proc.writeFact(pred::di_template_type_param::id, nodeId);
}

void
DebugInfoProcessor::Impl::write_di_tpl_value_param::write(
    const llvm::DITemplateValueParameter& diparam, const refmode_t& nodeId, DIProc& proc)
{
    const llvm::Metadata *value = diparam.getValue();
    proc.writeFact(pred::di_template_value_param::id, nodeId);
}
