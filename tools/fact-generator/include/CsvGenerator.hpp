#ifndef CSV_GENERATOR_H__
#define CSV_GENERATOR_H__

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/unordered_set.hpp>
#include <boost/unordered_map.hpp>
#include <string>

#include "llvm/IR/Type.h"
#include "llvm/IR/Value.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/GlobalValue.h"
#include "llvm/IR/GlobalVariable.h"

#include "AuxiliaryMethods.hpp"
#include "PredicateNames.hpp"
#include "PredicateFileMapping.hpp"
#include "Options.hpp"



class CsvGenerator
{
  protected:
    typedef boost::filesystem::path path;
    typedef boost::filesystem::ofstream ofstream;
    typedef boost::unordered_map<path, ofstream*> stream_cache_t;

    path prepend_dir(path p) {
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

  public:
    CsvGenerator(PredicateFileMapping &scheme, Options &options)
        : fileMappingScheme(&scheme)
    {
        // Set fields specified by command-line options
        outDir = options.getOutputDirectory();
        delim  = options.getDelimiter();

        // Initialize output file streams
        initStreams();
    }

    ~CsvGenerator()
    {
        for(stream_cache_t::iterator it = csvFiles.begin(), end = csvFiles.end();
            it != end; it++)
        {
            ofstream *file = it->second;
            file->flush();
            file->close();

            delete file;
        }
    }

    void writeEntityToCsv(const char *filename, const std::string& entityRefmode);

    void writeOperandPredicateToCsv(const char *predName, const std::string& entityRefmode, 
                                    const std::string& operandRefmode,
                                    bool operandType, int index = -1);

    template<class ValType>
    void writePredicateToCsv(const char *predName, const std::string& entityRefmode, 
                             const ValType& valueRefmode, int index = -1)
    {
        boost::filesystem::ofstream *csvFile = getCsvFile(toPath(predName));
        if(index == -1)
            (*csvFile) << entityRefmode << delim << valueRefmode << "\n";
        else
            (*csvFile) << entityRefmode << delim << index << delim << valueRefmode << "\n";
    }

    void processModule(const llvm::Module *Mod, std::string& path);

    void writeVarsTypesAndImmediates();

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


    /* Auxiliary methods */

    void identifyType(const llvm::Type *elementType, boost::unordered_set<const llvm::Type *> &componentTypes);

    void identifyStructType(const llvm::Type *structType, boost::unordered_set<const llvm::Type *> &componentTypes);

    void identifyFunctionType(const llvm::Type *funcType, boost::unordered_set<const llvm::Type *> &componentTypes);

    const char *writeLinkage(llvm::GlobalValue::LinkageTypes LT);

    const char *writeVisibility(llvm::GlobalValue::VisibilityTypes Vis);

    void writeGlobalVar(const llvm::GlobalVariable *gv, std::string globalName);

    void writeGlobalAlias(const llvm::GlobalAlias *ga, std::string globalAlias);

    std::string getRefmodeForValue(const llvm::Module * Mod, const llvm::Value * Val, std::string& path){
        return "<" + path + ">:" + auxiliary_methods::valueToString(Val, Mod);
    }

    ofstream* getCsvFile(path filename)
    {
        if (csvFiles.find(filename) == csvFiles.end())
            csvFiles[filename] = new ofstream(filename.c_str(), std::ios_base::out);

        return csvFiles[filename];
    }

    boost::unordered_set<const llvm::DataLayout *> layouts;
    boost::unordered_set<const llvm::Type *> types;
    boost::unordered_set<const llvm::Type *> componentTypes;
    boost::unordered_map<std::string, const llvm::Type *> variable;
    boost::unordered_map<std::string, const llvm::Type *> immediate;

    static const char * simplePredicates[];
    static const char * operandPredicates[];
};

#endif
