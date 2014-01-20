#include <iostream>
#include <set>
#include <string>
#include <sstream>
#include <cstdio>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <unistd.h>

#include "llvm/Assembly/Writer.h"
#include "PredicateNames.h"
#include "functions.h"

using namespace std;
using namespace llvm;

void printFactsToFile(const char *filename, const char* s) {

	string error;
	raw_fd_ostream f(filename, error, raw_fd_ostream::F_Append);
	while (*s) {
		if (*s == '%' && *++s != '%')
			cout << "Invalid format string: missing arguments. " << filename << "\n";
		f << *s++;
	}
	f.close();
}

void writeVolatileFlag(string instrId, bool volatileFlag) {

	if(volatileFlag) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
				"%s\t%s\n", instrId, "volatile");
	}
}

const char *writeAtomicInfo(string instrId, AtomicOrdering order, SynchronizationScope synchScope) {

	const char *atomic;

	switch (order) {
	case Unordered: atomic = "unordered"; 			 break;
	case Monotonic: atomic = "monotonic"; 			 break;
	case Acquire: atomic = "acquire"; 				 break;
	case Release: atomic = "release"; 				 break;
	case AcquireRelease: atomic = "acq_rel"; 		 break;
	case SequentiallyConsistent: atomic = "seq_cst"; break;
//	case NotAtomic: atomic = ""; break;
	default: atomic = ""; break;
	}
	//default synchScope: crossthread
	if(synchScope == SingleThread) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
				"%s\t%s\n", instrId, "singlethread");
	}
	return atomic;
}

void writeOptimizationInfoToFile(const User *u, string instrId) {

	if (const FPMathOperator *fpo = dyn_cast<const FPMathOperator>(u)) {
		if(fpo->hasUnsafeAlgebra()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
					"%s\t%s\n", instrId, "fast");
		}
		else {
			if(fpo->hasNoNaNs()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
						"%s\t%s\n", instrId, "nnan");
			}
			if(fpo->hasNoInfs()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
						"%s\t%s\n", instrId, "ninf");
			}
			if(fpo->hasNoSignedZeros()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
						"%s\t%s\n", instrId, "nsz");
			}
			if(fpo->hasAllowReciprocal()) {
				printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
						"%s\t%s\n", instrId, "arcp");
			}
		}
	}
	if (const OverflowingBinaryOperator *obo = dyn_cast<OverflowingBinaryOperator>(u)) {
		if(obo->hasNoUnsignedWrap()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(), "%s\t%s\n", instrId, "nuw");
		}
		if(obo->hasNoSignedWrap()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(), "%s\t%s\n", instrId, "nsw");
		}
	}
	else if (const PossiblyExactOperator *div = dyn_cast<PossiblyExactOperator>(u)) {
		if(div->isExact()) {
			printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::insnFlag).c_str(),
					"%s\t%s\n", instrId, "exact");
		}
	}
}

string writeCallingConv(unsigned cc) {

	string conv;

	switch (cc) {
//	case CallingConv::C:				conv = ""; 					break;
	case CallingConv::Fast:				conv =  "fastcc"; 			break;
	case CallingConv::Cold:				conv =  "coldcc"; 			break;
	case CallingConv::X86_FastCall:		conv =  "x86_fastcallcc"; 	break;
	case CallingConv::X86_StdCall:		conv =  "x86_stdcallcc"; 	break;
	case CallingConv::X86_ThisCall:		conv =  "x86_thiscallcc"; 	break;
	case CallingConv::Intel_OCL_BI:		conv =  "intel_ocl_bicc"; 	break;
	case CallingConv::ARM_AAPCS:		conv =  "arm_aapcscc"; 		break;
	case CallingConv::ARM_AAPCS_VFP:	conv =  "arm_aapcs_vfpcc"; 	break;
	case CallingConv::ARM_APCS:			conv =  "arm_apcscc"; 		break;
	case CallingConv::MSP430_INTR:		conv =  "msp430_intrcc";	break;
	case CallingConv::PTX_Device:		conv =  "tx_device"; 		break;
	case CallingConv::PTX_Kernel:		conv =  "ptx_kernel";		break;
	default:
		conv = "cc" + static_cast<ostringstream*>(&(ostringstream()<< cc))->str();
		break;
	}
	return conv;
}

void writeAtomicRMWOp(string instrId, AtomicRMWInst::BinOp op) {

	const char *oper;

	switch (op) {
	case AtomicRMWInst::Xchg: oper = "xchg";	break;
	case AtomicRMWInst::Add:  oper = "add"; 	break;
	case AtomicRMWInst::Sub:  oper = "sub"; 	break;
	case AtomicRMWInst::And:  oper = "and"; 	break;
	case AtomicRMWInst::Nand: oper = "nand"; 	break;
	case AtomicRMWInst::Or:   oper = "or"; 		break;
	case AtomicRMWInst::Xor:  oper = "xor"; 	break;
	case AtomicRMWInst::Max:  oper = "max"; 	break;
	case AtomicRMWInst::Min:  oper = "min"; 	break;
	case AtomicRMWInst::UMax: oper = "umax"; 	break;
	case AtomicRMWInst::UMin: oper = "umin"; 	break;
	default: oper = ""; break;
	}
	if(strlen(oper)) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::atomicRMWInsnOper).c_str(),
				"%s\t%s\n", instrId, oper);
	}
}

const char *writePredicate(unsigned predicate) {

	const char *pred;

	switch (predicate) {
	case FCmpInst::FCMP_FALSE: pred = "false"; 	break;
	case FCmpInst::FCMP_OEQ:   pred = "oeq"; 	break;
	case FCmpInst::FCMP_OGT:   pred = "ogt";	break;
	case FCmpInst::FCMP_OGE:   pred = "oge"; 	break;
	case FCmpInst::FCMP_OLT:   pred = "olt"; 	break;
	case FCmpInst::FCMP_OLE:   pred = "ole"; 	break;
	case FCmpInst::FCMP_ONE:   pred = "one"; 	break;
	case FCmpInst::FCMP_ORD:   pred = "ord"; 	break;
	case FCmpInst::FCMP_UNO:   pred = "uno"; 	break;
	case FCmpInst::FCMP_UEQ:   pred = "ueq"; 	break;
	case FCmpInst::FCMP_UGT:   pred = "ugt"; 	break;
	case FCmpInst::FCMP_UGE:   pred = "uge"; 	break;
	case FCmpInst::FCMP_ULT:   pred = "ult"; 	break;
	case FCmpInst::FCMP_ULE:   pred = "ule"; 	break;
	case FCmpInst::FCMP_UNE:   pred = "une"; 	break;
	case FCmpInst::FCMP_TRUE:  pred = "true"; 	break;

	case ICmpInst::ICMP_EQ:    pred = "eq";  	break;
	case ICmpInst::ICMP_NE:    pred = "ne"; 	break;
	case ICmpInst::ICMP_SGT:   pred = "sgt"; 	break;
	case ICmpInst::ICMP_SGE:   pred = "sge"; 	break;
	case ICmpInst::ICMP_SLT:   pred = "slt"; 	break;
	case ICmpInst::ICMP_SLE:   pred = "sle"; 	break;
	case ICmpInst::ICMP_UGT:   pred = "ugt"; 	break;
	case ICmpInst::ICMP_UGE:   pred = "uge"; 	break;
	case ICmpInst::ICMP_ULT:   pred = "ult"; 	break;
	case ICmpInst::ICMP_ULE:   pred = "ule"; 	break;
	default: pred = ""; break;
	}
	return pred;
}

 void annotateGeneratedInstr(Instruction * I) {

 	LLVMContext & con = I->getContext();
 	MDNode* N = MDNode::get(con, MDString::get(con, "constantExpr"));
 	I->setMetadata("synthetic_instruction", N);
 }

string printType(Type *type) {

	string type_str;
	raw_string_ostream rso(type_str);
	if(type->isStructTy()) {
		StructType *STy = cast<StructType>(type);
		if(STy->isLiteral()) {
			type->print(rso);
			return rso.str();
		}
		if(!STy->getName().empty()) {
			rso << "%" << STy->getName();
			return rso.str();
		}
		rso << "%\"type " << STy << "\"";
	}
	else {
		type->print(rso);
	}
	return rso.str();
}

void identifyType(Type *elementType, set<Type *> &componentTypes) {

	if(componentTypes.count(elementType) != 0) {
		return;
	}
	componentTypes.insert(elementType);
	if (elementType->isPrimitiveType() || elementType->isIntegerTy()) {
		return;
	}
	if (elementType->isArrayTy()) {
		identifyType(elementType->getArrayElementType(), componentTypes);
	}
	else if (elementType->isPointerTy()) {
		identifyType(elementType->getPointerElementType(), componentTypes);
	}
	else if (elementType->isStructTy()) {
		identifyStructType(elementType, componentTypes);
	}
	else if (elementType->isVectorTy()) {
		identifyType(elementType->getVectorElementType(), componentTypes);
	}
	else if(elementType->isFunctionTy()) {
		identifyFunctionType(elementType, componentTypes);
	}
	else {
		errs() << "Unrecognized type: " << printType(elementType) << " .\n";
	}
}

void identifyStructType(Type *structType, set<Type *> &componentTypes) {

	StructType *strTy = cast<StructType>(structType);
	if(!strTy->isOpaque()) {
		for (unsigned int i = 0; i < strTy->getStructNumElements(); ++i) {
			identifyType(strTy->getStructElementType(i), componentTypes);
		}
	}
}

void identifyFunctionType(Type *funcType, set<Type *> &componentTypes) {

	FunctionType *funcTy = dyn_cast<FunctionType>(funcType);
	identifyType(funcTy->getReturnType(), componentTypes);
	for (unsigned int par = 0; par < funcType->getFunctionNumParams(); ++par) {
		identifyType(funcTy->getFunctionParamType(par), componentTypes);
	}
}

Instruction *convertExtractValueInst(ConstantExpr * CE, Instruction * InsertPt) {

	ExtractValueInst * evi = ExtractValueInst::Create(CE->getOperand(0), CE->getIndices(), CE->getName(), InsertPt);
	annotateGeneratedInstr(evi);
	return evi;
}

Instruction *convertInsertValueInst(ConstantExpr * CE, Instruction * InsertPt) {

	InsertValueInst * ivi = InsertValueInst::Create(CE->getOperand(0), CE->getOperand(1), CE->getIndices(), CE->getName(), InsertPt);
	annotateGeneratedInstr(ivi);
	return ivi;
}

Instruction *convertGEP(ConstantExpr * CE, Instruction * InsertPt) {

	vector<Value *> Indices;

	for (unsigned index = 1; index < CE->getNumOperands(); ++index) {
		Indices.push_back(CE->getOperand(index));
	}
	GetElementPtrInst *gep = GetElementPtrInst::CreateInBounds(CE->getOperand(0), ArrayRef<Value *>(Indices), CE->getName(), InsertPt);
	annotateGeneratedInstr(gep);

	return gep;
}

Instruction *convertCstExpression(ConstantExpr * CE, Instruction * InsertPt) {

//
// Converts this constant expression into a regular instruction
//

	Instruction * NewInst = 0;
	switch (CE->getOpcode()) {

	case Instruction::GetElementPtr: {
		NewInst = convertGEP(CE, InsertPt);
		break;
	}

	case Instruction::Add:
	case Instruction::FAdd:
	case Instruction::Sub:
	case Instruction::FSub:
	case Instruction::Mul:
	case Instruction::FMul:
	case Instruction::UDiv:
	case Instruction::SDiv:
	case Instruction::FDiv:
	case Instruction::URem:
	case Instruction::SRem:
	case Instruction::FRem:
	case Instruction::Shl:
	case Instruction::LShr:
	case Instruction::AShr:
	case Instruction::And:
	case Instruction::Or:
	case Instruction::Xor: {

		Instruction::BinaryOps Op = (Instruction::BinaryOps) (CE->getOpcode());
		NewInst = BinaryOperator::Create(Op, CE->getOperand(0), CE->getOperand(1), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}

	case Instruction::Trunc:
	case Instruction::ZExt:
	case Instruction::SExt:
	case Instruction::FPToSI:
	case Instruction::FPToUI:
	case Instruction::UIToFP:
	case Instruction::SIToFP:
	case Instruction::FPTrunc:
	case Instruction::FPExt:
	case Instruction::PtrToInt:
	case Instruction::IntToPtr:
	case Instruction::BitCast: {

		Instruction::CastOps Op = (Instruction::CastOps) (CE->getOpcode());
		NewInst = CastInst::Create(Op, CE->getOperand(0), CE->getType(), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}
	case Instruction::ICmp:
	case Instruction::FCmp: {

		Instruction::OtherOps Op = (Instruction::OtherOps) (CE->getOpcode());
		NewInst = CmpInst::Create(Op, CE->getPredicate(), CE->getOperand(0), CE->getOperand(1), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}

	case Instruction::Select:
		NewInst = SelectInst::Create(CE->getOperand(0), CE->getOperand(1), CE->getOperand(2), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;

	case Instruction::ExtractElement: {
		NewInst = ExtractElementInst::Create(CE->getOperand(0), CE->getOperand(1), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}
	case Instruction::InsertElement: {
		NewInst = InsertElementInst::Create(CE->getOperand(0), CE->getOperand(1), CE->getOperand(2), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}
	case Instruction::ShuffleVector: {
		NewInst = new ShuffleVectorInst(CE->getOperand(0), CE->getOperand(1), CE->getOperand(2), CE->getName(), InsertPt);
		annotateGeneratedInstr(NewInst);
		break;
	}
	case Instruction::ExtractValue:	{
		NewInst = convertExtractValueInst(CE, InsertPt);
		break;
	}
	case Instruction::InsertValue:	{
		NewInst = convertInsertValueInst(CE, InsertPt);
		break;
	}
	default:
		errs() << "Unrecognized constant expression: " << *CE << "\n";
		break;
	}
	return NewInst;
}

void writeFnAttributes(const AttributeSet Attrs, vector<string> &FnAttr) {

	AttributeSet AS;
	string AttrStr;
	if (Attrs.hasAttributes(AttributeSet::FunctionIndex)) {
		AS = Attrs.getFnAttributes();
	}
	unsigned idx = 0;
	for (unsigned e = AS.getNumSlots(); idx != e; ++idx) {
		if (AS.getSlotIndex(idx) == AttributeSet::FunctionIndex) {
			break;
		}
	}
	for (AttributeSet::iterator I = AS.begin(idx), E = AS.end(idx); I != E; ++I) {
		Attribute Attr = *I;
		if (!Attr.isStringAttribute()) {
			AttrStr = Attr.getAsString();
			FnAttr.push_back(AttrStr);
	    }
	}
}

const char *writeLinkage(GlobalValue::LinkageTypes LT) {

	const char *linkTy;

	switch (LT) {
	case GlobalValue::ExternalLinkage: 		linkTy = "";				break;
	case GlobalValue::PrivateLinkage:       linkTy = "private";			break;
	case GlobalValue::LinkerPrivateLinkage: linkTy = "linker_private";	break;
	case GlobalValue::LinkerPrivateWeakLinkage:
		linkTy = "linker_private_weak";
		break;
	case GlobalValue::InternalLinkage:      linkTy = "internal";		break;
	case GlobalValue::LinkOnceAnyLinkage:   linkTy = "linkonce";       	break;
	case GlobalValue::LinkOnceODRLinkage:   linkTy = "linkonce_odr";   	break;
	case GlobalValue::LinkOnceODRAutoHideLinkage:
		linkTy = "linkonce_odr_auto_hide";
	    break;
	case GlobalValue::WeakAnyLinkage:		linkTy = "weak";			break;
	case GlobalValue::WeakODRLinkage:		linkTy = "weak_odr";		break;
	case GlobalValue::CommonLinkage:    	linkTy = "common";      	break;
	case GlobalValue::AppendingLinkage: 	linkTy = "appending";   	break;
	case GlobalValue::DLLImportLinkage:  	linkTy = "dllimport";   	break;
	case GlobalValue::DLLExportLinkage:   	linkTy = "dllexport";   	break;
	case GlobalValue::ExternalWeakLinkage:  linkTy = "extern_weak"; 	break;
	case GlobalValue::AvailableExternallyLinkage:
		linkTy = "available_externally";
	    break;
	default: linkTy = "";	break;
	}
	return linkTy;
}

const char *writeVisibility(GlobalValue::VisibilityTypes Vis) {

	const char *visibility;
	switch (Vis) {
	case GlobalValue::DefaultVisibility: 	visibility = ""; 			break;
	case GlobalValue::HiddenVisibility:    	visibility = "hidden"; 		break;
	case GlobalValue::ProtectedVisibility: 	visibility = "protected"; 	break;
	default: visibility = "";	break;
	}
	return visibility;
}

const char *writeThreadLocalModel(GlobalVariable::ThreadLocalMode TLM) {

	const char *tlm;

	switch (TLM) {
    case GlobalVariable::NotThreadLocal:
    	tlm = "";
      break;
    case GlobalVariable::GeneralDynamicTLSModel:
    	tlm = "thread_local";
    	break;
    case GlobalVariable::LocalDynamicTLSModel:
    	tlm = "thread_local(localdynamic)";
    	break;
    case GlobalVariable::InitialExecTLSModel:
    	tlm = "thread_local(initialexec)";
    	break;
    case GlobalVariable::LocalExecTLSModel:
    	tlm = "thread_local(localexec)";
    	break;
    default: tlm = ""; break;
	}
	return tlm;
}

void writeGlobalVar(const GlobalVariable *gv, string globalName) {

	string value_str;
	raw_string_ostream rso(value_str);

	value_str.clear();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVar).c_str(), "%s\n", globalName);
	if (!gv->hasInitializer() && gv->hasExternalLinkage()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarLink).c_str(),
				"%s\t%s\n", globalName, "external");
	}
	if(strlen(writeLinkage(gv->getLinkage()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarLink).c_str(),
				"%s\t%s\n", globalName, writeLinkage(gv->getLinkage()));
	}
	if(strlen(writeVisibility(gv->getVisibility()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarVis).c_str(),
				"%s\t%s\n", globalName, writeVisibility(gv->getVisibility()));
	}
	if(strlen(writeThreadLocalModel(gv->getThreadLocalMode()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarTlm).c_str(),
				"%s\t%s\n", globalName, writeThreadLocalModel(gv->getThreadLocalMode()));
	}
	// Den ta exoume sto schema ths vashs
//	if(unsigned AddressSpace = gv->getType()->getAddressSpace()) {
//		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarAddrSpace).c_str(), globalName, AddressSpace);
//	}
//	if (gv->hasUnnamedAddr()) {
//		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarUnnamed).c_str(), "%s\t%s\n", globalName, "unnamed_addr");
//	}
	if (gv->isExternallyInitialized()) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarFlag).c_str(),
				"%s\t%s\n", globalName, "externally_initialized");
	}
	const char * flag;
	if(gv->isConstant()) {
		flag = "constant";
	}
	else {
		flag = "global";
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarFlag).c_str(),
			"%s\t%s\n", globalName, flag);
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarType).c_str(),
			"%s\t%t\n", globalName, printType(gv->getType()->getElementType()));
	if(gv->hasInitializer()) {
		value_str.clear();
		WriteAsOperand(rso, gv->getInitializer(), 0, gv->getParent());
		string initializer = rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarInit).c_str(),
				"%s\t%s\n", globalName, initializer);
	}
	 if (gv->hasSection()) {
		 printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarSect).c_str(),
				 "%s\t%s\n", globalName, gv->getSection());
	 }
	 if(gv->getAlignment()) {
		 printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::globalVarAlign).c_str(),
				 "%s\t%d\n", globalName, gv->getAlignment());
	 }
}

void writeGlobalAlias(const GlobalAlias *ga, string globalAlias) {

	// @<Name> = alias [Linkage] [Visibility] <AliaseeTy> @<Aliasee>
	string value_str;
	raw_string_ostream rso(value_str);

	value_str.clear();
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::alias).c_str(), "%s\n", globalAlias);
	if(strlen(writeVisibility(ga->getVisibility()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::aliasVis).c_str(),
				"%s\t%s\n", globalAlias, writeVisibility(ga->getVisibility()));
	}
	if(strlen(writeLinkage(ga->getLinkage()))) {
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::aliasLink).c_str(),
				"%s\t%s\n", globalAlias, writeLinkage(ga->getLinkage()));
	}
	printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::aliasType).c_str(),
			"%s\t%s\n", globalAlias, printType(ga->getType()));
	const Constant *Aliasee = ga->getAliasee();
	if(Aliasee != 0) {
		value_str.clear();
		WriteAsOperand(rso, Aliasee, 0, ga->getParent());
		string aliasee_value = rso.str();
		printFactsToFile(PredicateNames::predNameToFilename(PredicateNames::aliasAliasee).c_str(),
				"%s\t%s\n", globalAlias, aliasee_value);
	}
}

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

void clearFactsDir(const char *dirName) {

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
				clearFactsDir(path.c_str());
			}
			else {
				unlink(path.c_str());
			}
		}
	}
	closedir(dir);
}

void getIRFilesfromDir(const char * dirName, vector<string> &files) {

	DIR *dir;
  	struct dirent *entry;
	string path;

	if((dir = opendir(dirName)) == NULL) {
		perror ("opendir()");
		exit(1);
	}
	while((entry = readdir(dir)) != NULL) {
		if(strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")) {
			cout << "Exei mesa ta : " << entry->d_name << "\n";
			path = string(dirName) + "/" + string(entry->d_name);
			cout << "!!!!  " << path << "\n";
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
