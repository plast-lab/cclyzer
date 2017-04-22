/**
 * This module is intended to provide a python interface to
 * AST-exporting routines, by leveraging the Boost.Python library.
 **/
#include <boost/filesystem.hpp>
#include <boost/python.hpp>
#include <boost/python/errors.hpp>
#include <iostream>
#include "ast_export.hpp"
#include "Options.hpp"

namespace fs = boost::filesystem;
namespace py = boost::python;


// Custom Export Exception Type
class ExportException : public std::exception
{
  public:
    ExportException(std::string message, int errorCode)
    {
        this->message = message;
        this->errorCode = errorCode;
    }
    const char *what() const throw() {
        return this->message.c_str();
    }

    ~ExportException() throw() {}

    std::string getMessage() {
        return this->message;
    }

    int getErrorCode() {
        return this->errorCode;
    }

  private:
    std::string message;
    int errorCode;
};


PyObject *exportExceptionType = NULL;

void translateExportException(ExportException const& exc)
{
    assert(exportExceptionType != NULL);
    boost::python::object pythonExceptionInstance(exc);
    PyErr_SetObject(exportExceptionType, pythonExceptionInstance.ptr());
}


void
py_export_ast(py::list arguments)
{
    using namespace cclyzer::ast_exporter;

    int length = py::extract<int>(arguments.attr("__len__")());
    char **args = new char *[length];

    for (int i = 0; i < length; i++) {
        std::string arg = py::extract<std::string>(arguments[i]);

        char * argcopy = new char[arg.size() + 1];
        std::copy(arg.begin(), arg.end(), argcopy);
        argcopy[arg.size()] = '\0';

        args[i] = argcopy;
    }

    try
    {
        // Parse command line
        Options options(length, args);

        // Export AST
        jsonexport::export_ast(options);
    }
    catch (int errorcode) {
        std::ostringstream errorstream;
        errorstream << "program exited with error code: " << errorcode;

        std::string error = errorstream.str();

        // PyErr_SetString(PyExc_ValueError, error.c_str());
        // py::throw_error_already_set();
        throw ExportException(error, errorcode);
    }

    for (int i = 0; i < length; i++)
        delete[] args[i];
    delete[] args;
}


// Declare boost python module
BOOST_PYTHON_MODULE(astexport)
{
    using namespace boost::python;

    boost::python::class_<ExportException>
        exportExceptionClass("ExportException",
                             boost::python::init<std::string, int>());

    exportExceptionClass
        .add_property("message", &ExportException::getMessage)
        .add_property("error_code", &ExportException::getErrorCode);

    exportExceptionType = exportExceptionClass.ptr();

    boost::python::register_exception_translator<ExportException>(
        &translateExportException);

    def("run", py_export_ast);
}
