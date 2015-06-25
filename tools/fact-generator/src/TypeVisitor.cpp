#include <boost/foreach.hpp>
#include "predicate_groups.hpp"
#include "TypeVisitor.hpp"

#define foreach BOOST_FOREACH

namespace pred = predicates;
using namespace llvm;


//-------------------------------------------------------------------
// Methods for recording different kinds of LLVM types.
//-------------------------------------------------------------------


void CsvGenerator::TypeVisitor::visitType(const Type *type)
{
    // Record type sizes while skipping unsized types (e.g.,
    // labels, functions)

    if (type->isSized()) {
        // Iterate over every cached data layout
        foreach (const DataLayout *DL, gen.layouts)
        {
            // TODO: address the case when the data layout does
            // not contain information about this type. This will
            // happen when we analyze multiple compilation units
            // (modules) at once.

            uint64_t allocSize = DL->getTypeAllocSize(const_cast<Type *>(type));
            uint64_t storeSize = DL->getTypeStoreSize(const_cast<Type *>(type));

            // Store size of type in bytes
            refmode_t typeRef = gen.refmodeOf(type);

            gen.writeFact(pred::type::alloc_size, typeRef, allocSize);
            gen.writeFact(pred::type::store_size, typeRef, storeSize);
            break;
        }
    }

    refmode_t tref = gen.refmodeOf(type);

    // Record each different kind of type
    switch (type->getTypeID()) { // Fallthrough is intended
      case llvm::Type::VoidTyID:
      case llvm::Type::LabelTyID:
      case llvm::Type::MetadataTyID:
          gen.writeFact(pred::primitive_type::id, tref);
          break;
      case llvm::Type::HalfTyID: // Fallthrough to all 6 floating point types
      case llvm::Type::FloatTyID:
      case llvm::Type::DoubleTyID:
      case llvm::Type::X86_FP80TyID:
      case llvm::Type::FP128TyID:
      case llvm::Type::PPC_FP128TyID:
          assert(type->isFloatingPointTy());
          gen.writeFact(pred::fp_type::id, tref);
          break;
      case llvm::Type::IntegerTyID:
          gen.writeFact(pred::integer_type::id, tref);
          break;
      case llvm::Type::FunctionTyID:
          visitFunctionType(cast<FunctionType>(type));
          break;
      case llvm::Type::StructTyID:
          visitStructType(cast<StructType>(type));
          break;
      case llvm::Type::ArrayTyID:
          visitArrayType(cast<ArrayType>(type));
          break;
      case llvm::Type::PointerTyID:
          visitPointerType(cast<PointerType>(type));
          break;
      case llvm::Type::VectorTyID:
          visitVectorType(cast<VectorType>(type));
          break;
      case llvm::Type::X86_MMXTyID: // TODO: handle this type
          break;
      default:
          type->dump();
          llvm::errs() << "-" << type->getTypeID()
                       << ": invalid type encountered.\n";
    }
}


void CsvGenerator::TypeVisitor::visitPointerType(const PointerType *ptrType)
{
    refmode_t tref = gen.refmodeOf(ptrType);
    refmode_t elementType = gen.refmodeOf(ptrType->getPointerElementType());

    // Record pointer type entity
    gen.writeFact(pred::ptr_type::id, tref);

    // Record pointer element type
    gen.writeFact(pred::ptr_type::component_type, tref, elementType);

    // Record pointer address space
    if (unsigned addressSpace = ptrType->getPointerAddressSpace())
        gen.writeFact(pred::ptr_type::addr_space, tref, addressSpace);
}


void CsvGenerator::TypeVisitor::visitArrayType(const ArrayType *arrayType)
{
    refmode_t tref = gen.refmodeOf(arrayType);
    refmode_t componentType = gen.refmodeOf(arrayType->getArrayElementType());
    size_t nElements = arrayType->getArrayNumElements();

    gen.writeFact(pred::array_type::id, tref);
    gen.writeFact(pred::array_type::component_type, tref, componentType);
    gen.writeFact(pred::array_type::size, tref, nElements);
}


void CsvGenerator::TypeVisitor::visitStructType(const StructType *structType)
{
    refmode_t tref = gen.refmodeOf(structType);
    size_t nFields = structType->getStructNumElements();

    // Record struct type entity
    gen.writeFact(pred::struct_type::id, tref);

    if (structType->isOpaque()) {
        // Opaque structs carry no info about their internal structure
        gen.writeFact(pred::struct_type::opaque, tref);
    } else {
        // Record struct field types
        for (size_t i = 0; i < nFields; i++)
        {
            refmode_t fieldType = gen.refmodeOf(
                structType->getStructElementType(i));

            gen.writeFact(pred::struct_type::field_type, tref, fieldType, i);
        }

        // Record number of fields
        gen.writeFact(pred::struct_type::nfields, tref, nFields);
    }
}


void CsvGenerator::TypeVisitor::visitFunctionType(const FunctionType *functionType)
{
    refmode_t signature  = gen.refmodeOf(functionType);
    refmode_t returnType = gen.refmodeOf(functionType->getReturnType());
    size_t nParameters = functionType->getFunctionNumParams();

    // Record function type entity
    gen.writeFact(pred::func_type::id, signature);

    // TODO: which predicate/entity do we need to update for varagrs?
    if (functionType->isVarArg())
        gen.writeFact(pred::func_type::varargs, signature);

    // Record return type
    gen.writeFact(pred::func_type::return_type, signature, returnType);

    // Record function formal parameters
    for (size_t i = 0; i < nParameters; i++)
    {
        refmode_t paramType = gen.refmodeOf(functionType->getFunctionParamType(i));

        gen.writeFact(pred::func_type::param_type, signature, paramType, i);
    }

    // Record number of formal parameters
    gen.writeFact(pred::func_type::nparams, signature, nParameters);
}


void CsvGenerator::TypeVisitor::visitVectorType(const VectorType *vectorType)
{
    refmode_t tref = gen.refmodeOf(vectorType);
    size_t nElements = vectorType->getVectorNumElements();
    Type *componentType = vectorType->getVectorElementType();

    // Record vector type entity
    gen.writeFact(pred::vector_type::id, tref);

    // Record vector component type
    refmode_t compref = gen.refmodeOf(componentType);
    gen.writeFact(pred::vector_type::component_type, tref, compref);

    // Record vector type size
    gen.writeFact(pred::vector_type::size, tref, nElements);
}
