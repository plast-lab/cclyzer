#ifndef OPTIONS_HPP__
#define OPTIONS_HPP__

#include <boost/filesystem.hpp>
#include <string>

#include "Singleton.hpp"

class Options : public Singleton<Options>
{

public:
    std::string& getDelimiter() {
        return delimiter;
    }

    boost::filesystem::path getOutputDirectory() {
        return outDirectory;
    }

    boost::filesystem::path getEntityOutputDirectory() {
        return outDirectory / ENTITIES_SUBDIR;
    }

    boost::filesystem::path getPredicateOutputDirectory() {
        return outDirectory / PREDICATES_SUBDIR;
    }

    std::vector<boost::filesystem::path>& getInputFiles() {
        return inputFiles;
    }

    Options * init(int argc, char* argv[]);

protected:

    friend class Singleton<Options>;

    Options() {}
    Options(const Options&);
    Options& operator= (const Options&);

    /* Set input files */
    void setInputFiles(std::vector<boost::filesystem::path>& paths, bool shouldRecurse);

    /* Set output directory */
    void setOutputDirectory(boost::filesystem::path path, bool shouldForce);

private:
    /* Output subdirectories */
    static const char *ENTITIES_SUBDIR;
    static const char *PREDICATES_SUBDIR;

    /* Parsing failure exit code */
    const static int ERROR_IN_COMMAND_LINE = 1;

    /* CSV Delimiter */
    std::string delimiter;

    /* Output Directory for generated facts */
    boost::filesystem::path outDirectory;

    /* LLVM Bitcode IR Input Files */
    std::vector<boost::filesystem::path> inputFiles;
};

#endif
