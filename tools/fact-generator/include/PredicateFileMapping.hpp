#ifndef PREDICATE_FILE_MAPPING_HPP__
#define PREDICATE_FILE_MAPPING_HPP__

#include <boost/filesystem.hpp>

// There are two types of instruction operands
namespace Operand {
    enum Type { IMMEDIATE, VARIABLE };
}

// A strategy to map predicate names to filesystem paths
class PredicateFileMapping
{
  protected:
    typedef boost::filesystem::path path;

  public:
    virtual ~PredicateFileMapping() {}

    virtual path toPath(const char * predName) = 0;
    virtual path toPath(const char * predName, Operand::Type type) = 0;
};

#endif /* PREDICATE_FILE_MAPPING_HPP__ */
