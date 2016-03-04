#ifndef FACT_WRITER_H__
#define FACT_WRITER_H__

#include <string>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/unordered_map.hpp>

#include "PredicateFilePolicy.hpp"
#include "Options.hpp"

namespace cclyzer {
    class FactWriter;
}

class cclyzer::FactWriter
{
  protected:

    /* Common type aliases */

    typedef boost::filesystem::path path;
    typedef boost::filesystem::ofstream ofstream;
    typedef boost::unordered_map<path, ofstream*> stream_cache_t;

    /* Filesystem path computation  */

    path prepend_dir(path p) const
    {
        using namespace boost::filesystem;

        p = outDir / p;
        create_directory(p.parent_path());
        return p;
    }

    path toPath(const char * predName) const {
        return prepend_dir(filePolicy.toPath(predName));
    }

    path toPath(const std::string &predName) const {
        return toPath(predName.c_str());
    }

    ofstream* getCsvFile(const char *predname) {
        return getCsvFile(toPath(predname));
    }

    ofstream* getCsvFile(path filename)
    {
        using namespace std;

        if (csvFiles.find(filename) == csvFiles.end())
            csvFiles[filename] = new ofstream(filename.c_str(), ios_base::out);

        return csvFiles[filename];
    }

  public:

    FactWriter(std::string delimiter = "\t",
               path outputDirectory = boost::filesystem::current_path())
        : delim(delimiter)
        , outDir(outputDirectory)
    {}

    /* Set fields specified by command-line options */
    FactWriter(Options &options)
        : delim(options.getDelimiter())
        , outDir(options.getOutputDirectory())
    {}

    /* Destructor must flush and close all output file streams */
    ~FactWriter()
    {
        for(auto &kv : csvFiles)
        {
            ofstream *file = kv.second;
            file->flush();
            file->close();

            delete file;
        }
    }

    template<class FileCollection>
    void init_streams(const FileCollection &items)
    {
        using namespace std;

        for (typename FileCollection::const_iterator
                 i = items.begin(); i != items.end(); ++i)
        {
            path filename = toPath(*i);
            csvFiles[filename] = new ofstream(filename.c_str(), ios_base::out);
        }
    }

    /* Basic routines for appending new facts to CSV files */

    void writeFact(const char *entityName,
                   const std::string& r_entity)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(entityName);

        // Append new fact
        (*csvFile) << r_entity << "\n";
    }


    template<typename V>
    void writeFact(const char *predName,
                   const std::string& r_entity,
                   const V& r_value)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(predName);

        // Append fact
        (*csvFile) << r_entity
                   << delim << r_value << "\n";
    }

    template<typename V, typename... Vs>
    void writeFact(const char *predName,
                   const std::string& r_entity,
                   const V& r_value,
                   const Vs&... r_values)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(predName);

        // Append fact
        (*csvFile) << r_entity;
        appendValues(*csvFile, r_value, r_values...);
        (*csvFile) << "\n";
    }

  private:

    /* Variadic method to append values to fact */

    template<typename V, typename ...Vargs>
    void appendValues(ofstream &csvFile, const V& value) {
        csvFile << delim << value;
    }

    template<typename V, typename ...Vs>
    void appendValues(ofstream &csvFile, const V& value, const Vs&... values) {
        appendValues(csvFile, value);
        appendValues(csvFile, values...);
    }

    /* Column Delimiter */
    const std::string delim;

    /* Output directory */
    const path outDir;

    /* Cache of file descriptors with path as a key */
    stream_cache_t csvFiles;

    /* Policy for mapping predicate names to filesystem paths */
    const PredicateFilePolicy filePolicy;
};


#endif /* FACT_WRITER_H__ */
