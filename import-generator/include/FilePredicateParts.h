#ifndef __FILE_PREDICATES_PARTS_H__
#define __FILE_PREDICATES_PARTS_H__

#include <algorithm>
#include <sstream>
#include <vector>

class FilePredicateParts {

    std::ostringstream filePredName;

    std::ostringstream vars;

    std::ostringstream types;

    std::ostringstream body;

    std::ostringstream head;

    std::ostringstream acc;

    static const std::string VARIABLE_PREFIX;

    static const std::string ENTITY_PREFIX;

    static const std::string TAB;

    static const std::string NEW_LINE;

    static const std::string L_PAR;

    static const std::string R_PAR;

    static const std::string L_BRAC;

    static const std::string R_BRAC;

    static const std::string EQUALS;

    static const std::string COMMA;

    std::string getFileName(){

        std::string rv = filePredName.str();

        std::replace(rv.begin(), rv.end(), ':', '-');
        std::replace(rv.begin(), rv.end(), '$', '-');

        return rv + ".dlm";
    }

    std::ostringstream& getFilePredSignature(std::ostringstream &acc)
    {
        acc << "_" << filePredName.str() << "(" << vars.str() << ") -> " << types.str() << ".";

        return acc;
    }

    std::ostringstream& getLangDirectives(std::ostringstream &acc, std::string &dirName, std::string &del)
    {
        std::string filePredNameStr = filePredName.str();
        acc << "lang:physical:delimiter[`_" << filePredNameStr << "] = \"" << del << "\".\n";
        acc << "lang:physical:filePath[`_" << filePredNameStr << "] = \""
            << dirName << getFileName() << "\".";

        return acc;
    }

    std::ostringstream& getImportRule(std::ostringstream &acc)
    {
        acc << head.str() << NEW_LINE
            << "<-" << NEW_LINE
            << TAB << "_" << filePredName.str() << "(" << vars.str() << ")"
            << body.str() << ".";

        return acc;
    }

public:

    FilePredicateParts(std::string &predName)
    {
        filePredName << predName;
    }

    void addVar(unsigned int index, const std::string &type)
    {
        if(index != 0)
        {
            vars << COMMA << " ";
            types << COMMA << " ";
        }
        vars << VARIABLE_PREFIX << index;
        types << type << L_PAR << VARIABLE_PREFIX << index << R_PAR;
    }

    FilePredicateParts& appendToFilePredName(const std::string &predExt)
    {
        filePredName << "$" << predExt;
        return *this;
    }

    void addRefmodeToHead(const std::string &refmodeName, const std::string &qualName,
                          unsigned varIdx, unsigned entityIdx)
    {
        if(head.tellp() > 0)
            head << COMMA << NEW_LINE;
        head << "+" << refmodeName
             << L_PAR << getSimpleVar(varIdx) << ":" << getEntityVar(entityIdx) << R_PAR << COMMA
             << NEW_LINE << "+" << qualName << L_PAR << getEntityVar(entityIdx) << R_PAR;
    }

    void addRefmodeToBody(const std::string &refmodeName, const std::string &qualName,
                          unsigned varIdx, unsigned entityIdx)
    {
        body << COMMA << NEW_LINE
             << TAB << refmodeName << L_PAR << getSimpleVar(varIdx) << ":" << getEntityVar(entityIdx) << R_PAR
             << COMMA << NEW_LINE
             << TAB << qualName << L_PAR << getEntityVar(entityIdx) << R_PAR;
    }

    
    void addFunctionalPredicateToHead(const std::string &predName, std::vector<std::string> &args)
    {
        if(head.tellp() > 0)
            head << COMMA << NEW_LINE;
        head << "+" << predName << L_BRAC;

        int end = args.size();
        for(int i = 0; i < end - 1; ++i)
        {
            if(i != 0)
                head << COMMA;
            head << args[i];
        }

        head << R_BRAC << " " << EQUALS << " " << args[end - 1];
    }

    void addFunctionalPredicateToBody(const std::string &predName, std::vector<std::string> &args)
    {
        body << COMMA << NEW_LINE
             << TAB << predName << L_BRAC;

        int end = args.size();
        for(int i = 0; i < end - 1; ++i)
        {
            if(i != 0)
                body << COMMA;
            body << args[i];
        }

        body << R_BRAC << " " << EQUALS << " " << args[end - 1];
    }

    void addPredicate(const std::string &predName, std::vector<std::string> &args)
    {
        if(head.tellp() > 0)
            head << COMMA << NEW_LINE;

        head << "+" << predName << L_PAR;

        for(int i = 0, end = args.size(); i < end; ++i)
        {
            if(i != 0)
                head << COMMA;
            head << args[i];
        }

        head << R_PAR;
    }

    void addRefmodelessEntityToHead(const std::string &entityName, const std::string &entityVar)
    {
        if(head.tellp() > 0)
            head << COMMA << NEW_LINE;

        head << "+" << entityName << L_PAR << entityVar << R_PAR;
    }

    void addRefmodelessEntityToBody(const std::string &entityName, const std::string &entityVar)
    {
        body << COMMA << NEW_LINE
             << TAB << entityName << L_PAR << entityVar << R_PAR;
    }

    std::ostringstream& getFilePredicate(std::ostringstream &acc, std::string &dirName, std::string &del)
    {
        getFilePredSignature(acc) << NEW_LINE << NEW_LINE;
        getLangDirectives(acc, dirName, del) << NEW_LINE << NEW_LINE;
        getImportRule(acc);

        return acc;
    }

    static std::string getEntityVar(int index)
    {
        std::ostringstream rv;
        rv << ENTITY_PREFIX << index;
        return rv.str();
    }

    static std::string getSimpleVar(int index)
    {
        std::ostringstream rv;
        rv << VARIABLE_PREFIX << index;
        return rv.str();
    }
};

#endif
