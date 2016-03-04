#ifndef PREDICATE_H__
#define PREDICATE_H__

#include <set>
#include <string>

#include "Singleton.hpp"

namespace cclyzer {
    /* Forward declarations to be able to define actual registries */
    class Predicate;
    class EntityPredicate;
    class OperandPredicate;

    /* Registry base class */
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
}

/* Predicate */

class cclyzer::Predicate
{
  public:

    /* Registry singleton instance */

    class Registry
        : public Singleton<Registry>,
          public cclyzer::Registry<Predicate>
    {
      protected:
        friend class Predicate;
        friend class Singleton<Registry>;
    };


    Predicate(const char *name) : name(name) {
        Registry::getInstance()->allInstances.insert(this);
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

class cclyzer::EntityPredicate : public cclyzer::Predicate
{
  public:
    /* Registry singleton instance */

    class Registry
        : public Singleton<Registry>,
          public cclyzer::Registry<EntityPredicate>
    {
      protected:
        friend class EntityPredicate;
        friend class Singleton<Registry>;
    };

    EntityPredicate(const char *name) : Predicate(name) {
        Registry::getInstance()->allInstances.insert(this);
    }

    virtual ~EntityPredicate() {};
};


/* Predicate that involves operand */

class cclyzer::OperandPredicate : public cclyzer::Predicate
{
  public:
    /* Registry singleton instance */

    class Registry
        : public Singleton<Registry>,
          public cclyzer::Registry<OperandPredicate>
    {
      protected:
        friend class OperandPredicate;
        friend class Singleton<Registry>;
    };

    OperandPredicate(const char *name)
        : Predicate(name)
        , constantOperand((std::string(name) + ":" + CONSTANT_SUFFIX).c_str())
        , variableOperand((std::string(name) + ":" + VARIABLE_SUFFIX).c_str())
    {
        Registry::getInstance()->allInstances.insert(this);
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
