#include <iostream>
#include <set>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>

#include "llvm/IR/Constants.h"
#include "llvm/Assembly/Writer.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"

#include "functions.h"
#include "InstructionVisitor.h"
#include "PredicateNames.h"
#include "DirInfo.h"

using namespace llvm;
using namespace std;

int main(int argc, char *argv[]) {

	if (argc < 2) {
		errs() << "Expected an LLVM IR file or directory.\n";
		exit(1);
	}

	if(mkdir(DirInfo::factsDir, 0777) != 0) {
		if(errno == EEXIST) {
			//delete all previous contents
			clearFactsDir("facts");
		}
		else {
			perror("mkdir()");
			exit(1);
		}
	}
	else {
		if(mkdir(DirInfo::entitiesDir, 0777) != 0) {
			perror("mkdir()");
			exit(1);
		}
		if(mkdir(DirInfo::predicatesDir, 0777) != 0) {
			perror("mkdir()");
			exit(1);
		}
	}
	char *path = realpath(argv[1], NULL);
	vector<string> IRFiles;

	if(isDir(path)) {
		getIRFilesfromDir(path, IRFiles);
	}
	else {
		IRFiles.push_back(path);
	}

	LLVMContext &Context = getGlobalContext();
	SMDiagnostic Err;

	// Type sets and maps
	set<Type *> types;
	set<Type *> componentTypes;
	map<string, Type *> variable;
	map<string, Type *> immediate;

  for(int i = 0; i < IRFiles.size(); ++i) {
	Module *Mod = ParseIRFile(IRFiles[i], Err, Context);

	char *real_path = realpath(IRFiles[i].c_str(), NULL);

	//break constant expressions into regular instructions
	for (Module::iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
		for (inst_iterator I = inst_begin(fi), E = inst_end(fi); I != E; ++I) {
			if(!isa<PHINode>(&*I)) {
				for (unsigned operands = 0; operands < I->getNumOperands(); ++operands) {
					if (ConstantExpr * CE = dyn_cast<ConstantExpr>(I->getOperand(operands))) {
						Instruction * InsertPt = dyn_cast<Instruction>(&*I);
						if(Instruction * NewInst = convertCstExpression(CE, InsertPt)) {
							InsertPt->setOperand(operands, NewInst);
						}
					}
				}
			}
		}
	}
//	string error;
//	raw_fd_ostream r("modifiedFile.ll", error, raw_fd_ostream::F_Binary);
//	Mod->print(r, 0);
//	r.close();

	string varId;
	string value_str;
	raw_string_ostream rso(value_str);

	InstructionVisitor IV(variable, immediate, Mod);

	for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
		value_str.clear();
		WriteAsOperand(rso, gi, 0, Mod);
		string globName = "<" + string(real_path) + ">:" + rso.str();
		writeGlobalVar(gi, globName);
		types.insert(gi->getType());
	}
	for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
		value_str.clear();
		WriteAsOperand(rso, ga, 0, Mod);
		string gal = "<" + string(real_path) + ">:" + rso.str();
		writeGlobalAlias(ga, gal);
		types.insert(ga->getType());
	}
	for (Module::iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
		string funcId = "<" + string(real_path) + ">:" + string(fi->getName());
		string instrId = funcId + ":";
		IV.setInstrId(instrId);
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::Func).c_str(), "%s\n", funcId);
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncType).c_str(),
				"%s\t%t\n", funcId, printType(fi->getFunctionType()));
		types.insert(fi->getFunctionType());
		if(strlen(writeLinkage(fi->getLinkage()))) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncLink).c_str(),
					"%s\t%s\n", funcId, writeLinkage(fi->getLinkage()));
		}
		if(strlen(writeVisibility(fi->getVisibility()))) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncVis).c_str(),
					"%s\t%s\n", funcId, writeVisibility(fi->getVisibility()));
		}
		if(fi->getCallingConv() != CallingConv::C) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncCallConv).c_str(),
					"%s\t%s\n", funcId, writeCallingConv(fi->getCallingConv()));
		}
		if(fi->getAlignment()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncAlign).c_str(),
					"%s\t%s\n", funcId, fi->getAlignment());
		}
		if(fi->hasGC()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncGc).c_str(),
					"%s\t%s\n", funcId, fi->getGC());
		}
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncName).c_str(),
					"%s\t%@s\n", funcId, fi->getName());
		if(fi->hasUnnamedAddr()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncUnnamedAddr).c_str(),
					"%s\n", funcId);
		}
		const AttributeSet &Attrs = fi->getAttributes();
		if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncRetAttr).c_str(),
					"%s\t%s\n", funcId, Attrs.getAsString(AttributeSet::ReturnIndex));
		}
		vector<string> FuncnAttr;
		writeFnAttributes(Attrs, FuncnAttr);
		for(int i = 0; i < FuncnAttr.size(); ++i) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncAttr).c_str(),
					"%s\t%s\n", funcId, FuncnAttr[i]);
		}
		if (!fi->isDeclaration()) {
			if(fi->hasSection()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncSect).c_str(),
						"%s\t%s\n", funcId, fi->getSection());
			}
			int index = 0;
			for (Function::arg_iterator arg = fi->arg_begin(), arg_end = fi->arg_end(); arg != arg_end; ++arg) {
				value_str.clear();
				WriteAsOperand(rso, arg, 0, Mod);
				varId = instrId + rso.str();
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::FuncParam).c_str(),
						"%s\t%d\t%s\n", funcId, index, varId);
				variable[varId] = arg->getType();
				index++;
			}
		}
		//iterate over instructions in the function
		int counter = 0;
		for (inst_iterator i = inst_begin(fi), e = inst_end(fi); i != e; ++i) {
			Instruction *ii = dyn_cast<Instruction>(&*i);
			errs() << *ii << "\n";
			string instrNum = instrId + static_cast<ostringstream*>(&(ostringstream()<< counter))->str();
			counter++;
			if(!ii->getType()->isVoidTy()) {
				value_str.clear();
				WriteAsOperand(rso, ii, 0, Mod);
				varId = instrId + rso.str();
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnTo).c_str(),
						"%s\t%s\n", instrNum, varId);
				variable[varId] = ii->getType();
			}
			if(ii->getNextNode()) {
				string instrNext = instrId + static_cast<ostringstream*>(&(ostringstream()<< counter))->str();
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnNext).c_str(),
						"%s\t%s\n", instrNum, instrNext);
			}
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFunc).c_str(),
					"%s\t%s\n", instrNum, funcId);
			value_str.clear();
			WriteAsOperand(rso, ii->getParent(), 0, Mod);
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnBBEntry).c_str(),
					"%s\t%s\n", instrNum, varId);

			// Instruction Visitor
			IV.setInstrNum(instrNum);
			IV.visit(*i);
		}
	}
	free(real_path);
	delete Mod;
  }
	// Immediate
	for (map<string, Type *>::iterator it = immediate.begin(); it != immediate.end(); ++it) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::immediate).c_str(), "%s\n", it->first);
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::immediateType).c_str(),
				"%s\t%t\n", it->first, printType(it->second));
		types.insert(it->second);
	}
	// Variable
	for (map<string, Type *>::iterator it = variable.begin(); it != variable.end(); ++it) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::variable).c_str(), "%s\n", it->first);
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::variableType).c_str(),
				"%s\t%t\n", it->first, printType(it->second));
		types.insert(it->second);
	}

	// Types
	for (set<Type *>::iterator it = types.begin(); it != types.end(); ++it) {
		Type *type = dyn_cast<Type>(*it);
		identifyType(type, componentTypes);
	}

	for (set<Type *>::iterator it = componentTypes.begin(); it != componentTypes.end(); ++it) {
		Type *type = dyn_cast<Type>(*it);
		if (type->isIntegerTy()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::intType).c_str(),
					"%t\n", printType(type));
		}
		else if (type->isPrimitiveType()) {
			if(type->isFloatingPointTy()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fpType).c_str(),
						"%t\n", printType(type));
			}
			else {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::primitiveType).c_str(),
						"%t\n", printType(type));
			}
		}
		else if(type->isPointerTy()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ptrType).c_str(),
					"%t\n", printType(type));
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ptrTypeComp).c_str(),
					"%t\t\%t\n", printType(type), printType(type->getPointerElementType()));
			if(unsigned AddressSpace = type->getPointerAddressSpace()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ptrTypeAddrSpace).c_str(),
						"%t\t\%d\n", printType(type), AddressSpace);
			}
		}
		else if(type->isArrayTy()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::arrayType).c_str(),
					"%t\n", printType(type));
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::arrayTypeSize).c_str(),
					"%t\t%d\n", printType(type), (int)type->getArrayNumElements());
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::arrayTypeComp).c_str(),
					"%t\t\%t\n", printType(type), printType(type->getArrayElementType()));
		}
		else if(type->isStructTy()) {
			StructType *strTy = cast<StructType>(type);
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::structType).c_str(),
					"%t\n", printType(strTy));
			if(strTy->isOpaque()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::opaqueStructType).c_str(),
						"%t\n", printType(strTy));
			}
			else {
				for (unsigned int i = 0; i < strTy->getStructNumElements(); ++i) {
					printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::structTypeField).c_str(),
							"%t\t%d\t%t\n", printType(strTy), i, printType(strTy->getStructElementType(i)));
				}
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::structTypeNFields).c_str(),
						"%t\t%d\n", printType(strTy), strTy->getStructNumElements());
			}
		}
		else if(type->isVectorTy()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::vectorType).c_str(),
					"%t\n", printType(type));
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::vectorTypeComp).c_str(),
					"%t\t\%t\n", printType(type), printType(type->getVectorElementType()));
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::vectorTypeSize).c_str(),
					"%t\t%d\n", printType(type), type->getVectorNumElements());
		}
		else if(type->isFunctionTy()) {
			FunctionType *funcType = cast<FunctionType>(type);
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::funcType).c_str(),
					"%t\n", printType(funcType));
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::funcTypeReturn).c_str(),
					"%t\t%t\n", printType(funcType), printType(funcType->getReturnType()));
			for (unsigned int par = 0; par < funcType->getFunctionNumParams(); ++par) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::funcTypeParam).c_str(),
						"%t\t%d\t%t\n", printType(funcType), par, printType(funcType->getFunctionParamType(par)));
			}
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::funcTypeNParams).c_str(),
					"%t\t%d\n", printType(funcType), funcType->getFunctionNumParams());
		}
		else {
			errs() << "Invalid Type in componentTypes set.\n";
		}
	}
	return 0;
}
//g++ -g Main.cpp functions.cpp InstructionVisitor.cpp -std=c++0x `llvm-config --cxxflags --ldflags | sed s/-fno-rtti//` -lLLVM-3.3 -o tut
