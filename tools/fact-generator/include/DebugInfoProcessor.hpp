#ifndef DEBUG_INFO_PROCESSOR_HPP__
#define DEBUG_INFO_PROCESSOR_HPP__

#include <map>
#include <memory>
#include <llvm/IR/DebugInfo.h>
#include "FactWriter.hpp"

namespace cclyzer {
    class DebugInfoProcessor;
}

class cclyzer::DebugInfoProcessor
{
  public:
    DebugInfoProcessor(FactWriter &, RefmodeEngine & );
    ~DebugInfoProcessor();

    /* Process elements with debug information */

    void processModule(const llvm::Module & );
    void processDeclare(const llvm::Module &, const llvm::DbgDeclareInst * );
    void processValue(const llvm::Module &, const llvm::DbgValueInst * );
    void reset();

    /* Generate and write any stored debug information */
    void generateDebugInfo(const llvm::Module &, const std::string &);

  private:

    /* Opaque Pointer Idiom */
    class Impl;
    std::unique_ptr<Impl> impl;
};

#endif /* DEBUG_INFO_PROCESSOR_HPP__ */
