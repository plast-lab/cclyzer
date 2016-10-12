#include <list>
#include <map>
#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include "DebugInfoProcessorImpl.hpp"
#include "predicate_groups.hpp"
#include "debuginfo_predicate_groups.hpp"

using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
using llvm::cast;
using llvm::dyn_cast;
using llvm::raw_string_ostream;
using std::list;
using std::string;
namespace pred = cclyzer::predicates;
namespace dwarf = llvm::dwarf;


//------------------------------------------------------------------------------
// Actual Implementation
//------------------------------------------------------------------------------

void
DebugInfoProcessor::Impl::generateDebugInfo(
    const llvm::Module &m, const string &path)
{
    using llvm::DICompositeType;
    using llvm::DIDerivedType;
    using llvm::DIScopeRef;
    using llvm::MDString;
    using llvm::Metadata;
    typedef llvm::DebugInfoFinder::type_iterator di_type_iterator;
    typedef llvm::DebugInfoFinder::scope_iterator di_scope_iterator;
    typedef llvm::DebugInfoFinder::subprogram_iterator di_subprogram_iterator;
    typedef llvm::DebugInfoFinder::global_variable_iterator di_global_var_iterator;
    typedef llvm::DebugInfoFinder::compile_unit_iterator di_comp_unit_iterator;

    // Get global variable iterator
    llvm::iterator_range<di_global_var_iterator> allVars =
        debugInfoFinder.global_variables();

    // iterate over global variables
    for (di_global_var_iterator iVar = allVars.begin(), E = allVars.end();
         iVar != E; ++iVar)
    {
        const llvm::DIGlobalVariable &divar = **iVar;
        record_di_variable::record(divar, *this);
    }

    // Get subprogram iterator
    llvm::iterator_range<di_subprogram_iterator> subprograms =
        debugInfoFinder.subprograms();

    // iterate over subprogram and record each one
    for (di_subprogram_iterator it = subprograms.begin(),
             end = subprograms.end(); it != end; ++it )
    {
        const llvm::DISubprogram& subprogram = **it;
        record_di_subprogram::record(subprogram, *this);
    }

    // Get scope iterator
    llvm::iterator_range<di_scope_iterator> scopes =
        debugInfoFinder.scopes();

    // iterate over subprogram and record each one
    for (di_scope_iterator it = scopes.begin(),
             end = scopes.end(); it != end; ++it )
    {
        const llvm::DIScope& scope = **it;
        record_di_scope::record(scope, *this);
    }

    // Get compile unit iterator
    llvm::iterator_range<di_comp_unit_iterator> compunits =
        debugInfoFinder.compile_units();

    // iterate over compile unit and record each one
    for (di_comp_unit_iterator it = compunits.begin(),
             end = compunits.end(); it != end; ++it )
    {
        const llvm::DICompileUnit& compUnit = **it;

        // iterate over imported entities
        auto importedEntities = compUnit.getImportedEntities();

        // record each imported entity entry
        for (unsigned i = 0; i < importedEntities.size(); ++i) {
            const llvm::DIImportedEntity& diimport = *importedEntities[i];
            record_di_imported_entity::record(diimport, *this);
        }
    }

    // Get type iterator
    llvm::iterator_range<di_type_iterator> allTypes = debugInfoFinder.types();

    // iterate over types
    for (di_type_iterator iType = allTypes.begin(), E = allTypes.end();
         iType != E; ++iType)
    {
        const llvm::DIType &dbgType = **iType;
        record_di_type::record(dbgType, *this);
        // dbgType.dump();
    }
    write_local_var_assocs();
}
