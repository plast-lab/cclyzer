#include <llvm/Support/raw_ostream.h>
#include "RefmodePolicy.hpp"
#include "LLVMEnums.hpp"

// Refmode Policy implementation
class RefmodePolicy::Impl : LLVMEnumSerializer {
  public:
    // Methods that compute refmodes for various LLVM types
    std::string refmodeOf(llvm::GlobalValue::LinkageTypes LT) const;
    std::string refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) const;
    std::string refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) const;
    std::string refmodeOf(llvm::CallingConv::ID CC) const;
    std::string refmodeOf(const llvm::Type *type) const;

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
