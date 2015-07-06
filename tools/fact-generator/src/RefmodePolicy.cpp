#include <sstream>
#include <map>
#include <boost/algorithm/string.hpp>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Metadata.h>
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
    refmode_t refmodeOf(const llvm::Value *Val) const;
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

    void enterModule(const llvm::Module *module)
    {
        using namespace llvm;

        Mod = module;
        mdnNext = 0;

        // Add metadata used by named metadata.
        for (Module::const_named_metadata_iterator
                 I = module->named_metadata_begin(),
                 E = module->named_metadata_end(); I != E; ++I)
        {
            const NamedMDNode *NMD = I;

            for (unsigned i = 0, e = NMD->getNumOperands(); i != e; ++i)
                createMetadataSlot(NMD->getOperand(i));
        }

        SmallVector<std::pair<unsigned, MDNode*>, 4> MDForInst;

        // Iterate over functions
        for (Module::const_iterator
                 fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi)
        {
            // Iterate over basic blocks
            for (Function::const_iterator
                     bbi = fi->begin(),
                     bbi_end = fi->end(); bbi != bbi_end; ++bbi)
            {
                // Iterate over instructions
                for (BasicBlock::const_iterator
                         I = bbi->begin(), E = bbi->end(); I != E; ++I)
                {
                    // Intrinsics can directly use metadata.  We allow direct calls to any
                    // llvm.foo function here, because the target may not be linked into the
                    // optimizer.
                    if (const CallInst *CI = dyn_cast<CallInst>(I)) {
                        if (Function *F = CI->getCalledFunction())
                            if (F->isIntrinsic())
                                for (unsigned i = 0, e = I->getNumOperands(); i != e; ++i)
                                    if (MDNode *N = dyn_cast_or_null<MDNode>(I->getOperand(i)))
                                        createMetadataSlot(N);
                    }

                    // Process metadata attached with this instruction.
                    I->getAllMetadata(MDForInst);
                    for (unsigned i = 0, e = MDForInst.size(); i != e; ++i)
                        createMetadataSlot(MDForInst[i].second);
                    MDForInst.clear();
                }
            }
        }
    }

    void exitModule() {
        Mod = nullptr;
        mdnMap.clear();
    }

  protected:
    typedef LLVMEnumSerializer enums;

    // Compute variable numberings
    static void computeNumbering(const llvm::Function *, std::map<const llvm::Value*,unsigned> &);

    // Add metadata node
    void createMetadataSlot(const llvm::MDNode *N);

    // Retrieve metadata slot
    int getMetadataSlot(const llvm::MDNode *N) const {
        // Find the MDNode in the module map
        std::map<const llvm::MDNode*, unsigned>::const_iterator MI = mdnMap.find(N);
        return MI == mdnMap.end() ? -1 : (int) MI->second;
    }

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

    // Current module
    const llvm::Module *Mod;

    // Mapping numbers to metadata nodes, module-wise
    std::map<const llvm::MDNode*, unsigned> mdnMap;
    unsigned mdnNext;
};


using std::string;
using namespace llvm;
using namespace boost::algorithm;


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

refmode_t RefmodePolicy::refmodeOf(const llvm::Value * Val) const {
    return impl->refmodeOf(Val);
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

void RefmodePolicy::enterModule(const llvm::Module *module) {
    impl->enterModule(module);
}

void RefmodePolicy::exitModule() {
    impl->exitModule();
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

refmode_t RefmodePolicy::Impl::refmodeOf(const llvm::Value * Val) const
{
    string rv;
    raw_string_ostream rso(rv);

    if (Val->hasName()) {
        rso << (isa<GlobalValue>(Val) ? '@' : '%')
            << Val->getName();
        goto print;
    }

    if (isa<Constant>(Val)) {
        Val->printAsOperand(rso, false);
        goto print;
    }

    if (Val->getType()->isVoidTy()) {
        Val->printAsOperand(rso, false, Mod);
        goto print;
    }

    if (Val->getType()->isMetadataTy()) {
        const MDNode *N = cast<MDNode>(Val);

        if (N->isFunctionLocal()) {
            rso << "!{";

            for (unsigned mi = 0, me = N->getNumOperands(); mi != me; ++mi) {
                const Value *V = N->getOperand(mi);
                if (!V)
                    rso << "null";
                else {
                    rso << refmodeOf(V->getType())
                        << ' '
                        << refmodeOf(V);
                }
                if (mi + 1 != me)
                    rso << ", ";
            }

            rso << "}";
        } else {
            // unnamed metadata value
            rso << '!' << getMetadataSlot(N);
        }
        goto print;
    }

    // Handle unnamed variables
    {
        unsigned N = contexts.size();

        while (N > 0) {
            --N;
            RefContext &ctxt = const_cast<RefContext&>(contexts[N]);

            if (ctxt.isFunction) {

                if (ctxt.numbering.empty())
                    computeNumbering(cast<llvm::Function>(ctxt.anchor), ctxt.numbering);

                rso << '%' << ctxt.numbering[Val];
                goto print;
            }
        }
    }

    // Expensive
    Val->printAsOperand(rso, false, Mod);

print:
    // Trim external whitespace
    string ref = rso.str();
    trim(ref);

    return ref;
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


void RefmodePolicy::Impl::createMetadataSlot(const MDNode *N)
{
    assert(N);

    // Don't insert if N is a function-local metadata, these are always printed
    // inline.
    if (!N->isFunctionLocal()) {
        std::map<const MDNode*, unsigned>::iterator I = mdnMap.find(N);

        if (I != mdnMap.end())
            return;

        unsigned DestSlot = mdnNext++;
        mdnMap[N] = DestSlot;
    }

    // Recursively add any MDNodes referenced by operands.
    for (unsigned i = 0, e = N->getNumOperands(); i != e; ++i)
        if (const MDNode *Op = dyn_cast_or_null<MDNode>(N->getOperand(i)))
            createMetadataSlot(Op);
}
