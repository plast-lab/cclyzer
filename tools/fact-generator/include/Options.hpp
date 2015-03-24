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
