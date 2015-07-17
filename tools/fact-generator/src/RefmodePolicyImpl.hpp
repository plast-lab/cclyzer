#include <sstream>
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

    refmode_t refmodeOfFunction(const llvm::Function *func, bool prefix=true) const;
    refmode_t refmodeOfBasicBlock(const llvm::BasicBlock *bb, bool prefix=true) const;
    refmode_t refmodeOfInstruction(const llvm::Instruction *instr, unsigned index) const;
    refmode_t refmodeOfConstant(const llvm::Constant *);
    refmode_t refmodeOfLocalValue(const llvm::Value *, bool prefix=true) const;
    refmode_t refmodeOfGlobalValue(const llvm::GlobalValue *val, bool prefix=true) const;

    // The following are copied from LLVM Diff Consumer

    /// Record that a local context has been entered.  ctx is an IR
    /// "container" of some sort which is being considered for
    /// structural equivalence: global variables, functions, blocks,
    /// instructions, etc.
    void enterContext(const llvm::Value *ctx)
    {
        std::string prefix;

        // Compute prefix for fully qualified value names under given
        // context

        if (llvm::isa<llvm::Function>(ctx)) {
            prefix = refmodeOfFunction(llvm::cast<llvm::Function>(ctx), false);
            instrIndex = 0;
        }
        else if (llvm::isa<llvm::BasicBlock>(ctx)) {
            prefix = refmodeOfBasicBlock(llvm::cast<llvm::BasicBlock>(ctx), false);
        }
        else if (llvm::isa<llvm::Instruction>(ctx)) {
            prefix = std::to_string(instrIndex++);
            constantIndex = 0;
        }

        contexts.push_back(RefContext(ctx, prefix));
    }

    /// Record that a local context has been exited.
    void exitContext() {
        contexts.pop_back();
    }

    void enterModule(const llvm::Module *module, const std::string &path)
    {
        using namespace llvm;

        Mod = module;
        mdnNext = 0;

        // Compute global prefix for this module
        std::stringstream prefix;
        prefix << '<' << path <<  '>' << std::flush;

        // Add context
        contexts.push_back(RefContext(prefix.str()));

        // Parse metadata
        parseMetadata(module);
    }

    void exitModule() {
        Mod = nullptr;
        mdnMap.clear();
        contexts.pop_back();
    }


    template<typename T, typename S>
    S &withContext(S &stream) const
    {
        for (std::vector<RefContext>::const_iterator
                 it = contexts.begin(); it != contexts.end(); ++it)
        {
            const llvm::Value *anchor = it->anchor;

            // Skip basic blocks
            if (anchor && llvm::isa<llvm::BasicBlock>(*anchor)
                       && !llvm::isa<T>(*anchor))
                continue;

            stream << it->prefix << ':';

            if (anchor && llvm::isa<T>(*anchor))
                break;
        }
        return stream;
    }

    template<typename S>
    S &withGlobalContext(S &stream) const
    {
        assert(!contexts.empty());
        assert(contexts[0].anchor == nullptr);
        stream << contexts[0].prefix << ':';
        return stream;
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
        RefContext(const llvm::Value *v, std::string prefix)
            : anchor(v), prefix(prefix)
            , isFunction(llvm::isa<llvm::Function>(v)) {}

        RefContext(std::string prefix)
            : anchor(nullptr), prefix(prefix)
            , isFunction(false) {}

        // Container of local context. Can be global variable,
        // function, block, instruction, etc.
        const llvm::Value *anchor;

        // Mapping numbers to unnamed values
        std::map<const llvm::Value*,unsigned> numbering;

        bool isFunction;

        std::string prefix;
    };

    // Tracking local contexts
    std::vector<RefContext> contexts;

    // Current module and path
    const llvm::Module *Mod;

    // Mapping numbers to metadata nodes, module-wise
    std::map<const llvm::MDNode*, unsigned> mdnMap;
    unsigned mdnNext;


    // Instruction and constant indices
    unsigned instrIndex;
    unsigned constantIndex;
};
