#ifndef DEFAULT_PREDICATE_NAMING_HPP__
#define DEFAULT_PREDICATE_NAMING_HPP__

#include "Singleton.hpp"
#include "PredicateNamingScheme.hpp"

// A strategy to transform predicate names to filesystem paths
class DefaultPredicateNaming : public PredicateNamingScheme,
                               public Singleton<DefaultPredicateNaming>
{
protected:
    friend class Singleton<DefaultPredicateNaming>;

    DefaultPredicateNaming() {}
    DefaultPredicateNaming(const DefaultPredicateNaming&);
    DefaultPredicateNaming& operator= (const DefaultPredicateNaming&);

public:
    virtual ~DefaultPredicateNaming() {}

    virtual boost::filesystem::path toPath(const char * predName);
    virtual boost::filesystem::path toPath(const char * predName, Operands::Type type);

private:
    static const std::string CSV_EXTENSION;
    static const std::string BY_VARIABLE_SUFFIX;
    static const std::string BY_IMMEDIATE_SUFFIX;
};


#endif /* DEFAULT_PREDICATE_NAMING_HPP__ */
