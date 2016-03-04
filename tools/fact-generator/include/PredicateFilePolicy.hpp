#ifndef PREDICATE_FILE_POLICY_HPP__
#define PREDICATE_FILE_POLICY_HPP__

#include <boost/filesystem.hpp>
#include "Singleton.hpp"

namespace cclyzer {
    class PredicateFilePolicy;
}

// A strategy to map predicate names to filesystem paths
class cclyzer::PredicateFilePolicy
{
  protected:
    typedef boost::filesystem::path path;

  public:

    PredicateFilePolicy();
    ~PredicateFilePolicy() {}

    /* Transform predicate name to filesystem path */
    path toPath(const char * predName) const;

  private:

    /* Opaque Pointer Idiom */
    class Impl;
    Impl *impl;
};

#endif /* PREDICATE_FILE_POLICY_HPP__ */
