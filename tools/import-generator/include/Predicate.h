#ifndef __PREDICATE_HPP__
#define __PREDICATE_HPP__

#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <boost/filesystem.hpp>

#include "FilePredicateParts.h"

//TODO: Clean up the code. We need a generic allocation/deallocation policy for the obects that derive from the Predicate class.

class Predicate;

/*
 * Represents an entity that can be used as a predicate argument.
 * This class keeps the information whether the argument is a primitive type
 * or a user defined predicate. For the time being we repesent primitive types
 * as strings.
 */
class PredicateArgument
{
    enum Kind {
        PRIMITIVE,
        USER_DEFINED
    };

    union Argument {

        std::string *primitive;

        Predicate *userDefPred;

    };

    Kind argType;
    Argument argument;

  public:

    using path = boost::filesystem::path;

    PredicateArgument(const std::string &primitive)
    {
        argType = PRIMITIVE;
        argument.primitive = new std::string(primitive);
    }

    PredicateArgument(Predicate *predicate)
    {
        argType = USER_DEFINED;
        argument.userDefPred = predicate;
    }

    bool isPrimitive() const {
        return argType == PRIMITIVE;
    }

    bool isUserDefined() const {
        return argType == USER_DEFINED;
    }

    std::string* getPrimitive() const {
        return argument.primitive;
    }

    Predicate* getUserDefinedPredicate() const {
        return argument.userDefPred;
    }

    int getFilePredNum() const;

};

class Predicate {
public:

    using path = boost::filesystem::path;

    enum PredicateType
    {
        REFMODE_ENTITY,
        FUNCTIONAL_PREDICATE,
        REFMODELESS_ENTITY,
        SIMPLE_PREDICATE
    };

protected:

    const std::string *qualifiedName;

    const PredicateType predType;

    //TODO: probably the first bool is not needed, the constructNewEntity variable is enough
    virtual std::string getFilePredicateParts(unsigned &, unsigned &, FilePredicateParts &,
                                              bool, bool, int w = 0) const = 0;

    static std::string getFilePredicateParts(const PredicateArgument* arg, unsigned &varIndex,
                                             unsigned &entityIndex, FilePredicateParts &filePredParts,
                                             bool construct, bool construtNewEntity, int whichCons = 0)
    {
        if(arg->isPrimitive())
        {
            filePredParts.addVar(varIndex, *(arg->getPrimitive()));
            varIndex++;

            return FilePredicateParts::getSimpleVar(varIndex - 1);
        }
        else
        {
            const Predicate *pred = arg->getUserDefinedPredicate();
            return pred->getFilePredicateParts(varIndex, entityIndex, filePredParts,
                                               construct, construtNewEntity, whichCons);
        }
    }

    static int getFilePredNum(const std::vector<const PredicateArgument*> &args)
    {
        int rv = 1;
        for(int i = 0, sz = args.size(); i < sz; ++i )
            rv *= args[i]->getFilePredNum();

        return rv;
    }

public:

    Predicate(const std::string &qualifiedName, PredicateType predType)
        : qualifiedName(new std::string(qualifiedName)), predType(predType)
    {

    }

    const std::string& getName() const
    {
        return *qualifiedName;
    }

    virtual const std::string
    getFilePredicates(const path& dirName, const std::string& delim) const
    {
        std::ostringstream acc;

        for(int i = 0, end = getFilePredNum(); i < end; ++i)
        {
            std::string predName = *qualifiedName;
            FilePredicateParts parts(predName);

            unsigned startVarIdx = 0, startEntityIdx = 0;
            getFilePredicateParts(startVarIdx, startEntityIdx, parts, true, false, i);

            parts.writeFilePredicate(acc, dirName, delim);
            acc << "\n\n";
        }

        return acc.str();
    }

    PredicateType getPredicateType() const
    {
        return predType;
    }

    virtual ~Predicate()
    {
        delete qualifiedName;
    }

    virtual int getFilePredNum() const
    {
        return 1;
    }
};

class Refmode
{

    const std::string *refmodeName;

    const std::string *refmodeType;

public:

    Refmode(const std::string &refmodeName, const std::string &refmodeType)
        : refmodeName(new std::string(refmodeName)), refmodeType(new std::string(refmodeType))
    {

    }

    const std::string* getTypeName() const
    {
        return refmodeType;
    }

    const std::string* getRefmodeName() const
    {
        return refmodeName;
    }

    ~Refmode()
    {
        delete refmodeName;
        delete refmodeType;
    }

};

class RefmodeEntity : public Predicate
{

    const Refmode *refmode;

protected:

    std::string getFilePredicateParts(unsigned &varIndex, unsigned &entityIndex, FilePredicateParts &filePredParts,
                                      bool construct, bool constructNewEntity, int whichCons = 0) const
    {
        assert(whichCons == 0);

        filePredParts.addVar(varIndex, *(refmode->getTypeName()));

        if(constructNewEntity)
            filePredParts.addRefmodeToBody(*(refmode->getRefmodeName()), *qualifiedName, varIndex, entityIndex);
        else
            filePredParts.addRefmodeToHead(*(refmode->getRefmodeName()), *qualifiedName, varIndex, entityIndex);

        varIndex++;
        entityIndex++;

        return FilePredicateParts::getEntityVar(entityIndex - 1);
    }

public:

    RefmodeEntity(const std::string &qualifiedName, const Refmode *refmode)
        : Predicate(qualifiedName, Predicate::REFMODE_ENTITY), refmode(refmode)
    {

    }

};

class FunctionalPredicate : public Predicate {
protected:

    std::vector<const PredicateArgument*> keyArgs;

    const PredicateArgument *valueArg;

    friend class RefmodelessEntity;

    mutable std::vector<std::vector<int> > consCombinations;

    virtual void genConsCombinations(std::vector<int> &combination, int idx) const
    {
        if(idx < keyArgs.size())
        {
            const PredicateArgument *arg = keyArgs[idx];
            for(int i = 0, consNum = arg->getFilePredNum(); i < consNum; ++i)
            {
                combination.push_back(i);
                genConsCombinations(combination, idx+1);
                combination.pop_back();
            }
        }
        else
        {
            for(int i = 0, end = valueArg->getFilePredNum(); i < end; ++i)
            {
                combination.push_back(i);
                consCombinations.push_back(combination);
                combination.pop_back();
            }
        }
    }

    void computeConsCombinations() const
    {
        std::vector<int> comb;
        genConsCombinations(comb, 0);

        assert(consCombinations.size() == getFilePredNum());
    }

    std::string getFilePredicateParts(unsigned &varIndex, unsigned &entityIndex, FilePredicateParts &filePredParts,
                                      bool construct, bool constructNewEntity, int whichCons = 0) const
    {
        assert(whichCons < getFilePredNum());

        if(consCombinations.empty())
        {
            computeConsCombinations();
        }

        std::vector<int> &consComb = consCombinations[whichCons];
        std::vector<std::string> entitiesVars;

        int end = keyArgs.size();
        for(int i = 0; i < end; ++i)
        {
            const PredicateArgument *arg = keyArgs[i];
            std::string en = Predicate::getFilePredicateParts(arg, varIndex, entityIndex, filePredParts,
                                                              false, constructNewEntity, consComb[i]);

            assert(en != "");

            entitiesVars.push_back(en);
        }

        std::string en;

        if(constructNewEntity)
        {
            en = FilePredicateParts::getEntityVar(entityIndex++);
        }
        else
        {
            en = Predicate::getFilePredicateParts(valueArg, varIndex, entityIndex, filePredParts,
                                                  false, constructNewEntity, consComb[end]);
        }

        assert(en != "");

        entitiesVars.push_back(en);

        if(construct || constructNewEntity)
            //constructNewEntity is true only for constructor.
            //So, newly constructed entities always go to the head.
            filePredParts.addFunctionalPredicateToHead(*qualifiedName, entitiesVars);
        else
            filePredParts.addFunctionalPredicateToBody(*qualifiedName, entitiesVars);

        return en;
    }

public:

    FunctionalPredicate(const std::string &name, const PredicateArgument *valueArg)
        : Predicate(name, FUNCTIONAL_PREDICATE), valueArg(valueArg)
    {

    }

    void addKeyArgument(const PredicateArgument *arg)
    {
        keyArgs.push_back(arg);
    }

    int getFilePredNum() const
    {
        return Predicate::getFilePredNum(keyArgs)*valueArg->getFilePredNum();
    }
};


class RefmodelessEntity;

class Constructor : public FunctionalPredicate {
protected:

    void genConsCombinations(std::vector<int> &combination, int idx) const
    {
        if(idx < keyArgs.size())
        {
            const PredicateArgument *arg = keyArgs[idx];
            for(int i = 0, consNum = arg->getFilePredNum(); i < consNum; ++i)
            {
                combination.push_back(i);
                genConsCombinations(combination, idx+1);
                combination.pop_back();
            }
        }
        else
        {
            consCombinations.push_back(combination);
        }
    }

public:

    Constructor(const std::string &name, RefmodelessEntity *valueArgument);


    const std::string
    getFilePredicates(const path& dirName, const std::string& delim) const
    {
        return "";
    }

    int getFilePredNum() const
    {
        return Predicate::getFilePredNum(keyArgs);
    }
};

/*
 * Entities that have constructors.
 */
class RefmodelessEntity : public Predicate {

    std::vector<const Constructor*> constructors;

protected:

    std::string getFilePredicateParts(unsigned &varIndex, unsigned &entityIndex, FilePredicateParts &filePredParts,
                                      bool construct, bool _, int whichCons = 0) const
    {
        assert(whichCons < getFilePredNum());
        //TODO: Do we care for constructors and/or functional predicates without arguments

        int i = 0;
        const Constructor *cons = constructors[i];
        int consPredNum = cons->getFilePredNum();
        while(whichCons >= consPredNum)
        {
            whichCons -= consPredNum;
            cons = constructors[++i];
            consPredNum = cons->getFilePredNum();
        }

        const std::string &consName = cons->getName();
        size_t colonPos = consName.find_last_of(':');

        if(colonPos == std::string::npos)
            filePredParts.appendToFilePredName(consName);
        else
            filePredParts.appendToFilePredName(consName.substr(colonPos + 1));

        std::string e = cons->getFilePredicateParts(varIndex, entityIndex, filePredParts, construct, true, whichCons);

        assert(e != "");

        //TODO: Is there any case where this guy must go to the body of the rule?
        filePredParts.addRefmodelessEntityToHead(*qualifiedName, e);

        return e;
    }

public:

    RefmodelessEntity(const std::string &name)
        : Predicate(name, REFMODELESS_ENTITY)
    {

    }

    void addConstructor(const Constructor *constructor)
    {
        constructors.push_back(constructor);
    }

    int getFilePredNum() const
    {
        int rv = 0;

        for(int i = 0, end = constructors.size(); i < end; ++i)
        {
            rv += constructors[i]->getFilePredNum();
        }

        return rv;
    }
};

class SimplePredicate : public Predicate {

    std::vector<const PredicateArgument*> args;

    mutable std::vector<std::vector<int> > consCombinations;

    void genConsCombinations(std::vector<int> &combination, int idx) const
    {
        if(idx < args.size())
        {
            const PredicateArgument *arg = args[idx];
            for(int i = 0, consNum = arg->getFilePredNum(); i < consNum; ++i)
            {
                combination.push_back(i);
                genConsCombinations(combination, idx+1);
                combination.pop_back();
            }
        }
        else
        {
            consCombinations.push_back(combination);
        }
    }

    void computeConsCombinations() const
    {
        std::vector<int> comb;
        genConsCombinations(comb, 0);

        assert(consCombinations.size() == getFilePredNum());
    }

protected:

    std::string getFilePredicateParts(unsigned &varIndex, unsigned &entityIndex, FilePredicateParts &filePredParts,
                                      bool construct, bool _, int whichCons = 0) const
    {
        assert(whichCons < getFilePredNum());

        if(consCombinations.empty())
        {
            computeConsCombinations();
        }

        std::vector<int> &consComb = consCombinations[whichCons];
        std::vector<std::string> entitiesVars;

        int end = args.size();
        for(int i = 0; i < end; ++i)
        {
            const PredicateArgument *arg = args[i];
            std::string en = Predicate::getFilePredicateParts(arg, varIndex, entityIndex,
                                                              filePredParts, false, _, consComb[i]);

            assert(en != "");

            entitiesVars.push_back(en);
        }

        assert(construct);

        filePredParts.addPredicate(*qualifiedName, entitiesVars);

        return "";
    }

public:

    SimplePredicate(const std::string &name)
        : Predicate(name, SIMPLE_PREDICATE)
    {

    }

    void addArgument(const PredicateArgument *arg)
    {
        args.push_back(arg);
    }

    int getFilePredNum() const
    {
        return Predicate::getFilePredNum(args);
    }
};

#endif
