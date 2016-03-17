#include "RefmodeEngine.hpp"
#include "RefmodeEngineImpl.hpp"


using cclyzer::RefmodeEngine;

// Opaque Pointer Idiom

RefmodeEngine::RefmodeEngine() {
    impl = new Impl();
}

RefmodeEngine::~RefmodeEngine() {
    delete impl;
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(llvm::GlobalValue::LinkageTypes LT) const {
    return impl->refmodeOf(LT);
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const {
    return impl->refmodeOf(Vis);
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const {
    return impl->refmodeOf(TLM);
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(llvm::CallingConv::ID CC) const {
    return impl->refmodeOf(CC);
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(llvm::AtomicOrdering AO) const {
    return impl->refmodeOf(AO);
}

cclyzer::refmode_t RefmodeEngine::refmodeOf(const llvm::Type *type) const {
    return impl->refmodeOf(type);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfFunction(const llvm::Function * func) const {
    return impl->refmodeOfFunction(func);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfBasicBlock(const llvm::BasicBlock *bb) const {
    return impl->refmodeOfBasicBlock(bb);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfInstruction(const llvm::Instruction *instr) const {
    return impl->refmodeOfInstruction(instr);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfConstant(const llvm::Constant *c) const {
    return impl->refmodeOfConstant(c);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfLocalValue(const llvm::Value *val) const {
    return impl->refmodeOfLocalValue(val);
}

cclyzer::refmode_t RefmodeEngine::refmodeOfGlobalValue(const llvm::GlobalValue *val) const {
    return impl->refmodeOfGlobalValue(val);
}

void RefmodeEngine::enterContext(const llvm::Value *val) {
    impl->enterContext(val);
}

void RefmodeEngine::exitContext() {
    impl->exitContext();
}

void RefmodeEngine::enterModule(const llvm::Module *module, const std::string &path) {
    impl->enterModule(module, path);
}

void RefmodeEngine::exitModule() {
    impl->exitModule();
}
