#include "DebugInfoProcessorImpl.hpp"
#include "debuginfo_predicate_groups.hpp"


using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
using llvm::cast;
using llvm::dyn_cast;
using std::string;
namespace pred = cclyzer::predicates;


//----------------------------------------------------------------------------
// Process Debug Info Files
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_file::write(
    const llvm::DIFile& difile, const refmode_t& nodeId, DIProc& proc)
{
    string filename = difile.getFilename();
    string directory = difile.getDirectory();

    proc.writeFact(pred::di_file::id, nodeId);
    proc.writeFact(pred::di_file::filename, nodeId, filename);
    proc.writeFact(pred::di_file::directory, nodeId, directory);
}


//----------------------------------------------------------------------------
// Process Debug Info Namespaces
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_namespace::write(
    const llvm::DINamespace& dinamespace, const refmode_t& nodeId, DIProc& proc)
{
    const string name = dinamespace.getName();
    const unsigned line = dinamespace.getLine();

    proc.writeFact(pred::di_namespace::id, nodeId);
    proc.writeFact(pred::di_namespace::name, nodeId, name);
    proc.writeFact(pred::di_namespace::line, nodeId, line);

    // Record file information for namespace
    if (const llvm::DIFile *difile = dinamespace.getFile()) {
        refmode_t fileId = record_di_file::record(*difile, proc);
        proc.writeFact(pred::di_namespace::file, nodeId, fileId);
    }

    // Record enclosing scope
    if (const llvm::DIScope *discope = dinamespace.getScope()) {
        refmode_t scopeId = record_di_scope::record(*discope, proc);
        proc.writeFact(pred::di_namespace::scope, nodeId, scopeId);
    }
}


//----------------------------------------------------------------------------
// Process Debug Info Scopes
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_scope::write(
    const llvm::DIScope& discope, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::DINamespace;
    using llvm::DIFile;
    using llvm::DIType;

    if (const DINamespace *dins = dyn_cast<DINamespace>(&discope)) {
        write_di_namespace::write(*dins, nodeId, proc);
        return;
    }

    if (const DIFile *difile = dyn_cast<DIFile>(&discope)) {
        write_di_file::write(*difile, nodeId, proc);
        return;
    }

    if (const DIType *ditype = dyn_cast<DIType>(&discope)) {
        write_di_type::write(*ditype, nodeId, proc);
        return;
    }
}
