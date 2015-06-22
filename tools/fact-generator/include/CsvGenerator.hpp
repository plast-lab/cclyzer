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

#include "AuxiliaryMethods.hpp" // TODO: remove
#include "FactWriter.hpp"

class CsvGenerator
{
    friend class InstructionVisitor;

  protected:

    /* Common type aliases */

    typedef boost::unordered_map<std::string, const llvm::Type *> type_cache_t;


    /* Recording constants and variables */

    void recordConstant(std::string id, const llvm::Type *type) {
        constantTypes[id] = type;
    }

    void recordVariable(std::string id, const llvm::Type *type) {
        variableTypes[id] = type;
    }


    /* Serializing methods */

    static std::string to_string(llvm::GlobalValue::LinkageTypes LT);
    static std::string to_string(llvm::GlobalValue::VisibilityTypes Vis);
    static std::string to_string(llvm::GlobalVariable::ThreadLocalMode TLM);
    static std::string to_string(llvm::CallingConv::ID CC);

    static std::string to_string(const llvm::Type *type) {
        return auxiliary_methods::printType(type);
    }

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

    // TODO: consider moving all these complex methods that deal with
    // predicate names to separate class
    void processModule(const llvm::Module *Mod, std::string& path);
    void writeVarsTypesAndImmediates();

  private:
    /* Initialize output file streams */
    void initStreams();

    /* Fact writer */
    FactWriter &writer;

    /* Caches for variable and constant types */
    type_cache_t variableTypes;
    type_cache_t constantTypes;


    /* Auxiliary methods */

    std::string getRefmodeForValue(const llvm::Module * Mod, const llvm::Value * Val, std::string& path){
        return "<" + path + ">:" + auxiliary_methods::valueToString(Val, Mod);
    }

    boost::unordered_set<const llvm::Type *> types;
};

#endif
