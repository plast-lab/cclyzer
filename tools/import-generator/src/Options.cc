#include <cstdlib>
#include <iostream>

#include <boost/filesystem.hpp>
#include <boost/program_options.hpp>
#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>

#include "Options.h"

using namespace std;

Options& Options::init(int argc, char* argv[])
{
    namespace fs = boost::filesystem;
    namespace po = boost::program_options;
    const string appName = fs::basename(argv[0]);

    // Define and parse the program options
    po::options_description genericOpts("Options");

    genericOpts.add_options()
        ("help,h", "Print help message")
        ("delim,d", po::value<string>(&fpDelimiter)->default_value(","), "File predicate delimiter")
        ("dir,d", po::value<fs::path>(&fpDirectory)->required(), "File predicate directory")
        ("out-dir,o", po::value<fs::path>(&outDirectory), "Output directory for generated logic files")
        ("ignore,i", po::value<fs::path>(&predicatesToIgnore),
         "File containing predicate names that don't need a file predicate");

    // hidden options group - don't show in help
    po::options_description hiddenOpts("hidden options");
    hiddenOpts.add_options()
        ("proto-files", po::value<vector<fs::path> >()->required(), "protobuf message files");

    po::options_description cmdline_options;
    cmdline_options.add(genericOpts).add(hiddenOpts);

    // positional arguments
    po::positional_options_description positionalOptions;
    positionalOptions.add("proto-files", -1);

    po::variables_map vm;

    try
    {
        po::store(
            po::command_line_parser(argc, argv)
            .options(cmdline_options)
            .positional(positionalOptions)
            .run(),
            vm);

        // --help option
        if (vm.count("help"))
        {
            cout << "Usage: "
                 << appName
                 << " [OPTIONS] PROTO_FILE...\n\n"
                 << genericOpts;

            exit(EXIT_SUCCESS);
        }

        // may throw error
        po::notify(vm);
    }
    catch(boost::program_options::required_option& e)
    {
        cerr << e.what() << " from option: "
             << e.get_option_name() << endl;

        exit(ERROR_IN_COMMAND_LINE);
    }
    catch(boost::program_options::error& e)
    {
        cerr << e.what() << endl;
        exit(ERROR_IN_COMMAND_LINE);
    }


    if (vm.count("proto-files"))
        protoFiles = vm["proto-files"].as<vector<fs::path> >();


    // Check if output directory exists
    if (vm.count("out-dir") && !fs::is_directory(outDirectory))
    {
        cerr << "Output directory does not exist: "
             << outDirectory << endl;

        exit(ERROR_IN_COMMAND_LINE);
    }

    if (vm.count("ignore"))
    {
        if (!fs::is_regular_file(predicatesToIgnore))
        {
            cerr << "File with predicate names to ignores does not exist: "
                 << predicatesToIgnore;
        }
        ignorePredicates = true;
    }
    else
    {
        ignorePredicates = false;
    }

    return *this;
}
