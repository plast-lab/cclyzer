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

    void enterModule(const llvm::Module *module, const std::string &p)
    {
        using namespace llvm;

        Mod = module;
        path = p;
        mdnNext = 0;

        parseMetadata(module);
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

    // Compute all metadata slots
    void parseMetadata(const llvm::Module *module);

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

    // Current module and path
    const llvm::Module *Mod;
    std::string path;

    // Mapping numbers to metadata nodes, module-wise
    std::map<const llvm::MDNode*, unsigned> mdnMap;
    unsigned mdnNext;
};
