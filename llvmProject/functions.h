#include <iostream>
#include <set>
#include <string>
#include <stdlib.h>

#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Operator.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace std;
using namespace llvm;

void printFactsToFile(const char *, const char *);

template<typename T, typename... Args>
void printFactsToFile(const char *filename, const char* s, const T& value, const Args&... args) {
	string error;
	raw_fd_ostream f(filename, error, raw_fd_ostream::F_Append);
	while (*s) {
		if (*s == '%' && *++s != '%') {
			f << const_cast<T&>(value);
	//		f << value;
			f.close();
			return printFactsToFile(filename, ++s, args...);
		}
		f << *s++;
	}
	errs() << "Extra arguments provided to printFactsToFile.\n";
}

void writeVolatileFlag(string, bool);

const char *writeAtomicInfo(string, AtomicOrdering, SynchronizationScope);

string writeCallingConv(unsigned);

void writeOptimizationInfoToFile(const User *, string);

void writeAtomicRMWOp(string, AtomicRMWInst::BinOp);

const char *writePredicate(unsigned);

void annotateGeneratedInstr(Instruction *);

//string convertHextoString(Value *);

string printType(Type *);

void identifyType(Type *, set<Type *> &);

void identifyStructType(Type *, set<Type *> &);

void identifyFunctionType(Type *, set<Type *> &);

Instruction *convertGEP(ConstantExpr *, Instruction *);

Instruction *convertExtractValueInst(ConstantExpr *, Instruction *);

Instruction *convertInsertValueInst(ConstantExpr *, Instruction *);

Instruction *convertCstExpression(ConstantExpr *, Instruction *);

void writeFnAttributes(const AttributeSet, vector<string> &);

const char *writeLinkage(GlobalValue::LinkageTypes);

const char *writeVisibility(GlobalValue::VisibilityTypes);

const char *writeThreadLocalModel(GlobalVariable::ThreadLocalMode);

void writeGlobalVar(const GlobalVariable *, string);

void writeGlobalAlias(const GlobalAlias *, string);

bool isDir(const char *);

void clearFactsDir(const char *);
