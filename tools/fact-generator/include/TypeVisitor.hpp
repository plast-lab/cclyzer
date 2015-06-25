#include <llvm/IR/Type.h>
#include "CsvGenerator.hpp"

class CsvGenerator::TypeVisitor
{
  public:

    TypeVisitor(CsvGenerator &generator) : gen(generator) {}

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
};
