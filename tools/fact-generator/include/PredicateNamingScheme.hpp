#ifndef PREDICATE_NAMING_SCHEME_HPP__
#define PREDICATE_NAMING_SCHEME_HPP__

#include <boost/filesystem.hpp>

// There are two types of instruction operands
namespace Operands {
    enum Type { IMMEDIATE, VARIABLE };
}

// A strategy to transform predicate names to filesystem paths
class PredicateNamingScheme
{
public:
    virtual ~PredicateNamingScheme() {}

    virtual boost::filesystem::path toPath(const char * predName) = 0;
    virtual boost::filesystem::path toPath(const char * predName, Operands::Type type) = 0;
};


#endif /* PREDICATE_NAMING_SCHEME_HPP__ */
