#ifndef FACT_WRITER_H__
#define FACT_WRITER_H__

#include <string>
#include <boost/filesystem.hpp>
#include <boost/unordered_map.hpp>
#include "csv_writer.hpp"
#include "predicate.hpp"
#include "RefmodeEngine.hpp"     // TODO replace


namespace cclyzer {
    class FactWriter;
}

class cclyzer::FactWriter
{
  public:

    /* Common type aliases */

    using path = boost::filesystem::path;
    using string = std::string;

    FactWriter(path outputDirectory, string delimiter);
    FactWriter(path outputDirectory);
    FactWriter();

    ~FactWriter();


    /* Delegation to fact writer instance  */

    void writeFact(const Predicate &pred,
                   const refmode_t &refmode)
    {
        getWriter(pred)->write(refmode);
    }

    template <typename V, typename ...Vs>
    void writeFact(const Predicate &pred,
                   const refmode_t &refmode,
                   const V& val, const Vs&... vals)
    {
        getWriter(pred)->write(refmode, val, vals...);
    }

  protected:

    /* Get CSV writer instance for given predicate */
    csv_writer* getWriter(const Predicate &pred);

    /* Filesystem path computation  */
    path getPath(const Predicate& pred);

    /* Exhaustive CSV writer initialization */
    void init_writers();

  private:

    /* Map type */
    template<typename K, typename V>
    using map = boost::unordered_map<K,V>;

    /* Column Delimiter */
    const string delim;

    /* Output directory */
    const path outdir;

    /* Map of CSV writers with predicate name as key */
    map<string, csv_writer*> writers;

    /* CSV file extension */
    static const string FILE_EXTENSION;

    /* Non-copyable */
    FactWriter( const FactWriter& other ) = delete;
    FactWriter& operator=( const FactWriter& ) = delete;
};


#endif /* FACT_WRITER_H__ */
