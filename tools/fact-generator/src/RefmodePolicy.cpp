#include "RefmodePolicy.hpp"
#include "RefmodePolicyImpl.hpp"


using cclyzer::RefmodePolicy;

// Opaque Pointer Idiom

RefmodePolicy::RefmodePolicy() {
    impl = new Impl();
}

RefmodePolicy::~RefmodePolicy() {
    delete impl;
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(llvm::GlobalValue::LinkageTypes LT) const {
    return impl->refmodeOf(LT);
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const {
    return impl->refmodeOf(Vis);
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const {
    return impl->refmodeOf(TLM);
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(llvm::CallingConv::ID CC) const {
    return impl->refmodeOf(CC);
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(llvm::AtomicOrdering AO) const {
    return impl->refmodeOf(AO);
}

cclyzer::refmode_t RefmodePolicy::refmodeOf(const llvm::Type *type) const {
    return impl->refmodeOf(type);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfFunction(const llvm::Function * func) const {
    return impl->refmodeOfFunction(func);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfBasicBlock(const llvm::BasicBlock *bb) const {
    return impl->refmodeOfBasicBlock(bb);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfInstruction(const llvm::Instruction *instr, unsigned index) const {
    return impl->refmodeOfInstruction(instr, index);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfInstruction(const llvm::Instruction *instr) const {
    return impl->refmodeOfInstruction(instr);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfConstant(const llvm::Constant *c) const {
    return impl->refmodeOfConstant(c);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfLocalValue(const llvm::Value *val) const {
    return impl->refmodeOfLocalValue(val);
}

cclyzer::refmode_t RefmodePolicy::refmodeOfGlobalValue(const llvm::GlobalValue *val) const {
    return impl->refmodeOfGlobalValue(val);
}

void RefmodePolicy::enterContext(const llvm::Value *val) {
    impl->enterContext(val);
}

void RefmodePolicy::exitContext() {
    impl->exitContext();
}

void RefmodePolicy::enterModule(const llvm::Module *module, const std::string &path) {
    impl->enterModule(module, path);
}

void RefmodePolicy::exitModule() {
    impl->exitModule();
}
