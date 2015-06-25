#include <sstream>
#include <llvm/Assembly/Writer.h> // This is for version <= 3.4
#include <llvm/Support/raw_ostream.h>
#include "RefmodePolicy.hpp"
#include "LLVMEnums.hpp"

// Refmode Policy implementation
class RefmodePolicy::Impl : LLVMEnumSerializer {
  public:
    // Methods that compute refmodes for various LLVM types
    refmode_t refmodeOf(llvm::GlobalValue::LinkageTypes LT) const;
    refmode_t refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const;
    refmode_t refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const;
    refmode_t refmodeOf(llvm::CallingConv::ID CC) const;
    refmode_t refmodeOf(const llvm::Type *type) const;
    refmode_t refmodeOf(const llvm::Value *Val, const llvm::Module *Mod = 0) const;
    refmode_t refmodeOf(const llvm::Function *func, const std::string &path) const;

  protected:
    typedef LLVMEnumSerializer enums;
};


using std::string;
using namespace llvm;


// Refmodes for LLVM TYpe

refmode_t RefmodePolicy::Impl::refmodeOf(const Type *type) const
{
    string type_str;
    raw_string_ostream rso(type_str);

    if (type->isStructTy()) {
        const StructType *STy = cast<StructType>(type);

        if (STy->isLiteral()) {
            type->print(rso);
            return rso.str();
        }

        if (STy->hasName()) {
            rso << "%" << STy->getName();
            return rso.str();
        }
        rso << "%\"type " << STy << "\"";
    }
    else {
        type->print(rso);
    }
    return rso.str();
}


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

refmode_t RefmodePolicy::refmodeOf(const Type *type) const {
    return impl->refmodeOf(type);
}

refmode_t RefmodePolicy::refmodeOf(const llvm::Value * Val, const Module * Mod) const {
    return impl->refmodeOf(Val, Mod);
}

refmode_t RefmodePolicy::refmodeOf(const llvm::Function * func, const std::string &path) const {
    return impl->refmodeOf(func, path);
}


// Refmodes for LLVM Enums

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalValue::LinkageTypes LT) const {
    return enums::to_string(LT);
}

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalValue::VisibilityTypes Vis) const {
    return enums::to_string(Vis);
}

refmode_t RefmodePolicy::Impl::refmodeOf(GlobalVariable::ThreadLocalMode TLM) const {
    return enums::to_string(TLM);
}

refmode_t RefmodePolicy::Impl::refmodeOf(CallingConv::ID CC) const {
    return enums::to_string(CC);
}

// Refmode for LLVM Values

refmode_t RefmodePolicy::Impl::refmodeOf(const llvm::Value * Val, const Module * Mod) const
{
    string rv;
    raw_string_ostream rso(rv);
    WriteAsOperand(rso, Val, false, Mod);
    return rso.str();
}


// Refmode for LLVM Functions

refmode_t RefmodePolicy::Impl::refmodeOf(
    const llvm::Function * func, const std::string &path) const
{
    std::ostringstream refmode;

    refmode << '<' << path <<  ">:"
            << string(func->getName());

    return refmode.str();
}
