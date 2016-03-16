#include <algorithm>
#include "FactWriter.hpp"
#include "predicate_groups.hpp"

namespace fs = boost::filesystem;
namespace pred = cclyzer::predicates;

using cclyzer::FactWriter;
using cclyzer::csv_writer;

using pred::pred_t;
using pred::entity_pred_t;
using pred::operand_pred_t;


//-------------------------------------------------------------------
// Constant Definitions
//-------------------------------------------------------------------

const std::string  FactWriter::FILE_EXTENSION = ".dlm";


//-------------------------------------------------------------------
// Delegating Constructors
//-------------------------------------------------------------------


FactWriter::FactWriter(path outputDirectory, string delimiter)
    : delim(delimiter)
    , outdir(outputDirectory)
{
    // Initialize all CSV writers
    init_writers();
}

FactWriter::FactWriter(path outputDirectory)
    : FactWriter(outputDirectory, "\t")
{}

FactWriter::FactWriter()
    : FactWriter(fs::current_path())
{}


FactWriter::~FactWriter()
{
    for(map<string, csv_writer*>::iterator
            it = writers.begin(), end = writers.end();
        it != end; ++it)
    {
        csv_writer *writer = it->second;
        delete writer;
    }
}



//-------------------------------------------------------------------
// CSV Writers Management
//-------------------------------------------------------------------

csv_writer*
FactWriter::getWriter(const pred_t& pred)
{
    using namespace boost::filesystem;

    // Use predicate name as key
    const string& key = pred.getName();

    // Search for existing writer
    map<string, csv_writer*>::iterator it = writers.find(key);

    // Return existing writer
    if (it != writers.end())
        return it->second;

    // Get filesystem path to CSV file
    path file = getPath(pred);
    create_directory(file.parent_path());

    // Create and return new writer
    return writers[key] = new csv_writer(file, delim);
}


fs::path
FactWriter::getPath(const pred_t& pred)
{
    namespace fs = boost::filesystem;

    string basename(pred);

    // Replace all ':' characters with '-'
    std::replace(basename.begin(), basename.end(), ':', '-');

    // Add directory and extension
    fs::path path = outdir / basename;
    path += FILE_EXTENSION;

    return path;
}


void
FactWriter::init_writers()
{
    using namespace predicates;

    for (pred_iterator it = predicates_begin(), end = predicates_end();
         it != end; ++it)
    {
        const pred_t *pred = *it;
        const operand_pred_t *operand_pred =
            dynamic_cast< const operand_pred_t*>(pred);

        if (operand_pred) {
            const pred_t &cpred = operand_pred->asConstant();
            const pred_t &vpred = operand_pred->asVariable();

            getWriter(cpred);
            getWriter(vpred);
        }
        else {
            getWriter(*pred);
        }
    }

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}
