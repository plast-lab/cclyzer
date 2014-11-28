#include "Predicate.h"

Constructor::Constructor(const std::string &name, RefmodelessEntity *valueArgument)
        : FunctionalPredicate(name, new PredicateArgument(valueArgument))
{

}


int PredicateArgument::getFilePredNum() const
{
    return argType == PRIMITIVE ? 1 : argument.userDefPred->getFilePredNum();
}
