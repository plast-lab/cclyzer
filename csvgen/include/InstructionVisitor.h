#include "llvm/InstVisitor.h"
#include "../include/PredicateNames.h"

using namespace llvm;

class InstructionVisitor : public InstVisitor<InstructionVisitor>, public PredicateNames {

public:

	InstructionVisitor(map<string, const Type *> &var, map<string, const Type *> &imm, Module *M);

	//////////////////////////
	// 	   visit methods    //
	/////////////////////////

	// Binary Operations

	void visitAdd(BinaryOperator &);
	void visitFAdd(BinaryOperator &);
	void visitSub(BinaryOperator &);
	void visitFsub(BinaryOperator &);
	void visitMul(BinaryOperator &);
	void visitFMul(BinaryOperator &);
	void visitSdiv(BinaryOperator &);
	void visitFdiv(BinaryOperator &);
	void visitUDiv(BinaryOperator &);
	void visitSRem(BinaryOperator &);
	void visitFRem(BinaryOperator &);
	void visitURem(BinaryOperator &);

	// Bitwise Binary Operations

	void visitShl(BinaryOperator &);
	void visitLShr(BinaryOperator &);
	void visitAShr(BinaryOperator &);
	void visitAnd(BinaryOperator &);
	void visitOr(BinaryOperator &);
	void visitXor(BinaryOperator &);

	// Conversion Operations

	void visitTruncInst(TruncInst &);
	void visitZExtInst(ZExtInst &);
	void visitSExtInst(SExtInst &);
	void visitFPTruncInst(FPTruncInst &);
	void visitFPExtInst(FPExtInst &);
	void visitFPToUIInst(FPToUIInst &);
	void visitFPToSIInst(FPToSIInst &);
	void visitUIToFPInst(UIToFPInst &);
	void visitSIToFPInst(SIToFPInst &);
	void visitPtrToIntInst(PtrToIntInst &);
	void visitIntToPtrInst(IntToPtrInst &);
	void visitBitCastInst(BitCastInst &);

	// Terminator Instructions

	void visitReturnInst(ReturnInst &);
	void visitBranchInst(BranchInst &);
	void visitSwitchInst(const SwitchInst &);
	void visitIndirectBrInst(IndirectBrInst &);
	void visitInvokeInst(InvokeInst &);
	void visitResumeInst(ResumeInst &);
	void visitUnreachableInst(UnreachableInst &);

	// Aggregate Operations

	void visitInsertValueInst(InsertValueInst &);
	void visitExtractValueInst(ExtractValueInst &);

	// Memory Operations

	void visitAllocaInst(AllocaInst &);
	void visitLoadInst(LoadInst &);
	void visitStoreInst(StoreInst &);
	void visitAtomicCmpXchgInst(AtomicCmpXchgInst &);
	void visitAtomicRMWInst(AtomicRMWInst &);
	void visitFenceInst(FenceInst &);
	void visitGetElementPtrInst(GetElementPtrInst &);

	// Other

	void visitICmpInst(ICmpInst &);
	void visitFCmpInst(FCmpInst &);
	void visitPHINode(PHINode &);
	void visitSelectInst(SelectInst &);
	void visitLandingPadInst(LandingPadInst &);
	void visitCallInst(CallInst &);
	void visitVAArgInst(VAArgInst &);

	// Vector Operations

	void visitExtractElementInst(ExtractElementInst &);
	void visitInsertElementInst(InsertElementInst &);
	void visitShuffleVectorInst(ShuffleVectorInst &);

	// 'default' case
	void visitInstruction(Instruction &I);

	void setInstrNum(std::string instructionNum) {

		instrNum = instructionNum;
	}
	void setInstrId(std::string instructionId) {

		instrId = instructionId;
	}

private:

    void logSimpleValue(const Value * Value, const char * predNmae);
    void logOperand(const Value * Operand, const char * predName);
    void logBinaryOperator(BinaryOperator &BI, const char * predName, 
                           const char * predNameLeftOp, const char * predNameRightOp);

	std::string instrNum;
	std::string instrId;
	std::string varId;
	std::string value_str;
	map<std::string, const Type *> &variable;
	map<std::string, const Type *> &immediate;
	Module *Mod;
};
