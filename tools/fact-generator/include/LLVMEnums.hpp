#ifndef LLVM_ENUMS_HPP__
#define LLVM_ENUMS_HPP__

#include <string>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/Instructions.h>


class LLVMEnumSerializer {
  public:
    static std::string to_string(llvm::GlobalValue::LinkageTypes LT);
    static std::string to_string(llvm::GlobalValue::VisibilityTypes Vis);
    static std::string to_string(llvm::GlobalVariable::ThreadLocalMode TLM);
    static std::string to_string(llvm::CallingConv::ID CC);
    static std::string to_string(llvm::AtomicOrdering AO);
};

#endif /* LLVM_ENUMS_HPP__ */
