#include <cassert>
#include <cstdlib>
#include <fcntl.h>
#include <fstream>
#include <iostream>
#include <sstream>

#include <google/protobuf/text_format.h>
#include <google/protobuf/io/zero_copy_stream_impl.h>

#include "parse-protobuf.h"

using namespace std;
namespace common = blox::common::protocol;
namespace compiler = blox::compiler::protocol;

Predicate* createPredicate(const common::PredicateInfo *, map<const string, Predicate*> *, predicateInfMap *);

const PredicateArgument* createArgument(const std::string &argName, map<const string, Predicate*> *allPreds,
                                        predicateInfMap *protoMsgs)
{
    if(allPreds->find(argName) != allPreds->end())
    {
        return new PredicateArgument((*allPreds)[argName]);
    }
    else if(protoMsgs->find(argName) != protoMsgs->end())
    {
        Predicate *pred = createPredicate((*protoMsgs)[argName], allPreds, protoMsgs);
        (*allPreds)[argName] = pred;
        return new PredicateArgument(pred);
    }
    else
    {
        return new PredicateArgument(argName);
    }
}

Predicate* createPredicate(const common::PredicateInfo *predMsg, map<const string, Predicate*> *allPreds,
                                 predicateInfMap *protoMsgs)
{
    assert(!predMsg->is_entity());

    Predicate *rv;

    const string &predName = predMsg->qualified_name();

    int keyArity = predMsg->key_arity();
    int valueArity = predMsg->value_arity();

    if(valueArity != 0)
    {
        assert(valueArity == 1);

        FunctionalPredicate *funPred = NULL;

        Constructor *cons = NULL;

        const PredicateArgument *valArg = createArgument(predMsg->value_argument(0), allPreds, protoMsgs);

        if(!predMsg->is_constructor())
        {
            funPred = new FunctionalPredicate(predName, valArg);
        }
        else
        {
            assert(valArg->isUserDefined());
            assert(valArg->getUserDefinedPredicate()->getPredicateType() == Predicate::REFMODELESS_ENTITY);

            RefmodelessEntity *val = (RefmodelessEntity*)valArg->getUserDefinedPredicate();

            assert(val != NULL);

            cons = new Constructor(predName, val);
            funPred = cons;

            val->addConstructor(cons);

        }

        for(int i = 0; i < keyArity; ++i)
        {
            const string &argName = predMsg->key_argument(i);
            const PredicateArgument *predArg = createArgument(argName, allPreds, protoMsgs);

            funPred->addKeyArgument(predArg);
        }

        rv = funPred;
    }
    else
    {
        SimplePredicate *pred = new SimplePredicate(predName);

        for(int i = 0; i < keyArity; ++i){
            const string &argName = predMsg->key_argument(i);
            const PredicateArgument *valueArg = createArgument(argName, allPreds, protoMsgs);

            pred->addArgument(valueArg);
        }

        rv = pred;
    }

    return rv;
}

int parse(const char *inputFile, vector<const Constructor*> &constructors, map<const string, Predicate*> &allPredicates)
{

    compiler::CompilationUnitSummary compUnit;

    {
        int fileDescriptor = open(inputFile, O_RDONLY);

        if (fileDescriptor < 0)
        {
            std::cerr << " Error opening the file " << std::endl;
            return FAILURE;
        }

        google::protobuf::io::FileInputStream fileInput(fileDescriptor);
        fileInput.SetCloseOnDelete(true);

        if (!google::protobuf::TextFormat::Parse(&fileInput, &compUnit))
        {
            cerr << std::endl << "Failed to parse file!" << endl;
            return FAILURE;
        }
    }

    int infoSize = compUnit.info_size();

    predicateInfMap predInfoMsgs;
    for(int i = 0; i < infoSize; ++i)
    {
        const common::PredicateInfo &info = compUnit.info(i);

        predInfoMsgs[info.qualified_name()] = &info;
    }

    int refPredSize = compUnit.ref_predicates_size();

    for(int i = 0; i < refPredSize; ++i)
    {
        const compiler::ReferencedPredicate &refPred = compUnit.ref_predicates(i);
        const common::PredicateInfo &info = refPred.info();

        predInfoMsgs[info.qualified_name()] = &info;
    }

    map<const string, RefmodelessEntity*> constructorEntities;

    for(predicateInfMap::iterator s = predInfoMsgs.begin(), end = predInfoMsgs.end(); s != end; s++)
    {
        const common::PredicateInfo *pred = s->second;
        const string &predName = pred->qualified_name();

        if(allPredicates.find(predName) != allPredicates.end())
            continue;

        if(pred->derivation_type() == common::NOT_DERIVED)
        {
            if(pred->is_entity())
            {
                //entities
                if(pred->has_ref_mode()){
                    const common::PredicateInfo * refmode = predInfoMsgs[pred->ref_mode_name()];

                    assert(refmode->key_arity() == 1);
                    assert(refmode->value_arity() == 1);

                    const string &refmodeName = refmode->qualified_name();
                    //this has to be a primitive
                    const string &valueArgument = refmode->value_argument(0);

                    RefmodeEntity *refmodeEntity = new RefmodeEntity(predName, new Refmode(refmodeName, valueArgument));
                    allPredicates[predName] = refmodeEntity;
                }
                else
                {
                    RefmodelessEntity *consEntity = new RefmodelessEntity(predName);
                    constructorEntities[predName] = consEntity;
                    allPredicates[predName] = consEntity;
                }
            }
        }
    }

    for(predicateInfMap::iterator s = predInfoMsgs.begin(), end = predInfoMsgs.end(); s != end; s++)
    {
        const common::PredicateInfo *pred = s->second;
        const string &predName = pred->qualified_name();
        if(pred->derivation_type() == common::NOT_DERIVED &&
           !pred->is_entity() &&
           !pred->is_ref_mode())
        {
            if(allPredicates.find(predName) == allPredicates.end())
            {
                allPredicates[predName] = createPredicate(pred, &allPredicates, &predInfoMsgs);
            }
        }
    }

    return SUCCESS;
}
