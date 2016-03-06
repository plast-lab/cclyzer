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
        Registry() {
            allInstances.insert(static_cast<const T*>(this));
        }

        // Define iterator methods over class instances

        typedef typename std::set< const T* >::const_iterator iterator;

        static iterator begin() {
            return allInstances.begin();
        }

        static iterator end() {
            return allInstances.end();
        }

      protected:
        ~Registry() {
            allInstances.erase(static_cast<const T*>(this));
        }

        // Collection of instances
        static std::set< const T* > allInstances;

      private:
        // Make objects non-copyable
        Registry (const Registry &);
        Registry & operator = (const Registry &);
    };
}

/* Predicate */

class cclyzer::Predicate
    : protected Registry<Predicate>
{
  public:

    Predicate(const char *name) : name(name) {}

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

class cclyzer::EntityPredicate
    : public cclyzer::Predicate,
      protected Registry<EntityPredicate>
{
  public:
    EntityPredicate(const char *name) : Predicate(name) {}

    virtual ~EntityPredicate() {};
};


/* Predicate that involves operand */

class cclyzer::OperandPredicate
    : public cclyzer::Predicate,
      protected Registry<OperandPredicate>
{
  public:
    OperandPredicate(const char *name)
        : Predicate(name)
        , constantOperand((std::string(name) + ":" + CONSTANT_SUFFIX).c_str())
        , variableOperand((std::string(name) + ":" + VARIABLE_SUFFIX).c_str())
    {}

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
