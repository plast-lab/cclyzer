#include <list>
#include <map>
#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>
#include "DebugInfoProcessor.hpp"
#include "RefmodeEngine.hpp"
#include "predicate_groups.hpp"
#include "debuginfo_predicate_groups.hpp"

using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
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

            writeDebugInfoScope(*dis);
        }
    }

    // Append namespaces in reverse visiting order
    for (list<string>::iterator it = nsComponents.begin(),
             end = nsComponents.end(); it != end; ++it)
        stream << demangle(*it) << "::";
}

void
DebugInfoProcessor::postProcess(const Module &m, const string &path)
{
    typedef DebugInfoFinder::type_iterator di_type_iterator;
    typedef DebugInfoFinder::global_variable_iterator di_global_var_iterator;

    // Get global variable iterator
    llvm::iterator_range<di_global_var_iterator> allVars =
        debugInfoFinder.global_variables();

    // Construct a mapping from Type ID to Type name
    CollectTypeIDs();

    // iterate over global variables
    for (di_global_var_iterator iVar = allVars.begin(), E = allVars.end();
         iVar != E; ++iVar)
    {
        const DIGlobalVariable &dbgGlobalVar = **iVar;
        refmode_t refmode = refmodeOf(dbgGlobalVar, path);

        unsigned lineNum = dbgGlobalVar.getLine();
        string fileName = dbgGlobalVar.getFilename();
        string dir = dbgGlobalVar.getDirectory();

        writeFact(pred::global_var::pos, refmode, dir, fileName, lineNum);
    }

    // Get type iterator
    llvm::iterator_range<di_type_iterator> allTypes = debugInfoFinder.types();

    // iterate over types
    for (di_type_iterator iType = allTypes.begin(), E = allTypes.end();
         iType != E; ++iType)
    {
        const DIType &dbgType = **iType;

        // dbgType.dump();
        writeDebugInfoType(dbgType);

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
DebugInfoProcessor::refmodeOf(const DIGlobalVariable &dbgGlobalVar, const string &path)
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

            writeFact(pred::struct_type::field_name,
                      refmode, bitOffset, fieldName);
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


refmode_t
DebugInfoProcessor::writeDebugInfoFile(const llvm::DIFile& difile)
{
    // Check if node has been processed before
    auto search = nodeIds.find(&difile);

    if (search != nodeIds.end())
        return search->second;

    // Generate refmode for this node
    refmode_t nodeId = refmEngine.refmode<llvm::DINode>(difile);
    string filename = difile.getFilename();
    string directory = difile.getDirectory();

    writeFact(pred::di_file::id, nodeId);
    writeFact(pred::di_file::filename, nodeId, filename);
    writeFact(pred::di_file::directory, nodeId, directory);

    return nodeIds[&difile] = nodeId;
}


refmode_t
DebugInfoProcessor::writeDebugInfoNamespace(const llvm::DINamespace& dinamespace)
{
    // Check if node has been processed before
    auto search = nodeIds.find(&dinamespace);

    if (search != nodeIds.end())
        return search->second;

    // Generate refmode for this node
    refmode_t nodeId = refmEngine.refmode<llvm::DINode>(dinamespace);
    const string name = dinamespace.getName();
    const unsigned line = dinamespace.getLine();

    writeFact(pred::di_namespace::id, nodeId);
    writeFact(pred::di_namespace::name, nodeId, name);
    writeFact(pred::di_namespace::line, nodeId, line);

    // Record file information for namespace
    if (const llvm::DIFile *difile = dinamespace.getFile()) {
        refmode_t fileId = writeDebugInfoFile(*difile);
        writeFact(pred::di_namespace::file, nodeId, fileId);
    }

    // Record enclosing scope
    if (const llvm::DIScope *discope = dinamespace.getScope()) {
        refmode_t scopeId = writeDebugInfoScope(*discope);
        writeFact(pred::di_namespace::scope, nodeId, scopeId);
    }

    return nodeIds[&dinamespace] = nodeId;
}


refmode_t
DebugInfoProcessor::writeDebugInfoScope(const llvm::DIScope& discope)
{
    using llvm::DINamespace;

    if (const DINamespace *dins = llvm::dyn_cast<DINamespace>(&discope))
        return writeDebugInfoNamespace(*dins);
    // TODO
    return "<nullref>";
}


refmode_t
DebugInfoProcessor::writeDebugInfoType(const llvm::DIType& ditype)
{
    using llvm::DIBasicType;
    using llvm::DICompositeType;
    using llvm::DIDerivedType;
    using llvm::DISubroutineType;
    using llvm::dyn_cast;

    // Check if node has been processed before
    auto search = nodeIds.find(&ditype);

    if (search != nodeIds.end())
        return search->second;

    // Generate refmode for this node
    refmode_t nodeId = refmEngine.refmode<llvm::DINode>(ditype);
    handleCoreDIType(ditype, nodeId);

    if (const DIBasicType *basictype = dyn_cast<DIBasicType>(&ditype))
        handleDIBasicType(*basictype, nodeId);
    else if (const DICompositeType *comptype = dyn_cast<DICompositeType>(&ditype))
        handleDICompositeType(*comptype, nodeId);
    else if (const DIDerivedType *derivedtype = dyn_cast<DIDerivedType>(&ditype))
        handleDIDerivedType(*derivedtype, nodeId);
    else if (const DISubroutineType *subrtype = dyn_cast<DISubroutineType>(&ditype))
        handleDISubroutineType(*subrtype, nodeId);

    return nodeIds[&ditype] = nodeId;
}


void
DebugInfoProcessor::handleCoreDIType(const llvm::DIType& ditype, const refmode_t& nodeId)
{
    const string name = ditype.getName();
    const unsigned line = ditype.getLine();

    writeFact(pred::di_type::id, nodeId);

    if (!name.empty()) {
        writeFact(pred::di_type::name, nodeId, name);
    }

    if (line) {                 // zero indicates non-existence
        writeFact(pred::di_type::line, nodeId, line);
    }


    // Record bit sizes
    switch (ditype.getTag()) {
      // Skip sizeless entries
      case dwarf::Tag::DW_TAG_typedef:
      case dwarf::Tag::DW_TAG_const_type:
      case dwarf::Tag::DW_TAG_restrict_type:
      case dwarf::Tag::DW_TAG_subroutine_type:
          break;
      default: {
          const uint64_t bitSize = ditype.getSizeInBits();
          const uint64_t bitAlign = ditype.getAlignInBits();
          const uint64_t bitOffset = ditype.getOffsetInBits();

          writeFact(pred::di_type::bitsize, nodeId, bitSize);
          writeFact(pred::di_type::bitalign, nodeId, bitAlign);
          writeFact(pred::di_type::bitoffset, nodeId, bitOffset);
      }
    }


    // Record enclosing scope
    if (const llvm::DIScopeRef discope = ditype.getScope())
    {
        using llvm::MDString;
        const llvm::Metadata& meta = *discope;

        if (const MDString *mds = dyn_cast<MDString>(&meta)) {
            string scopeStr = mds->getString();
            writeFact(pred::di_type::raw_scope, nodeId, scopeStr);
        }
        else {
            refmode_t scopeId = writeDebugInfoScope(cast<DIScope>(*discope));
            writeFact(pred::di_type::scope, nodeId, scopeId);
        }
    }


    // Record flags
    const pred::pred_t& flag = pred::di_type::flag;

    if (ditype.isPrivate()) { writeFact(flag, nodeId, "private"); }
    if (ditype.isProtected()) { writeFact(flag, nodeId, "protected"); }
    if (ditype.isPublic()) { writeFact(flag, nodeId, "public"); }
    if (ditype.isForwardDecl()) { writeFact(flag, nodeId, "forward_decl"); }
    if (ditype.isAppleBlockExtension()) { writeFact(flag, nodeId, "apple_block_extension"); }
    if (ditype.isBlockByrefStruct()) { writeFact(flag, nodeId, "block_byref_struct"); }
    if (ditype.isVirtual()) { writeFact(flag, nodeId, "virtual"); }
    if (ditype.isArtificial()) { writeFact(flag, nodeId, "artificial"); }
    if (ditype.isObjectPointer()) { writeFact(flag, nodeId, "object_pointer"); }
    if (ditype.isObjcClassComplete()) { writeFact(flag, nodeId, "objc_class_complete"); }
    if (ditype.isVector()) { writeFact(flag, nodeId, "vector"); }
    if (ditype.isStaticMember()) { writeFact(flag, nodeId, "static_member"); }
    if (ditype.isLValueReference()) { writeFact(flag, nodeId, "lvalue_reference"); }
    if (ditype.isRValueReference()) { writeFact(flag, nodeId, "rvalue_reference"); }
}


void
DebugInfoProcessor::handleDIBasicType(const llvm::DIBasicType& ditype, const refmode_t& nodeId)
{
    writeFact(pred::di_basic_type::id, nodeId);
}


void
DebugInfoProcessor::handleDICompositeType(const llvm::DICompositeType& ditype, const refmode_t& nodeId)
{
    writeFact(pred::di_composite_type::id, nodeId);
    // TODO
}


void
DebugInfoProcessor::handleDIDerivedType(const llvm::DIDerivedType& ditype, const refmode_t& nodeId)
{
    writeFact(pred::di_derived_type::id, nodeId);

    // Record exact kind of derived type
    switch (ditype.getTag()) {
      case dwarf::Tag::DW_TAG_pointer_type:
          writeFact(pred::di_derived_type::kind, nodeId, "pointer_type");
          break;
      case dwarf::Tag::DW_TAG_restrict_type:
          writeFact(pred::di_derived_type::kind, nodeId, "restrict_type");
          break;
      case dwarf::Tag::DW_TAG_volatile_type:
          writeFact(pred::di_derived_type::kind, nodeId, "volatile_type");
          break;
      case dwarf::Tag::DW_TAG_const_type:
          writeFact(pred::di_derived_type::kind, nodeId, "const_type");
          break;
      case dwarf::Tag::DW_TAG_reference_type:
          writeFact(pred::di_derived_type::kind, nodeId, "reference_type");
          break;
      case dwarf::Tag::DW_TAG_rvalue_reference_type:
          writeFact(pred::di_derived_type::kind, nodeId, "rvalue_reference_type");
          break;
      case dwarf::Tag::DW_TAG_ptr_to_member_type:
          writeFact(pred::di_derived_type::kind, nodeId, "ptr_to_member_type");
          break;
      case dwarf::Tag::DW_TAG_typedef:
          writeFact(pred::di_derived_type::kind, nodeId, "typedef");
          break;
      case dwarf::Tag::DW_TAG_member:
          writeFact(pred::di_derived_type::kind, nodeId, "member");
          break;
      case dwarf::Tag::DW_TAG_inheritance:
          writeFact(pred::di_derived_type::kind, nodeId, "inheritance");
          break;
      case dwarf::Tag::DW_TAG_friend:
          writeFact(pred::di_derived_type::kind, nodeId, "friend");
          break;
    }

    // Record base type
    if (const llvm::DITypeRef baseType = ditype.getBaseType())
    {
        using llvm::MDString;
        const llvm::Metadata& meta = *baseType;

        if (const MDString *mds = dyn_cast<MDString>(&meta)) {
            string typeStr = mds->getString();
            writeFact(pred::di_derived_type::raw_basetype, nodeId, typeStr);
        }
        else {
            refmode_t baseTypeId = writeDebugInfoType(cast<DIType>(*baseType));
            writeFact(pred::di_derived_type::basetype, nodeId, baseTypeId);
        }
    }

    // Record file information for type
    if (const llvm::DIFile *difile = ditype.getFile()) {
        refmode_t fileId = writeDebugInfoFile(*difile);
        writeFact(pred::di_derived_type::file, nodeId, fileId);
    }
}


void
DebugInfoProcessor::handleDISubroutineType(const llvm::DISubroutineType& ditype, const refmode_t& nodeId)
{
    using llvm::MDString;
    writeFact(pred::di_subroutine_type::id, nodeId);

    auto typeArray = ditype.getTypeArray();

    for (size_t i = 0; i < typeArray.size(); ++i) {
        if (const DITypeRef type = typeArray[i]) {
            const llvm::Metadata& meta = *type;

            if (const MDString *mds = dyn_cast<MDString>(&meta)) {
                string typeStr = mds->getString();
                writeFact(pred::di_subroutine_type::raw_type_elem, nodeId, i, typeStr);
            }
            else {
                refmode_t typeId = writeDebugInfoType(cast<DIType>(*type));
                writeFact(pred::di_subroutine_type::type_elem, nodeId, i, typeId);
            }
        }
    }
}
