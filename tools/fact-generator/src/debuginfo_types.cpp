#include "DebugInfoProcessor.hpp"
#include "debuginfo_predicate_groups.hpp"


using cclyzer::DebugInfoProcessor;
using cclyzer::refmode_t;
using llvm::cast;
using llvm::dyn_cast;
using std::string;
namespace pred = cclyzer::predicates;
namespace dwarf = llvm::dwarf;



//----------------------------------------------------------------------------
// Process Debug Info Types
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_type::write(
    const llvm::DIType& ditype, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::DIBasicType;
    using llvm::DICompositeType;
    using llvm::DIDerivedType;
    using llvm::DISubroutineType;

    if (const DIBasicType *basictype = dyn_cast<DIBasicType>(&ditype))
        write_di_basic_type::write(*basictype, nodeId, proc);
    else if (const DICompositeType *comptype = dyn_cast<DICompositeType>(&ditype))
        write_di_composite_type::write(*comptype, nodeId, proc);
    else if (const DIDerivedType *derivedtype = dyn_cast<DIDerivedType>(&ditype))
        write_di_derived_type::write(*derivedtype, nodeId, proc);
    else if (const DISubroutineType *subrtype = dyn_cast<DISubroutineType>(&ditype))
        write_di_subroutine_type::write(*subrtype, nodeId, proc);
}


//----------------------------------------------------------------------------
// Process Debug Info Basic Types
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_basic_type::write(
    const llvm::DIBasicType& ditype, const refmode_t& nodeId, DIProc& proc)
{
    proc.write_di_type_common(ditype, nodeId);
    proc.writeFact(pred::di_basic_type::id, nodeId);
}


//----------------------------------------------------------------------------
// Process Debug Info Composite Types
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_composite_type::write(
    const llvm::DICompositeType& ditype, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::DIType;

    proc.write_di_type_common(ditype, nodeId);
    proc.writeFact(pred::di_composite_type::id, nodeId);

    // Record exact kind of derived type
    switch (ditype.getTag()) {  // TODO
      case dwarf::Tag::DW_TAG_structure_type:
      case dwarf::Tag::DW_TAG_class_type:
      case dwarf::Tag::DW_TAG_array_type:
      case dwarf::Tag::DW_TAG_union_type:
      case dwarf::Tag::DW_TAG_enumeration_type:
          break;
    }

    // Record ABI Identifier for this composite type
    const string abiId = ditype.getIdentifier();
    proc.writeFact(pred::di_composite_type::abi_id, nodeId, abiId);

    // Record fields of composite type
    const llvm::DINodeArray& elements = ditype.getElements();

    for (size_t i = 0; i < elements.size(); i++) {
        if (const DIType *field = dyn_cast<DIType>(elements[i])) {
            refmode_t fieldId = record_di_type::record(*field, proc);
            proc.writeFact(pred::di_composite_type::field, nodeId, i, fieldId);
        }
    }

    // Record base type
    proc.recordUnionAttribute<pred::di_composite_type::basetype, write_di_type>(
        nodeId, ditype.getBaseType());

    // Record v-table
    proc.recordUnionAttribute<pred::di_composite_type::vtable, write_di_type>(
        nodeId, ditype.getVTableHolder());

    // Record template parameters
    const llvm::DITemplateParameterArray& tplParams = ditype.getTemplateParams();

    for (size_t i = 0; i < tplParams.size(); ++i) {
        const llvm::DITemplateParameter *tplParam = tplParams[i];

        // TODO
    }

    // Record file information for type
    if (const llvm::DIFile *difile = ditype.getFile()) {
        refmode_t fileId = record_di_file::record(*difile, proc);
        proc.writeFact(pred::di_composite_type::file, nodeId, fileId);
    }
}


//----------------------------------------------------------------------------
// Process Debug Info Derived Types
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_derived_type::write(
    const llvm::DIDerivedType& ditype, const refmode_t& nodeId, DIProc& proc)
{
    proc.write_di_type_common(ditype, nodeId);
    proc.writeFact(pred::di_derived_type::id, nodeId);

    // Record exact kind of derived type
    switch (ditype.getTag()) {
      case dwarf::Tag::DW_TAG_pointer_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "pointer_type");
          break;
      case dwarf::Tag::DW_TAG_restrict_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "restrict_type");
          break;
      case dwarf::Tag::DW_TAG_volatile_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "volatile_type");
          break;
      case dwarf::Tag::DW_TAG_const_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "const_type");
          break;
      case dwarf::Tag::DW_TAG_reference_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "reference_type");
          break;
      case dwarf::Tag::DW_TAG_rvalue_reference_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "rvalue_reference_type");
          break;
      case dwarf::Tag::DW_TAG_ptr_to_member_type:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "ptr_to_member_type");
          break;
      case dwarf::Tag::DW_TAG_typedef:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "typedef");
          break;
      case dwarf::Tag::DW_TAG_member:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "member");
          break;
      case dwarf::Tag::DW_TAG_inheritance:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "inheritance");
          break;
      case dwarf::Tag::DW_TAG_friend:
          proc.writeFact(pred::di_derived_type::kind, nodeId, "friend");
          break;
    }

    // Record base type
    proc.recordUnionAttribute<pred::di_derived_type::basetype, write_di_type>(
        nodeId, ditype.getBaseType());

    // Record file information for type
    if (const llvm::DIFile *difile = ditype.getFile()) {
        refmode_t fileId = record_di_file::record(*difile, proc);
        proc.writeFact(pred::di_derived_type::file, nodeId, fileId);
    }
}


//----------------------------------------------------------------------------
// Process Debug Info Subroutine Types
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_subroutine_type::write(
    const llvm::DISubroutineType& ditype, const refmode_t& nodeId, DIProc& proc)
{
    using llvm::MDString;
    using llvm::DIType;

    proc.write_di_type_common(ditype, nodeId);
    proc.writeFact(pred::di_subroutine_type::id, nodeId);

    auto typeArray = ditype.getTypeArray();

    for (size_t i = 0; i < typeArray.size(); ++i) {
        if (const llvm::DITypeRef type = typeArray[i]) {
            const llvm::Metadata& meta = *type;

            if (const MDString *mds = dyn_cast<MDString>(&meta)) {
                string typeStr = mds->getString();
                proc.writeFact(pred::di_subroutine_type::raw_type_elem, nodeId, i, typeStr);
            }
            else {
                const llvm::DIType& typeNode = cast<DIType>(*type);
                refmode_t typeId = record_di_type::record(typeNode, proc);
                proc.writeFact(pred::di_subroutine_type::type_elem, nodeId, i, typeId);
            }
        }
    }
}



//----------------------------------------------------------------------------
// Write common Debug Info Type Attributes
//----------------------------------------------------------------------------

void
DebugInfoProcessor::write_di_type_common(
    const llvm::DIType& ditype, const refmode_t& nodeId)
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
    recordUnionAttribute<pred::di_type::scope, write_di_scope>(
        nodeId, ditype.getScope());

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


//------------------------------------------------------------------------------
// Helper method to record union attributes
//------------------------------------------------------------------------------

template<typename P, typename writer, typename T> void
DebugInfoProcessor::recordUnionAttribute(
    const refmode_t& nodeId, const llvm::TypedDINodeRef<T>& attribute)
{
    typedef P pred;
    typedef di_recorder<T, writer> recorder;

    if (attribute) {
        using llvm::MDString;
        const llvm::Metadata& meta = *attribute;

        if (const MDString *mds = dyn_cast<MDString>(&meta)) {
            std::string attribStr = mds->getString();
            writeFact(pred::raw, nodeId, attribStr);
        }
        else {
            refmode_t attribId = recorder::record(cast<T>(*attribute), *this);
            writeFact(pred::node, nodeId, attribId);
        }
    }
}
