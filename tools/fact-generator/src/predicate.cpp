#include "predicate.hpp"

// Initialize registry singleton instances
template<> PredicateRegistry *Singleton<PredicateRegistry>::INSTANCE = NULL;
template<> EntityPredicateRegistry *Singleton<EntityPredicateRegistry>::INSTANCE = NULL;
template<> OperandPredicateRegistry *Singleton<OperandPredicateRegistry>::INSTANCE = NULL;
