#ifndef DEBUG_INFO_PROCESSOR_HPP__
#define DEBUG_INFO_PROCESSOR_HPP__

#include <llvm/IR/DebugInfo.h>
#include "Demangler.hpp"
#include "PredicateFactWriter.hpp"

class DebugInfoProcessor
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
    postProcess(const llvm::Module &);

    void
    postProcessType(const llvm::DICompositeType &,
                    const std::string altName = "");

  private:
    /* Debug Info */
    llvm::DebugInfoFinder debugInfoFinder;
};

#endif /* DEBUG_INFO_PROCESSOR_HPP__ */
