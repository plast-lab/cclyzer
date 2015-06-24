#ifndef INSTR_VISITOR_H__
#define INSTR_VISITOR_H__

#include <string>
#include <boost/unordered_map.hpp>
#include <llvm/InstVisitor.h>
#include <llvm/IR/Attributes.h>

#include "predicate_groups.hpp"
#include "CsvGenerator.hpp"

typedef std::string refmode_t;


class InstructionVisitor : public llvm::InstVisitor<InstructionVisitor>
{
  protected:
    friend class CsvGenerator;

    // Type aliases
    typedef predicates::pred_t pred_t;
    typedef predicates::entity_pred_t entity_pred_t;
    typedef predicates::operand_pred_t operand_pred_t;

    // Fact writing methods

    void writeFact(const pred_t &predicate,
                   const refmode_t& entity)
    {
        writer.writeFact(predicate.c_str(), entity);
    }

    template<class ValType>
    void writeFact(const pred_t &predicate,
                   const refmode_t& entity,
                   const ValType& value)
    {
        writer.writeFact(predicate.c_str(), entity, value);
    }

    template<class ValType>
    void writeFact(const pred_t &predicate,
                   const refmode_t& entity,
                   const ValType& value, int index)
    {
        writer.writeFact(predicate.c_str(), entity, value, index);
    }


    template<typename T>
    void _visitCastInst(llvm::CastInst &instr)
    {
        typedef T pred;
        using namespace auxiliary_methods;

        // Record instruction entity
        refmode_t iref = recordInstruction(pred::instr);

        // Record right-hand-side operand
        writeInstrOperand(pred::from_operand, iref, instr.getOperand(0));

        // Record type being casted to
        writeFact(pred::to_type, iref, printType(instr.getType()));
    }

    template<typename T>
    void _visitBinaryInst(llvm::BinaryOperator &instr)
    {
        typedef T pred;
        using namespace auxiliary_methods;

        // Record instruction entity
        refmode_t iref = recordInstruction(pred::instr);

        writeInstrOperand(pred::first_operand, iref, instr.getOperand(0));
        writeInstrOperand(pred::second_operand, iref, instr.getOperand(1));
        writeOptimizationInfoToFile(&instr, iref);
    }

    void setInstrNum(std::string instructionNum) {
        instrNum = instructionNum;
        immediateOffset = 0;
    }

    void setInstrId(std::string instructionId) {
        instrId = instructionId;
    }


    inline refmode_t refmodeOf(llvm::GlobalValue::LinkageTypes LT) {
        return csvGen->refmodeOf(LT);
    }

    inline refmode_t refmodeOf(llvm::GlobalValue::VisibilityTypes Vis) {
        return csvGen->refmodeOf(Vis);
    }

    inline refmode_t refmodeOf(llvm::GlobalVariable::ThreadLocalMode TLM) {
        return csvGen->refmodeOf(TLM);
    }

    inline refmode_t refmodeOf(llvm::CallingConv::ID CC) {
        return csvGen->refmodeOf(CC);
    }

    inline refmode_t refmodeOf(const llvm::Type *type) {
        return csvGen->refmodeOf(type);
    }

  public:
    InstructionVisitor(CsvGenerator *generator, const llvm::Module *M)
        : csvGen(generator), Mod(M), writer(generator->writer) {}

    /* Complex fact writing methods */

    void visitGlobalAlias(const llvm::GlobalAlias *, const refmode_t &);
    void visitGlobalVar(const llvm::GlobalVariable *, const refmode_t &);


    /************************
     * Type Visitor methods *
     ************************/

    void visitType(const llvm::Type *);
    void visitPointerType(const llvm::PointerType *);
    void visitArrayType(const llvm::ArrayType *);
    void visitStructType(const llvm::StructType *);
    void visitFunctionType(const llvm::FunctionType *);
    void visitVectorType(const llvm::VectorType *);


    /*******************************
     * Instruction Visitor methods *
     *******************************/

    // Binary Operations

    void visitAdd(llvm::BinaryOperator &);
    void visitFAdd(llvm::BinaryOperator &);
    void visitSub(llvm::BinaryOperator &);
    void visitFSub(llvm::BinaryOperator &);
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

  private:

    /* Fact writer */
    FactWriter &writer;

    // Instruction-specific write functions

    refmode_t recordInstruction(const entity_pred_t &instrType) {
        writer.writeFact(instrType.c_str(), instrNum);
        return instrNum;
    }

    void writeInstrOperand(const operand_pred_t &predicate,
                           const refmode_t &instr,
                           const llvm::Value *Operand, int index = -1);

    void writeInstrOperand(const pred_t &predicate,
                           const refmode_t &instr,
                           const llvm::Value *Value, int index = -1);


    // Auxiliary methods

    const char* writePredicate(unsigned predicate);
    void writeOptimizationInfoToFile(const llvm::User *u, std::string instrId);
    const char *writeAtomicInfo(std::string instrId, llvm::AtomicOrdering order, llvm::SynchronizationScope synchScope);
    void writeAtomicRMWOp(std::string instrId, llvm::AtomicRMWInst::BinOp op);

    void writeVolatileFlag(std::string instrId, bool volatileFlag) {
        if (volatileFlag)
            writeFact(predicates::instruction::flag, instrId, "volatile");
    }

    std::string instrNum;
    std::string instrId;
    int immediateOffset;
    CsvGenerator *csvGen;
    const llvm::Module *Mod;
};

#endif
