#ifndef FACT_GENERATOR_HPP__
#define FACT_GENERATOR_HPP__

#include <string>
#include <boost/filesystem.hpp>

namespace cclyzer
{
    // Main fact-generation routines

    template<typename FileIt> void
    factgen(FileIt firstFile, FileIt endFile, boost::filesystem::path outputDir)
    {
        return factgen(firstFile, endFile, outputDir, "\t");
    }

    template<typename FileIt> void
    factgen(FileIt firstFile, FileIt endFile, boost::filesystem::path outputDir,
            std::string delim);
}

#endif /* FACT_GENERATOR_HPP__ */
