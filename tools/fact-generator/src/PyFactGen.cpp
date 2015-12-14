/**
 * This module is intended to provide a python interface to
 * fact-generator, by leveraging the Boost.Python library.
 **/
#include <boost/filesystem.hpp>
#include <boost/python.hpp>
#include "ParseException.hpp"

namespace fs = boost::filesystem;
namespace py = boost::python;

void pyfactgen(py::list inputFiles, std::string outputDir, std::string delim = "\t")
{
    int length = py::extract<int>(inputFiles.attr("__len__")());
    std::vector<fs::path> files(length);

    // Create list of input files
    for (int i = 0; i < len(inputFiles); ++i) {
        files[i] = py::extract<char const *>(inputFiles[i]);
    }

    // Create non-existing directory
    if (!fs::exists(outputDir))
        fs::create_directory(outputDir);

    if (!fs::is_directory(outputDir)) {
        PyErr_SetString(PyExc_ValueError,
                        "Invalid output directory path");
        boost::python::throw_error_already_set();
        return;
    }

    // Remove old contents
    for (fs::directory_iterator end, it(outputDir); it != end; ++it)
        remove_all(it->path());

    // Ensure output directory is empty
    if (!fs::is_empty(outputDir)) {
        PyErr_SetString(PyExc_ValueError,
                        "Output directory not empty");
        boost::python::throw_error_already_set();
        return;
    }

    void generateFacts(const std::vector<fs::path> &inputFiles,
                       fs::path outputDir, std::string delim);

    // Run fact generation
    generateFacts(files, outputDir, delim);
}


// Translate parse exception to python

PyObject *parseExceptionType = NULL;

void translateParseException(ParseException const &e)
{
    assert(parseExceptionType != NULL);
    py::object pythonExceptionInstance(e);
    PyErr_SetObject(parseExceptionType, pythonExceptionInstance.ptr());
}


// Create thin wrappers for overloaded function

BOOST_PYTHON_FUNCTION_OVERLOADS(pyfactgen_overloads, pyfactgen, 2, 3)


// Path converter

struct path_to_python_str
{
    static PyObject* convert(fs::path const& p)
    {
        return boost::python::incref(
            boost::python::object(p.string()).ptr());
    }
};

// Declare boost python module

BOOST_PYTHON_MODULE(factgen)
{
    using namespace boost::python;

    // register exception
    class_<ParseException>
        parseExceptionClass("ParseException", py::init<fs::path>());

    parseExceptionType = parseExceptionClass.ptr();

    register_exception_translator<ParseException>
        (&translateParseException);

    // register the path-to-python converter
    to_python_converter<fs::path, path_to_python_str>();

    def("run", pyfactgen, pyfactgen_overloads());
}
