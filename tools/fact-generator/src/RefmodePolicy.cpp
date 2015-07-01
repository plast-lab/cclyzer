#include <sstream>
#include <map>
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
    refmode_t refmodeOf(llvm::AtomicOrdering AO) const;
    refmode_t refmodeOf(const llvm::Type *type) const;
    refmode_t refmodeOf(const llvm::Value *Val, const llvm::Module *Mod = 0) const;
    refmode_t refmodeOf(const llvm::Function *func, const std::string &path) const;

    // The following are copied from LLVM Diff Consumer

    /// Record that a local context has been entered.  ctx is an IR
    /// "container" of some sort which is being considered for
    /// structural equivalence: global variables, functions, blocks,
    /// instructions, etc.
    void enterContext(const llvm::Value *ctx) {
        contexts.push_back(RefContext(ctx));
    }

    /// Record that a local context has been exited.
    void exitContext() {
        contexts.pop_back();
    }

  protected:
    typedef LLVMEnumSerializer enums;

    // Compute variable numberings
    static void computeNumbering(const llvm::Function *, std::map<const llvm::Value*,unsigned> &);

  private:

    struct RefContext {
        RefContext(const llvm::Value *v)
            : anchor(v), isFunction(llvm::isa<llvm::Function>(v)) {}

        // Container of local context. Can be global variable,
        // function, block, instruction, etc.
        const llvm::Value *anchor;

        // Mapping numbers to unnamed values
        std::map<const llvm::Value*,unsigned> numbering;

        bool isFunction;
    };

    // Tracking local contexts
    std::vector<RefContext> contexts;
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

refmode_t RefmodePolicy::refmodeOf(llvm::AtomicOrdering AO) const {
    return impl->refmodeOf(AO);
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

void RefmodePolicy::enterContext(const llvm::Value *val) {
    impl->enterContext(val);
}

void RefmodePolicy::exitContext() {
    impl->exitContext();
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

refmode_t RefmodePolicy::Impl::refmodeOf(AtomicOrdering AO) const {
    return enums::to_string(AO);
}


// Refmode for LLVM Values

refmode_t RefmodePolicy::Impl::refmodeOf(const llvm::Value * Val, const Module * Mod) const
{
    string rv;
    raw_string_ostream rso(rv);

    do {
        if (Val->hasName()) {
            rso << (isa<GlobalValue>(Val) ? '@' : '%')
                << Val->getName();
            break;
        }

        if (isa<Constant>(Val)) { // this also prints type
            rso << *Val;
            break;
        }

        if (Val->getType()->isVoidTy()) {
            Val->printAsOperand(rso, false, Mod);
            break;
        }

        if (Val->getType()->isMetadataTy()) {
            Val->printAsOperand(rso, false, Mod);
            break;
        }

        unsigned N = contexts.size();

        while (N > 0) {
            --N;
            RefContext &ctxt = const_cast<RefContext&>(contexts[N]);

            if (ctxt.isFunction) {

                if (ctxt.numbering.empty())
                    computeNumbering(cast<llvm::Function>(ctxt.anchor), ctxt.numbering);

                rso << '%' << ctxt.numbering[Val];
                return rso.str();
            }
        }

        // Expensive
        Val->printAsOperand(rso, false, Mod);
    } while(0);

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



void RefmodePolicy::Impl::computeNumbering(
    const llvm::Function *func, std::map<const llvm::Value*,unsigned> &numbering)
{
    unsigned counter = 0;

    // Arguments get the first numbers.
    for (Function::const_arg_iterator
             ai = func->arg_begin(), ae = func->arg_end(); ai != ae; ++ai)
    {
        if (!ai->hasName())
            numbering[&*ai] = counter++;
    }

    // Walk the basic blocks in order.
    for (llvm::Function::const_iterator
             fi = func->begin(), fe = func->end(); fi != fe; ++fi)
    {
        if (!fi->hasName())
            numbering[&*fi] = counter++;

        // Walk the instructions in order.
        for (llvm::BasicBlock::const_iterator
                 bi = fi->begin(), be = fi->end(); bi != be; ++bi)
        {
            // void instructions don't get numbers.
            if (!bi->hasName() && !bi->getType()->isVoidTy())
                numbering[&*bi] = counter++;
        }
    }

    assert(!numbering.empty() && "asked for numbering but numbering was no-op");
}
