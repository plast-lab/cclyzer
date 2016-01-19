#include <list>
#include <map>
#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include "DebugInfoProcessor.hpp"
#include "RefmodePolicy.hpp"
#include "predicate_groups.hpp"

using namespace llvm;
using std::list;
using std::map;
using std::string;
namespace pred = predicates;


void
DebugInfoProcessor::postProcess(const Module &m)
{
    typedef DebugInfoFinder::type_iterator di_type_iterator;

    // Get iterator over all module types
    llvm::iterator_range<di_type_iterator> allTypes = debugInfoFinder.types();

    // iterate over types
    for (di_type_iterator iType = allTypes.begin(), E = allTypes.end();
         iType != E; ++iType)
    {
        const DIType &dbgType = **iType;

        // dbgType.dump();

        switch (dbgType.getTag()) {
          case dwarf::Tag::DW_TAG_typedef: {
              const DIDerivedType &did = cast<DIDerivedType>(dbgType);
              const Metadata *baseType = did.getRawBaseType();

              if (!baseType) continue;

              if (const DICompositeType *compType = dyn_cast<DICompositeType>(baseType))
                  postProcessType(*compType, dbgType.getName());
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


void
DebugInfoProcessor::postProcessType(const DICompositeType &type, const string altName)
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
          return;
      }
    }

    DIScopeRef iScope = type.getScope();
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
        rso << *it << "::";

    // Append class name to refmode
    string typeName = type.getName();
    typeName = (typeName.empty() ? altName : typeName);

    if (typeName.empty())
        return;

    rso << typeName;
    rso.flush();

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
