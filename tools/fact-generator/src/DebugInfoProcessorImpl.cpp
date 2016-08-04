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


template
void DebugInfoProcessor::Impl::printScope<raw_string_ostream>(
    raw_string_ostream &, const llvm::DIScopeRef &);

template<typename Stream> void
DebugInfoProcessor::Impl::printScope(
    Stream &stream, const llvm::DIScopeRef &outerScope)
{
    using llvm::DIScope;
    using llvm::MDString;
    using llvm::Metadata;

    llvm::DIScopeRef iScope = outerScope;
    list<string> nsComponents;

    // Find all enclosing namespaces
    while (iScope) {
        const Metadata &scope = *iScope;

        if (const MDString *mds = dyn_cast<MDString>(&scope)) {
            nsComponents.push_front(mds->getString());
            iScope = nullptr;
        }
        else {
            const DIScope *dis = dyn_cast<DIScope>(&scope);
            nsComponents.push_front(dis->getName());
            iScope = dis->getScope();

            record_di_scope::record(*dis, *this);
        }
    }

    // Append namespaces in reverse visiting order
    for (list<string>::iterator it = nsComponents.begin(),
             end = nsComponents.end(); it != end; ++it)
        stream << demangle(*it) << "::";
}

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
    typedef llvm::DebugInfoFinder::subprogram_iterator di_subprogram_iterator;
    typedef llvm::DebugInfoFinder::global_variable_iterator di_global_var_iterator;

    // Get global variable iterator
    llvm::iterator_range<di_global_var_iterator> allVars =
        debugInfoFinder.global_variables();

    // Construct a mapping from Type ID to Type name
    CollectTypeIDs();

    // iterate over global variables
    for (di_global_var_iterator iVar = allVars.begin(), E = allVars.end();
         iVar != E; ++iVar)
    {
        const llvm::DIGlobalVariable &dbgGlobalVar = **iVar;
        refmode_t refmode = refmodeOf(dbgGlobalVar, path);

        unsigned lineNum = dbgGlobalVar.getLine();
        string fileName = dbgGlobalVar.getFilename();
        string dir = dbgGlobalVar.getDirectory();

        writeFact(pred::global_var::pos, refmode, dir, fileName, lineNum);

        record_di_variable::record(**iVar, *this);
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

    // Get type iterator
    llvm::iterator_range<di_type_iterator> allTypes = debugInfoFinder.types();

    // iterate over types
    for (di_type_iterator iType = allTypes.begin(), E = allTypes.end();
         iType != E; ++iType)
    {
        const llvm::DIType &dbgType = **iType;

        // dbgType.dump();
        record_di_type::record(dbgType, *this);

        switch (dbgType.getTag()) {
          case dwarf::Tag::DW_TAG_typedef: {
              postProcessTypedef(cast<DIDerivedType>(dbgType), dbgType.getName().str());
              break;
          }
          case dwarf::Tag::DW_TAG_inheritance: {
              const DIDerivedType &did = cast<DIDerivedType>(dbgType);
              const Metadata *baseType = did.getRawBaseType();
              const DIScopeRef scope = did.getScope();

              if (const MDString *mds = dyn_cast<MDString>(baseType)) {
                  if (const MDString *mdscope = dyn_cast<MDString>(scope)) {
                      string subtypeID = mdscope->getString();
                      string supertypeID = mds->getString();

                      if (!typeNameByID.count(subtypeID))
                          continue;

                      if (!typeNameByID.count(supertypeID))
                          continue;

                      refmode_t refmode = typeNameByID[subtypeID];
                      refmode_t baseRefmode = typeNameByID[supertypeID];
                      uint64_t bitOffset = did.getOffsetInBits();

                      // Inheritance relation accounts for a subobject
                      // field at some given offset

                      size_t pos = baseRefmode.find_first_of(".");
                      std::string basename = baseRefmode.substr(pos + 1);

                      // UPDATE - In fact, it can account for more
                      // than one fields at the same offset, since all
                      // super-classes of zero size would be mapped to
                      // offset 0.

                      writeFact(pred::struct_type::inheritance,
                                refmode, bitOffset, basename);
                  }
              }
              break;
          }
          case dwarf::Tag::DW_TAG_structure_type: {
              postProcessType(cast<DICompositeType>(dbgType));
              break;
          }
          case dwarf::Tag::DW_TAG_class_type: {
              postProcessType(cast<DICompositeType>(dbgType));
              break;
          }
          default: {
              break;
          }
        }
    }
}


cclyzer::refmode_t
DebugInfoProcessor::Impl::refmodeOf(
    const llvm::DICompositeType &type, const string &altName)
{
    // Construct refmode
    refmode_t refmode;
    raw_string_ostream rso(refmode);

    // Append prefix based on dwarf tag
    switch (type.getTag()) {
      case dwarf::Tag::DW_TAG_class_type: {
          rso << "%class.";
          break;
      }
      case dwarf::Tag::DW_TAG_structure_type: {
          rso << "%struct.";
          break;
      }
      default: {
          return "";
      }
    }

    // Append scope to name
    printScope(rso, type.getScope());

    // Append class name to refmode
    string typeName = type.getName();
    typeName = (typeName.empty() ? altName : typeName);

    if (typeName.empty())
        return "";

    rso << typeName;
    rso.flush();

    return refmode;
}

cclyzer::refmode_t
DebugInfoProcessor::Impl::refmodeOf(
    const llvm::DIGlobalVariable &dbgGlobalVar, const string &path)
{
    // Construct refmode
    refmode_t refmode;
    raw_string_ostream rso(refmode);

    rso << "<" << path << ">:";

    // Append global var name to refmode

    std::string globalName = dbgGlobalVar.getName();
    if (globalName.empty())
        return "";

    rso << "@" << globalName;
    rso.flush();

    return refmode;
}

void
DebugInfoProcessor::Impl::postProcessTypedef(
    const llvm::DIDerivedType &dbgType, const string &name)
{
    using llvm::DICompositeType;
    using llvm::DIDerivedType;
    const llvm::Metadata *baseType = dbgType.getRawBaseType();

    if (!baseType) return;

    if (const DICompositeType *compType = dyn_cast<DICompositeType>(baseType)) {
        postProcessType(*compType, name);
    }
    else if (const DIDerivedType *derType = dyn_cast<DIDerivedType>(baseType)) {
        postProcessTypedef(*derType, name);
    }
}

void
DebugInfoProcessor::Impl::postProcessType(
    const llvm::DICompositeType& type, const string &altName)
{
    // Construct refmode
    refmode_t refmode = refmodeOf(type, altName);

    if (refmode.empty()) return;

    // Record fields of composite type
    const llvm::DINodeArray &elements = type.getElements();

    for (unsigned i = 0; i < elements.size(); i++) {
        if (llvm::DIType *field = dyn_cast<llvm::DIType>(elements[i]))
        {
            string fieldName = field->getName();
            uint64_t bitOffset = field->getOffsetInBits();

            if (fieldName.empty())
                continue;

            if (field->isStaticMember()) { // TODO
                continue;
            }

            writeFact(pred::struct_type::field_name,
                      refmode, bitOffset, fieldName);
        }
    }
}


void DebugInfoProcessor::Impl::CollectTypeIDs()
{
    using llvm::DIType;
    using llvm::DICompositeType;

    // collect type ids
    for (const DIType *type : debugInfoFinder.types())
        if (const DICompositeType *tp = dyn_cast<DICompositeType>(type)) {
            refmode_t refmode = refmodeOf(*tp);

            if (!refmode.empty())
                typeNameByID[tp->getIdentifier()] = refmode;
        }
}
