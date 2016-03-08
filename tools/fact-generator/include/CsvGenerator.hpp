#ifndef CSV_GENERATOR_H__
#define CSV_GENERATOR_H__

#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/DataLayout.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <string>
#include "predicate_groups.hpp"
#include "Demangler.hpp"
#include "DebugInfoProcessor.hpp"
#include "FactWriter.hpp"
#include "RefmodePolicy.hpp"

namespace cclyzer {
    class CsvGenerator;
}

class cclyzer::CsvGenerator
    : private RefmodePolicy,
      private Demangler,
      private PredicateFactWriter
{
    friend class InstructionVisitor;
    friend class TypeVisitor;
    using RefmodePolicy::refmodeOf;

  protected:

    /* Common type aliases */

    typedef boost::unordered_map<std::string, const llvm::Type *> type_cache_t;
    typedef predicates::pred_t pred_t;
    typedef predicates::entity_pred_t entity_pred_t;
    typedef predicates::operand_pred_t operand_pred_t;


    /* Recording constants and variables */

    void recordConstant(std::string id, const llvm::Type *type) {
        constantTypes[id] = type;
    }

    void recordVariable(std::string id, const llvm::Type *type) {
        variableTypes[id] = type;
    }


    /* Fact writing methods */

    template<typename PredGroup>
    void writeFnAttributes(const refmode_t &refmode, const llvm::AttributeSet Attrs);

    void writeConstantArray(const llvm::ConstantArray&, const refmode_t &);
    void writeConstantStruct(const llvm::ConstantStruct&, const refmode_t &);
    void writeConstantVector(const llvm::ConstantVector&, const refmode_t &);
    void writeConstantExpr(const llvm::ConstantExpr&, const refmode_t &);
    refmode_t writeConstant(const llvm::Constant&);

    template<typename PredGroup, class ConstantType>
    void writeConstantWithOperands(const ConstantType &base, const refmode_t &refmode)
    {
        unsigned nOperands = base.getNumOperands();

        for (unsigned i = 0; i < nOperands; i++)
        {
            const llvm::Constant *c = base.getOperand(i);

            refmode_t index_ref = writeConstant(*c);
            writeFact(PredGroup::index, refmode, i, index_ref);
        }

        writeFact(PredGroup::size, refmode, nOperands);
        writeFact(PredGroup::id, refmode);
    }

  public:
    /* Constructor must initialize output file streams */
    CsvGenerator(FactWriter &writer)
        : PredicateFactWriter(writer), debugInfoProcessor(writer) {}

    /* Global fact writing methods */

    void visitGlobalAlias(const llvm::GlobalAlias *, const refmode_t &);
    void visitGlobalVar(const llvm::GlobalVariable *, const refmode_t &);
    void visitNamedMDNode(const llvm::NamedMDNode *NMD);


    void processModule(const llvm::Module &Mod, const std::string& path);
    void writeVarsTypesAndConstants(const llvm::DataLayout &layout);


  private:
    /* Initialize output file streams */
    void initStreams();

    /* Caches for variable and constant types */
    type_cache_t variableTypes;
    type_cache_t constantTypes;

    /* Debug Info */
    DebugInfoProcessor debugInfoProcessor;

    /* Auxiliary methods */

    boost::unordered_set<const llvm::Type *> types;

    /* A RAII object for recording the current context. */
    struct Context {
        Context(CsvGenerator &generator, const llvm::Value &v)
            : gen(generator) {
            gen.enterContext(&v);
        }

        ~Context() {
            gen.exitContext();
        }

      private:
        CsvGenerator &gen;
    };

    struct ModuleContext {
        ModuleContext(CsvGenerator &generator, const llvm::Module &m, const std::string &path)
            : gen(generator)
        {
            gen.enterModule(&m, path);
            gen.debugInfoProcessor.processModule(m);
        }

        ~ModuleContext() {
            gen.exitModule();
            gen.debugInfoProcessor.reset();
        }

      private:
        CsvGenerator &gen;
    };
};

#endif
