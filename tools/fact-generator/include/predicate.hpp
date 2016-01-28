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

    const std::set<const T*> items() const {
        return allInstances;
    }

  protected:
    std::set< const T* > allInstances;
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

    friend std::ostream& operator<<(std::ostream& stream, const Predicate&p);

    virtual ~Predicate() {}

  private:
    const std::string name;

    Predicate( const Predicate& other ) = delete; // non construction-copyable
    Predicate& operator=( const Predicate& ) = delete; // non copyable
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
    OperandPredicate(const char *name)
        : Predicate(name)
        , constantOperand((std::string(name) + ":" + CONSTANT_SUFFIX).c_str())
        , variableOperand((std::string(name) + ":" + VARIABLE_SUFFIX).c_str())
    {
        OperandPredicateRegistry::getInstance()->allInstances.insert(this);
    }

    virtual ~OperandPredicate() {}

    // Transformation functions
    const Predicate &asConstant() const {
        return constantOperand;
    }

    const Predicate &asVariable() const {
        return variableOperand;
    }

  private:
    const Predicate constantOperand;
    const Predicate variableOperand;

    static const char *CONSTANT_SUFFIX;
    static const char *VARIABLE_SUFFIX;
};

#endif
