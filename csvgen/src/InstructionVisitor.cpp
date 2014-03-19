#include <iostream>
#include <set>
#include <string>

#include "llvm/Assembly/Writer.h"
#include "llvm/IR/Module.h"

#include "functions.h"
#include "InstructionVisitor.h"
#include "PredicateNames.h"

using namespace llvm;
using namespace std;

InstructionVisitor::InstructionVisitor(map<string,Type *> &var,
		map<string, Type *> &imm, Module *M): variable(var), immediate(imm), Mod(M) {
}

void InstructionVisitor::visitAdd(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::addInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::addInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::addInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::addInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::addInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitFAdd(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::faddInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::faddInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::faddInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::faddInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::faddInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitSub(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::subInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::subInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::subInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::subInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::subInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitFsub(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fsubInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fsubInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fsubInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fsubInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fsubInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitMul(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::mulInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::mulInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::mulInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::mulInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::mulInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitFMul(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fmulInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fmulInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fmulInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fmulInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fmulInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitSdiv(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sdivInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sdivInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sdivInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sdivInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sdivInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitFdiv(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fdivInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fdivInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fdivInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fdivInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fdivInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitUDiv(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::udivInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::udivInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::udivInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::udivInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::udivInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitSRem(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sremInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sremInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sremInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sremInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sremInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitFRem(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fremInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fremInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fremInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fremInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fremInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitURem(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::uremInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uremInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uremInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uremInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uremInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitShl(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::shlInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shlInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shlInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shlInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shlInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitLShr(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::lshrInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::lshrInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::lshrInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::lshrInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::lshrInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitAShr(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ashrInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ashrInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ashrInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ashrInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ashrInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitAnd(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::andInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::andInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::andInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::andInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::andInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitOr(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::orInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::orInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::orInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::orInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::orInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitXor(BinaryOperator &BI) {

	raw_string_ostream rso(value_str);
	string error;

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::xorInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::xorInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::xorInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::xorInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::xorInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

void InstructionVisitor::visitReturnInst(ReturnInst &RI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::retInsn).c_str(), "%s\n", instrNum);
	// ret <type> <value>
	if(RI.getReturnValue()) {
		value_str.clear();
		WriteAsOperand(rso, RI.getReturnValue(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(RI.getReturnValue())) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::retInsnOp, 0).c_str(),
					"%s\t%s\n", instrNum, varId);
			immediate[varId] = RI.getReturnValue()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::retInsnOp, 1).c_str(),
					"%s\t%s\n", instrNum, varId);
			variable[varId] = RI.getReturnValue()->getType();
		}
	}
	// ret void
	else {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::retInsnVoid).c_str(), "%s\n", instrNum);
	}
}

void InstructionVisitor::visitBranchInst(BranchInst &BI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brInsn).c_str(), "%s\n", instrNum);
	// br i1 <cond>, label <iftrue>, label <iffalse>
	if(BI.isConditional()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brCondInsn).c_str(), "%s\n", instrNum);
		// Condition Operand
		value_str.clear();
		WriteAsOperand(rso, BI.getCondition(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(BI.getCondition())) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::brCondInsnCondition, 0).c_str(),
					"%s\t%s\n", instrNum, varId);
			immediate[varId] = BI.getCondition()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::brCondInsnCondition, 1).c_str(),
					"%s\t%s\n", instrNum, varId);
			variable[varId] = BI.getCondition()->getType();
		}
		// 'iftrue' label
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brCondInsnIfTrue).c_str(),
					"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(0)->getType();

		// 'iffalse' label
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(1), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brCondInsnIfFalse).c_str(),
					"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(1)->getType();
	}
	else {
		//br label <dest>
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brUncondInsn).c_str(), "%s\n", instrNum);
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::brUncondInsnDest).c_str(),
					"%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(0)->getType();
	}
}

void InstructionVisitor::visitSwitchInst(SwitchInst &SI) {

	raw_string_ostream rso(value_str);
	string error;

	//switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::switchInsn).c_str(), "%s\n", instrNum);
	//'value' Operand
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::switchInsnOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::switchInsnOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(0)->getType();
	}
	//'defaultdest' label
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(1), 0, Mod);
	varId = instrId + rso.str();
	variable[varId] = SI.getOperand(1)->getType();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::switchInsnDefLabel).c_str(),
			"%s\t%s\n", instrNum, varId);
	//'case list' [constant, label]
	for(unsigned i = 2; i < SI.getNumOperands(); i += 2) {
		value_str.clear();
		WriteAsOperand(rso, SI.getOperand(i), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::switchInsnCaseVal).c_str(),
				"%s\t%d\t%s\n", instrNum, i-2, varId);
		immediate[varId] = SI.getOperand(i)->getType();

		value_str.clear();
		WriteAsOperand(rso, SI.getOperand(i+1), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::switchInsnCaseLabel).c_str(),
				"%s\t%d\t%s\n", instrNum, i-2, varId);
		variable[varId] = SI.getOperand(i+1)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::switchInsnNCases).c_str(),
			"%s\t%d\n", instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR) {

	raw_string_ostream rso(value_str);
	string error;

	//indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::indirectbrInsn).c_str(), "%s\n", instrNum);
	//'address' Operand
	value_str.clear();
	WriteAsOperand(rso, IBR.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IBR.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::indirectbrInsnAddr, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IBR.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::indirectbrInsnAddr, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IBR.getOperand(0)->getType();
	}
	//'label' list
	for(unsigned i = 1; i < IBR.getNumOperands(); ++i) {
		value_str.clear();
		WriteAsOperand(rso, IBR.getOperand(i), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::indirectbrInsnLabel).c_str(),
				"%s\t%d\t%s\n", instrNum, i-1, varId);
		variable[varId] = IBR.getOperand(i)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::indirectbrInsnNLabels).c_str(),
			"%s\t%d\n", instrNum, IBR.getNumOperands()-1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsn).c_str(), "%s\n", instrNum);
	Value *invokeOp = II.getCalledValue();
	PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
	FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

	value_str.clear();
	WriteAsOperand(rso, II.getCalledValue(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(II.getCalledValue())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::invokeInsnFunc, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = funcTy;
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::invokeInsnFunc, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = funcTy;
	}
	if(II.getCalledFunction()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::directInvokeInsn).c_str(),
				"%s\n", instrNum);
	}
	else {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::indirectInvokeInsn).c_str(),
				"%s\n", instrNum);
	}
	//actual args
	for(unsigned op = 0; op < II.getNumArgOperands(); ++op) {
		value_str.clear();
		WriteAsOperand(rso, II.getArgOperand(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(II.getArgOperand(op))) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::invokeInsnArg, 0).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			immediate[varId] = II.getArgOperand(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::invokeInsnArg, 1).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			variable[varId] = II.getArgOperand(op)->getType();
		}
	}
	//'normal label'
	value_str.clear();
	WriteAsOperand(rso, II.getNormalDest(), 0, Mod);
	varId = instrId + rso.str();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsnNormalLabel).c_str(),
			"%s\t%s\n", instrNum, varId);
	variable[varId] = II.getNormalDest()->getType();
	//'exception label'
	value_str.clear();
	WriteAsOperand(rso, II.getUnwindDest(), 0, Mod);
	varId = instrId + rso.str();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsnExceptLabel).c_str(),
			"%s\t%s\n", instrNum, varId);
	variable[varId] = II.getUnwindDest()->getType();
	//Function Attributes
	const AttributeSet &Attrs = II.getAttributes();
	if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsnRetAttr).c_str(),
				"%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
	}
	vector<string> FuncnAttr;
	writeFnAttributes(Attrs, FuncnAttr);
	for(int i = 0; i < FuncnAttr.size(); ++i) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsnFuncAttr).c_str(),
				"%s\t%s\n", instrNum, FuncnAttr[i]);
	}
	if (II.getCallingConv() != CallingConv::C) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::invokeInsnCallConv).c_str(),
				"%s\t%s\n", instrNum, writeCallingConv(II.getCallingConv()));
	}
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::resumeInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, RI.getValue(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(RI.getValue())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::resumeInsnOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = RI.getValue()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::resumeInsnOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = RI.getValue()->getType();
	}
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::unreachableInsn).c_str(), "%s\n", instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::allocaInsn).c_str(),
			"%s\n", instrNum);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::allocaInsnType).c_str(),
			"%s\t%t\n", instrNum, printType(AI.getAllocatedType()));
	if(AI.isArrayAllocation()) {
		value_str.clear();
		WriteAsOperand(rso, AI.getArraySize(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(AI.getArraySize())) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::allocaInsnSize, 0).c_str(),
					"%s\t%s\n", instrNum, varId);
			immediate[varId] = AI.getArraySize()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::allocaInsnSize, 1).c_str(),
					"%s\t%s\n", instrNum, varId);
			variable[varId] = AI.getArraySize()->getType();
		}
	}
	if(AI.getAlignment()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::allocaInsnAlign).c_str(),
				"%s\t%d\n", instrNum, AI.getAlignment());
	}
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::loadInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, LI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(LI.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::loadInsnAddr, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = LI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::loadInsnAddr, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = LI.getPointerOperand()->getType();
	}
	writeVolatileFlag(instrNum, LI.isVolatile());
	if(LI.isAtomic()) {
		const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());
		if(strlen(ord)) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::loadInsnOrd).c_str(),
					"%s\t%d\n", instrNum, ord);
		}
	}
	if(LI.getAlignment()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::loadInsnAlign).c_str(),
				"%s\t%d\n", instrNum, LI.getAlignment());
	}
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::vaargInsn).c_str(),
			"%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, VI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(VI.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::vaargInsnList, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = VI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::vaargInsnList, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = VI.getPointerOperand()->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::vaargInsnType).c_str(),
			"%s\t%t\n", instrNum, printType(VI.getType()));
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::extractValueInsn).c_str(), "%s\n", instrNum);
	//Aggregate Operand
	value_str.clear();
	WriteAsOperand(rso, EVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EVI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractValueInsnBase, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = EVI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractValueInsnBase, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = EVI.getOperand(0)->getType();
	}
	//Constant Indices
	int index = 0;
	for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::extractValueInsnIndex).c_str(),
				"%s\t%d\t%s\n", instrNum, index, *i);
		index++;
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::extractValueInsnNIndices).c_str(),
			"%s\t%s\n", instrNum, EVI.getNumIndices());
}

void InstructionVisitor::visitTruncInst(TruncInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::truncInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::truncInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::truncInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::truncInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitZExtInst(ZExtInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::zextInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::zextInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::zextInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::zextInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitSExtInst(SExtInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sextInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sextInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sextInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sextInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitFPTruncInst(FPTruncInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptruncInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptruncInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptruncInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptruncInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitFPExtInst(FPExtInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fpextInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fpextInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fpextInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fpextInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitFPToUIInst(FPToUIInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptouiInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptouiInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptouiInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptouiInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitFPToSIInst(FPToSIInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptosiInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptosiInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fptosiInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fptosiInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitUIToFPInst(UIToFPInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::uitofpInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uitofpInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::uitofpInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::uitofpInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitSIToFPInst(SIToFPInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sitofpInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sitofpInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::sitofpInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sitofpInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitPtrToIntInst(PtrToIntInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ptrtointInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ptrtointInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::ptrtointInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::ptrtointInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitIntToPtrInst(IntToPtrInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::inttoptrInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::inttoptrInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::inttoptrInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::inttoptrInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitBitCastInst(BitCastInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::sitofpInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::bitcastInsnFrom, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::bitcastInsnFrom, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::bitcastInsnToType).c_str(), "%s\t%t\n", instrNum,
			printType(I.getType()));
}

void InstructionVisitor::visitStoreInst(StoreInst &SI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::storeInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, SI.getValueOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getValueOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::storeInsnValue, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getValueOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::storeInsnValue, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getValueOperand()->getType();
	}
	value_str.clear();
	WriteAsOperand(rso, SI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::storeInsnAddr, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::storeInsnAddr, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getPointerOperand()->getType();
	}
	writeVolatileFlag(instrNum, SI.isVolatile());
	if(SI.isAtomic()) {
		const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());
		if(strlen(ord)) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::storeInsnOrd).c_str(),
					"%s\t%d\n", instrNum, ord);
		}
	}
	if(SI.getAlignment()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::storeInsnAlign).c_str(),
				"%s\t%d\n", instrNum, SI.getAlignment());
	}
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::cmpxchgInsn).c_str(), "%s\n", instrNum);
	//ptrValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnAddr, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnAddr, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getPointerOperand()->getType();
	}
	//cmpValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getCompareOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getCompareOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnCmp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getCompareOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnCmp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getCompareOperand()->getType();
	}
	//newValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getNewValOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getNewValOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnNew, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getNewValOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::cmpxchgInsnNew, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getNewValOperand()->getType();
	}
	writeVolatileFlag(instrNum, AXI.isVolatile());
	const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::cmpxchgInsnOrd).c_str(),
				"%s\t%d\n", instrNum, ord);
	}
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::atomicRMWInsn).c_str(), "%s\n", instrNum);
	//ptrValue - LeftOperand
	value_str.clear();
	WriteAsOperand(rso, AWI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AWI.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::atomicRMWInsnAddr, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = AWI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::atomicRMWInsnAddr, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = AWI.getPointerOperand()->getType();
	}
	//valOperand - Right Operand
	value_str.clear();
	WriteAsOperand(rso, AWI.getValOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AWI.getValOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::atomicRMWInsnValue, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = AWI.getValOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::atomicRMWInsnValue, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = AWI.getValOperand()->getType();
	}
	writeVolatileFlag(instrNum, AWI.isVolatile());
	writeAtomicRMWOp(instrNum, AWI.getOperation());
	const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::atomicRMWInsnOper).c_str(),
				"%s\t%d\n", instrNum, ord);
	}
}

void InstructionVisitor::visitFenceInst(FenceInst &FI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fenceInsn).c_str(),
			"%s\n", instrNum);
	//fence [singleThread]  <ordering>
	const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fenceInsnOrd).c_str(),
				"%s\t%d\n", instrNum, ord);
	}
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::gepInsn).c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, GEP.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(GEP.getPointerOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::gepInsnBase, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = GEP.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::gepInsnBase, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = GEP.getPointerOperand()->getType();
	}
	for (unsigned index = 1; index < GEP.getNumOperands(); ++index) {
		value_str.clear();
		WriteAsOperand(rso, GEP.getOperand(index), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(GEP.getOperand(index))) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::gepInsnIndex, 0).c_str(),
					"%s\t%d\t%s\n", instrNum, index-1, varId);
            printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::constToInt).c_str(), 
                             "%s\t%s\n", varId, c->getUniqueInteger().toString(10,true));
			immediate[varId] = GEP.getOperand(index)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::gepInsnIndex, 1).c_str(),
					"%s\t%d\t%s\n", instrNum, index-1, varId);
			variable[varId] = GEP.getOperand(index)->getType();
		}
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::gepInsnNIndices).c_str(),
			"%s\t%d\n", instrNum, GEP.getNumIndices());
	if(GEP.isInBounds()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
				"%s\t%s\n", instrNum, "inbounds");
	}
}

void InstructionVisitor::visitPHINode(PHINode &PHI) {

	raw_string_ostream rso(value_str);

	// <result> = phi <ty> [ <val0>, <label0>], ...
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::phiInsn).c_str(), "%s\n", instrNum);
	// type
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::phiInsnType).c_str(),
			"%s\t%t\n", instrNum, printType(PHI.getType()));
	for(unsigned op = 0; op < PHI.getNumIncomingValues(); ++op) {
		//value
		value_str.clear();
		WriteAsOperand(rso, PHI.getIncomingValue(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(PHI.getIncomingValue(op))) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::phiInsnPairValue, 0).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			immediate[varId] = PHI.getIncomingValue(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::phiInsnPairValue, 1).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			variable[varId] = PHI.getIncomingValue(op)->getType();
		}
		//<label>
		value_str.clear();
		WriteAsOperand(rso, PHI.getIncomingBlock(op), 0, Mod);
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::phiInsnPairLabel).c_str(),
				"%s\t%d\t%s\n", instrNum, op, varId);
		variable[varId] = PHI.getIncomingBlock(op)->getType();
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::phiInsnNPairs).c_str(),
			"%s\t%d\n", instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::selectInsn).c_str(), "%s\n", instrNum);
	//Condition
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnCond, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnCond, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(0)->getType();
	}
	//Left Operand (true value)
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(1)->getType();
	}
	//Right Operand (false value)
	value_str.clear();
	WriteAsOperand(rso,SI.getOperand(2), 0, Mod);
	if (Constant *c = dyn_cast<Constant>(SI.getOperand(2))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(2)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::selectInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(2)->getType();
	}
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insertValueInsn).c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, IVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IVI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertValueInsnBase, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IVI.getOperand(0)->getType();

	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertValueInsnBase, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IVI.getOperand(0)->getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso, IVI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IVI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertValueInsnValue, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IVI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertValueInsnValue, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IVI.getOperand(1)->getType();
	}
	//Constant Indices
	int index = 0;
	for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end(); i != e; ++i) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insertValueInsnIndex).c_str(),
				"%s\t%d\t%s\n", instrNum, index, *i);
		index++;
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insertValueInsnNIndices).c_str(),
			"%s\t%s\n", instrNum, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::landingpadInsn).c_str(), "%s\n", instrNum);
	// type
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::landingpadInsnType).c_str(),
			"%s\t%t\n", instrNum, printType(LI.getType()));

	// function
	value_str.clear();
	WriteAsOperand(rso, LI.getPersonalityFn(), 0, Mod);
	varId = instrId + rso.str();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::landingpadInsnFunc).c_str(),
			"%s\t%s\n", instrNum, varId);
	immediate[varId] = LI.getPersonalityFn()->getType();
	//cleanup
	if(LI.isCleanup()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
				"%s\t%s\n", instrNum, "cleanup");
	}
	//#clauses
	for (unsigned i = 0; i < LI.getNumClauses(); ++i) {
		//catch clause
		if(LI.isCatch(i)) {
			value_str.clear();
			WriteAsOperand(rso, LI.getClause(i), 0, Mod);
			if (Constant *c = dyn_cast<Constant>(LI.getClause(i))) {
				varId = rso.str();
				printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::landingpadInsnCatch, 0).c_str(),
						"%s\t%s\n", instrNum, varId);
				immediate[varId] = LI.getClause(i)->getType();
			}
			else {
				varId = instrId + rso.str();
				printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::landingpadInsnCatch, 1).c_str(),
						"%s\t%s\n", instrNum, varId);
				variable[varId] = LI.getClause(i)->getType();
			}
		}
		//filter clause
		else {
			value_str.clear();
			WriteAsOperand(rso, LI.getClause(i), 0, Mod);
			//constantArray
			varId = rso.str();
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::landingpadInsnFilter).c_str(),
					"%s\t%s\n", instrNum, varId);
			immediate[varId] = LI.getClause(i)->getType();
		}
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::landingpadInsnNClauses).c_str(),
			"%s\t%s\n", instrNum, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::callInsn).c_str(), "%s\n", instrNum);
	Value *callOp = CI.getCalledValue();
	PointerType *ptrTy = cast<PointerType>(callOp->getType());
	FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
	Type *RetTy = funcTy->getReturnType();

	value_str.clear();
	WriteAsOperand(rso, callOp, 0, Mod);
	if(Constant *c = dyn_cast<Constant>(callOp)) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::callInsnFunction, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = funcTy;
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::callInsnFunction, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = funcTy;
	}
	if(CI.getCalledFunction()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::directCallInsn).c_str(), "%s\n", instrNum);
	}
	else {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::indirectCallInsn).c_str(), "%s\n", instrNum);
	}
	for(unsigned op = 0; op < CI.getNumArgOperands(); ++op) {
		value_str.clear();
		WriteAsOperand(rso, CI.getArgOperand(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(CI.getArgOperand(op))) {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::callInsnArg, 0).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			immediate[varId] = CI.getArgOperand(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::callInsnArg, 1).c_str(),
					"%s\t%d\t%s\n", instrNum, op, varId);
			variable[varId] = CI.getArgOperand(op)->getType();
		}
	}
	if(CI.isTailCall()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
				"%s\t%s\n", instrNum, "tail");
	}
	if (CI.getCallingConv() != CallingConv::C) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::callCallConv).c_str(),
				"%s\t%s\n", instrNum, writeCallingConv(CI.getCallingConv()));
	}
	const AttributeSet &Attrs = CI.getAttributes();
	if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::callInsnRetAttr).c_str(),
				"%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
	}
	vector<string> FuncnAttr;
	writeFnAttributes(Attrs, FuncnAttr);
	for(int i = 0; i < FuncnAttr.size(); ++i) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::callInsnFuncAttr).c_str(),
				"%s\t%s\n", instrNum, FuncnAttr[i]);
	}
}

void InstructionVisitor::visitICmpInst(ICmpInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::icmpInsn).c_str(), "%s\n", instrNum);

	//Condition
	if(strlen(writePredicate(I.getPredicate()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::icmpInsnCond).c_str(),
				"%s\t%s\n", instrNum, writePredicate(I.getPredicate()));
	}
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::icmpInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::icmpInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::icmpInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::icmpInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(1)->getType();
	}
}

void InstructionVisitor::visitFCmpInst(FCmpInst &I) {

	raw_string_ostream rso(value_str);
	string error;

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fcmpInsn).c_str(), "%s\n", instrNum);

	//Condition
	if(strlen(writePredicate(I.getPredicate()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::fcmpInsnCond).c_str(),
				"%s\t%s\n", instrNum, writePredicate(I.getPredicate()));
	}
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fcmpInsnFirstOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fcmpInsnFirstOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(0)->getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso, I.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(I.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fcmpInsnSecondOp, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = I.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::fcmpInsnSecondOp, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = I.getOperand(1)->getType();
	}
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::extractElemInsn).c_str(), "%s\n", instrNum);
	//VectorOperand
	value_str.clear();
	WriteAsOperand(rso, EEI.getVectorOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EEI.getVectorOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractElemInsnBase, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = EEI.getVectorOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractElemInsnBase, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = EEI.getVectorOperand()->getType();
	}
	//indexValue
	value_str.clear();
	WriteAsOperand(rso, EEI.getIndexOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EEI.getIndexOperand())) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractElemInsnIndex, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = EEI.getIndexOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::extractElemInsnIndex, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = EEI.getIndexOperand()->getType();
	}
}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insertElemInsn).c_str(), "%s\n", instrNum);
	//vectorOperand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnBase, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnBase, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(0)->getType();
	}
	//Value Operand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnValue, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnValue, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(1)->getType();
	}
	//Index Operand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(2), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(2))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnIndex, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(2)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::insertElemInsnIndex, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(2)->getType();
	}
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI) {

	raw_string_ostream rso(value_str);

	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::shuffleVectorInsn).c_str(), "%s\n", instrNum);
	//firstVector
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SVI.getOperand(0))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shuffleVectorInsnFirstVec, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SVI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shuffleVectorInsnFirstVec, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SVI.getOperand(0)->getType();
	}
	//secondVector
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SVI.getOperand(1))) {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shuffleVectorInsnSecondVec, 0).c_str(),
				"%s\t%s\n", instrNum, varId);
		immediate[varId] = SVI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile(PredicateNames::predNameWithOperandToFilename(PredicateNames::shuffleVectorInsnSecondVec, 1).c_str(),
				"%s\t%s\n", instrNum, varId);
		variable[varId] = SVI.getOperand(1)->getType();
	}
	//Mask
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(2), 0, Mod);
	varId = instrId + rso.str();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::shuffleVectorInsnMask).c_str(),
			"%s\t%s\n", instrNum, varId);
	immediate[varId] = SVI.getOperand(2)->getType();
}

void  InstructionVisitor::visitInstruction(Instruction &I) {

	errs() << I.getOpcodeName() << ": Unhandled instruction\n";
}
