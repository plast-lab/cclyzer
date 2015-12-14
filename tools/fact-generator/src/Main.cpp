#include <iostream>
#include <string>
#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include "CsvGenerator.hpp"
#include "FactWriter.hpp"
#include "ParseException.hpp"
#include "Options.hpp"

#define foreach BOOST_FOREACH

namespace fs = boost::filesystem;


void generateFacts(const std::vector<fs::path> &inputFiles,
                   fs::path outputDir,
                   std::string delim = "\t")
{
    llvm::LLVMContext &context = llvm::getGlobalContext();
    llvm::SMDiagnostic err;

    // Create fact writer
    FactWriter writer(delim, outputDir);

    // Create CSV generator
    CsvGenerator csvGen(writer);

    // Loop over each input file
    foreach(fs::path inputFile, inputFiles)
    {
        // Parse input file
        std::unique_ptr<llvm::Module> module =
            llvm::parseIRFile(inputFile.string(), err, context);

        // Check if parsing succeeded
        if (!module)
            throw ParseException(inputFile);

        // Canonicalize path
        std::string realPath = fs::canonical(inputFile).string();

        // Generate facts for this module
        csvGen.processModule(module.get(), realPath);

        // Get data layout of this module
        const llvm::DataLayout &layout = module->getDataLayout();

        // Write types
        csvGen.writeVarsTypesAndConstants(layout);
    }
}


int main(int argc, char *argv[])
{
    // Parse command line
    Options options(argc, argv);

    // Get analysis options
    std::string delim = options.getDelimiter();
    fs::path outputDir = options.getOutputDirectory();

    try {
        generateFacts(options.getInputFiles(), outputDir, delim);
    }
    catch (const ParseException &error) {
        std::cerr << error.what() << std::endl;
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}
