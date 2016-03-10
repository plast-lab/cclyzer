#ifndef LLVM_ENUMS_HPP__
#define LLVM_ENUMS_HPP__

#include <string>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/Instructions.h>

namespace cclyzer
{
    namespace utils
    {
        // Functions that convert the various LLVM enums to strings
        std::string to_string(llvm::GlobalValue::LinkageTypes LT);
        std::string to_string(llvm::GlobalValue::VisibilityTypes Vis);
        std::string to_string(llvm::GlobalVariable::ThreadLocalMode TLM);
        std::string to_string(llvm::CallingConv::ID CC);
        std::string to_string(llvm::AtomicOrdering AO);

    } // end of namespace cclyzer::utils

} // end of namespace cclyzer

#endif /* LLVM_ENUMS_HPP__ */
