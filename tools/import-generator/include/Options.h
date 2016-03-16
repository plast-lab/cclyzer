#ifndef OPTIONS_H__
#define OPTIONS_H__

#include <boost/filesystem.hpp>
#include <string>

class Options
{

  public:
    static Options& getInstance() {
        static Options instance;
        return instance;
    }

    std::string& getPredDelimiter() {
        return fpDelimiter;
    }

    boost::filesystem::path& getPredDirectory() {
        return fpDirectory;
    }

    boost::filesystem::path& getOutputDirectory() {
        return outDirectory;
    }

    std::vector<boost::filesystem::path>& getFiles() {
        return protoFiles;
    }

    bool mustIgnorePredicates() {
        return ignorePredicates;
    }

    boost::filesystem::path& getPredicatesToIgnore() {
        return predicatesToIgnore;
    }

    Options& init(int argc, char* argv[]);

  private:

    Options() {};

    /* Non-copyable */
    Options(Options const&) = delete;
    void operator=(Options const&) = delete;

    /* Parsing failure exit code */
    const static int ERROR_IN_COMMAND_LINE = 1;

    /* File Predicate Delimiter */
    std::string fpDelimiter;

    /* File Predicate Directory */
    boost::filesystem::path fpDirectory;

    /* Output Directory for auto-generated logic files */
    boost::filesystem::path outDirectory;

    /* Protobuf Message Files */
    std::vector<boost::filesystem::path> protoFiles;

    /* File with predicates to ignore during import-generation */
    boost::filesystem::path predicatesToIgnore;

    bool ignorePredicates;
};

#endif
