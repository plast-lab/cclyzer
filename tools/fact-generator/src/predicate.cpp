#include "predicate.hpp"

// Add to current namespace
using cclyzer::Registry;
using cclyzer::Predicate;
using cclyzer::OperandPredicate;
using cclyzer::EntityPredicate;

// Initialize registries
template <typename T> std::set< const T* >& Registry<T>::all() {
    static std::set< const T* > *allInstances = new std::set< const T*>();
    return *allInstances;
}

// Add explicit instantiations
namespace cclyzer {
    template std::set< const Predicate* >& Registry<Predicate>::all();
    template std::set< const EntityPredicate* >& Registry<EntityPredicate>::all();
    template std::set< const OperandPredicate* >& Registry<OperandPredicate>::all();
}

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
