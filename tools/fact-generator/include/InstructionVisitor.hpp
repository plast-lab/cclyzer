#ifndef INSTR_VISITOR_H__
#define INSTR_VISITOR_H__

#include <string>
#include <boost/unordered_map.hpp>
#include <llvm/InstVisitor.h>
#include <llvm/IR/Attributes.h>

#include "predicate_groups.hpp"
#include "CsvGenerator.hpp"


class InstructionVisitor : public llvm::InstVisitor<InstructionVisitor>
{
  protected:
    friend class CsvGenerator;

    // Type aliases
    typedef predicates::pred_t pred_t;
    typedef predicates::entity_pred_t entity_pred_t;
    typedef predicates::operand_pred_t operand_pred_t;


    // Methods that handle many similar instructions

    template<typename T>
    inline void _visitCastInst(llvm::CastInst &instr)
    {
        typedef T pred;

        // Record instruction entity
        refmode_t iref = recordInstruction(pred::instr);

        // Record right-hand-side operand
        writeInstrOperand(pred::from_operand, iref, instr.getOperand(0));

        // Record type being casted to
        gen.writeFact(pred::to_type, iref, gen.refmodeOf(instr.getType()));
    }

    template<typename T>
    inline void _visitBinaryInst(llvm::BinaryOperator &instr)
    {
        typedef T pred;

        // Record instruction entity
        refmode_t iref = recordInstruction(pred::instr);

        writeInstrOperand(pred::first_operand, iref, instr.getOperand(0));
        writeInstrOperand(pred::second_operand, iref, instr.getOperand(1));
        writeOptimizationInfoToFile(&instr, iref);
    }


    // Instruction numbering

    void setInstrNum(std::string instructionNum) {
        instrNum = instructionNum;
        immediateOffset = 0;
    }

    void setInstrId(std::string instructionId) {
        instrId = instructionId;
    }

  public:
    InstructionVisitor(CsvGenerator &generator, const llvm::Module *M)
        : gen(generator), Mod(M), writer(generator.writer) {}

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


    /* Instruction-specific write functions */

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


    /* Auxiliary methods */


    // Transform a condition predicate code to string
    static const char* pred_to_string(unsigned predicate);

    // Record several facts regarding optimizations
    void writeOptimizationInfoToFile(const llvm::User *, refmode_t);

    // Record `atomicrmw` binary operator
    void writeAtomicRMWOp(refmode_t, llvm::AtomicRMWInst::BinOp);

    // Deprecated
    void writeVolatileFlag(refmode_t iref, bool volatileFlag) {
        if (volatileFlag)
            gen.writeFact(predicates::instruction::flag, iref, "volatile");
    }

    // Record atomic instruction info
    template<typename P, typename I>
    void writeAtomicInfo(refmode_t iref, I &instr)
    {
        using namespace llvm;
        const char *atomic = (char *) 0;

        AtomicOrdering order = instr.getOrdering();
        SynchronizationScope synchScope = instr.getSynchScope();

        switch (order) {
          case Unordered: atomic = "unordered";            break;
          case Monotonic: atomic = "monotonic";            break;
          case Acquire: atomic = "acquire";                break;
          case Release: atomic = "release";                break;
          case AcquireRelease: atomic = "acq_rel";         break;
          case SequentiallyConsistent: atomic = "seq_cst"; break;
              // TODO: NotAtomic?
          default: break;
        }

        // default synchScope: crossthread
        if (synchScope == SingleThread)
            gen.writeFact(predicates::instruction::flag, iref, "singlethread");

        if (atomic)
            gen.writeFact(P::ordering, iref, atomic);
    }


    std::string instrNum;
    std::string instrId;
    int immediateOffset;

    /* Associated LLVM module */
    const llvm::Module *Mod;

    /* Instance of outer CSV generator */
    CsvGenerator &gen;
};

#endif
