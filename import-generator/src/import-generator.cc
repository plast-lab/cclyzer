#include <string>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <cstring>

#include "parse-protobuf.h"

using namespace std;

void usage()
{
    cerr << "usage: import-generator --dir [dirname] --delim [delim] [protobufmessage,...]" << endl;
}

int main(int argc, char* argv[])
{
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    GOOGLE_PROTOBUF_VERIFY_VERSION;

    vector<const Constructor*> constructors;
    map<const string, Predicate*> allPredicates;

    string dir, delim;

    if(argc <= 5)
    {
        usage();
        return EXIT_FAILURE;
    }

    if(strcmp(argv[1], "--dir"))
    {
        usage();
        return EXIT_FAILURE;
    }
    else
    {
        dir = argv[2];

        if(dir[dir.length() - 1] != '/')
            dir.append(1, '/');
    }

    if(strcmp(argv[3], "--delim"))
    {
        usage();
        return EXIT_FAILURE;
    }
    else
    {
        delim = argv[4];
    }

    ofstream entitiesImports("import-entities.logic"),
             predicatesImports("import-predicates.logic");

    for(int i = 5; i < argc; ++i)
    {
        if(parse(argv[i], constructors, allPredicates) == FAILURE)
            return EXIT_FAILURE;
    }

    string entitiesDir = dir + "entities/", predicatesDir = dir + "predicates/";

    for(map<const string, Predicate*>::iterator it = allPredicates.begin(), end = allPredicates.end(); it != end; ++it)
    {
        Predicate *p = it->second;

        switch(p->getPredicateType())
        {
        case Predicate::REFMODE_ENTITY:
            entitiesImports << p->getFilePredicates(entitiesDir, delim) << "\n\n";
            break;
        case Predicate::REFMODELESS_ENTITY:
            //we don't want to generate file predicates for refmodeless entities
            continue;
        case Predicate::SIMPLE_PREDICATE:
        case Predicate::FUNCTIONAL_PREDICATE:
            predicatesImports << p->getFilePredicates(predicatesDir, delim) << "\n\n";
            break;
        }
    }

    //Delete all global objects allocated by libprotobuf.
    google::protobuf::ShutdownProtobufLibrary();

    return EXIT_SUCCESS;
}
