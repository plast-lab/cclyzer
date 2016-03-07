#include <algorithm>
#include <string>
#include <boost/unordered_map.hpp>
#include "PredicateFilePolicy.hpp"


// Type and namespace definitions
namespace fs = boost::filesystem;

using cclyzer::PredicateFilePolicy;

// Predicate File Policy implementation
class PredicateFilePolicy::Impl {
  public:
    path toPath(const char * predName) const;

  private:
    /* Type aliases */
    typedef boost::unordered_map<std::string, fs::path> cache_t;

    /* Path cache from previous results */
    mutable cache_t cache;

    /* CSV file extension */
    static const std::string FILE_EXTENSION;

    /* Entities and predicates go to different directories */
    static const path ENTITIES_DIR;
    static const path PREDICATES_DIR;
};


// Predicate name to file mapping

fs::path PredicateFilePolicy::Impl::toPath(const char *predName) const
{
    using namespace std;

    // Cache key
    std::string key(predName);

    // Get any previously returned path
    cache_t::iterator cachedValue = cache.find(key);

    if (cachedValue != cache.end())
        return cachedValue->second;

    string basename(predName);

    // Replace all ':' characters with '-'
    size_t pos = 0;
    fs::path dir = ENTITIES_DIR;

    while ((pos = basename.find(':', pos)) != string::npos) {
        basename[pos] = '-';
        dir = PREDICATES_DIR;
    }

    // Add directory and extension
    fs::path path = dir / basename;
    path += FILE_EXTENSION;

    return cache[key] = path;
}


// Constant definitions
const std::string PredicateFilePolicy::Impl::FILE_EXTENSION = ".dlm";
const fs::path PredicateFilePolicy::Impl::ENTITIES_DIR = "entities";
const fs::path PredicateFilePolicy::Impl::PREDICATES_DIR = "predicates";


// Opaque Pointer Idiom

PredicateFilePolicy::PredicateFilePolicy() {
    impl = new Impl();
}

PredicateFilePolicy::~PredicateFilePolicy() {
    if (impl) {
        delete impl;
    }
}

fs::path PredicateFilePolicy::toPath(const char * predName) const {
    return impl->toPath(predName);
}
