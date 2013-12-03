#include <iostream>
#include <set>
#include <string>
#include <cctype>

#include "functions.h"
#include "InstructionVisitor.h"

#include "llvm/Assembly/Writer.h"
#include "llvm/IR/Module.h"

using namespace llvm;
using namespace std;

// Visit methods definitions including constructor
InstructionVisitor::InstructionVisitor(map<string,Type *> &var,
		map<string, Type *> &imm, Module *M): variable(var), immediate(imm), Mod(M) {

    errs() << "InstructionVisitor is being created.\n";
}

void InstructionVisitor::visitBinaryOperator(BinaryOperator &BI) {
	raw_string_ostream rso(value_str);

	string instrName = string(BI.getOpcodeName());
	instrName[0] = toupper(instrName[0]);
	instrName = instrName + "Instruction";
	string entityName = "facts/entities/" + instrName + ".dlm";
	string leftOperand = "facts/" + instrName + "-Left-";
	string rightOperand = "facts/" + instrName + "-Right-";
	string cond = "facts/predicates/" + instrName + "-Cond.dlm";

	writeOptimizationInfoToFile(&BI, instrNum);
	printFactsToFile(entityName.c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(0))) {
	//	varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile((leftOperand + "Imm.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile((rightOperand + "Var.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso,BI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(BI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile((rightOperand + "Imm.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		immediate[varId] = BI.getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile((rightOperand + "Var.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getType();
	}
}

// Terminator Instructions
void InstructionVisitor::visitReturnInst(ReturnInst &RI) {
	printFactsToFile("facts/entities/ReturnInstruction.dlm", "%s\n", instrNum);
	//ret <type> <value>
	raw_string_ostream rso(value_str);
	if(RI.getReturnValue()) {
		value_str.clear();
		WriteAsOperand(rso, RI.getReturnValue(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(RI.getReturnValue())) {
//			varId = rso.str();
			varId = instrId + rso.str();
			printFactsToFile("facts/ReturnInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = RI.getReturnValue()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile("facts/ReturnInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
			variable[varId] = RI.getReturnValue()->getType();
		}
	}
	//ret void
	else {
		printFactsToFile("facts/entities/ReturnInstruction-Void.dlm", "%s\n", instrNum);
	}
}
void InstructionVisitor::visitBranchInst(BranchInst &BI) {

	printFactsToFile("facts/entities/BrInstruction.dlm", "%s\n", instrNum);
	raw_string_ostream rso(value_str);
	if(BI.isConditional()) {
		//br i1 <cond>, label <iftrue>, label <iffalse>
		printFactsToFile("facts/entities/BrInstruction-Conditional.dlm", "%s\n", instrNum);
		//Condition Operand
		value_str.clear();
		WriteAsOperand(rso, BI.getCondition(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(BI.getCondition())) {
//			varId = rso.str();
			varId = instrId + rso.str();
			printFactsToFile("facts/BrInstruction-Conditional-Imm.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = BI.getCondition()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile("facts/BrInstruction-Conditional-Var.dlm", "%s\t%s\n", instrNum, varId);
			variable[varId] = BI.getCondition()->getType();
		}
		//'iftrue' label
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
/*		if(Constant *c = dyn_cast<Constant>(bi->getOperand(0))) {
			varId = rso.str();
			printFactsToFile("facts/BrInstruction-Conditional-TrueLabel-Imm.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = bi->getOperand(0)->getType();
		} */
 	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/BrInstruction-Conditional-TrueLabel.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(0)->getType();
	//	}
		//'iffalse' label
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(1), 0, Mod);
/*		if(Constant *c = dyn_cast<Constant>(bi->getOperand(1))) {
			varId = rso.str();
			printFactsToFile("facts/BrInstruction-Conditional-FalseLabel-Imm.txt", "%s\t%s\n", instrNum, varId);
			immediate[varId] = bi->getOperand(1)->getType();
		}*/
	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/BrInstruction-Conditional-FalseLabel.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(1)->getType();
	//	}
	}
	else {
		//br label <dest>
		printFactsToFile("facts/entities/BrInstruction-Unconditional.dlm", "%s\n", instrNum);
		value_str.clear();
		WriteAsOperand(rso, BI.getOperand(0), 0, Mod);
	/*	if(Constant *c = dyn_cast<Constant>(bi->getOperand(0))) {
			varId = rso.str();
			printFactsToFile("facts/BrInstruction-Unconditional-Label-Imm.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = bi->getOperand(0)->getType();
		}*/
	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/BrInstruction-Unconditional-Label.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = BI.getOperand(0)->getType();
	//	}
	}
}

void InstructionVisitor::visitSwitchInst(SwitchInst &SI) {

	//switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
	printFactsToFile("facts/entities/SwitchInstruction.dlm", "%s\n", instrNum);
	raw_string_ostream rso(value_str);
	//'value' Operand
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/SwitchInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/SwitchInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(0)->getType();
	}
	//'defaultdest' label
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(1), 0, Mod);
/*	if(Constant *c = dyn_cast<Constant>(si->getOperand(1))) {
		varId = rso.str();
		printFactsToFile("SwitchInstruction-Label-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = si->getOperand(1)->getType();
	} */
//	else {
	varId = instrId + rso.str();
	printFactsToFile("facts/predicates/SwitchInstruction-Label.dlm", "%s\t%s\n", instrNum, varId);
	variable[varId] = SI.getOperand(1)->getType();
//	}
	//'case list' [constant, label]
	for(unsigned i = 2; i < SI.getNumOperands(); i += 2) {
		value_str.clear();
		WriteAsOperand(rso, SI.getOperand(i), 0, Mod);
	//	varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/SwitchInstruction-Case-Value.dlm", "%s\t%d\t%s\n", instrNum, i-2, varId);
		immediate[varId] = SI.getOperand(i)->getType();
/*		if(Constant *c = dyn_cast<Constant>(si->getOperand(i+1))) {
			varId = rso.str();
			printFactsToFile("SwitchInstruction-Case-Label-Imm.dlm", "%s\t%d\t%s\n", instrNum, i-2, varId);
			immediate[varId] = si->getOperand(i+1)->getType();
		} */
	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/SwitchInstruction-Case-Label.dlm", "%s\t%d\t%s\n", instrNum, i-2, varId);
		variable[varId] = SI.getOperand(i+1)->getType();
	//	}
	}
	printFactsToFile("facts/predicates/SwitchInstruction-nCases.dlm", "%s\t%d\n", instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR) {
	raw_string_ostream rso(value_str);

	//indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
	printFactsToFile("facts/entities/IndirectBrInstruction.dlm", "%s\n", instrNum);
	//'address' Operand
	value_str.clear();
	WriteAsOperand(rso, IBR.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IBR.getOperand(0))) {
	//	varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/IndirectBrInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IBR.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/IndirectBrInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IBR.getOperand(0)->getType();
	}
	//'label' list
	for(unsigned i = 1; i < IBR.getNumOperands(); ++i) {
		value_str.clear();
		WriteAsOperand(rso, IBR.getOperand(i), 0, Mod);
	/*	if(Constant *c = dyn_cast<Constant>(ibr->getOperand(i))) {
			varId = rso.str();
			printFactsToFile("IndirectBrInstruction-Label-Imm.txt", "%s\t%d\t%s\n", instrNum, i-1, varId);
			immediate[varId] = ibr->getOperand(i)->getType();
		} */
	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/IndirectBrInstruction-Label.dlm", "%s\t%d\t%s\n", instrNum, i-1, varId);
		variable[varId] = IBR.getOperand(i)->getType();
	//	}
	}
	printFactsToFile("facts/predicates/IndirectBrInstruction-nLabels.dlm", "%s\t%d\n", instrNum, IBR.getNumOperands()-1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/InvokeInstruction.dlm", "%s\n", instrNum);
	Value *invokeOp = II.getCalledValue();
	PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
	FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

	string funcName;
	value_str.clear();
	WriteAsOperand(rso, invokeOp, 0, Mod);
	if(II.getCalledFunction()) {
		printFactsToFile("facts/entities/InvokeInstruction-Direct.dlm", "%s\n", instrNum);
		funcName = rso.str();
		printFactsToFile("facts/predicates/InvokeInstruction-Direct-Name.dlm", "%s\t%s\n", instrNum, funcName);
		printFactsToFile("facts/predicates/InvokeInstruction-Direct-Type.dlm", "%s\t%s\n", instrNum, printType(funcTy));
	}
	else {
		printFactsToFile("facts/entities/InvokeInstruction-Indirect.dlm", "%s\n", instrNum);
		funcName = instrId + rso.str();
		printFactsToFile("facts/predicates/InvokeInstruction-Indirect-Pointer.dlm", "%s\t%s\n", instrNum, funcName);
		variable[funcName] = funcTy;
	}
	//actual args
	for(unsigned op = 0; op < II.getNumArgOperands(); ++op) {
		value_str.clear();
		WriteAsOperand(rso, II.getArgOperand(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(II.getArgOperand(op))) {
	//		varId = rso.str();
			varId = instrId + rso.str();
			immediate[varId] = II.getArgOperand(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			variable[varId] = II.getArgOperand(op)->getType();
		}
		printFactsToFile("facts/predicates/InvokeInstruction-ActualArg.dlm", "%s\t%d\t%s\n", instrNum, op, varId);
	}
	//'normal label'
	value_str.clear();
	WriteAsOperand(rso, II.getNormalDest(), 0, Mod);
/*		if(Constant *c = dyn_cast<Constant>(ii->getNormalDest())) {
		varId = rso.str();
		printFactsToFile("InvokeInstruction-NormalLabel-Imm.txt", "%s\t%s\n", instrNum, varId);
		immediate[varId] = ii->getNormalDest()->getType();
	} */
//	else {
	varId = instrId + rso.str();
	printFactsToFile("facts/predicates/InvokeInstruction-NormalLabel.dlm", "%s\t%s\n", instrNum, varId);
	variable[varId] = II.getNormalDest()->getType();
//	}
	//'exception label'
/*	if(Constant *c = dyn_cast<Constant>(ii->getUnwindDest())) {
		varId = rso.str();
		printFactsToFile("InvokeInstruction-ExceptionLabel-Imm.txt", "%s\t%s\n", instrNum, varId);
		immediate[varId] = ii->getUnwindDest()->getType();
	} */
//	else {
	varId = instrId + rso.str();
	printFactsToFile("facts/predicates/InvokeInstruction-ExceptionLabel.dlm", "%s\t%s\n", instrNum, varId);
	variable[varId] = II.getUnwindDest()->getType();
//	}
	//Function Attributes
	const AttributeSet &Attrs = II.getAttributes();
	if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
	//	errs() << "Ret Attr : " << Attrs.getAsString(AttributeSet::ReturnIndex) << "\n";
		printFactsToFile("facts/predicates/InvokeInstruction-RetAttribute.dlm", "%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
	}
	vector<string> FuncnAttr;
	writeFnAttributes(Attrs, FuncnAttr);
	for(int i = 0; i < FuncnAttr.size(); ++i) {
		printFactsToFile("facts/predicates/InvokeInstruction-FnAttributes.dlm", "%s\t%s\n", instrNum, FuncnAttr[i]);
	}
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/ResumeInstruction.dlm", "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, RI.getValue(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(RI.getValue())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ResumeInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = RI.getValue()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ResumeInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = RI.getValue()->getType();
	}
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
	printFactsToFile("facts/entities/UnreachableInstruction.dlm", "%s\n", instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/AllocaInstruction.dlm", "%s\n", instrNum);
	printFactsToFile("facts/predicates/AllocaInstruction-Size-Type.dlm", "%s\t%t\n", instrNum, printType(AI.getAllocatedType()));
//		types.insert(ai->getAllocatedType());
	if(AI.isArrayAllocation()) {
		value_str.clear();
		WriteAsOperand(rso, AI.getArraySize(), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(AI.getArraySize())) {
//			varId = rso.str();
			varId = instrId + rso.str();
			printFactsToFile("facts/predicates/AllocaInstruction-Size-Imm.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = AI.getArraySize()->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile("facts/predicates/AllocaInstruction-Size-Var.dlm", "%s\t%s\n", instrNum, varId);
			variable[varId] = AI.getArraySize()->getType();
		}
	}
	if(AI.getAlignment()) {
		printFactsToFile("facts/predicates/AllocaInstruction-Align.dlm", "%s\t%d\n", instrNum, AI.getAlignment());
	}
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/LoadInstruction.dlm", "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, LI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(LI.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/LoadInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = LI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/LoadInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = LI.getPointerOperand()->getType();
	}
	writeVolatileFlag(instrNum, LI.isVolatile());
	if(LI.isAtomic()) {
		printFactsToFile("facts/predicates/Instruction-Flag.dlm", "%s\t%s\n", instrNum, "atomic");
		const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());
		if(strlen(ord)) {
			printFactsToFile("facts/predicates/LoadInstruction-Ordering.dlm", "%s\t%d\n", instrNum, ord);
		}
	}
	if(LI.getAlignment()) {
		printFactsToFile("facts/predicates/LoadInstruction-Align.dlm", "%s\t%d\n", instrNum, LI.getAlignment());
	}
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/VAArgInstruction.dlm", "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, VI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(VI.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/VAArgInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = VI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/VAArgInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = VI.getPointerOperand()->getType();
	}
//			printFactsToFile("facts/predicates/VAArgInstruction-Type.dlm", "%s\t%t\n", instrNum, *vi->getType());
	printFactsToFile("facts/predicates/VAArgInstruction-Type.dlm", "%s\t%t\n", instrNum, printType(VI.getType()));
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/ExtractValueInstruction.dlm", "%s\n", instrNum);
	//Aggregate Operand
	value_str.clear();
	WriteAsOperand(rso, EVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EVI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractValueInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = EVI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractValueInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = EVI.getOperand(0)->getType();
	}
	//Constant Indices
	for (unsigned index = 1; index < EVI.getNumOperands(); ++index) {
		value_str.clear();
		WriteAsOperand(rso, EVI.getOperand(index), 0, Mod);
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/ExtractValueInstruction-Indices.dlm", "%s\t%d\t%s\n", instrNum, index-1, varId);
	}
	printFactsToFile("facts/predicates/ExtractValueInstruction-nIndices.dlm", "%s\t%s\n", instrNum, EVI.getNumIndices());
}

void InstructionVisitor::visitCastInst(CastInst &CI) {
	raw_string_ostream rso(value_str);

	string instrName = string(CI.getOpcodeName());
	instrName[0] = toupper(instrName[0]);
	instrName = instrName + "Instruction";
	string entityName = "facts/entities/" + instrName + ".dlm";
	string operand = "facts/" + instrName;
	string type = "facts/predicates/" + instrName + "-Type.dlm";

	printFactsToFile(entityName.c_str(), "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, CI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(CI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile((operand + "-Imm.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		immediate[varId] = CI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile((operand + "-Var.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		variable[varId] = CI.getOperand(0)->getType();
	}
	printFactsToFile(type.c_str(), "%s\t%t\n", instrNum, printType(CI.getType()));
}

void InstructionVisitor::visitStoreInst(StoreInst &SI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/StoreInstruction.dlm", "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, SI.getValueOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getValueOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/StoreInstruction-Left-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getValueOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/StoreInstruction-Left-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getValueOperand()->getType();
	}
	value_str.clear();
	WriteAsOperand(rso, SI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/StoreInstruction-Right-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/StoreInstruction-Right-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getPointerOperand()->getType();
	}
	writeVolatileFlag(instrNum, SI.isVolatile());
	if(SI.isAtomic()) {
		printFactsToFile("facts/predicates/Instruction-Flag.dlm", "%s\t%s\n", instrNum, "atomic");
		const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());
		if(strlen(ord)) {
			printFactsToFile("facts/predicates/StoreInstruction-Ordering.dlm", "%s\t%d\n", instrNum, ord);
		}
	}
	if(SI.getAlignment()) {
		printFactsToFile("facts/predicates/StoreInstruction-Align.dlm", "%s\t%d\n", instrNum, SI.getAlignment());
	}
}
void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/AtomicCmpXchgInstruction.dlm", "%s\n", instrNum);
	//ptrValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-PtrValue-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-PtrValue-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getPointerOperand()->getType();
	}
	//cmpValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getCompareOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getCompareOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-CmpValue-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getCompareOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-CmpValue-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getCompareOperand()->getType();
	}
	//newValue
	value_str.clear();
	WriteAsOperand(rso, AXI.getNewValOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AXI.getNewValOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-NewValue-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = AXI.getNewValOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicCmpXchgInstruction-NewValue-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = AXI.getNewValOperand()->getType();
	}
	writeVolatileFlag(instrNum, AXI.isVolatile());
	const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile("facts/predicates/AtomicCmpXchgInstruction-Ordering.dlm", "%s\t%d\n", instrNum, ord);
	}
}
void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/AtomicRMWInstruction.dlm", "%s\n", instrNum);
	//ptrValue - LeftOperand
	value_str.clear();
	WriteAsOperand(rso, AWI.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AWI.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicRMWInstruction-Left-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = AWI.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicRMWInstruction-Left-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = AWI.getPointerOperand()->getType();
	}
	//valOperand - Right Operand
	value_str.clear();
	WriteAsOperand(rso, AWI.getValOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(AWI.getValOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicRMWInstruction-Right-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = AWI.getValOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/AtomicRMWInstruction-Right-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = AWI.getValOperand()->getType();
	}
	writeVolatileFlag(instrNum, AWI.isVolatile());
	writeAtomicRMWOp(instrNum, AWI.getOperation());
	const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile("facts/predicates/AtomicRMWInstruction-Ordering.dlm", "%s\t%d\n", instrNum, ord);
	}
}

void InstructionVisitor::visitFenceInst(FenceInst &FI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/FenceInstruction.dlm", "%s\n", instrNum);
	//fence [singleThread]  <ordering>
	const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());
	if(strlen(ord)) {
		printFactsToFile("facts/predicates/FenceInstruction-Ordering.dlm", "%s\t%d\n", instrNum, ord);
	}
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/GepInstruction.dlm", "%s\n", instrNum);
	value_str.clear();
	WriteAsOperand(rso, GEP.getPointerOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(GEP.getPointerOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/GepInstruction-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = GEP.getPointerOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/GepInstruction-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = GEP.getPointerOperand()->getType();
	}
	for (unsigned index = 1; index < GEP.getNumOperands(); ++index) {
		value_str.clear();
		WriteAsOperand(rso, GEP.getOperand(index), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(GEP.getOperand(index))) {
//			varId = rso.str();
			varId = instrId + rso.str();
			printFactsToFile("facts/GepInstruction-Indices-Imm.dlm", "%s\t%d\t%s\n", instrNum, index-1, varId);
			immediate[varId] = GEP.getOperand(index)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile("facts/GepInstruction-Indices-Var.dlm", "%s\t%d\t%s\n", instrNum, index-1, varId);
			variable[varId] = GEP.getOperand(index)->getType();
		}
	}
	printFactsToFile("facts/predicates/GepInstruction-nIndices.dlm", "%s\t%d\n", instrNum, GEP.getNumIndices());
	if(GEP.isInBounds()) {
		printFactsToFile("facts/predicates/Instruction-Flag.dlm", "%s\t%s\n", instrNum, "inbounds");
	}
}

void InstructionVisitor::visitPHINode(PHINode &PHI) {
	raw_string_ostream rso(value_str);

	//<result> = phi <ty> [ <val0>, <label0>], ...
	printFactsToFile("facts/entities/PhiInstruction.dlm", "%s\n", instrNum);
	//type
	printFactsToFile("facts/predicates/PhiInstruction-Type.dlm", "%s\t%t\n", instrNum, printType(PHI.getType()));
	for(unsigned op = 0; op < PHI.getNumIncomingValues(); ++op) {
		//value
		value_str.clear();
		WriteAsOperand(rso, PHI.getIncomingValue(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(PHI.getIncomingValue(op))) {
//			varId = rso.str();
			varId = instrId + rso.str();
			printFactsToFile("facts/PhiInstruction-Pair-Value-Imm.dlm", "%s\t%d\t%s\n", instrNum, op, varId);
			immediate[varId] = PHI.getIncomingValue(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			printFactsToFile("facts/PhiInstruction-Pair-Value-Var.dlm", "%s\t%d\t%s\n", instrNum, op, varId);
			variable[varId] = PHI.getIncomingValue(op)->getType();
		}
		//<label>
		value_str.clear();
		WriteAsOperand(rso, PHI.getIncomingBlock(op), 0, Mod);
	/*	if(Constant *c = dyn_cast<Constant>(phi->getIncomingBlock(op))) {
			varId = rso.str();
			printFactsToFile("PhiInstruction-Label-Imm.txt", "%s\t%d\t%s\n", instrNum, op, varId);
			immediate[varId] = phi->getIncomingBlock(op)->getType();
		}*/
	//	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/predicates/PhiInstruction-Pair-Label.dlm", "%s\t%d\t%s\n", instrNum, op, varId);
		variable[varId] = PHI.getIncomingBlock(op)->getType();
	//	}
	}
	printFactsToFile("facts/predicates/PhiInstruction-nPairs.txt", "%s\t%d\n", instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/SelectInstruction.dlm", "%s\n", instrNum);
	//Condition
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-Condition-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-Condition-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(0)->getType();
	}
	//Left Operand (true value)
	value_str.clear();
	WriteAsOperand(rso, SI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-LeftValue-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-LeftValue-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(1)->getType();
	}
	//Right Operand (false value)
	value_str.clear();
	WriteAsOperand(rso,SI.getOperand(2), 0, Mod);
	if (Constant *c = dyn_cast<Constant>(SI.getOperand(2))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-RightValue-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SI.getOperand(2)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/SelectInstruction-RightValue-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SI.getOperand(2)->getType();
	}
}
void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/InsertValueInstruction.dlm", "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, IVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IVI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertValueInstruction-Left-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IVI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertValueInstruction-Left-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IVI.getOperand(0)->getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso, IVI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IVI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertValueInstruction-Right-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IVI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertValueInstruction-Right-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IVI.getOperand(1)->getType();
	}
	//Constant Indices
	for (unsigned index = 2; index < IVI.getNumOperands(); ++index) {
		value_str.clear();
		WriteAsOperand(rso, IVI.getOperand(index), 0, Mod);
		varId = rso.str();
		printFactsToFile("facts/predicates/InsertValueInstruction-Indices.dlm", "%s\t%d\t%s\n", instrNum, index-2, varId);
	}
	printFactsToFile("facts/predicates/InsertValueInstruction-nIndices.dlm", "%s\t%s\n", instrNum, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/LandingpadInstruction.dlm", "%s\n", instrNum);
	//type
//		printFactsToFile("facts/predicates/LandingpadInstruction-Type.dlm", "%s\t%t\n", instrNum, *li->getType());
	printFactsToFile("facts/predicates/LandingpadInstruction-Type.dlm", "%s\t%t\n", instrNum, printType(LI.getType()));
	//function
	value_str.clear();
	WriteAsOperand(rso, LI.getPersonalityFn(), 0, Mod);
	if (Constant *c = dyn_cast<Constant>(LI.getPersonalityFn())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/LandingpadInstruction-Function-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = LI.getPersonalityFn()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/LandingpadInstruction-Function-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = LI.getPersonalityFn()->getType();
	}
	//cleanup
	if(LI.isCleanup()) {
		printFactsToFile("facts/predicates/Instruction-Flag.dlm", "%s\t%s\n", instrNum, "cleanup");
	}
	//#clauses
	for (unsigned i = 0; i < LI.getNumClauses(); ++i) {
		//catch clause
		if(LI.isCatch(i)) {
			value_str.clear();
			WriteAsOperand(rso, LI.getClause(i), 0, Mod);
			if (Constant *c = dyn_cast<Constant>(LI.getClause(i))) {
				varId = rso.str();
				printFactsToFile("facts/LandingpadInstruction-Clause-Catch-Imm.dlm", "%s\t%s\n", instrNum, varId);
				immediate[varId] = LI.getClause(i)->getType();
			}
			else {
				varId = instrId + rso.str();
				printFactsToFile("facts/LandingpadInstruction-Clause-Catch-Var.dlm", "%s\t%s\n", instrNum, varId);
				variable[varId] = LI.getClause(i)->getType();
			}
		}
		//filter clause
		else {
			value_str.clear();
			WriteAsOperand(rso, LI.getClause(i), 0, Mod);
			//constantArray
			varId = rso.str();
			printFactsToFile("facts/predicates/LandingpadInstruction-Clause-Filter.dlm", "%s\t%s\n", instrNum, varId);
			immediate[varId] = LI.getClause(i)->getType();
		}
	}
}

void InstructionVisitor::visitCallInst(CallInst &CI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/CallInstruction.dlm", "%s\n", instrNum);
	Value *callOp = CI.getCalledValue();
	PointerType *ptrTy = cast<PointerType>(callOp->getType());
	FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
//	types.insert(ptrTy);
	Type *RetTy = funcTy->getReturnType();
//	value_str.clear();
//	WriteAsOperand(rso, callOp, 1, Mod);
//	errs() << "called value: " << rso.str() << "\n";
//	errs() << "+ " << *ptrTy << "+ " << *funcTy << "+ " << *RetTy << "\n";
	string funcName;
	value_str.clear();
	WriteAsOperand(rso, callOp, 0, Mod);
	if(CI.getCalledFunction()) {
		printFactsToFile("facts/entities/CallInstruction-Direct.dlm", "%s\n", instrNum);
		funcName = rso.str();
		printFactsToFile("facts/predicates/CallInstruction-Direct-Name.dlm", "%s\t%s\n", instrNum, funcName);
		printFactsToFile("facts/predicates/CallInstruction-Direct-Type.dlm", "%s\t%s\n", instrNum, printType(funcTy));
	}
	else {
		printFactsToFile("facts/entities/CallInstruction-Indirect.dlm", "%s\n", instrNum);
		funcName = instrId + rso.str();
		printFactsToFile("facts/predicates/CallInstruction-Indirect-Pointer.dlm", "%s\t%s\n", instrNum, funcName);
		variable[funcName] = funcTy;
	}
	for(unsigned op = 0; op < CI.getNumArgOperands(); ++op) {
		value_str.clear();
		WriteAsOperand(rso, CI.getArgOperand(op), 0, Mod);
		if(Constant *c = dyn_cast<Constant>(CI.getArgOperand(op))) {
//			varId = rso.str();
			varId = instrId + rso.str();
			immediate[varId] = CI.getArgOperand(op)->getType();
		}
		else {
			varId = instrId + rso.str();
			variable[varId] = CI.getArgOperand(op)->getType();
		}
		printFactsToFile("facts/predicates/CallInstruction-ActualArg.dlm", "%s\t%d\t%s\n", instrNum, op, varId);
	}
	if(CI.isTailCall()) {
		printFactsToFile("facts/predicates/Instruction-Flag.dlm", "%s\t%s\n", instrNum, "tail");
	}
	if (CI.getCallingConv() != CallingConv::C) {
		printFactsToFile("facts/predicates/CallInstruction-CallingConv.dlm", "%s\t%s\n", instrNum, writeCallingConv(CI.getCallingConv()));
	}
	const AttributeSet &Attrs = CI.getAttributes();
	if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
	//	errs() << "Ret Attr : " << Attrs.getAsString(AttributeSet::ReturnIndex) << "\n";
		printFactsToFile("facts/predicates/CallInstruction-RetAttribute.dlm", "%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
	}
	vector<string> FuncnAttr;
	writeFnAttributes(Attrs, FuncnAttr);
	for(int i = 0; i < FuncnAttr.size(); ++i) {
		printFactsToFile("facts/predicates/CallInstruction-FnAttributes.dlm", "%s\t%s\n", instrNum, FuncnAttr[i]);
	}
}

void InstructionVisitor::visitCmpInst(CmpInst &CI) {
	raw_string_ostream rso(value_str);

	string instrName = string(CI.getOpcodeName());
	instrName[0] = toupper(instrName[0]);
	instrName = instrName + "Instruction";
	string entityName = "facts/entities/" + instrName + ".dlm";
	string leftOperand = "facts/" + instrName + "-Left-";
	string rightOperand = "facts/" + instrName + "-Right-";
	string cond = "facts/predicates/" + instrName + "-Cond.dlm";
//	printFactsToFile("facts/entities/IcmpInstruction.dlm", "%s\n", instrNum);
	printFactsToFile(entityName.c_str(), "%s\n", instrNum);
	//Left Operand
	value_str.clear();
	WriteAsOperand(rso, CI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(CI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile((leftOperand + "Imm.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		immediate[varId] = CI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile((leftOperand + "Var.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		variable[varId] = CI.getOperand(0)->getType();
	}
	//Right Operand
	value_str.clear();
	WriteAsOperand(rso, CI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(CI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile((rightOperand + "Imm.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		immediate[varId] = CI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile((rightOperand + "Var.dlm").c_str(), "%s\t%s\n", instrNum, varId);
		variable[varId] = CI.getOperand(1)->getType();
	}
	//Condition
	if(strlen(writePredicate(CI.getPredicate()))) {
		printFactsToFile(cond.c_str(), "%s\t%s\n", instrNum, writePredicate(CI.getPredicate()));
	}
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/ExtractElementInstruction.dlm", "%s\n", instrNum);
	//VectorOperand
	value_str.clear();
	WriteAsOperand(rso, EEI.getVectorOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EEI.getVectorOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractElementInstruction-Left-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = EEI.getVectorOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractElementInstruction-Left-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = EEI.getVectorOperand()->getType();
	}
	//indexValue
	value_str.clear();
	WriteAsOperand(rso, EEI.getIndexOperand(), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(EEI.getIndexOperand())) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractElementInstruction-Right-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = EEI.getIndexOperand()->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ExtractElementInstruction-Right-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = EEI.getIndexOperand()->getType();
	}
}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/InsertElementInstruction.dlm", "%s\n", instrNum);
	//vectorOperand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Vector-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Vector-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(0)->getType();
	}
	//Value Operand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Value-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Value-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(1)->getType();
	}
	//Index Operand
	value_str.clear();
	WriteAsOperand(rso, IEI.getOperand(2), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(IEI.getOperand(2))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Index-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = IEI.getOperand(2)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/InsertElementInstruction-Index-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = IEI.getOperand(2)->getType();
	}
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI) {
	raw_string_ostream rso(value_str);

	printFactsToFile("facts/entities/ShuffleVecotrInstruction.dlm", "%s\n", instrNum);
	//firstVector
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(0), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SVI.getOperand(0))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ShuffleVecotrInstruction-LeftVector-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SVI.getOperand(0)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ShuffleVecotrInstruction-LeftVector-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SVI.getOperand(0)->getType();
	}
	//secondVector
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(1), 0, Mod);
	if(Constant *c = dyn_cast<Constant>(SVI.getOperand(1))) {
//		varId = rso.str();
		varId = instrId + rso.str();
		printFactsToFile("facts/ShuffleVecotrInstruction-RightVector-Imm.dlm", "%s\t%s\n", instrNum, varId);
		immediate[varId] = SVI.getOperand(1)->getType();
	}
	else {
		varId = instrId + rso.str();
		printFactsToFile("facts/ShuffleVecotrInstruction-RightVector-Var.dlm", "%s\t%s\n", instrNum, varId);
		variable[varId] = SVI.getOperand(1)->getType();
	}
	//Mask
	value_str.clear();
	WriteAsOperand(rso, SVI.getOperand(2), 0, Mod);
//	if(Constant *c = dyn_cast<Constant>(svi->getOperand(2))) {
//	varId = rso.str();
	varId = instrId + rso.str();
	printFactsToFile("facts/predicates/ShuffleVecotrInstruction-Mask.dlm", "%s\t%s\n", instrNum, varId);
	immediate[varId] = SVI.getOperand(2)->getType();
}

void  InstructionVisitor::visitInstruction(Instruction &I) {

	errs() << I.getOpcodeName() << ": Unhandled Instruction\n";

}
