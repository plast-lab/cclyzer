#ifndef TYPE_ACCUMULATOR_HPP__
#define TYPE_ACCUMULATOR_HPP__

#include <boost/unordered_set.hpp>
#include <llvm/IR/Type.h>
#include <llvm/Support/raw_ostream.h>

namespace llvm_extra {
    using namespace llvm;

    template<typename Set>
    class TypeAccumulator
    {
      public:
        typedef Set types_t;

        TypeAccumulator() {}
        ~TypeAccumulator() {}

        types_t operator()(types_t rootTypes)
        {
            // Visit every type
            for (const Type *type : rootTypes)
                visitType(type);

            // Return superset of types
            return types;
        }

        void visitType(const Type *elementType)
        {
            if (types.count(elementType) != 0)
                return;

            // Add new type
            types.insert(elementType);

            // Nothing else needs to be done for simple types
            if (isPrimitiveType(elementType) || elementType->isIntegerTy())
                return;

            // Recurse into component types if need be
            if (elementType->isArrayTy()) {
                visitType(elementType->getArrayElementType());
            }
            else if (elementType->isPointerTy()) {
                visitType(elementType->getPointerElementType());
            }
            else if (elementType->isStructTy()) {
                visitStructType(elementType);
            }
            else if (elementType->isVectorTy()) {
                visitType(elementType->getVectorElementType());
            }
            else if (elementType->isFunctionTy()) {
                visitFunctionType(elementType);
            }
            else {
                errs() << "Unrecognized type: ";
                elementType->print(errs());
                errs() << "\n";
            }
        }

        void visitStructType(const Type *structType)
        {
            const StructType *strTy = cast<StructType>(structType);

            if (!strTy->isOpaque())
                for (size_t i = 0; i < strTy->getStructNumElements(); i++)
                    visitType(strTy->getStructElementType(i));
        }

        void visitFunctionType(const Type *funcType)
        {
            const FunctionType *funcTy = dyn_cast<FunctionType>(funcType);
            visitType(funcTy->getReturnType());

            for (size_t i = 0; i < funcType->getFunctionNumParams(); i++)
                visitType(funcTy->getFunctionParamType(i));
        }

      protected:

        bool isPrimitiveType(const Type * type) {
            return type->isVoidTy()   || type->isHalfTy()    ||
                type->isFloatTy()     || type->isDoubleTy()  ||
                type->isX86_FP80Ty()  || type->isFP128Ty()   ||
                type->isPPC_FP128Ty() || type->isLabelTy()   ||
                type->isMetadataTy()  || type->isX86_MMXTy();
        }

      private:
        types_t types;
    };
}

#endif /* TYPE_ACCUMULATOR_HPP__ */
