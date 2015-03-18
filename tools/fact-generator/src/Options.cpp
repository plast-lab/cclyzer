#include <assert.h>
#include <cstdlib>
#include <iostream>

#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>
#include <boost/program_options.hpp>
#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>

#include "Options.hpp"

#define foreach BOOST_FOREACH

const char *Options::ENTITIES_SUBDIR = "entities";
const char *Options::PREDICATES_SUBDIR = "predicates";

namespace fs = boost::filesystem;
namespace po = boost::program_options;
template<> Options *Singleton<Options>::INSTANCE = NULL;


Options* Options::init(int argc, char* argv[])
{
    const std::string appName = fs::basename(argv[0]);

    // Define and parse the program options
    po::options_description genericOpts("Options");

    genericOpts.add_options()
        ("help,h", "Print help message")
        ("delim,d", po::value<std::string>(&delimiter)->default_value("\t"),
         "CSV file delimiter (default \\t)")
        ("out-dir,o", po::value<fs::path>(&outDirectory)->required(),
         "Output directory for generated facts")
        ("recursive,r", "Recurse into input directories")
        ("force,f", "Remove existing contents of output directory");

    // hidden options group - don't show in help
    po::options_description hiddenOpts("hidden options");
    hiddenOpts.add_options()
        ("input-files", po::value<std::vector<fs::path> >()->required(),
         "LLVM bitcode input files");

    po::options_description cmdline_options;
    cmdline_options.add(genericOpts).add(hiddenOpts);

    // positional arguments
    po::positional_options_description positionalOptions;
    positionalOptions.add("input-files", -1);

    po::variables_map vm;

    try {
        po::store(
            po::command_line_parser(argc, argv)
            .options(cmdline_options)
            .positional(positionalOptions)
            .run(),
            vm);

        // --help option
        if (vm.count("help"))
        {
            std::cout << "Usage: " << appName
                      << " [OPTIONS] INPUT_FILE...\n\n" << genericOpts;

            exit(EXIT_SUCCESS);
        }

        // may throw error
        po::notify(vm);
    }
    catch(boost::program_options::required_option& e) {
        std::cerr << e.what() << " from option: " << e.get_option_name() << std::endl;
        exit(ERROR_IN_COMMAND_LINE);
    }
    catch(boost::program_options::error& e) {
        std::cerr << e.what() << std::endl;
        exit(ERROR_IN_COMMAND_LINE);
    }

    // Sanity checks
    assert(vm.count("out-dir"));
    assert(vm.count("input-files"));


    // Compute input files and create output directories
    std::vector<fs::path> paths = vm["input-files"].as<std::vector<fs::path> >();
    setOutputDirectory(outDirectory, vm.count("force"));
    setInputFiles(paths, vm.count("recursive"));

    return this;
}


void Options::setInputFiles(std::vector<fs::path> &paths, bool shouldRecurse)
{
    // Delete old contents
    inputFiles.clear();

    // Iterate over every given path
    foreach(fs::path path, paths)
    {
        // Check for existence
        if (!fs::exists(path)) {
            std::cerr << "Path does not exist: " << path << std::endl;
            exit(ERROR_IN_COMMAND_LINE);
        }

        // Add normal files
        if (!fs::is_directory(path)) {
            inputFiles.push_back(path);
            continue;
        }

        if (!shouldRecurse) {
            std::cerr << "Input directory given, without -r option: "
                      << path << std::endl;

            exit(ERROR_IN_COMMAND_LINE);
        }

        // Recurse into directories
        for (fs::recursive_directory_iterator iter(path), end; iter != end; ++iter)
        {
            if (!fs::is_directory(iter->path()))
                inputFiles.push_back(iter->path());
        }
    }
}


void Options::setOutputDirectory(fs::path path, bool shouldForce)
{
    fs::path entitiesDir = path / ENTITIES_SUBDIR;
    fs::path predicatesDir = path / PREDICATES_SUBDIR;

    // Create non-existing directory
    if (fs::exists(path)) {
        if (!fs::is_directory(path)) {
            std::cerr << "Not a directory: " << path << std::endl;
            exit(ERROR_IN_COMMAND_LINE);
        }
    } else {
        fs::create_directory(path);
    }

    // Remove old contents
    if (shouldForce) {
        fs::remove_all(entitiesDir);
        fs::remove_all(predicatesDir);
    } else {
        fs::path dirs[] = {entitiesDir, predicatesDir};

        // Check subdirectories
        foreach(fs::path d, dirs)
        {
            if (!fs::exists(d))
                continue;

            if (!fs::is_directory(d)) {
                std::cerr << "Not a directory: " << d << std::endl;
                exit(ERROR_IN_COMMAND_LINE);
            }

            if (!fs::is_empty(d)) {
                std::cerr << "Directory not empty: " << d << std::endl;
                exit(ERROR_IN_COMMAND_LINE);
            }
        }
    }

    // Check if output directory exists
    if (!fs::is_directory(outDirectory))
    {
        std::cerr << "Output directory does not exist: "
                  << outDirectory << std::endl;

        exit(ERROR_IN_COMMAND_LINE);
    }

    // Store output directory (CHECK: should we canonicalize path)
    outDirectory = path;

    // Create subdirectories
    fs::create_directory(entitiesDir);
    fs::create_directory(predicatesDir);
}
