#ifndef CSV_GENERATOR_H__
#define CSV_GENERATOR_H__

#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>
#include <llvm/IR/Attributes.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/InlineAsm.h>
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
#include "ForwardingFactWriter.hpp"
#include "RefmodeEngine.hpp"

namespace cclyzer {
    class FactGenerator;
}

class cclyzer::FactGenerator
    : private RefmodeEngine,
      private Demangler,
      private ForwardingFactWriter
{
    friend class InstructionVisitor;
    friend class TypeVisitor;
    using RefmodeEngine::refmode;

  public:
    /* Get fact generator instance for a given fact writer */
    static FactGenerator& getInstance(FactWriter & );

    /* Fact Writing Methods */
    refmode_t writeConstant(const llvm::Constant&);
    refmode_t writeAsm(const llvm::InlineAsm&);

    void processModule(const llvm::Module &Mod, const std::string& path);
    void writeOperands(const llvm::DataLayout &layout);

  protected:
    /* Common type aliases */
    typedef boost::unordered_map<std::string, const llvm::Type *> type_cache_t;
    typedef predicates::pred_t pred_t;
    typedef predicates::entity_pred_t entity_pred_t;
    typedef predicates::operand_pred_t operand_pred_t;

    /* Constructor must initialize output file streams */
    FactGenerator(FactWriter &writer)
        : ForwardingFactWriter(writer)
        , debugInfoProcessor(writer, static_cast<RefmodeEngine&>(*this))
    {}

    /* Recording variables and types */
    void recordVariable(std::string id, const llvm::Type *type) {
        variableTypes[id] = type;
    }

    refmode_t recordType(const llvm::Type *type) {
        types.insert(type);
        return refmode<llvm::Type>(*type);
    }


    /* Auxiliary fact writing methods */

    template<typename PredGroup>
    void writeFnAttributes(const refmode_t&, const llvm::AttributeSet);

    template<typename PredGroup, class ConstantType>
    void writeConstantWithOperands(const ConstantType&, const refmode_t&);

    void writeFunction(const llvm::Function&, const refmode_t&);
    void writeConstantArray(const llvm::ConstantArray&, const refmode_t&);
    void writeConstantStruct(const llvm::ConstantStruct&, const refmode_t&);
    void writeConstantVector(const llvm::ConstantVector&, const refmode_t&);
    void writeConstantExpr(const llvm::ConstantExpr&, const refmode_t&);
    void writeGlobalAlias(const llvm::GlobalAlias & , const refmode_t & );
    void writeGlobalVar(const llvm::GlobalVariable &, const refmode_t & );

    void visitNamedMDNode(const llvm::NamedMDNode & );

  private:
    /* Non-copyable */
    FactGenerator(FactGenerator const&) = delete;
    FactGenerator& operator= (FactGenerator const&) = delete;

    /* Initialize output file streams */
    void initStreams();

    /* Caches for variable types */
    type_cache_t variableTypes;

    /* Debug Info */
    DebugInfoProcessor debugInfoProcessor;

    /* Auxiliary methods */

    boost::unordered_set<const llvm::Type *> types;

    /* A RAII object for recording the current context. */
    struct Context {
        Context(FactGenerator &generator, const llvm::Value &v)
            : gen(generator) {
            gen.enterContext(v);
        }

        ~Context() {
            gen.exitContext();
        }

      private:
        FactGenerator &gen;
    };

    struct ModuleContext {
        ModuleContext(FactGenerator& generator, const llvm::Module& m, const std::string& path)
            : gen(generator)
        {
            gen.enterModule(m, path);
            gen.debugInfoProcessor.processModule(m);
        }

        ~ModuleContext() {
            gen.exitModule();
            gen.debugInfoProcessor.reset();
        }

      private:
        FactGenerator &gen;
    };
};

#endif
