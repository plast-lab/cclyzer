#include <sstream>
#include <llvm/IR/ModuleSlotTracker.h>
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
    refmode_t refmodeOfConstant(const llvm::Constant *);
    refmode_t refmodeOfLocalValue(const llvm::Value *, bool prefix=true) const;
    refmode_t refmodeOfGlobalValue(const llvm::GlobalValue *val, bool prefix=true) const;
    refmode_t refmodeOfInstruction(const llvm::Instruction *instr, unsigned index) const;

    refmode_t refmodeOfInstruction(const llvm::Instruction *instr) const {
        return refmodeOfInstruction(instr, instrIndex - 1);
    }

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
        slotTracker = new ModuleSlotTracker(Mod);

        // Compute global prefix for this module
        std::stringstream prefix;
        prefix << '<' << path <<  '>' << std::flush;

        // Add context
        contexts.push_back(RefContext(prefix.str()));
    }

    void exitModule() {
        Mod = nullptr;
        contexts.pop_back();
        delete slotTracker;
    }

  protected:
    typedef LLVMEnumSerializer enums;

    // Compute variable numberings
    static void computeNumbering(const llvm::Function *, std::map<const llvm::Value*,unsigned> &);

    // Compute all metadata slots
    void parseMetadata(const llvm::Module *module);

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

        std::string prefix;

        bool isFunction;
    };

    // Tracking local contexts
    std::vector<RefContext> contexts;

    // Current module and path
    const llvm::Module *Mod;

    // Slot tracker
    llvm::ModuleSlotTracker *slotTracker;

    // Instruction and constant indices
    unsigned instrIndex;
    unsigned constantIndex;
};
