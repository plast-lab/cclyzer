#include <iostream>
#include <set>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>
#include <boost/program_options.hpp>
#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>
#include <boost/filesystem.hpp>

#include "llvm/IR/Constants.h"
#include "llvm/Assembly/Writer.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/CFG.h"

#include "InstructionVisitor.hpp"
#include "PredicateNames.hpp"
#include "DirInfo.hpp"

using namespace llvm;
using namespace std;
using namespace boost::program_options;
using namespace boost::filesystem;

template<> DirInfo *Singleton<DirInfo>::INSTANCE = NULL;

options_description desc("Usage");
variables_map optionVals;

bool isDir(const char *path) {

    bool dir = false;
    struct stat buf;

    if(stat(path, &buf) == -1)
    {
        perror("stat()");
        exit(1);
    }
    if((buf.st_mode & S_IFMT ) == S_IFDIR) {
        dir = true;
    }
    else if((buf.st_mode & S_IFMT ) == S_IFREG) {
        dir = false;
    }
    else {
        errs() << path << ":Unknown File Format\n";
        exit(1);
    }
    return dir;
}

void getIRFilesfromDir(const char * dirName, vector<string> &files) {
    //TODO: use boost
    DIR *dir;
    struct dirent *entry;
    string path;

    if((dir = opendir(dirName)) == NULL) {
        perror ("opendir()");
        exit(1);
    }
    while((entry = readdir(dir)) != NULL) {
        if(strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")) {
            path = string(dirName) + "/" + string(entry->d_name);
            if(isDir(path.c_str())) {
                getIRFilesfromDir(path.c_str(), files);
            }
            else {
                files.push_back(path.c_str());
            }
        }
    }
    closedir(dir);
}

void registerOptions(){
    //TODO: add positional argument for in-dir
    desc.add_options()
        ("help,h", "show help message")
        ("in-dir,i", value<string>(), "directory that contains llvm bitcode files")
        ("out-dir,o", value<string>(), "facts output directory")
        ("delim,d", value<char>(), "delimiter for csv files (default \\t)")
        ;
}

void parseOptions(int argc, char *argv[]){
    store(parse_command_line(argc, argv, desc), optionVals);
    notify(optionVals);

    if(optionVals.count("help")){
        cout << desc << "\n";
        exit(EXIT_SUCCESS);
    }

    if(!optionVals.count("in-dir")){
        cerr << "Missing input directory" << endl;
        cerr << desc << "\n";
        exit(EXIT_FAILURE);
    }

    if(!optionVals.count("out-dir")){
        cerr << "Missing output directory" << endl;
        cerr << desc << "\n";
        exit(EXIT_FAILURE);
    }

    DirInfo *dirs = DirInfo::getInstance();

    if(!dirs->setFactsDir(optionVals["out-dir"].as<string>())){
        cerr << "Unable to create output directories, exiting..." << endl;
        exit(EXIT_FAILURE);
    }

    if(!dirs->setInputDir(optionVals["in-dir"].as<string>())){
        cerr << "Error while opening input direcotry, exiting..." << endl;
        exit(EXIT_FAILURE);
    }
}

int main(int argc, char *argv[]) {

    registerOptions();

    parseOptions(argc, argv);

    vector<string> IRFiles;

    DirInfo * dirs = DirInfo::getInstance();

    getIRFilesfromDir(dirs->getInputDir().c_str(), IRFiles);

    LLVMContext &Context = getGlobalContext();
    SMDiagnostic Err;

    CsvGenerator *csvGen = CsvGenerator::getInstance();

    for(int i = 0; i < IRFiles.size(); ++i) {
        Module *Mod = ParseIRFile(IRFiles[i], Err, Context);
        //TODO: check if parsing .ll file fails
        string realPath = string(realpath(IRFiles[i].c_str(), NULL));

        csvGen->processModule(Mod, realPath);

        delete Mod;
    }

    csvGen->writeVarsTypesAndImmediates();
    csvGen->destroy();
    exit(EXIT_SUCCESS);
}
