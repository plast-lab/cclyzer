#ifndef DEFAULT_PREDICATE_NAMING_HPP__
#define DEFAULT_PREDICATE_NAMING_HPP__

#include "Singleton.hpp"
#include "PredicateNamingScheme.hpp"

// A strategy to transform predicate names to filesystem paths
class DefaultPredicateNaming : public PredicateNamingScheme,
                               public Singleton<DefaultPredicateNaming>
{
protected:
    typedef boost::filesystem::path path;
    friend class Singleton<DefaultPredicateNaming>;

    DefaultPredicateNaming()
        : extension(".dlm")
        , entitiesDir("entities")
        , predicatesDir("predicates")
        , varSuffix("-by_variable")
        , immSuffix("-by_immediate")
    {}

    DefaultPredicateNaming(const DefaultPredicateNaming&);
    DefaultPredicateNaming& operator= (const DefaultPredicateNaming&);

public:
    virtual ~DefaultPredicateNaming() {}

    virtual path toPath(const char * predName);
    virtual path toPath(const char * predName, Operands::Type type);

private:
    /* CSV file extension */
    const std::string extension;

    /* Entities and predicates go to different directories */
    const path entitiesDir;
    const path predicatesDir;

    /* Predicates with operands have two files associated with them */
    const std::string varSuffix;
    const std::string immSuffix;
};


#endif /* DEFAULT_PREDICATE_NAMING_HPP__ */
