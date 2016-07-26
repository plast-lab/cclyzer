#ifndef PREDICATE_H__
#define PREDICATE_H__

#include <memory>
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
            all().insert(static_cast<const T*>(this));
        }

        // Define iterator methods over class instances

        typedef typename std::set< const T* >::const_iterator iterator;

        static iterator begin() {
            return all().begin();
        }

        static iterator end() {
            return all().end();
        }

      protected:
        ~Registry() {
            all().erase(static_cast<const T*>(this));
        }

        // Collection of instances
        static std::set< const T* >& all();

      private:
        // Make objects non-copyable
        Registry (const Registry &);
        Registry & operator = (const Registry &);
    };

    template class Registry<Predicate>;
    template class Registry<EntityPredicate>;
    template class Registry<OperandPredicate>;
}

/* Predicate */

class cclyzer::Predicate
    : public Registry<Predicate>
{
  public:

    Predicate(const char *name) : name(name) {}
    Predicate(const std::string& name) : name(name) {}

    // Conversions

    std::string getName() const {
        return name;
    }

    operator std::string() const {
        return name;
    }

    const char *c_str() const {
        return name.c_str();
    }


    // Comparison operators

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
      public Registry<EntityPredicate>
{
  public:
    EntityPredicate(const char *name) : Predicate(name) {}

    virtual ~EntityPredicate() {};
};


/* Predicate that involves operand */

class cclyzer::OperandPredicate
    : public cclyzer::Predicate,
      public Registry<OperandPredicate>
{
  public:
    OperandPredicate(const char *name)
        : Predicate(name)
        , constantOperand(nullptr)
        , variableOperand(nullptr)
    {}

    virtual ~OperandPredicate() {}

    // Transformation functions
    const Predicate &asConstant() const {
        if (!constantOperand) {
            std::string name = getName() + ":" + CONSTANT_SUFFIX;
            constantOperand.reset(new Predicate(name));
        }
        return *constantOperand;
    }

    const Predicate &asVariable() const {
        if (!variableOperand) {
            std::string name = getName() + ":" + VARIABLE_SUFFIX;
            variableOperand.reset(new Predicate(name));
        }
        return *variableOperand;
    }

  private:
    mutable std::unique_ptr<Predicate> constantOperand;
    mutable std::unique_ptr<Predicate> variableOperand;

    static const char *CONSTANT_SUFFIX;
    static const char *VARIABLE_SUFFIX;
};

#endif
