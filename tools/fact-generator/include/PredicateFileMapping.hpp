#ifndef PREDICATE_FILE_MAPPING_HPP__
#define PREDICATE_FILE_MAPPING_HPP__

#include <boost/filesystem.hpp>
#include "Singleton.hpp"

// There are two types of instruction operands
namespace Operand {
    enum class Type { IMMEDIATE, VARIABLE };
}

// A strategy to map predicate names to filesystem paths
class PredicateFileMapping
{
  protected:
    typedef boost::filesystem::path path;

  public:
    virtual ~PredicateFileMapping() {}

    virtual path toPath(const char * predName) const = 0;
    virtual path toPath(const char * predName, Operand::Type type) const = 0;

    static PredicateFileMapping &DEFAULT_SCHEME;
};


// Default implementation
class PredicateFileMappingImpl : public PredicateFileMapping,
                                 public Singleton<PredicateFileMappingImpl>
{
  protected:
    friend class Singleton<PredicateFileMappingImpl>;

    PredicateFileMappingImpl()
        : extension(".dlm")
        , entitiesDir("entities")
        , predicatesDir("predicates")
        , varSuffix("-by_variable")
        , immSuffix("-by_immediate")
    {}

    PredicateFileMappingImpl(const PredicateFileMappingImpl&);
    PredicateFileMappingImpl& operator= (const PredicateFileMappingImpl&);

  public:
    virtual ~PredicateFileMappingImpl() {}

    virtual path toPath(const char * predName) const;
    virtual path toPath(const char * predName, Operand::Type type) const;

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


#endif /* PREDICATE_FILE_MAPPING_HPP__ */
