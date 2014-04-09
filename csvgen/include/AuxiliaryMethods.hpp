#ifndef __AUXILIARY_METHODS_HPP__
#define __AUXILIARY_METHODS_HPP__

#include <string>

#include "llvm/IR/CallingConv.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Type.h"
#include "llvm/Assembly/Writer.h" //This is for version <= 3.4
//TODO: config macro for llvm version!

namespace auxiliary_methods {

    bool isPrimitiveType(const llvm::Type * Tp);

    std::string writeCallingConv(unsigned cc);

    std::string printType(const llvm::Type *type);

    //TODO: do we need this guy?
    const char *writeThreadLocalModel(llvm::GlobalVariable::ThreadLocalMode TLM);

    void writeFnAttributes(const llvm::AttributeSet Attrs, std::vector<std::string> &FnAttr);

    std::string valueToString(const llvm::Value*, const llvm::Module *);

}


#endif
