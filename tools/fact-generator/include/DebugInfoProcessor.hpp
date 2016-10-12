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

    refmode_t record_di_file(const llvm::DIFile & );
    refmode_t record_di_namespace(const llvm::DINamespace & );
    refmode_t record_di_scope(const llvm::DIScope & );
    refmode_t record_di_type(const llvm::DIType & );
    refmode_t record_di_template_param(const llvm::DITemplateParameter & );
    refmode_t record_di_variable(const llvm::DIVariable & );
    refmode_t record_di_subprogram(const llvm::DISubprogram & );
    refmode_t record_di_enumerator(const llvm::DIEnumerator & );
    refmode_t record_di_subrange(const llvm::DISubrange & );
    refmode_t record_di_imported_entity(const llvm::DIImportedEntity & );
    refmode_t record_di_location(const llvm::DILocation & );

  private:

    /* Opaque Pointer Idiom */
    class Impl;
    std::unique_ptr<Impl> impl;
};

#endif /* DEBUG_INFO_PROCESSOR_HPP__ */
