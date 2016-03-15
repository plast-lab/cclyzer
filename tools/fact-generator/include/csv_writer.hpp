#ifndef CSV_WRITER_H__
#define CSV_WRITER_H__

#include <string>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

namespace cclyzer {
    class csv_writer;
}

class cclyzer::csv_writer
{
  public:

    typedef boost::filesystem::path path;
    typedef boost::filesystem::ofstream ofstream;

    /* Constructor must create output file stream */

    csv_writer(const path& csvfile, std::string delimiter = "\t")
        : out(csvfile), delim(delimiter)
    {
        // Create parent directory
        create_directory(csvfile.parent_path());
    }

    /* Destructor must flush and close underlying file stream */
    ~csv_writer() {
        out.flush();
        out.close();
    }


    /* Basic routines for appending new records to CSV files */

    void write(const std::string& hdr) {
        out << hdr << "\n";
    }


    template<typename V>
    void write(const std::string& hdr, const V& fld) {
        out << hdr
            << delim << fld << "\n";
    }

    template<typename V, typename... Vs>
    void write(const std::string& hdr, const V& fld, const Vs&... flds) {
        out << hdr;
        appendFields(fld, flds...);
        out << "\n";
    }

  protected:

    /* Variadic method to append fields to record */

    template<typename V, typename ...Vargs>
    void appendFields(const V& value) {
        out << delim << value;
    }

    template<typename V, typename ...Vs>
    void appendFields(const V& value, const Vs&... values) {
        appendFields(value);
        appendFields(values...);
    }


  private:

    /* CSV Output Stream */
    ofstream out;

    /* Column Delimiter */
    const std::string delim;
};


#endif /* CSV_WRITER_H__ */
