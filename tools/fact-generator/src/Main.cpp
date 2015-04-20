#include <iostream>
#include <string>
#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "CsvGenerator.hpp"
#include "PredicateFileMapping.hpp"
#include "Options.hpp"

#define foreach BOOST_FOREACH


int main(int argc, char *argv[])
{
    namespace fs = boost::filesystem;

    llvm::LLVMContext &context = llvm::getGlobalContext();
    llvm::SMDiagnostic err;

    // Parse command line
    Options options(argc, argv);

    // Select predicate to file mapping strategy
    PredicateFileMapping &mappingScheme = PredicateFileMapping::DEFAULT_SCHEME;

    // Create CSV generator
    CsvGenerator csvGen(mappingScheme, options);

    // Loop over each input file
    foreach(fs::path inputFile, options.getInputFiles())
    {
        // Parse input file
        llvm::Module *module = llvm::ParseIRFile(inputFile.string(), err, context);

        // Check if parsing succeeded
        if (!module) {
            std::cerr << "Failed to parse " << inputFile << std::endl;
            return EXIT_FAILURE;
        }

        // Canonicalize path
        std::string realPath = fs::canonical(inputFile).string();

        // Generate facts for this module
        csvGen.processModule(module, realPath);

        delete module;
    }

    csvGen.writeVarsTypesAndImmediates();

    return EXIT_SUCCESS;
}
