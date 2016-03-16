#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <set>
#include <string>

#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>

#include "parse-protobuf.h"
#include "Options.h"


int main(int argc, char* argv[])
{
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    GOOGLE_PROTOBUF_VERIFY_VERSION;

    namespace fs = boost::filesystem;
    using std::string;

    std::vector<const Constructor*> constructors;
    std::map<const string, Predicate*> allpreds;

    try
    {
        // Get program options instance
        Options& opt = Options::getInstance().init(argc, argv);

        // Compute paths of logic files to be generated
        fs::path outdir = opt.getOutputDirectory();
        fs::path entitiesImports   = outdir / "import-entities.logic";
        fs::path predicatesImports = outdir / "import-predicates.logic";

        // Create set of predicates to ignore
        std::set<string> ignored_preds;

        if (opt.mustIgnorePredicates())
        {
            fs::ifstream predlist(opt.getPredicatesToIgnore());
            string predname;

            while (predlist >> predname)
                ignored_preds.insert(predname);
        }

        // Create output file streams
        fs::ofstream entitiesStream(entitiesImports);
        fs::ofstream predicatesStream(predicatesImports);

        // Parse input protobuf files
        std::vector<fs::path> proto = opt.getFiles();
        typedef std::vector<fs::path>::iterator proto_iterator;

        for (proto_iterator it = proto.begin(), end = proto.end();
             it != end; ++it)
        {
            string file = it->string();

            // Parse next protobuf file
            if (parse(file.c_str(), constructors, allpreds) == FAILURE)
                return EXIT_FAILURE;
        }

        const fs::path factsdir = opt.getPredDirectory();
        const string delim = opt.getPredDelimiter();

        for(std::map<const string, Predicate*>::iterator
                it = allpreds.begin(), end = allpreds.end();
            it != end; ++it)
        {
            Predicate &p = *(it->second);

            // Skip ignored predicates
            if (ignored_preds.find(p.getName()) != ignored_preds.end())
                continue;

            switch (p.getPredicateType())
            {
              case Predicate::REFMODE_ENTITY:
                  entitiesStream << p.getFilePredicates(factsdir, delim)
                                 << "\n\n";
                  break;
              case Predicate::REFMODELESS_ENTITY:
                  // we don't want to generate file predicates for
                  // refmodeless entities
                  continue;
              case Predicate::SIMPLE_PREDICATE:
                  // Fallthrough
              case Predicate::FUNCTIONAL_PREDICATE:
                  predicatesStream << p.getFilePredicates(factsdir, delim)
                                   << "\n\n";
                  break;
            }
        }
    }
    catch (std::exception& e) {
        std::cerr << e.what() << "\n";
        return EXIT_FAILURE;
    }

    // Delete all global objects allocated by libprotobuf.
    google::protobuf::ShutdownProtobufLibrary();

    return EXIT_SUCCESS;
}
