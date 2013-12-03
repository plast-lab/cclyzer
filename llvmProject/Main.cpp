#include <iostream>
#include <set>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>

#include "functions.h"
#include "InstructionVisitor.h"

#include "llvm/IR/Constants.h"

#include "llvm/Assembly/Writer.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LLVMContext.h"

using namespace llvm;
using namespace std;

int main(int argc, char *argv[]) {

	if (argc < 2) {	
		errs() << "Expected an LLVM IR file name.\n";
		exit(1);
	}

	if(mkdir("facts", 0777) != 0) {
		if(errno == EEXIST) {
			errs() << "facts dir exists delete the contents.\n";
			//delete all previous contents
			clearFactsDir("facts");
		}
		else {
			perror("mkdir()");
			exit(1);
		}
	}
	else {
		if(mkdir("facts/entities", 0777) != 0) {
			perror("mkdir()");
			exit(1);
		}
		if(mkdir("facts/predicates", 0777) != 0) {
			perror("mkdir()");
			exit(1);
		}
	}

	LLVMContext &Context = getGlobalContext();
	SMDiagnostic Err;
	Module *Mod = ParseIRFile(argv[1], Err, Context);

	char *real_path = realpath(argv[1], NULL);
	errs() << "PATH: " << real_path << "\n";

	for (Module::iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
		for (inst_iterator I = inst_begin(fi), E = inst_end(fi); I != E; ++I) {
			if(!isa<PHINode>(&*I)) {
				for (unsigned operands = 0; operands < I->getNumOperands(); ++operands) {
					if (ConstantExpr * CE = dyn_cast<ConstantExpr>(I->getOperand(operands))) {
					//	errs() << "CE: " << *CE << "\n";
						Instruction * InsertPt = dyn_cast<Instruction>(&*I);
						if(Instruction * NewInst = convertCstExpression(CE, InsertPt)) {
							InsertPt->setOperand(operands, NewInst);
						}
					}
				}
			}
		}
	}
	string error;
	raw_fd_ostream r("modifiedFile.ll", error, raw_fd_ostream::F_Binary);
	Mod->print(r, 0);
	r.close();

	//Type sets
//	vector<Instruction *> synthetic;
	set<Type *> types;
	set<Type *> componentTypes;
	map<string, Type *> variable;
	map<string, Type *> immediate;

	string varId;
	string value_str;
	raw_string_ostream rso(value_str);

	InstructionVisitor IV(variable, immediate, Mod);

	for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
		value_str.clear();
		WriteAsOperand(rso, gi, 0, Mod);
		string globName = "<" + string(real_path) + ">:" + rso.str();
	//	immediate[globName] = gi->getType();
		writeGlobalVar(gi, globName);
		types.insert(gi->getType());
	}
	for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
		value_str.clear();
		WriteAsOperand(rso, ga, 0, Mod);
		string gal = "<" + string(real_path) + ">:" + rso.str();
		writeGlobalAlias(ga, gal);
//		immediate[gal] = ga->getType();
		types.insert(ga->getType());
	}
	for (Module::iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
		string instrId = "<" + string(real_path) + ">:" + string(fi->getName()) + ":";
		IV.setInstrId(instrId);
		errs() << "Function name: " << fi->getName() << " has: "<< fi->getArgumentList().size() << " arguments.\n";
		printFactsToFile("facts/entities/Function.dlm", "@%s\n", fi->getName());
		printFactsToFile("facts/predicates/Function-Type.dlm", "@%s\t%t\n", fi->getName(), printType(fi->getFunctionType()));
		types.insert(fi->getFunctionType());
		if(strlen(writeLinkage(fi->getLinkage()))) {
			printFactsToFile("facts/predicates/Function-LinkageType.dlm", "@%s\t%s\n", fi->getName(), writeLinkage(fi->getLinkage()));
		}
		if(strlen(writeVisibility(fi->getVisibility()))) {
			printFactsToFile("facts/predicates/Function-Visibility.dlm", "@%s\t%s\n", fi->getName(), writeVisibility(fi->getVisibility()));
		}
		if(fi->getCallingConv() != CallingConv::C) {
			printFactsToFile("facts/predicates/Function-CallingConvention.dlm", "@%s\t%s\n", fi->getName(), writeCallingConv(fi->getCallingConv()));
		}
		if(fi->getAlignment()) {
			printFactsToFile("facts/predicates/Function-Align.dlm", "@%s\t%s\n", fi->getName(), fi->getAlignment());
		}
		if(fi->hasGC()) {
			printFactsToFile("facts/predicates/Function-GC.dlm", "@%s\t%s\n", fi->getName(), fi->getGC());
		}
		if(fi->hasUnnamedAddr()) {
			printFactsToFile("facts/predicates/Function-Unnamed_Addr.dlm", "@%s\n", fi->getName());
		}
		const AttributeSet &Attrs = fi->getAttributes();
//		errs() << "Atrr ths @" << fi->getName() << "\n";
		if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
	//		errs() << "Ret Attr : " << Attrs.getAsString(AttributeSet::ReturnIndex) << "\n";
			printFactsToFile("facts/predicates/Function-RetAttribute.dlm", "@%s\t%s\n", fi->getName(), Attrs.getAsString(AttributeSet::ReturnIndex));
		}
		vector<string> FuncnAttr;
//		errs() << "FnAtrr ths @" << fi->getName() << "\n";
		writeFnAttributes(Attrs, FuncnAttr);
		for(int i = 0; i < FuncnAttr.size(); ++i) {
			printFactsToFile("facts/predicates/Function-FnAttributes.dlm", "@%s\t%s\n", fi->getName(), FuncnAttr[i]);
		}
		if (!fi->isDeclaration()) {
			if(fi->hasSection()) {
				printFactsToFile("facts/predicates/Function-Section.dlm", "@%s\t%s\n", fi->getName(), fi->getSection());
			}
			int index = 0;
			for (Function::arg_iterator arg = fi->arg_begin(), arg_end = fi->arg_end(); arg != arg_end; ++arg) {
				value_str.clear();
				WriteAsOperand(rso, arg, 0, Mod);
				varId = instrId + rso.str();
				printFactsToFile("facts/predicates/Function-FormalArg.dlm", "@%s\t%d\t%s\n", fi->getName(), index, varId);//funcId
				variable[varId] = arg->getType();
				index++;
			}
		}
		//iterate over Instructions in the Function
		int counter = 0;
		for (inst_iterator I = inst_begin(fi), E = inst_end(fi); I != E; ++I) {
			Instruction *ii = dyn_cast<Instruction>(&*I);
			string instrNum = instrId + static_cast<ostringstream*>(&(ostringstream()<< counter))->str();
			counter++;
			if(!ii->getType()->isVoidTy()) {
				value_str.clear();
				WriteAsOperand(rso, ii, 0, Mod);
				varId = instrId + rso.str();
				printFactsToFile("facts/predicates/Instruction-To.dlm", "%s\t%s\n", instrNum, varId);
				variable[varId] = ii->getType();
			}
			//visitor
			IV.setInstrNum(instrNum);
			IV.visit(*I);
			///-----------
		}
	}
	//Immediate
	for (map<string, Type *>::iterator it = immediate.begin(); it != immediate.end(); ++it) {
		printFactsToFile("facts/entities/Immediate.dlm", "%s\n", it->first);
		printFactsToFile("facts/predicates/Immediate-Type.dlm", "%s\t%t\n", it->first, printType(it->second));
		types.insert(it->second);
	}
	//Variable
	for (map<string, Type *>::iterator it = variable.begin(); it != variable.end(); ++it) {
		printFactsToFile("facts/entities/Variable.dlm", "%s\n", it->first);
		printFactsToFile("facts/predicates/Variable-Type.dlm", "%s\t%t\n", it->first, printType(it->second));
		types.insert(it->second);
	}
	//Types
	for (set<Type *>::iterator it = types.begin(); it != types.end(); ++it) {
		Type *type = dyn_cast<Type>(*it);
		identifyType(type, componentTypes);
	}
	for (set<Type *>::iterator it = componentTypes.begin(); it != componentTypes.end(); ++it) {
		Type *type = dyn_cast<Type>(*it);
		if (type->isIntegerTy()) {
			printFactsToFile("facts/entities/IntegerType.dlm", "%t\n", printType(type));
		}
		else if (type->isPrimitiveType()) {
			if(type->isFloatingPointTy()) {
				printFactsToFile("facts/entities/FloatingPointType.dlm", "%t\n", printType(type));
			}
			else {
				printFactsToFile("facts/entities/PrimitiveType.dlm", "%t\n", printType(type));
			}
		}
		else if(type->isPointerTy()) {
			printFactsToFile("facts/entities/PointerType.dlm", "%t\n", printType(type));
			printFactsToFile("facts/predicates/PointerType-Component.dlm", "%t\t\%t\n", printType(type), printType(type->getPointerElementType()));
			if(unsigned AddressSpace = type->getPointerAddressSpace()) {
				printFactsToFile("facts/predicates/PointerType-AddrSpace.dlm", "%t\t\%d\n", printType(type), AddressSpace);
			}
		}
		else if(type->isArrayTy()) {
	//		const ArrayType * arr = dyn_cast<ArrayType>(type);
	//		unsigned Num = arr->getNumElements;
			printFactsToFile("facts/entities/ArrayType.dlm", "%t\n", printType(type));
			printFactsToFile("facts/predicates/ArrayType-Size.dlm", "%t\t%d\n", printType(type), (int)type->getArrayNumElements());
			printFactsToFile("facts/predicates/ArrayType-Component.dlm", "%t\t\%t\n", printType(type), printType(type->getArrayElementType()));
		}
		else if(type->isStructTy()) {
			StructType *strTy = cast<StructType>(type);
			printFactsToFile("facts/entities/StructType.dlm", "%t\n", printType(strTy));
			if(strTy->isOpaque()) {
				printFactsToFile("facts/entities/OpaqueStructType.dlm", "%t\n", printType(strTy));
			}
			else {
				for (unsigned int i = 0; i < strTy->getStructNumElements(); ++i) {
					printFactsToFile("facts/predicates/StructType-Field.dlm", "%t\t%d\t%t\n", printType(strTy), i, printType(strTy->getStructElementType(i)));
				}
				printFactsToFile("facts/predicates/StructType-nFields.dlm", "%t\t%d\n", printType(strTy), strTy->getStructNumElements());
			}
		}
		else if(type->isVectorTy()) {
			printFactsToFile("facts/entities/VectorType.dlm", "%t\n", printType(type));
			printFactsToFile("facts/predicates/VectorType-Component.dlm", "%t\t\%t\n", printType(type), printType(type->getVectorElementType()));
			printFactsToFile("facts/predicates/VectorType-Size.dlm", "%t\t%d\n", printType(type), type->getVectorNumElements());
		}
		else if(type->isFunctionTy()) {
			FunctionType *funcType = cast<FunctionType>(type);
			printFactsToFile("facts/entities/FunctionType.dlm", "%t\n", printType(funcType));
			printFactsToFile("facts/predicates/FunctionType-ReturnType.dlm", "%t\t%t\n", printType(funcType), printType(funcType->getReturnType()));
			for (unsigned int par = 0; par < funcType->getFunctionNumParams(); ++par) {
				printFactsToFile("facts/predicates/FunctionType-Arg.dlm", "%t\t%d\t%t\n", printType(funcType), par, printType(funcType->getFunctionParamType(par)));
			}
			printFactsToFile("facts/predicates/FunctionType-nArgs.dlm", "%t\t%d\n", printType(funcType), funcType->getFunctionNumParams());
		}
		else {
			errs() << "Invalid Type in componentTypes set.\n";
		}
	}
	free(real_path);
	delete Mod;

	return 0;
}
//g++ -g Main.cpp functions.cpp InstructionVisitor.cpp -std=c++0x `llvm-config --cxxflags --ldflags | sed s/-fno-rtti//` -lLLVM-3.3 -o tut
