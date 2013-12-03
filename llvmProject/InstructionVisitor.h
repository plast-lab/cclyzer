#include "llvm/InstVisitor.h"

using namespace llvm;
using namespace std;

class InstructionVisitor : public InstVisitor<InstructionVisitor> {

public:
	InstructionVisitor(map<string, Type *> &var, map<string, Type *> &imm, Module *M); //, raw_string_ostream &rso_stream);
	// visit methods
	void visitBinaryOperator(BinaryOperator &I);
	void visitCmpInst(CmpInst &I);
	// Terminator Instructions
	void visitReturnInst(ReturnInst &I);
	void visitBranchInst(BranchInst &I);
	void visitSwitchInst(SwitchInst &I);
	void visitIndirectBrInst(IndirectBrInst &I);
	void visitInvokeInst(InvokeInst &I);
	void visitResumeInst(ResumeInst &I);
	void visitUnreachableInst(UnreachableInst &I);
	// Unary Instructions
	void visitAllocaInst(AllocaInst &I);
	void visitLoadInst(LoadInst &I);
	void visitVAArgInst(VAArgInst &I);
	void visitCastInst(CastInst &I);
	void visitExtractValueInst(ExtractValueInst &I);
	// Other
	void visitStoreInst(StoreInst &I);
	void visitAtomicCmpXchgInst(AtomicCmpXchgInst &I);
	void visitAtomicRMWInst(AtomicRMWInst &I);
	void visitFenceInst(FenceInst &I);
	void visitGetElementPtrInst(GetElementPtrInst &I);
	void visitPHINode(PHINode &I);
	void visitSelectInst(SelectInst &I);
	void visitInsertValueInst(InsertValueInst &I);
	void visitLandingPadInst(LandingPadInst &I);
	void visitCallInst(CallInst &I);
	//Vector Operations
	void visitExtractElementInst(ExtractElementInst &I);
	void visitInsertElementInst(InsertElementInst &I);
	void visitShuffleVectorInst(ShuffleVectorInst &I);
	//'default' case
	void visitInstruction(Instruction &I);

	void setInstrNum(string instructionNum) {

		instrNum = instructionNum;
	}
	void setInstrId(string instructionId) {

		instrId = instructionId;
	}

private :
	string instrNum;
	string instrId;
	string varId;
	string value_str;
	map<string, Type *> &variable;
	map<string, Type *> &immediate;
	Module *Mod;
 };
