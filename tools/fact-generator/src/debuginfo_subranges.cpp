#include "DebugInfoProcessorImpl.hpp"
#include "debuginfo_predicate_groups.hpp"


using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
namespace pred = cclyzer::predicates;

//----------------------------------------------------------------------------
// Process Debug Info Subranges
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_subrange::write(
    const llvm::DISubrange& disubrange, const refmode_t& nodeId, DIProc& proc)
{
    proc.writeFact(pred::di_subrange::id, nodeId);

    const int64_t count = disubrange.getCount();
    const int64_t lowerBound = disubrange.getLowerBound();

    proc.writeFact(pred::di_subrange::count, nodeId, count);

    if (lowerBound)
        proc.writeFact(pred::di_subrange::lower_bound, nodeId, lowerBound);
}
