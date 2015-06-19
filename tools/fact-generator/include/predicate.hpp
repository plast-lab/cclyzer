#ifndef PREDICATE_H__
#define PREDICATE_H__

#include <set>
#include <string>

#include "Singleton.hpp"


template<typename T>
class Registry
{
  public:
    Registry() {}

    const std::set<T*> items() const {
        return allInstances;
    }

  protected:
    std::set< T* > allInstances;
};

/* Forward declarations to be able to define actual registries */
class Predicate;
class EntityPredicate;
class OperandPredicate;



/* Registry singleton instances */

class PredicateRegistry : public Singleton<PredicateRegistry>,
                          public Registry<Predicate>
{
  protected:
    friend class Predicate;
    friend class Singleton<PredicateRegistry>;
};


class EntityPredicateRegistry : public Singleton<EntityPredicateRegistry>,
                                public Registry<EntityPredicate>
{
  protected:
    friend class EntityPredicate;
    friend class Singleton<EntityPredicateRegistry>;
};


class OperandPredicateRegistry : public Singleton<OperandPredicateRegistry>,
                                 public Registry<OperandPredicate>
{
  protected:
    friend class OperandPredicate;
    friend class Singleton<OperandPredicateRegistry>;
};



/* Predicate */

class Predicate
{
  public:
    Predicate(const char *name) : name(name) {
        PredicateRegistry::getInstance()->allInstances.insert(this);
    }

    operator std::string() const {
        return name;
    }

    const char *c_str() const {
        return name.c_str();
    }

    friend bool operator== (Predicate &p1, Predicate &p2);
    friend bool operator!= (Predicate &p1, Predicate &p2);

    friend bool operator> (Predicate &p1, Predicate &p2);
    friend bool operator<= (Predicate &p1, Predicate &p2);

    friend bool operator< (Predicate &p1, Predicate &p2);
    friend bool operator>= (Predicate &p1, Predicate &p2);

    virtual ~Predicate() {}

  private:
    const std::string name;
};


/* Predicate that defines entity */

class EntityPredicate : public Predicate
{
  public:
    EntityPredicate(const char *name) : Predicate(name) {
        EntityPredicateRegistry::getInstance()->allInstances.insert(this);
    }

    virtual ~EntityPredicate() {};
};


/* Predicate that involves operand */

class OperandPredicate : public Predicate
{
  public:
    OperandPredicate(const char *name) : Predicate(name) {
        OperandPredicateRegistry::getInstance()->allInstances.insert(this);
    }

    virtual ~OperandPredicate() {};
};

#endif
