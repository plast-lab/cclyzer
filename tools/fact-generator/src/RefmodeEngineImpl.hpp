#include <sstream>
#include <llvm/IR/ModuleSlotTracker.h>
#include "ContextManager.hpp"
#include "RefmodeEngine.hpp"

// Forward declaration
namespace llvm {
    class raw_string_ostream;
}

// Refmode Policy implementation
class cclyzer::RefmodeEngine::Impl
{
  public:

    // Compute refmode for obj, given some context state
    template<typename T>
    refmode_t refmode(const T& obj); // const;

    //-------------------------------------------------
    // Context management
    //-------------------------------------------------

    void enterContext(const llvm::Value& val) {
        ctx->pushContext(val);
    }

    void exitContext() {
        ctx->popContext();
    }

    void enterModule(const llvm::Module& module, const std::string& path)
    {
        slotTracker.reset(new llvm::ModuleSlotTracker(&module));
        ctx.reset(new ContextManager(module, path));
    }

    void exitModule() {}

  protected:

    // Methods that compute refmodes for various LLVM types
    refmode_t refmodeOf(const llvm::Value *Val);

    void appendMetadataId(llvm::raw_string_ostream & , const llvm::Metadata & );

    // Compute variable numberings
    static void computeNumbering(
        const llvm::Function *, std::map<const llvm::Value*,unsigned> &);

    // Compute all metadata slots
    void parseMetadata(const llvm::Module *module);

    template<typename T, typename S>
    S &withContext(S &stream) const
    {
        for (ContextManager::const_iterator
                 it = ctx->begin(); it != ctx->end(); ++it)
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
        ContextManager::iterator firstCtxt = ctx->begin();

        assert(firstCtxt != ctx->end());
        assert(firstCtxt->anchor == nullptr);
        stream << firstCtxt->prefix << ':';
        return stream;
    }

  private:
    // Slot tracker and context manager
    std::unique_ptr<llvm::ModuleSlotTracker> slotTracker;
    std::unique_ptr<ContextManager> ctx;
};
