#include <algorithm>
#include <string>
#include <boost/unordered_map.hpp>

#include "PredicateFileMapping.hpp"


// Initialize singleton instance
template<> PredicateFileMappingImpl *Singleton<PredicateFileMappingImpl>::INSTANCE = NULL;

// Type and namespace definitions
namespace fs = boost::filesystem;
typedef std::pair<const PredicateFileMapping *,const char *> cachekey_t;


// Initialize default predicate file mapping scheme
PredicateFileMapping &PredicateFileMapping::DEFAULT_SCHEME =
    *PredicateFileMappingImpl::getInstance();


fs::path PredicateFileMappingImpl::toPath(const char *predName) const
{
    using namespace std;
    typedef boost::unordered_map<cachekey_t, fs::path> cache_t;

    // Cache of previous results
    static cache_t cache;

    // Create cache key
    cachekey_t key = make_pair(this, predName);

    // Get any previously returned path
    cache_t::iterator cachedValue = cache.find(key);

    if (cachedValue != cache.end())
        return cachedValue->second;

    string basename(predName);

    // Replace all ':' characters with '-'
    size_t pos = 0;
    fs::path dir = entitiesDir;

    while ((pos = basename.find(':', pos)) != string::npos) {
        basename[pos] = '-';
        dir = predicatesDir;
    }

    // Add directory and extension
    fs::path path = dir / basename;
    path += extension;

    return cache[key] = path;
}


fs::path PredicateFileMappingImpl::toPath(const char *predName, Operand::Type type) const
{
    using namespace std;
    typedef boost::unordered_map<cachekey_t, pair<fs::path, fs::path> > cache_t;

    // Cache of previous results
    static cache_t cache;

    // Create cache key
    cachekey_t key = make_pair(this, predName);

    // Get any previously returned path
    cache_t::iterator cachedValue = cache.find(key);

    if (cachedValue != cache.end())
        return type == Operand::Type::VARIABLE
            ? cachedValue->second.first
            : cachedValue->second.second;

    string basename(predName);

    // Replace all ':' characters with '-'
    replace(basename.begin(), basename.end(), ':', '-');

    // Add directory and extension
    fs::path vpath = predicatesDir / basename;
    fs::path ipath = vpath;

    vpath += varSuffix + extension;
    ipath += immSuffix + extension;

    cache[key] = make_pair(vpath, ipath);
    return type == Operand::Type::VARIABLE ? vpath : ipath;
}
