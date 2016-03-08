#ifndef TYPE_ACCUMULATOR_HPP__
#define TYPE_ACCUMULATOR_HPP__

#include <boost/unordered_set.hpp>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Type.h>
#include <llvm/Support/raw_ostream.h>


namespace cclyzer {
    namespace llvm_utils {
        class TypeAccumulator;
    }
}



class cclyzer::llvm_utils::TypeAccumulator
{
  public:
    typedef boost::unordered_set<const llvm::Type *> container_t;
    typedef container_t::iterator iterator;
    typedef container_t::const_iterator const_iterator;

    TypeAccumulator() {}
    ~TypeAccumulator() {}

    template<typename Iterator>
    void accumulate(Iterator first, Iterator last)
    {
        // Visit every type
        for (Iterator it = first; it != last; ++it) {
            // Iterator must be over LLVM Types
            const llvm::Type *type = static_cast<const llvm::Type *>(*it);

            // Process type
            visitType(type);
        }
    }


    // Iterator over all collected types

    iterator begin() { return types.begin(); }
    iterator end()   { return types.end(); }

    const_iterator begin() const { return types.begin(); }
    const_iterator end()   const { return types.end(); }


    // Visitor-like methods (do not yet implement the visitor pattern)

    void visitType(const llvm::Type *elementType)
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
            llvm::errs() << "Unrecognized type: ";
            elementType->print(llvm::errs());
            llvm::errs() << "\n";
        }
    }

    void visitStructType(const llvm::Type *structType)
    {
        using llvm::StructType;
        const StructType *strTy = llvm::cast<StructType>(structType);

        if (!strTy->isOpaque())
            for (size_t i = 0; i < strTy->getStructNumElements(); i++)
                visitType(strTy->getStructElementType(i));
    }

    void visitFunctionType(const llvm::Type *funcType)
    {
        using llvm::FunctionType;
        const FunctionType *funcTy = llvm::dyn_cast<FunctionType>(funcType);

        visitType(funcTy->getReturnType());

        for (size_t i = 0; i < funcType->getFunctionNumParams(); i++)
            visitType(funcTy->getFunctionParamType(i));
    }

  protected:

    bool isPrimitiveType(const llvm::Type * type) {
        return type->isVoidTy()   || type->isHalfTy()    ||
            type->isFloatTy()     || type->isDoubleTy()  ||
            type->isX86_FP80Ty()  || type->isFP128Ty()   ||
            type->isPPC_FP128Ty() || type->isLabelTy()   ||
            type->isMetadataTy()  || type->isX86_MMXTy();
    }

  private:
    container_t types;
};

#endif /* TYPE_ACCUMULATOR_HPP__ */
