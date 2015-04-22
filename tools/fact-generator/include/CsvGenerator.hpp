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

#include "AuxiliaryMethods.hpp" // TODO: remove
#include "Options.hpp"
#include "PredicateFileMapping.hpp"


class CsvGenerator
{
    friend class InstructionVisitor;

  protected:

    /* Common type aliases */

    typedef boost::filesystem::path path;
    typedef boost::filesystem::ofstream ofstream;
    typedef boost::unordered_map<path, ofstream*> stream_cache_t;
    typedef boost::unordered_map<std::string, const llvm::Type *> type_cache_t;


    /* Filesystem path computation  */

    path prepend_dir(path p)
    {
        using namespace boost::filesystem;

        p = outDir / p;
        create_directory(p.parent_path());
        return p;
    }

    path toPath(const char * predName) {
        return prepend_dir(fileMappingScheme->toPath(predName));
    }

    path toPath(const char * predName, Operand::Type type) {
        return prepend_dir(fileMappingScheme->toPath(predName, type));
    }

    ofstream* getCsvFile(const char *predname) {
        return getCsvFile(toPath(predname));
    }

    ofstream* getCsvFile(path filename)
    {
        if (csvFiles.find(filename) == csvFiles.end())
            csvFiles[filename] = new ofstream(filename.c_str(), std::ios_base::out);

        return csvFiles[filename];
    }


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

    static std::string to_string(const llvm::Type *type) {
        return auxiliary_methods::printType(type);
    }

  public:
    /* Constructor must initialize output file streams */
    CsvGenerator(PredicateFileMapping &scheme, Options &options)
        : fileMappingScheme(&scheme)
    {
        // Set fields specified by command-line options
        outDir = options.getOutputDirectory();
        delim  = options.getDelimiter();

        // Initialize output file streams
        initStreams();
    }

    /* Destructor must flush and close all output file streams */
    ~CsvGenerator()
    {
        for(auto &kv : csvFiles)
        {
            ofstream *file = kv.second;
            file->flush();
            file->close();

            delete file;
        }
    }



    /* Basic routines for appending new facts to CSV files */

    void writeEntity(const char *entityName,
                     const std::string& entityRefmode)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(entityName);

        // Append new fact
        (*csvFile) << entityRefmode << "\n";
    }


    template<class ValType>
    void writeSimpleFact(const char *predName,
                         const std::string& entityRefmode,
                         const ValType& valueRefmode, int index = -1)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(predName);

        // Append fact while differentiating between ordinary and
        // indexed predicates

        if (index == -1)
            (*csvFile) << entityRefmode
                       << delim << valueRefmode << "\n";
        else
            (*csvFile) << entityRefmode
                       << delim << index
                       << delim << valueRefmode << "\n";
    }


    void writeOperandFact(const char *predName,
                          const std::string& entityRefmode,
                          const std::string& operandRefmode,
                          Operand::Type operandType, int index = -1)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(toPath(predName, operandType));

        // Append fact while differentiating between ordinary and
        // indexed predicates

        if (index == -1)
            (*csvFile) << entityRefmode
                       << delim << operandRefmode << "\n";
        else
            (*csvFile) << entityRefmode
                       << delim << index
                       << delim << operandRefmode << "\n";
    }


    // TODO: consider moving all these complex methods that deal with
    // predicate names to separate class
    void processModule(const llvm::Module *Mod, std::string& path);
    void writeVarsTypesAndImmediates();

    /* Complex fact writing methods */

    void writeGlobalVar(const llvm::GlobalVariable *gv, std::string globalName);
    void writeGlobalAlias(const llvm::GlobalAlias *ga, std::string globalAlias);
    void writeFunctionType(const llvm::FunctionType *functionType);
    void writeVectorType(const llvm::VectorType *vectorType);
    void writeStructType(const llvm::StructType *structType);
    void writeArrayType(const llvm::ArrayType *arrayType);
    void writePointerType(const llvm::PointerType *ptrType);

  private:
    /* Output directory */
    path outDir;

    /* Column Delimiter */
    std::string delim;

    /* Strategy pattern for mapping predicate names to filesystem paths */
    PredicateFileMapping *fileMappingScheme;

    /* Initialize output file streams */
    void initStreams();

    /* Cache of file descriptors with path as a key */
    stream_cache_t csvFiles;

    /* Caches for variable and constant types */
    type_cache_t variableTypes;
    type_cache_t constantTypes;


    /* Auxiliary methods */

    std::string getRefmodeForValue(const llvm::Module * Mod, const llvm::Value * Val, std::string& path){
        return "<" + path + ">:" + auxiliary_methods::valueToString(Val, Mod);
    }

    boost::unordered_set<const llvm::DataLayout *> layouts;
    boost::unordered_set<const llvm::Type *> types;

    static const char * simplePredicates[];
    static const char * operandPredicates[];
};

#endif
