#ifndef __INSTRUCTION_VISITOR_H__
#define __INSTRUCTION_VISITOR_H__

#include <string>

#include <boost/unordered_map.hpp>

#include "llvm/InstVisitor.h"
#include "llvm/IR/Attributes.h"

#include "PredicateNames.hpp"
#include "CsvGenerator.hpp"

class InstructionVisitor : public llvm::InstVisitor<InstructionVisitor> {

public:

	InstructionVisitor(boost::unordered_map<std::string, const llvm::Type *> &var, 
                       boost::unordered_map<std::string, const llvm::Type *> &imm,
                       const llvm::Module *M);

	//////////////////////////
	// 	   visit methods    //
	/////////////////////////

	// Binary Operations

	void visitAdd(llvm::BinaryOperator &);
	void visitFAdd(llvm::BinaryOperator &);
	void visitSub(llvm::BinaryOperator &);
	void visitFsub(llvm::BinaryOperator &);
	void visitMul(llvm::BinaryOperator &);
	void visitFMul(llvm::BinaryOperator &);
	void visitSDiv(llvm::BinaryOperator &);
	void visitFDiv(llvm::BinaryOperator &);
	void visitUDiv(llvm::BinaryOperator &);
	void visitSRem(llvm::BinaryOperator &);
	void visitFRem(llvm::BinaryOperator &);
	void visitURem(llvm::BinaryOperator &);

	// Bitwise Binary Operations

	void visitShl(llvm::BinaryOperator &);
	void visitLShr(llvm::BinaryOperator &);
	void visitAShr(llvm::BinaryOperator &);
	void visitAnd(llvm::BinaryOperator &);
	void visitOr(llvm::BinaryOperator &);
	void visitXor(llvm::BinaryOperator &);

	// Conversion Operations

	void visitTruncInst(llvm::TruncInst &);
	void visitZExtInst(llvm::ZExtInst &);
	void visitSExtInst(llvm::SExtInst &);
	void visitFPTruncInst(llvm::FPTruncInst &);
	void visitFPExtInst(llvm::FPExtInst &);
	void visitFPToUIInst(llvm::FPToUIInst &);
	void visitFPToSIInst(llvm::FPToSIInst &);
	void visitUIToFPInst(llvm::UIToFPInst &);
	void visitSIToFPInst(llvm::SIToFPInst &);
	void visitPtrToIntInst(llvm::PtrToIntInst &);
	void visitIntToPtrInst(llvm::IntToPtrInst &);
	void visitBitCastInst(llvm::BitCastInst &);

	// Terminator Instructions

	void visitReturnInst(llvm::ReturnInst &);
	void visitBranchInst(llvm::BranchInst &);
	void visitSwitchInst(const llvm::SwitchInst &);
	void visitIndirectBrInst(llvm::IndirectBrInst &);
	void visitInvokeInst(llvm::InvokeInst &);
	void visitResumeInst(llvm::ResumeInst &);
	void visitUnreachableInst(llvm::UnreachableInst &);

	// Aggregate Operations

	void visitInsertValueInst(llvm::InsertValueInst &);
	void visitExtractValueInst(llvm::ExtractValueInst &);

	// Memory Operations

	void visitAllocaInst(llvm::AllocaInst &);
	void visitLoadInst(llvm::LoadInst &);
	void visitStoreInst(llvm::StoreInst &);
	void visitAtomicCmpXchgInst(llvm::AtomicCmpXchgInst &);
	void visitAtomicRMWInst(llvm::AtomicRMWInst &);
	void visitFenceInst(llvm::FenceInst &);
	void visitGetElementPtrInst(llvm::GetElementPtrInst &);

	// Other

	void visitICmpInst(llvm::ICmpInst &);
	void visitFCmpInst(llvm::FCmpInst &);
	void visitPHINode(llvm::PHINode &);
	void visitSelectInst(llvm::SelectInst &);
	void visitLandingPadInst(llvm::LandingPadInst &);
	void visitCallInst(llvm::CallInst &);
	void visitVAArgInst(llvm::VAArgInst &);

	// Vector Operations

	void visitExtractElementInst(llvm::ExtractElementInst &);
	void visitInsertElementInst(llvm::InsertElementInst &);
	void visitShuffleVectorInst(llvm::ShuffleVectorInst &);

	// 'default' case
	void visitInstruction(llvm::Instruction &I);

	void setInstrNum(std::string instructionNum) {

		instrNum = instructionNum;
	}
	void setInstrId(std::string instructionId) {

		instrId = instructionId;
	}

private:
    //auxiliary methods
    void logSimpleValue(const llvm::Value * Value, const char * predNmae, int index = -1);
    void logOperand(const llvm::Value * Operand, const char * predName, int index = -1);
    void logBinaryOperator(llvm::BinaryOperator &BI, const char * predName, 
                           const char * predNameLeftOp, const char * predNameRightOp);

    const char* writePredicate(unsigned predicate);
    void writeOptimizationInfoToFile(const llvm::User *u, std::string instrId);
    const char *writeAtomicInfo(std::string instrId, llvm::AtomicOrdering order, llvm::SynchronizationScope synchScope);
    void writeAtomicRMWOp(std::string instrId, llvm::AtomicRMWInst::BinOp op);

    void writeVolatileFlag(std::string instrId, bool volatileFlag) {

        if(volatileFlag) {
            csvGen->writePredicateToCsv(predicate_names::insnFlag, instrId, "volatile");
        }
    }

	std::string instrNum;
	std::string instrId;
	std::string varId;
    CsvGenerator *csvGen;
    boost::unordered_map<std::string, const llvm::Type *> &variable;
    boost::unordered_map<std::string, const llvm::Type *> &immediate;
	const llvm::Module *Mod;
};

#endif
