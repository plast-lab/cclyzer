#ifndef CSV_GENERATOR_H__
#define CSV_GENERATOR_H__

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>
#include <llvm/IR/Type.h>
#include <llvm/IR/DataLayout.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Value.h>
#include <llvm/IR/GlobalValue.h>
#include <llvm/IR/GlobalVariable.h>
#include <string>
#include <vector>
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

    /**
     * After processing every module, we record information for all
     * the encountered types. To compute the byte size of each type,
     * we need a data layout object, which we can create given an LLVM
     * module. However, since this step is performed at the end we
     * have to keep a set of all data layouts (one per module).
     *
     * TODO: Consider moving the writing of types during module
     * processing, to be able to eliminate this field and only pass
     * the *current* data layout and module as function parameters to
     * the fact writing methods.
     */
    boost::unordered_set<const llvm::DataLayout *> layouts;

  public:
    /* Constructor must initialize output file streams */
    CsvGenerator(FactWriter &writer) : writer(writer)
    {
        // Initialize output file streams
        initStreams();
    }

    /* Global fact writing methods */

    void visitGlobalAlias(const llvm::GlobalAlias *, const refmode_t &);
    void visitGlobalVar(const llvm::GlobalVariable *, const refmode_t &);


    void processModule(const llvm::Module *Mod, std::string& path);
    void writeVarsTypesAndImmediates();

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

    inline std::string getRefmodeForValue(const llvm::Module * Mod, const llvm::Value * Val, std::string& path){
        return "<" + path + ">:" + refmodeOf(Val, Mod);
    }

    boost::unordered_set<const llvm::Type *> types;
};

#endif
