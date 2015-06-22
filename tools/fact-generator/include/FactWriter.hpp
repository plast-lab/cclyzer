#ifndef FACT_WRITER_H__
#define FACT_WRITER_H__

#include <string>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <boost/unordered_map.hpp>

#include "PredicateFilePolicy.hpp"
#include "Options.hpp"


class FactWriter
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
    void init_streams(FileCollection items)
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


    template<class ValType>
    void writeFact(const char *predName,
                   const std::string& r_entity,
                   const ValType& r_value)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(predName);

        // Append fact
        (*csvFile) << r_entity
                   << delim << r_value << "\n";
    }

    template<class ValType>
    void writeFact(const char *predName,
                   const std::string& r_entity,
                   const ValType& r_value, int index)
    {
        // Locate CSV file for the given predicate
        ofstream *csvFile = getCsvFile(predName);

        // Append fact
        (*csvFile) << r_entity
                   << delim << index
                   << delim << r_value << "\n";
    }


  private:

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
