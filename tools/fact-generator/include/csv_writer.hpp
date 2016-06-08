#ifndef CSV_WRITER_H__
#define CSV_WRITER_H__

#include <string>
#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

namespace cclyzer {

    // Define serializable type trait. Only serializable types will be
    // allowed to be written by CSV writer
    template<class T>
    struct is_serializable
        : std::integral_constant<
        bool,
        std::is_convertible<T, const char*>::value ||
        std::is_arithmetic<T>::value ||
        std::is_same<std::string, typename std::remove_cv<T>::type>::value
        >
    {};

    // Define variadic serializable type trait that generalizes to
    // multiple values
    template <typename... Ts>
    struct all_serializable;

    template <typename Head, typename... Tail>
    struct all_serializable<Head, Tail...>
    {
        static const bool value =
            is_serializable<Head>::value && all_serializable<Tail...>::value;
    };

    template <typename T>
    struct all_serializable<T>
    {
        static const bool value = is_serializable<T>::value;
    };


    //-----------------------------------------------------------------------
    // Generic CSV writer class
    //-----------------------------------------------------------------------

    class csv_writer
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


        template<typename V, typename... Vs>
        void write(const std::string& hdr, const V& fld, const Vs&... flds)
        {
            static_assert( all_serializable<V, Vs...>::value,
                           "All types must be serializable" );
            out << hdr;
            appendFields(fld, flds...);
            out << "\n";
        }

      protected:

        /* Variadic method to append fields to record */

        void appendFields() {}

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

} // end of namespace cclyzer

#endif /* CSV_WRITER_H__ */
