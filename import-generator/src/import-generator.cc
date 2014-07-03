#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <set>
#include <string>

#include <boost/filesystem.hpp>

#include "parse-protobuf.h"
#include "Options.h"

using namespace std;

int main(int argc, char* argv[])
{
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    GOOGLE_PROTOBUF_VERIFY_VERSION;

    vector<const Constructor*> constructors;
    map<const string, Predicate*> allPredicates;

    try
    {
        namespace fs = boost::filesystem;

        // Get program options instance
        Options& opt = Options::getInstance().init(argc, argv);

        fs::path entitiesImports   = opt.getOutputDirectory() / "import-entities.logic";
        fs::path predicatesImports = opt.getOutputDirectory() / "import-predicates.logic";

        set<string> predicatesToIgnore;

        if(opt.mustIgnorePredicates())
        {
            ifstream predNamesToIgnore(opt.getPredicatesToIgnore().string().c_str());
            string name;

            while(predNamesToIgnore >> name)
            {
                predicatesToIgnore.insert(name);
            }
        }

        ofstream entitiesStream(entitiesImports.string().c_str()),
                 predicatesStream(predicatesImports.string().c_str());

        vector<fs::path> proto = opt.getFiles();

        for(vector<fs::path>::iterator it = proto.begin(); it != proto.end(); ++it)
        {
            string file = it->string();

            if(parse(file.c_str(), constructors, allPredicates) == FAILURE)
                return EXIT_FAILURE;
        }

        string entitiesDir   = ( opt.getPredDirectory() / "entities/"   ).string();
        string predicatesDir = ( opt.getPredDirectory() / "predicates/" ).string();
        string delim = opt.getPredDelimiter();

        set<string>::iterator ignoreEnd = predicatesToIgnore.end();
        for(map<const string, Predicate*>::iterator it = allPredicates.begin(), end = allPredicates.end(); it != end; ++it)
        {
            Predicate *p = it->second;

            if(predicatesToIgnore.find(p->getName()) == ignoreEnd)
            {
                cout << p->getName() << endl;
                switch (p->getPredicateType())
                {
                case Predicate::REFMODE_ENTITY:
                    entitiesStream << p->getFilePredicates(entitiesDir, delim) << "\n\n";
                    break;
                case Predicate::REFMODELESS_ENTITY:
                    //we don't want to generate file predicates for refmodeless entities
                    continue;
                case Predicate::SIMPLE_PREDICATE:
                case Predicate::FUNCTIONAL_PREDICATE:
                    predicatesStream << p->getFilePredicates(predicatesDir, delim) << "\n\n";
                    break;
                }
            }
        }
    }
    catch(exception& e)
    {
        cout << e.what() << "\n";
        return 1;
    }

    // Delete all global objects allocated by libprotobuf.
    google::protobuf::ShutdownProtobufLibrary();

    return EXIT_SUCCESS;
}
