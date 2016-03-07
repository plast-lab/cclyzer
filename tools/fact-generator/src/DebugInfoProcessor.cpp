#include <list>
#include <map>
#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include "DebugInfoProcessor.hpp"
#include "RefmodePolicy.hpp"
#include "predicate_groups.hpp"

using cclyzer::DebugInfoProcessor;
using namespace llvm;
using std::list;
using std::map;
using std::string;
namespace pred = cclyzer::predicates;


template
void DebugInfoProcessor::printScope<raw_string_ostream>(
    raw_string_ostream &, const DIScopeRef &);

template<typename Stream> void
DebugInfoProcessor::printScope(Stream &stream, const DIScopeRef &outerScope)
{
    DIScopeRef iScope = outerScope;
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
        }
    }

    // Append namespaces in reverse visiting order
    for (list<string>::iterator it = nsComponents.begin(),
             end = nsComponents.end(); it != end; ++it)
        stream << demangle(*it) << "::";
}

void
DebugInfoProcessor::postProcess(const Module &m, string &path)
{
    typedef DebugInfoFinder::type_iterator di_type_iterator;
    typedef DebugInfoFinder::global_variable_iterator di_global_variable_iterator;

    // Get iterators
    llvm::iterator_range<di_type_iterator> allTypes = debugInfoFinder.types();
    llvm::iterator_range<di_global_variable_iterator> allVars = debugInfoFinder.global_variables();

    // Construct a mapping from Type ID to Type name
    CollectTypeIDs();

    // iterate over global variables
    for (di_global_variable_iterator iVar = allVars.begin(), E = allVars.end();
         iVar != E; ++iVar)
    {
        const DIGlobalVariable &dbgGlobalVar = **iVar;
        refmode_t refmode = refmodeOf(dbgGlobalVar, path);
        unsigned globalVarLine = dbgGlobalVar.getLine();
        std::string globalFileName = dbgGlobalVar.getFilename();
        std::string globalDirectory = dbgGlobalVar.getDirectory();
        writeFact(pred::global_var::location, refmode, globalDirectory, globalFileName, globalVarLine);
    }

    // iterate over types
    for (di_type_iterator iType = allTypes.begin(), E = allTypes.end();
         iType != E; ++iType)
    {
        const DIType &dbgType = **iType;

        // dbgType.dump();

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
                      refmode_t basename = baseRefmode.substr(pos + 1);
                      refmode_t subobjField = "_subobj$" + basename;

                      // UPDATE - In fact, it can account for more
                      // than one fields at the same offset, since all
                      // super-classes of zero size would be mapped to
                      // offset 0.

                      writeFact(pred::struct_type::field_name,
                                refmode, bitOffset, subobjField);
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
DebugInfoProcessor::refmodeOf(const DICompositeType &type, const string &altName)
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
DebugInfoProcessor::refmodeOf(const DIGlobalVariable &dbgGlobalVar, string &path)
{
    // Construct refmode
    refmode_t refmode;
    raw_string_ostream rso(refmode);

    rso << "<";
    rso << path;
    rso << ">:";

    // Append global var name to refmode

    std::string globalName = dbgGlobalVar.getName();
    if (globalName.empty())
        return "";

    rso << "@";
    rso << globalName;
    rso.flush();

    return refmode;
}

void
DebugInfoProcessor::postProcessTypedef(const DIDerivedType &dbgType, const string &name)
{
    const Metadata *baseType = dbgType.getRawBaseType();

    if (!baseType) return;

    if (const DICompositeType *compType = dyn_cast<DICompositeType>(baseType)) {
        postProcessType(*compType, name);
    }
    else if (const DIDerivedType *derType = dyn_cast<DIDerivedType>(baseType)) {
        postProcessTypedef(*derType, name);
    }
}

void
DebugInfoProcessor::postProcessType(const DICompositeType &type, const string &altName)
{
    // Construct refmode
    refmode_t refmode = refmodeOf(type, altName);

    if (refmode.empty()) return;

    // Record fields of composite type
    const DINodeArray &elements = type.getElements();

    for (unsigned i = 0; i < elements.size(); i++) {
        if (DIType *field = dyn_cast<DIType>(elements[i]))
        {
            string fieldName = field->getName();
            uint64_t bitOffset = field->getOffsetInBits();

            if (fieldName.empty())
                continue;

            if (field->isStaticMember()) { // TODO
                continue;
            }

            PredicateFactWriter::writeFact(
                pred::struct_type::field_name, refmode, bitOffset, fieldName);
        }
    }
}


void DebugInfoProcessor::CollectTypeIDs()
{
    // collect type ids
    for (const DIType *type : debugInfoFinder.types())
        if (const DICompositeType *tp = dyn_cast<DICompositeType>(type)) {
            refmode_t refmode = refmodeOf(*tp);

            if (!refmode.empty())
                typeNameByID[tp->getIdentifier()] = refmode;
        }
}
