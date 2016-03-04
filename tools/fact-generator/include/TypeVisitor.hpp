#include <llvm/IR/DataLayout.h>
#include <llvm/IR/Type.h>
#include "CsvGenerator.hpp"

class cclyzer::CsvGenerator::TypeVisitor
{
  public:

    TypeVisitor(CsvGenerator &generator, const llvm::DataLayout &DL)
        : gen(generator), layout(DL) {}

    /* Type Visitor methods */

    void visitType(const llvm::Type *);
    void visitPointerType(const llvm::PointerType *);
    void visitArrayType(const llvm::ArrayType *);
    void visitStructType(const llvm::StructType *);
    void visitFunctionType(const llvm::FunctionType *);
    void visitVectorType(const llvm::VectorType *);

  private:
    /* Instance of outer CSV generator */
    CsvGenerator &gen;

    /**
     * Data layout. To compute the byte size of each type, we need a
     * data layout object, that is associated with the given LLVM
     * module.
     */
    const llvm::DataLayout &layout;
};
