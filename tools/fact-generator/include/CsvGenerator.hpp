#ifndef CSV_GENERATOR_H__
#define CSV_GENERATOR_H__

#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>
#include <llvm/IR/Type.h>
#include <llvm/IR/DataLayout.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <string>
#include "predicate_groups.hpp"
#include "FactWriter.hpp"
#include "RefmodePolicy.hpp"

class CsvGenerator : private RefmodePolicy
{
    friend class InstructionVisitor;
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

    inline void writeFact(const pred_t &predicate,
                          const refmode_t& entity)
    {
        writer.writeFact(predicate.c_str(), entity);
    }

    template<class ValType>
    inline void writeFact(const pred_t &predicate,
                          const refmode_t& entity,
                          const ValType& value)
    {
        writer.writeFact(predicate.c_str(), entity, value);
    }

    template<class ValType>
    inline void writeFact(const pred_t &predicate,
                          const refmode_t& entity,
                          const ValType& value, int index)
    {
        writer.writeFact(predicate.c_str(), entity, value, index);
    }

    void writeFnAttributes(const pred_t &pred,
                           const refmode_t &refmode,
                           const llvm::AttributeSet Attrs);

  public:
    /* Constructor must initialize output file streams */
    CsvGenerator(FactWriter &writer) : writer(writer) {
        initStreams();
    }

    /* Global fact writing methods */

    void visitGlobalAlias(const llvm::GlobalAlias *, const refmode_t &);
    void visitGlobalVar(const llvm::GlobalVariable *, const refmode_t &);


    void processModule(const llvm::Module *Mod, std::string& path);
    void writeVarsTypesAndImmediates(const llvm::DataLayout &layout);

    /* Visitor classes */
    class TypeVisitor;
    friend class TypeVisitor;

  private:
    /* Initialize output file streams */
    void initStreams();

    /* Fact writer */
    FactWriter &writer;

    /* Caches for variable and constant types */
    type_cache_t variableTypes;
    type_cache_t constantTypes;


    /* Auxiliary methods */

    boost::unordered_set<const llvm::Type *> types;

    /* A RAII object for recording the current context. */
    struct Context {
        Context(CsvGenerator &generator, const llvm::Value *v)
            : gen(generator) {
            gen.enterContext(v);
        }

        ~Context() {
            gen.exitContext();
        }

      private:
        CsvGenerator &gen;
    };

    struct ModuleContext {
        ModuleContext(CsvGenerator &generator, const llvm::Module *m, const std::string &path)
            : gen(generator) {
            gen.enterModule(m, path);
        }

        ~ModuleContext() {
            gen.exitModule();
        }

      private:
        CsvGenerator &gen;
    };
};

#endif
