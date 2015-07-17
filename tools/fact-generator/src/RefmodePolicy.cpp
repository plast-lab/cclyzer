#include "RefmodePolicy.hpp"
#include "RefmodePolicyImpl.hpp"

using namespace llvm;


// Opaque Pointer Idiom

RefmodePolicy::RefmodePolicy() {
    impl = new Impl();
}

RefmodePolicy::~RefmodePolicy() {
    delete impl;
}

refmode_t RefmodePolicy::refmodeOf(GlobalValue::LinkageTypes LT) const {
    return impl->refmodeOf(LT);
}

refmode_t RefmodePolicy::refmodeOf(GlobalValue::VisibilityTypes Vis) const {
    return impl->refmodeOf(Vis);
}

refmode_t RefmodePolicy::refmodeOf(GlobalVariable::ThreadLocalMode TLM) const {
    return impl->refmodeOf(TLM);
}

refmode_t RefmodePolicy::refmodeOf(CallingConv::ID CC) const {
    return impl->refmodeOf(CC);
}

refmode_t RefmodePolicy::refmodeOf(AtomicOrdering AO) const {
    return impl->refmodeOf(AO);
}

refmode_t RefmodePolicy::refmodeOf(const Type *type) const {
    return impl->refmodeOf(type);
}

refmode_t RefmodePolicy::refmodeOf(const Value * Val) const {
    return impl->refmodeOf(Val);
}

refmode_t RefmodePolicy::refmodeOfFunction(const Function * func) const {
    return impl->refmodeOfFunction(func);
}

refmode_t RefmodePolicy::refmodeOfBasicBlock(const llvm::BasicBlock *bb) const {
    return impl->refmodeOfBasicBlock(bb);
}

refmode_t RefmodePolicy::refmodeOfInstruction(const llvm::Instruction *instr, unsigned index) const {
    return impl->refmodeOfInstruction(instr, index);
}

refmode_t RefmodePolicy::refmodeOfConstant(const llvm::Constant *c) const {
    return impl->refmodeOfConstant(c);
}

refmode_t RefmodePolicy::refmodeOfLocalValue(const llvm::Value *val) const {
    return impl->refmodeOfLocalValue(val);
}

refmode_t RefmodePolicy::refmodeOfGlobalValue(const llvm::GlobalValue *val) const {
    return impl->refmodeOfGlobalValue(val);
}

void RefmodePolicy::enterContext(const Value *val) {
    impl->enterContext(val);
}

void RefmodePolicy::exitContext() {
    impl->exitContext();
}

void RefmodePolicy::enterModule(const Module *module, const std::string &path) {
    impl->enterModule(module, path);
}

void RefmodePolicy::exitModule() {
    impl->exitModule();
}
