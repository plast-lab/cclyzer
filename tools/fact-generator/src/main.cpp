#include <iostream>
#include <string>
#include <boost/filesystem.hpp>
#include <llvm/Config/llvm-config.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include "factgen.hpp"
#include "FactGenerator.hpp"
#include "FactWriter.hpp"
#include "ParseException.hpp"
#include "Options.hpp"


// Type aliases
namespace fs = boost::filesystem;

//--------------------------------------------------------------------------
// Driver Fact-Generation Routine
//--------------------------------------------------------------------------

template<typename FileIt> void
cclyzer::factgen(FileIt firstFile, FileIt endFile,
                 fs::path outputDir, std::string delim)
{
    using cclyzer::FactGenerator;
    using cclyzer::FactWriter;

#if LLVM_VERSION_MAJOR == 3 && LLVM_VERSION_MINOR >= 9
    llvm::LLVMContext context;
#else
    llvm::LLVMContext &context = llvm::getGlobalContext();
#endif
    llvm::SMDiagnostic err;

    // Create fact writer
    FactWriter writer(outputDir, delim);

    // Create CSV generator
    FactGenerator& gen = FactGenerator::getInstance(writer);

    // Loop over each input file
    for(FileIt it = firstFile; it != endFile; ++it)
    {
        fs::path inputFile = *it;

        // Parse input file
        std::unique_ptr<llvm::Module> module =
            llvm::parseIRFile(inputFile.string(), err, context);

        // Check if parsing succeeded
        if (!module)
            throw ParseException(inputFile);

        // Canonicalize path
        std::string realPath = fs::canonical(inputFile).string();

        // Generate facts for this module
        gen.processModule(*module, realPath);

        // Get data layout of this module
        const llvm::DataLayout &layout = module->getDataLayout();

        // Write types
        gen.writeOperands(layout);
    }
}


int main(int argc, char *argv[])
{
    using cclyzer::Options;

    // Parse command line
    Options options(argc, argv);

    // Get analysis options
    const std::string delim = options.delimiter();
    const fs::path outdir = options.output_dir();

    // Get input file iterators
    Options::input_file_iterator input_begin = options.input_file_begin();
    Options::input_file_iterator input_end = options.input_file_end();

    try {
        cclyzer::factgen(input_begin, input_end, outdir, delim);
    }
    catch (const ParseException &error) {
        std::cerr << error.what() << std::endl;
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}


// Alternate version that doesn't use templates so that the python bindings work

void factgen2(std::vector<fs::path> files, fs::path outputDir, std::string delim) {
    cclyzer::factgen(files.begin(), files.end(), outputDir, delim);
}
