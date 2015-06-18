#ifndef OPTIONS_HPP__
#define OPTIONS_HPP__

#include <boost/filesystem.hpp>
#include <string>

class Options
{
  public:
    /* Constructor given command-line options */
    Options(int argc, char* argv[]);

    const std::string& getDelimiter() const {
        return delimiter;
    }

    boost::filesystem::path getOutputDirectory() const {
        return outDirectory;
    }

    const std::vector<boost::filesystem::path>& getInputFiles() const {
        return inputFiles;
    }

  protected:
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
