#ifndef DEBUG_INFO_PROCESSOR_HPP__
#define DEBUG_INFO_PROCESSOR_HPP__

#include <map>
#include <llvm/IR/DebugInfo.h>
#include "Demangler.hpp"
#include "PredicateFactWriter.hpp"

namespace cclyzer {
    class DebugInfoProcessor;
}

class cclyzer::DebugInfoProcessor
    : private PredicateFactWriter, private Demangler
{
  public:
    DebugInfoProcessor(FactWriter &writer)
        : PredicateFactWriter(writer) {}

    /* Delegate to debug info finder */

    void
    processModule(const llvm::Module &module) {
        debugInfoFinder.processModule(module);
    }

    void
    processDeclare(const llvm::Module &module,
                   const llvm::DbgDeclareInst *inst) {
        debugInfoFinder.processDeclare(module, inst);
    }

    void
    processValue(const llvm::Module &module,
                 const llvm::DbgValueInst *inst) {
        debugInfoFinder.processValue(module, inst);
    }

    void reset() { debugInfoFinder.reset(); }


    /* Fact-generating methods */

    void
    postProcess(const llvm::Module &, std::string &path);

    void
    postProcessType(const llvm::DICompositeType &, const std::string &);

    void
    postProcessType(const llvm::DICompositeType &tp) {
        postProcessType(tp, "");
    }

    void
    postProcessTypedef(const llvm::DIDerivedType &, const std::string &);

  protected:

    // Construct a mapping from type ID to type name
    void CollectTypeIDs();

    // Append debug info scope to stream
    template<typename Stream>
    void printScope(Stream &stream, const llvm::DIScopeRef &outerScope);

    // Generate refmode for debug info composite type
    refmode_t refmodeOf(const llvm::DICompositeType &,
                        const std::string &altName = "");

    // Generate refmode for debug info global variables
    refmode_t refmodeOf(const llvm::DIGlobalVariable &,
                        std::string &);
  private:
    /* Debug Info */
    llvm::DebugInfoFinder debugInfoFinder;

    /* Mapping from DIType ID to type name  */
    std::map<std::string, refmode_t> typeNameByID;
};

#endif /* DEBUG_INFO_PROCESSOR_HPP__ */
