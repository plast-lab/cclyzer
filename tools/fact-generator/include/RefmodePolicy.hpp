#ifndef REFMODE_POLICY_HPP__
#define REFMODE_POLICY_HPP__

#include <string>
#include <llvm/IR/Function.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/CallingConv.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/Instructions.h>

/* Type aliases */
typedef std::string refmode_t;

class RefmodePolicy {
  public:
    RefmodePolicy();
    ~RefmodePolicy();

    refmode_t refmodeOf(llvm::GlobalValue::LinkageTypes LT) const;
    refmode_t refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const;
    refmode_t refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const;
    refmode_t refmodeOf(llvm::CallingConv::ID CC) const;
    refmode_t refmodeOf(llvm::AtomicOrdering AO) const;
    refmode_t refmodeOf(const llvm::Type *type) const;

    refmode_t refmodeOf(const llvm::Value *Val) const;
    refmode_t refmodeOf(const llvm::Function *func, const std::string &path) const;

    void enterContext(const llvm::Value *val);
    void exitContext();

    void enterModule(const llvm::Module *Mod, const std::string &path);
    void exitModule();

  private:
    /* Opaque Pointer Idiom */
    class Impl;
    Impl *impl;
};

#endif /* REFMODE_POLICY_HPP__ */
