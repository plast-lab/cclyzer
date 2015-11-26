#include <exception>
#include <string>
#include <sstream>
#include <boost/filesystem.hpp>

class ParseException: public std::exception
{
    std::string err_msg;

  public:
    ParseException(boost::filesystem::path inputFile) {
        std::ostringstream msg;

        // Construct error message
        msg << "Failed to parse " << inputFile;
        err_msg = msg.str();
    }

    ~ParseException() throw() {};

    virtual const char* what() const throw() {
        return err_msg.c_str();
    }
};
