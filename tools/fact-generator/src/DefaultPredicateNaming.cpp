#include <algorithm>
#include <string>
#include <boost/unordered_map.hpp>

#include "DefaultPredicateNaming.hpp"
#include "PredicateNamingScheme.hpp"
#include "Options.hpp"

namespace fs = boost::filesystem;
template<> DefaultPredicateNaming *Singleton<DefaultPredicateNaming>::INSTANCE = NULL;
typedef std::pair<PredicateNamingScheme *,const char *> cachekey_t;

// Default extensions
const std::string DefaultPredicateNaming::CSV_EXTENSION = ".dlm";
const std::string DefaultPredicateNaming::BY_VARIABLE_SUFFIX = "-by_variable";
const std::string DefaultPredicateNaming::BY_IMMEDIATE_SUFFIX = "-by_immediate";


fs::path DefaultPredicateNaming::toPath(const char *predName)
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

    Options *opt = Options::getInstance();
    string basename(predName);

    // Replace all ':' characters with '-'
    size_t pos = 0;
    fs::path dir = opt->getEntityOutputDirectory();

    while ((pos = basename.find(':', pos)) != string::npos) {
        basename[pos] = '-';
        dir = opt->getPredicateOutputDirectory();
    }

    // Add directory and extension
    fs::path path = dir / basename;
    path += CSV_EXTENSION;

    return cache[key] = path;
}


fs::path DefaultPredicateNaming::toPath(const char *predName, Operands::Type type)
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
        return type == Operands::VARIABLE
            ? cachedValue->second.first
            : cachedValue->second.second;

    string basename(predName);
    fs::path dir = Options::getInstance()->getPredicateOutputDirectory();

    // Replace all ':' characters with '-'
    replace(basename.begin(), basename.end(), ':', '-');

    // Add directory and extension
    fs::path vpath = dir / basename;
    fs::path ipath = vpath;

    vpath += BY_VARIABLE_SUFFIX + CSV_EXTENSION;
    ipath += BY_IMMEDIATE_SUFFIX + CSV_EXTENSION;

    cache[key] = make_pair(vpath, ipath);
    return type == Operands::VARIABLE ? vpath : ipath;
}
