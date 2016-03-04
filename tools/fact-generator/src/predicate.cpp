#include "predicate.hpp"

using cclyzer::Predicate;
using cclyzer::OperandPredicate;
using cclyzer::EntityPredicate;

// Initialize registry singleton instances
template<> Predicate::Registry *Singleton<Predicate::Registry>::INSTANCE = nullptr;
template<> EntityPredicate::Registry *Singleton<EntityPredicate::Registry>::INSTANCE = nullptr;
template<> OperandPredicate::Registry *Singleton<OperandPredicate::Registry>::INSTANCE = nullptr;

// Two suffixes for the two variants of each operand predicate
const char *OperandPredicate::CONSTANT_SUFFIX = "by_constant";
const char *OperandPredicate::VARIABLE_SUFFIX = "by_variable";


// Comparing predicates

namespace cclyzer {

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

    std::ostream& operator<<(std::ostream& stream, const Predicate& pred) {
        return stream << std::string(pred);
    }
}
