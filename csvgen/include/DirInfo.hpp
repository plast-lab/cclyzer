#ifndef __DIR_INFO_H__
#define __DIR_INFO_H__

#include <string>

#include <boost/filesystem.hpp>

namespace bfs = boost::filesystem;

class DirInfo {
public:

    static DirInfo* getInstance(){
        if(INSTANCE == NULL)
            INSTANCE = new DirInfo();

        return INSTANCE;
    }

    bool setInputDir(const std::string &inputDirStr){
        this->inputDir = bfs::canonical(inputDirStr + "/");
        if(!bfs::exists(inputDir) || !bfs::is_directory(inputDir))
            return false;
        return true;
    }

    bool setFactsDir(const std::string &factsDirStr){
        this->factsDir = factsDirStr;
        this->entitiesDir = factsDirStr + "/entities";
        this->predicatesDir = factsDirStr + "/predicates";
        bool facts = true, pred = true, ent = true;

        if(bfs::exists(factsDir)){
            if(!bfs::is_directory(factsDir)){
                return false;
            }
            //TODO: remove existing files

            if(!bfs::exists(entitiesDir)){
                ent = bfs::create_directory(entitiesDir);
            }
            if(!bfs::exists(predicatesDir)){
                pred = bfs::create_directory(predicatesDir);
            }
        }
        else{
            facts = bfs::create_directory(factsDir);
            ent = bfs::create_directory(entitiesDir);
            pred = bfs::create_directory(predicatesDir);
        }

        if(facts && ent && pred){
            factsDir = bfs::canonical(factsDir);
            entitiesDir = bfs::canonical(entitiesDir);
            predicatesDir = bfs::canonical(predicatesDir);
        }

        return facts && ent && pred;
    }

    std::string getFactsDir(){
        return factsDir.string();
    }

    std::string getEntitiesDir(){
        return entitiesDir.string();
    }

    std::string getPredicatesDir(){
        return predicatesDir.string();
    }

    std::string getInputDir(){
        return inputDir.string();
    }

private:

    DirInfo() {}
    DirInfo(const DirInfo&);
    DirInfo& operator= (const DirInfo&);

    ~DirInfo(){
        delete INSTANCE;
        INSTANCE = NULL;
    }

    bfs::path inputDir;

    bfs::path factsDir;

    bfs::path entitiesDir;

    bfs::path predicatesDir;

    static DirInfo *INSTANCE;

};

#endif
