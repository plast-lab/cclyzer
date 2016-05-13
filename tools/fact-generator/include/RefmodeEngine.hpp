#ifndef REFMODE_ENGINE_HPP__
#define REFMODE_ENGINE_HPP__

#include <string>
#include <llvm/IR/Function.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Instructions.h>

namespace cclyzer {
    namespace refmode {
        /* Type aliases */
        typedef std::string refmode_t;
    }

    /* Forward Declartion */
    class RefmodeEngine;

    typedef refmode::refmode_t refmode_t;
}


class cclyzer::RefmodeEngine {
  public:
    RefmodeEngine();
    ~RefmodeEngine();

    // Simple value-based refmodes
    refmode_t refmodeOf(llvm::GlobalValue::LinkageTypes LT) const;
    refmode_t refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const;
    refmode_t refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const;
    refmode_t refmodeOf(llvm::CallingConv::ID CC) const;
    refmode_t refmodeOf(llvm::AtomicOrdering AO) const;
    refmode_t refmodeOf(const llvm::Type *type) const;

    // Fully qualified refmodes that guarantee uniqueness
    refmode_t refmodeOfFunction(const llvm::Function *) const;
    refmode_t refmodeOfBasicBlock(const llvm::BasicBlock *) const;
    refmode_t refmodeOfConstant(const llvm::Constant *) const;
    refmode_t refmodeOfInlineAsm(const llvm::InlineAsm *) const;
    refmode_t refmodeOfLocalValue(const llvm::Value *) const;
    refmode_t refmodeOfGlobalValue(const llvm::GlobalValue *) const;
    refmode_t refmodeOfInstruction(const llvm::Instruction *) const;

    // Context modifying methods
    void enterContext(const llvm::Value *val);
    void exitContext();
    void enterModule(const llvm::Module *Mod, const std::string &path);
    void exitModule();

  private:
    /* Opaque Pointer Idiom */
    class Impl;
    Impl *impl;
};

#endif /* REFMODE_ENGINE_HPP__ */
