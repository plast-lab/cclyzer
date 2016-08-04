#include <llvm/ADT/SmallVector.h>
#include "DebugInfoProcessorImpl.hpp"
#include "debuginfo_predicate_groups.hpp"


using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
using llvm::cast;
using llvm::dyn_cast;
using llvm::SmallVector;
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
// Process Debug Info Subprograms
//----------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::write_di_subprogram::write(
    const llvm::DISubprogram& disubprogram, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::DINamespace;
    using llvm::DIFile;
    using llvm::DIType;

    proc.writeFact(pred::di_subprogram::id, nodeId);

    //-----------------------------------------------------------------
    // Record generic scope properties
    //-----------------------------------------------------------------

    const std::string name = disubprogram.getName();
    if (!name.empty())
        proc.writeFact(pred::di_subprogram::name, nodeId, name);

    // Record file information for namespace
    if (const llvm::DIFile *difile = disubprogram.getFile()) {
        refmode_t fileId = record_di_file::record(*difile, proc);
        proc.writeFact(pred::di_subprogram::file, nodeId, fileId);
    }

    // Record enclosing scope
    proc.recordUnionAttribute<pred::di_subprogram::scope, write_di_scope>(
        nodeId, disubprogram.getScope());

    //-----------------------------------------------------------------
    // Record subprogram-specific properties
    //-----------------------------------------------------------------

    // Record linkage name
    const std::string linkageName = disubprogram.getLinkageName();
    if (!linkageName.empty())
        proc.writeFact(pred::di_subprogram::linkage_name, nodeId, linkageName);

    // Record subprogram type
    if (const llvm::DIType *ditype = disubprogram.getType()) {
        refmode_t typeId = record_di_type::record(*ditype, proc);
        proc.writeFact(pred::di_subprogram::type, nodeId, typeId);
    }

    // Record lines
    const unsigned line = disubprogram.getLine();
    const unsigned scopeLine = disubprogram.getScopeLine();

    proc.writeFact(pred::di_subprogram::line, nodeId, line);
    proc.writeFact(pred::di_subprogram::scope_line, nodeId, scopeLine);

    // Record various flags
    if (disubprogram.isDefinition())
        proc.writeFact(pred::di_subprogram::is_definition, nodeId);

    if (disubprogram.isLocalToUnit())
        proc.writeFact(pred::di_subprogram::is_local_to_unit, nodeId);

    if (disubprogram.isOptimized())
        proc.writeFact(pred::di_subprogram::is_optimized, nodeId);

    // Record containing type
    proc.recordUnionAttribute<pred::di_subprogram::containing_type,
                              write_di_type>(
        nodeId, disubprogram.getContainingType());

    // Record declaration
    if (const llvm::DISubprogram *decl = disubprogram.getDeclaration()) {
        refmode_t declId = record_di_subprogram::record(*decl, proc);
        proc.writeFact(pred::di_subprogram::declaration, nodeId, declId);
    }

    // Record virtuality and virtual index
    if (unsigned virtuality = disubprogram.getVirtuality()) {
        const char *virtualityStr = llvm::dwarf::VirtualityString(virtuality);
        proc.writeFact(pred::di_subprogram::virtuality, nodeId, virtualityStr);

        unsigned virtIdx = disubprogram.getVirtualIndex();
        proc.writeFact(pred::di_subprogram::virtual_index, nodeId, virtIdx);
    }

    // Record flags
    if (unsigned flags = disubprogram.getFlags())
    {
        // Split flags inside vector
        typedef SmallVector<unsigned,8> FlagVectorT;
        FlagVectorT flagsVector;
        llvm::DINode::splitFlags(flags, flagsVector);

        for (FlagVectorT::iterator it = flagsVector.begin(),
                 end = flagsVector.end(); it != end; ++it )
        {
            const char *flag = llvm::DINode::getFlagString(*it);
            proc.writeFact(pred::di_subprogram::flag, nodeId, flag);
        }
    }

    // Record variables
    const auto& variables = disubprogram.getVariables();
    for (size_t i = 0; i < variables.size(); ++i) {
        // TODO this throws segfault
        // // Record variable
        // refmode_t varId = record_di_variable::record(*variables[i], proc);

        // // Record variable - subprogram association
        // proc.writeFact(pred::di_subprogram::variable, nodeId, i, varId);
    }

    // Record template parameters
    const auto& tplParams = disubprogram.getTemplateParams();
    for (size_t i = 0; i < tplParams.size(); ++i) {
        // Record template parameter
        refmode_t param =
            record_di_template_param::record(*tplParams[i], proc);

        // Record parameter - subprogram association
        proc.writeFact(pred::di_subprogram::template_param, nodeId, i, param);
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
    using llvm::DISubprogram;

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

    if (const DISubprogram *disp = dyn_cast<DISubprogram>(&discope)) {
        write_di_subprogram::write(*disp, nodeId, proc);
        return;
    }

}
