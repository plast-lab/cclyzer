#include "predicate.hpp"

// Initialize registry singleton instances
template<> PredicateRegistry *Singleton<PredicateRegistry>::INSTANCE = NULL;
template<> EntityPredicateRegistry *Singleton<EntityPredicateRegistry>::INSTANCE = NULL;
template<> OperandPredicateRegistry *Singleton<OperandPredicateRegistry>::INSTANCE = NULL;

// Two suffixes for the two variants of each operand predicate
const char *OperandPredicate::CONSTANT_SUFFIX = "by_immediate";
const char *OperandPredicate::VARIABLE_SUFFIX = "by_variable";


// Comparing predicates

bool operator== (Predicate &p1, Predicate &p2) {
    return p1.name == p2.name;
}

bool operator!= (Predicate &p1, Predicate &p2) {
    return p1.name != p2.name;
}

bool operator< (Predicate &p1, Predicate &p2) {
    return p1.name < p2.name;
}

bool operator<= (Predicate &p1, Predicate &p2) {
    return p1.name <= p2.name;
}

bool operator> (Predicate &p1, Predicate &p2) {
    return p1.name > p2.name;
}

bool operator>= (Predicate &p1, Predicate &p2) {
    return p1.name >= p2.name;
}
