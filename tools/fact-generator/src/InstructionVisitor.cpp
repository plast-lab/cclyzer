#include <cassert>
#include <string>
#include <boost/foreach.hpp>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>

#include "AuxiliaryMethods.hpp"
#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "predicate_groups.hpp"

#define foreach BOOST_FOREACH

using namespace llvm;
using namespace std;
using namespace boost;
using namespace auxiliary_methods;

namespace pred = predicates;

//TODO: why do we store the volatile property with two different ways?
//      (see writeVolatileFlag and :volatile for some entities)

//TODO: Remove these if(strlen(...)) checks

void InstructionVisitor::writeInstrValue(const pred_t &predicate, const Value * Val, int index)
{
    // Value refmode and type
    ostringstream refmode;
    const Type * type = Val->getType();

    if (const Constant *c = dyn_cast<Constant>(Val)) {
        // Compute refmode for constant value
        refmode << instrNum
                << ':' << immediateOffset++
                << ':' << valueToString(c, Mod);

        // Record constant value
        csvGen->recordConstant(refmode.str(), type);
    }
    else {
        // Compute refmode for vairable value
        refmode << instrId << valueToString(Val, Mod);

        // Record variable value
        csvGen->recordVariable(refmode.str(), type);
    }

    // Write value fact
    writeInstrProperty(predicate, refmode.str(), index);
}

void InstructionVisitor::writeInstrOperand(const operand_pred_t &predicate, const Value * Operand, int index)
{
    // Operand refmode and type
    ostringstream refmode;
    const Type * type = Operand->getType();

    // Operand category is either constant or variable
    const char *predname;

    if (const Constant *c = dyn_cast<Constant>(Operand)) {
        // Compute refmode for constant
        refmode << instrNum
                << ':' << immediateOffset++
                << ':' << valueToString(c, Mod);

        // Record constant operand
        predname = predicate.asConstant().c_str();
        csvGen->recordConstant(refmode.str(), type);
    }
    else {
        refmode << instrId << valueToString(Operand, Mod);

        // Record variable operand
        predname = predicate.asVariable().c_str();
        csvGen->recordVariable(refmode.str(), type);
    }

    // Write operand fact
    csvGen->writeOperandFact(predname, instrNum, refmode.str(), index);
}

void InstructionVisitor::visitTruncInst(llvm::TruncInst &I) {
    writeCastInst<pred::trunc>(I);
}

void InstructionVisitor::visitZExtInst(llvm::ZExtInst &I) {
    writeCastInst<pred::zext>(I);
}

void InstructionVisitor::visitSExtInst(llvm::SExtInst &I) {
    writeCastInst<pred::sext>(I);
}

void InstructionVisitor::visitFPTruncInst(llvm::FPTruncInst &I) {
    writeCastInst<pred::fptrunc>(I);
}

void InstructionVisitor::visitFPExtInst(llvm::FPExtInst &I) {
    writeCastInst<pred::fpext>(I);
}

void InstructionVisitor::visitFPToUIInst(llvm::FPToUIInst &I) {
    writeCastInst<pred::fptoui>(I);
}

void InstructionVisitor::visitFPToSIInst(llvm::FPToSIInst &I) {
    writeCastInst<pred::fptosi>(I);
}

void InstructionVisitor::visitUIToFPInst(llvm::UIToFPInst &I) {
    writeCastInst<pred::uitofp>(I);
}

void InstructionVisitor::visitSIToFPInst(llvm::SIToFPInst &I) {
    writeCastInst<pred::sitofp>(I);
}

void InstructionVisitor::visitPtrToIntInst(llvm::PtrToIntInst &I) {
    writeCastInst<pred::ptrtoint>(I);
}

void InstructionVisitor::visitIntToPtrInst(llvm::IntToPtrInst &I) {
    writeCastInst<pred::inttoptr>(I);
}

void InstructionVisitor::visitBitCastInst(llvm::BitCastInst &I) {
    writeCastInst<pred::bitcast>(I);
}

void InstructionVisitor::visitAdd(BinaryOperator &BI) {
    writeBinaryInst<pred::add>(BI);
}

void InstructionVisitor::visitFAdd(BinaryOperator &BI) {
    writeBinaryInst<pred::fadd>(BI);
}

void InstructionVisitor::visitSub(BinaryOperator &BI) {
    writeBinaryInst<pred::sub>(BI);
}

void InstructionVisitor::visitFSub(BinaryOperator &BI) {
    writeBinaryInst<pred::fsub>(BI);
}

void InstructionVisitor::visitMul(BinaryOperator &BI) {
    writeBinaryInst<pred::mul>(BI);
}

void InstructionVisitor::visitFMul(BinaryOperator &BI) {
    writeBinaryInst<pred::fmul>(BI);
}

void InstructionVisitor::visitSDiv(BinaryOperator &BI) {
    writeBinaryInst<pred::sdiv>(BI);
}

void InstructionVisitor::visitFDiv(BinaryOperator &BI) {
    writeBinaryInst<pred::fdiv>(BI);
}

void InstructionVisitor::visitUDiv(BinaryOperator &BI) {
    writeBinaryInst<pred::udiv>(BI);
}

void InstructionVisitor::visitSRem(BinaryOperator &BI) {
    writeBinaryInst<pred::srem>(BI);
}

void InstructionVisitor::visitFRem(BinaryOperator &BI) {
    writeBinaryInst<pred::frem>(BI);
}

void InstructionVisitor::visitURem(BinaryOperator &BI) {
    writeBinaryInst<pred::urem>(BI);
}

void InstructionVisitor::visitShl(BinaryOperator &BI) {
    writeBinaryInst<pred::shl>(BI);
}

void InstructionVisitor::visitLShr(BinaryOperator &BI) {
    writeBinaryInst<pred::lshr>(BI);
}

void InstructionVisitor::visitAShr(BinaryOperator &BI) {
    writeBinaryInst<pred::ashr>(BI);
}

void InstructionVisitor::visitAnd(BinaryOperator &BI) {
    writeBinaryInst<pred::and_>(BI);
}

void InstructionVisitor::visitOr(BinaryOperator &BI) {
    writeBinaryInst<pred::or_>(BI);
}

void InstructionVisitor::visitXor(BinaryOperator &BI) {
    writeBinaryInst<pred::xor_>(BI);
}

void InstructionVisitor::visitReturnInst(ReturnInst &RI)
{
    recordInstruction(pred::ret::instr);

    if(RI.getReturnValue()) {   // with returned value
        writeInstrOperand(pred::ret::operand, RI.getReturnValue());
    }
    else {                      // w/o returned value
        writeInstrProperty(pred::ret::instr_void);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI) {

    string error;

    recordInstruction(pred::br::instr);

    if(BI.isConditional()) {    // conditional branch
        // br i1 <cond>, label <iftrue>, label <iffalse>
        recordInstruction(pred::br::instr_cond);

        // Condition Operand
        writeInstrOperand(pred::br::condition, BI.getCondition());

        // 'iftrue' and 'iffalse' labels
        writeInstrValue(pred::br::cond_iftrue, BI.getOperand(1));
        writeInstrValue(pred::br::cond_iffalse, BI.getOperand(2));
    }
    else {                      // unconditional branch
        // br label <dest>
        recordInstruction(pred::br::instr_uncond);
        writeInstrValue(pred::br::uncond_dest, BI.getOperand(0));
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI)
{
    // switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    recordInstruction(pred::switch_::instr);

    // 'value' Operand
    writeInstrOperand(pred::switch_::operand, SI.getOperand(0));

    // 'defaultdest' label
    writeInstrValue(pred::switch_::default_label, SI.getOperand(1));

    // 'case list' [constant, label]
    int index = 0;

    for(SwitchInst::ConstCaseIt
            Case = SI.case_begin(), CasesEnd = SI.case_end();
        Case != CasesEnd; Case++)
    {
        writeInstrValue(pred::switch_::case_value, Case.getCaseValue(), index);
        writeInstrValue(pred::switch_::case_label, Case.getCaseSuccessor(), index++);
    }
    writeInstrProperty(pred::switch_::ncases, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR)
{
    // indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    recordInstruction(pred::indirectbr::instr);

    // 'address' Operand
    writeInstrOperand(pred::indirectbr::address, IBR.getOperand(0));

    // 'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i)
        writeInstrValue(pred::indirectbr::label, IBR.getOperand(i), i-1);

    writeInstrProperty(pred::indirectbr::nlabels, IBR.getNumOperands() - 1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II)
{
    recordInstruction(pred::invoke::instr);
    recordInstruction(II.getCalledFunction()
                      ? pred::invoke::instr_direct
                      : pred::invoke::instr_indirect);

    Value *invokeOp = II.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

    // invoke instruction function
    writeInstrOperand(pred::invoke::function, invokeOp);

    // actual args
    for (unsigned op = 0; op < II.getNumArgOperands(); ++op)
        writeInstrOperand(pred::invoke::arg, II.getArgOperand(op), op);

    // 'normal label'
    writeInstrValue(pred::invoke::normal_label, II.getNormalDest());

    // 'exception label'
    writeInstrValue(pred::invoke::exc_label, II.getUnwindDest());

    // Function Attributes
    const AttributeSet &Attrs = II.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
    {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        writeInstrProperty(pred::invoke::ret_attr, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i) {
        writeInstrProperty(pred::invoke::fn_attr, FuncnAttr[i]);
    }

    // TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        string cconv = CsvGenerator::to_string(II.getCallingConv());
        writeInstrProperty(pred::invoke::calling_conv, cconv);
    }

    // TODO: param attributes?
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI)
{
    recordInstruction(pred::resume::instr);
    writeInstrOperand(pred::resume::operand, RI.getValue());
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    recordInstruction(pred::instruction::unreachable);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI)
{
    recordInstruction(pred::alloca::instr);
    writeInstrProperty(pred::alloca::type, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation())
        writeInstrOperand(pred::alloca::size, AI.getArraySize());

    if(AI.getAlignment())
        writeInstrProperty(pred::alloca::alignment, AI.getAlignment());
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    recordInstruction(pred::load::instr);
    writeInstrOperand(pred::load::address, LI.getPointerOperand());

    if (LI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());

        if (strlen(ord))
            writeInstrProperty(pred::load::ordering, ord);
    }

    if (LI.getAlignment())
        writeInstrProperty(pred::load::alignment, LI.getAlignment());

    if (LI.isVolatile())
        writeInstrProperty(pred::load::isvolatile);
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI)
{
    recordInstruction(pred::va_arg::instr);
    writeInstrProperty(pred::va_arg::type, printType(VI.getType()));
    writeInstrOperand(pred::va_arg::va_list, VI.getPointerOperand());
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI)
{
    recordInstruction(pred::extract_value::instr);

    // Aggregate Operand
    writeInstrOperand(pred::extract_value::base, EVI.getOperand(0));

    // Constant Indices
    int index = 0;

    for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
        writeInstrProperty(pred::extract_value::index, *i, index);
        index++;
    }

    writeInstrProperty(pred::extract_value::nindices, EVI.getNumIndices());
}

void InstructionVisitor::visitStoreInst(StoreInst &SI)
{
    recordInstruction(pred::store::instr);
    writeInstrOperand(pred::store::value, SI.getValueOperand());
    writeInstrOperand(pred::store::address, SI.getPointerOperand());

    if(SI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());

        if(strlen(ord))
            writeInstrProperty(pred::store::ordering, ord);
    }

    if (SI.getAlignment())
        writeInstrProperty(pred::store::alignment, SI.getAlignment());

    if (SI.isVolatile())
        writeInstrProperty(pred::store::isvolatile);
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI)
{
    recordInstruction(pred::cmpxchg::instr);

    // ptrValue
    writeInstrOperand(pred::cmpxchg::address, AXI.getPointerOperand());

    // cmpValue
    writeInstrOperand(pred::cmpxchg::cmp, AXI.getCompareOperand());

    // newValue
    writeInstrOperand(pred::cmpxchg::new_, AXI.getNewValOperand());

    if (AXI.isVolatile())
        writeInstrProperty(pred::cmpxchg::isvolatile);

    const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());

    if (strlen(ord))
        writeInstrProperty(pred::cmpxchg::ordering, ord);

    // TODO: type?
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI)
{
    recordInstruction(pred::atomicrmw::instr);

    // ptrValue - LeftOperand
    writeInstrOperand(pred::atomicrmw::address, AWI.getPointerOperand());

    // valOperand - Right Operand
    writeInstrOperand(pred::atomicrmw::value, AWI.getValOperand());

    if (AWI.isVolatile())
        writeInstrProperty(pred::atomicrmw::isvolatile);

    writeAtomicRMWOp(instrNum, AWI.getOperation());

    const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());

    if (strlen(ord))
        writeInstrProperty(pred::atomicrmw::ordering, ord);
}

void InstructionVisitor::visitFenceInst(FenceInst &FI)
{
    recordInstruction(pred::fence::instr);

    // fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());

    if(strlen(ord))
        writeInstrProperty(pred::fence::ordering, ord);
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    recordInstruction(pred::gep::instr);
    writeInstrOperand(pred::gep::base, GEP.getPointerOperand());

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index)
    {
        int immOffset = immediateOffset;
        const Value * GepOperand = GEP.getOperand(index);

        writeInstrOperand(pred::gep::index, GepOperand, index - 1);

        if (const Constant *c = dyn_cast<Constant>(GepOperand)) {
            ostringstream constant;

            // Compute constant refmode
            constant << instrNum
                     << ':' << immOffset
                     << ':' << valueToString(c, Mod);

            // Compute integer string representation
            string int_value = c->getUniqueInteger().toString(10, true);

            // Write constant to integer fact
            writeFact(pred::constant::to_integer, constant.str(), int_value);
        }
    }

    writeInstrProperty(pred::gep::nindices, GEP.getNumIndices());

    if (GEP.isInBounds())
        writeInstrProperty(pred::gep::inbounds);
}

void InstructionVisitor::visitPHINode(PHINode &PHI)
{
    // <result> = phi <ty> [ <val0>, <label0>], ...
    recordInstruction(pred::phi::instr);

    // type
    writeInstrProperty(pred::phi::type, printType(PHI.getType()));

    for (unsigned op = 0; op < PHI.getNumIncomingValues(); ++op)
    {
        writeInstrOperand(pred::phi::pair_value, PHI.getIncomingValue(op), op);
        writeInstrValue(pred::phi::pair_label, PHI.getIncomingBlock(op), op);
    }

    writeInstrProperty(pred::phi::npairs, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI)
{
    recordInstruction(pred::select::instr);

    // Condition
    writeInstrOperand(pred::select::condition, SI.getOperand(0));

    // Left Operand (true value)
    writeInstrOperand(pred::select::first_operand, SI.getOperand(1));

    // Right Operand (false value)
    writeInstrOperand(pred::select::second_operand, SI.getOperand(2));
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI)
{
    recordInstruction(pred::insert_value::instr);

    // Left Operand
    writeInstrOperand(pred::insert_value::base, IVI.getOperand(0));

    // Right Operand
    writeInstrOperand(pred::insert_value::value, IVI.getOperand(1));

    // Constant Indices
    int index = 0;

    for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end();
         i != e; ++i,index++)
    {
        writeInstrProperty(pred::insert_value::index, *i, index);
    }

    writeInstrProperty(pred::insert_value::nindices, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI)
{
    recordInstruction(pred::landingpad::instr);

    // type
    writeInstrProperty(pred::landingpad::type, printType(LI.getType()));

    // function
    writeInstrValue(pred::landingpad::fn, LI.getPersonalityFn());

    // cleanup
    if (LI.isCleanup())
        writeInstrProperty(pred::landingpad::cleanup);

    // #clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i)
    {
        const pred_t &pred_clause = LI.isCatch(i)
            ? pred::landingpad::catch_clause
            : pred::landingpad::filter_clause;

        writeInstrProperty(pred_clause, LI.getClause(i), i);
    }

    writeInstrProperty(pred::landingpad::nclauses, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI)
{
    recordInstruction(pred::call::instr);
    recordInstruction(CI.getCalledFunction()
                      ? pred::call::instr_direct
                      : pred::call::instr_indirect);

    Value *callOp = CI.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(callOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
    Type *RetTy = funcTy->getReturnType();

    writeInstrOperand(pred::call::function, callOp);

    for (unsigned op = 0; op < CI.getNumArgOperands(); ++op)
        writeInstrOperand(pred::call::arg, CI.getArgOperand(op), op);

    if(CI.isTailCall())
        writeInstrProperty(pred::call::tail);

    if (CI.getCallingConv() != CallingConv::C) {
        string cconv = CsvGenerator::to_string(CI.getCallingConv());
        writeInstrProperty(pred::call::calling_conv, cconv);
    }

    // Attributes
    const AttributeSet &Attrs = CI.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        writeInstrProperty(pred::call::ret_attr, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i)
        writeInstrProperty(pred::call::fn_attr, FuncnAttr[i]);

    // TODO: parameter attributes?
}

void InstructionVisitor::visitICmpInst(ICmpInst &I)
{
    recordInstruction(pred::icmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        writeInstrProperty(pred::icmp::condition, writePredicate(I.getPredicate()));

    // Left Operand
    writeInstrOperand(pred::icmp::first_operand, I.getOperand(0));

    // Right Operand
    writeInstrOperand(pred::icmp::second_operand, I.getOperand(1));

}

void InstructionVisitor::visitFCmpInst(FCmpInst &I)
{
    recordInstruction(pred::fcmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        writeInstrProperty(pred::fcmp::condition, writePredicate(I.getPredicate()));

    // Left Operand
    writeInstrOperand(pred::fcmp::first_operand, I.getOperand(0));

    // Right Operand
    writeInstrOperand(pred::fcmp::second_operand, I.getOperand(1));
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI)
{
    recordInstruction(pred::extract_element::instr);

    // VectorOperand
    writeInstrOperand(pred::extract_element::base, EEI.getVectorOperand());

    // indexValue
    writeInstrOperand(pred::extract_element::index, EEI.getIndexOperand());

}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI)
{
    recordInstruction(pred::insert_element::instr);

    // vectorOperand
    writeInstrOperand(pred::insert_element::base, IEI.getOperand(0));

    // Value Operand
    writeInstrOperand(pred::insert_element::value, IEI.getOperand(1));

    // Index Operand
    writeInstrOperand(pred::insert_element::index, IEI.getOperand(2));
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI)
{
    recordInstruction(pred::shuffle_vector::instr);

    // firstVector
    writeInstrOperand(pred::shuffle_vector::first_vector, SVI.getOperand(0));

    // secondVector
    writeInstrOperand(pred::shuffle_vector::second_vector, SVI.getOperand(1));

    // Mask
    writeInstrValue(pred::shuffle_vector::mask, SVI.getOperand(2));

}

void  InstructionVisitor::visitInstruction(Instruction &I)
{
    errs() << I.getOpcodeName() << ": Unhandled instruction\n";
}

//auxiliary methods

const char* InstructionVisitor::writePredicate(unsigned predicate) {

    const char *pred;

    switch (predicate) {
    case FCmpInst::FCMP_FALSE: pred = "false";  break;
    case FCmpInst::FCMP_OEQ:   pred = "oeq";    break;
    case FCmpInst::FCMP_OGT:   pred = "ogt";    break;
    case FCmpInst::FCMP_OGE:   pred = "oge";    break;
    case FCmpInst::FCMP_OLT:   pred = "olt";    break;
    case FCmpInst::FCMP_OLE:   pred = "ole";    break;
    case FCmpInst::FCMP_ONE:   pred = "one";    break;
    case FCmpInst::FCMP_ORD:   pred = "ord";    break;
    case FCmpInst::FCMP_UNO:   pred = "uno";    break;
    case FCmpInst::FCMP_UEQ:   pred = "ueq";    break;
    case FCmpInst::FCMP_UGT:   pred = "ugt";    break;
    case FCmpInst::FCMP_UGE:   pred = "uge";    break;
    case FCmpInst::FCMP_ULT:   pred = "ult";    break;
    case FCmpInst::FCMP_ULE:   pred = "ule";    break;
    case FCmpInst::FCMP_UNE:   pred = "une";    break;
    case FCmpInst::FCMP_TRUE:  pred = "true";   break;

    case ICmpInst::ICMP_EQ:    pred = "eq";     break;
    case ICmpInst::ICMP_NE:    pred = "ne";     break;
    case ICmpInst::ICMP_SGT:   pred = "sgt";    break;
    case ICmpInst::ICMP_SGE:   pred = "sge";    break;
    case ICmpInst::ICMP_SLT:   pred = "slt";    break;
    case ICmpInst::ICMP_SLE:   pred = "sle";    break;
    case ICmpInst::ICMP_UGT:   pred = "ugt";    break;
    case ICmpInst::ICMP_UGE:   pred = "uge";    break;
    case ICmpInst::ICMP_ULT:   pred = "ult";    break;
    case ICmpInst::ICMP_ULE:   pred = "ule";    break;
    default: pred = ""; break;
    }
    return pred;
}

void InstructionVisitor::writeOptimizationInfoToFile(const User *u, string instrId)
{
    if (const FPMathOperator *fpo = dyn_cast<const FPMathOperator>(u)) {
        if(fpo->hasUnsafeAlgebra()) {
            writeFact(pred::instruction::flag, instrId, "fast");
        }
        else {
            if(fpo->hasNoNaNs()) {
                writeFact(pred::instruction::flag, instrId, "nnan");
            }
            if(fpo->hasNoInfs()) {
                writeFact(pred::instruction::flag, instrId, "ninf");
            }
            if(fpo->hasNoSignedZeros()) {
                writeFact(pred::instruction::flag, instrId, "nsz");
            }
            if(fpo->hasAllowReciprocal()) {
                writeFact(pred::instruction::flag, instrId, "arcp");
            }
        }
    }
    if (const OverflowingBinaryOperator *obo = dyn_cast<OverflowingBinaryOperator>(u)) {
        if(obo->hasNoUnsignedWrap()) {
            writeFact(pred::instruction::flag, instrId, "nuw");
        }
        if(obo->hasNoSignedWrap()) {
            writeFact(pred::instruction::flag, instrId, "nsw");
        }
    }
    else if (const PossiblyExactOperator *div = dyn_cast<PossiblyExactOperator>(u)) {
        if(div->isExact()) {
            writeFact(pred::instruction::flag, instrId, "exact");
        }
    }
}

const char* InstructionVisitor::writeAtomicInfo(string instrId, AtomicOrdering order, SynchronizationScope synchScope) {

    const char *atomic;

    switch (order) {
    case Unordered: atomic = "unordered";            break;
    case Monotonic: atomic = "monotonic";            break;
    case Acquire: atomic = "acquire";                break;
    case Release: atomic = "release";                break;
    case AcquireRelease: atomic = "acq_rel";         break;
    case SequentiallyConsistent: atomic = "seq_cst"; break;
        //TODO: NotAtomic?
    default: atomic = ""; break;
    }

    // default synchScope: crossthread
    if(synchScope == SingleThread)
        writeFact(pred::instruction::flag, instrId, "singlethread");

    return atomic;
}

void InstructionVisitor::writeAtomicRMWOp(string instrId, AtomicRMWInst::BinOp op) {

    const char *oper;

    switch (op) {
    case AtomicRMWInst::Xchg: oper = "xchg";    break;
    case AtomicRMWInst::Add:  oper = "add";     break;
    case AtomicRMWInst::Sub:  oper = "sub";     break;
    case AtomicRMWInst::And:  oper = "and";     break;
    case AtomicRMWInst::Nand: oper = "nand";    break;
    case AtomicRMWInst::Or:   oper = "or";      break;
    case AtomicRMWInst::Xor:  oper = "xor";     break;
    case AtomicRMWInst::Max:  oper = "max";     break;
    case AtomicRMWInst::Min:  oper = "min";     break;
    case AtomicRMWInst::UMax: oper = "umax";    break;
    case AtomicRMWInst::UMin: oper = "umin";    break;
    default: oper = ""; break;
    }

    if (strlen(oper))
        writeFact(pred::atomicrmw::operation, instrId, oper);
}


void InstructionVisitor::visitGlobalAlias(const GlobalAlias *ga, string &refmode)
{
    //------------------------------------------------------------------
    // A global alias introduces a /second name/ for the aliasee value
    // (which can be either function, global variable, another alias
    // or bitcast of global value). It has the following form:
    //
    // @<Name> = alias [Linkage] [Visibility] <AliaseeTy> @<Aliasee>
    //------------------------------------------------------------------

    // Get aliasee value as llvm constant
    const llvm::Constant *Aliasee = ga->getAliasee();

    // Record alias entity
    writeEntity(pred::alias::id, refmode);

    // Serialize alias properties
    string visibility = CsvGenerator::to_string(ga->getVisibility());
    string linkage    = CsvGenerator::to_string(ga->getLinkage());
    string aliasType  = CsvGenerator::to_string(ga->getType());

    // Record visibility
    if (!visibility.empty())
        writeFact(pred::alias::visibility, refmode, visibility);

    // Record linkage
    if (!linkage.empty())
        writeFact(pred::alias::linkage, refmode, linkage);

    // Record type
    writeFact(pred::alias::type, refmode, aliasType);

    // Record aliasee
    if (Aliasee) {
        string aliasee = valueToString(Aliasee, ga->getParent()); // CHECK
        writeFact(pred::alias::aliasee, refmode, aliasee);
    }
}


void InstructionVisitor::visitGlobalVar(const GlobalVariable *gv, string &refmode)
{
    // Record global variable entity
    writeEntity(pred::global_var::id, refmode);

    // Serialize global variable properties
    string visibility = CsvGenerator::to_string(gv->getVisibility());
    string linkage    = CsvGenerator::to_string(gv->getLinkage());
    string varType    = CsvGenerator::to_string(gv->getType()->getElementType());
    string thrLocMode = CsvGenerator::to_string(gv->getThreadLocalMode());

    // Record external linkage
    if (!gv->hasInitializer() && gv->hasExternalLinkage())
        writeFact(pred::global_var::linkage, refmode, "external");

    // Record linkage
    if (!linkage.empty())
        writeFact(pred::global_var::linkage, refmode, linkage);

    // Record visibility
    if (!visibility.empty())
        writeFact(pred::global_var::visibility, refmode, visibility);

    // Record thread local mode
    if (!thrLocMode.empty())
        writeFact(pred::global_var::threadlocal_mode, refmode, thrLocMode);

    // TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized())
        writeFact(pred::global_var::flag, refmode, "externally_initialized");

    // Record flags and type
    const char * flag = gv->isConstant() ? "constant": "global";

    writeFact(pred::global_var::flag, refmode, flag);
    writeFact(pred::global_var::type, refmode, varType);

    // Record initializer
    if (gv->hasInitializer()) {
        string val = valueToString(gv->getInitializer(), gv->getParent()); // CHECK
        writeFact(pred::global_var::initializer, refmode, val);
    }

    // Record section
    if (gv->hasSection())
        writeFact(pred::global_var::section, refmode, gv->getSection());

    // Record alignment
    if (gv->getAlignment())
        writeFact(pred::global_var::align, refmode, gv->getAlignment());
}



//-------------------------------------------------------------------
// Methods for recording different kinds of LLVM types.
//-------------------------------------------------------------------


void InstructionVisitor::visitType(const Type *type)
{
    // Record type sizes while skipping unsized types (e.g.,
    // labels, functions)

    if (type->isSized()) {
        // Iterate over every cached data layout
        foreach (const DataLayout *DL, csvGen->layouts)
        {
            // TODO: address the case when the data layout does
            // not contain information about this type. This will
            // happen when we analyze multiple compilation units
            // (modules) at once.

            uint64_t allocSize = DL->getTypeAllocSize(const_cast<Type *>(type));
            uint64_t storeSize = DL->getTypeStoreSize(const_cast<Type *>(type));

            // Store size of type in bytes
            string typeRef = CsvGenerator::to_string(type);
            writeFact(pred::type::alloc_size, typeRef, allocSize);
            writeFact(pred::type::store_size, typeRef, storeSize);
            break;
        }
    }

    string type_signature = CsvGenerator::to_string(type);

    // Record each different kind of type
    switch (type->getTypeID()) { // Fallthrough is intended
      case llvm::Type::VoidTyID:
      case llvm::Type::LabelTyID:
      case llvm::Type::MetadataTyID:
          writeEntity(pred::primitive_type::id, type_signature);
          break;
      case llvm::Type::HalfTyID: // Fallthrough to all 6 floating point types
      case llvm::Type::FloatTyID:
      case llvm::Type::DoubleTyID:
      case llvm::Type::X86_FP80TyID:
      case llvm::Type::FP128TyID:
      case llvm::Type::PPC_FP128TyID:
          assert(type->isFloatingPointTy());
          writeEntity(pred::fp_type::id, type_signature);
          break;
      case llvm::Type::IntegerTyID:
          writeEntity(pred::integer_type::id, type_signature);
          break;
      case llvm::Type::FunctionTyID:
          visitFunctionType(cast<FunctionType>(type));
          break;
      case llvm::Type::StructTyID:
          visitStructType(cast<StructType>(type));
          break;
      case llvm::Type::ArrayTyID:
          visitArrayType(cast<ArrayType>(type));
          break;
      case llvm::Type::PointerTyID:
          visitPointerType(cast<PointerType>(type));
          break;
      case llvm::Type::VectorTyID:
          visitVectorType(cast<VectorType>(type));
          break;
      case llvm::Type::X86_MMXTyID: // TODO: handle this type
          break;
      default:
          type->dump();
          llvm::errs() << "-" << type->getTypeID()
                       << ": invalid type encountered.\n";
    }
}


void InstructionVisitor::visitPointerType(const PointerType *ptrType)
{
    string refmode = CsvGenerator::to_string(ptrType);
    string elementType = CsvGenerator::to_string(ptrType->getPointerElementType());

    // Record pointer type entity
    writeEntity(pred::ptr_type::id, refmode);

    // Record pointer element type
    writeFact(pred::ptr_type::component_type, refmode, elementType);

    // Record pointer address space
    if (unsigned addressSpace = ptrType->getPointerAddressSpace())
        writeFact(pred::ptr_type::addr_space, refmode, addressSpace);
}


void InstructionVisitor::visitArrayType(const ArrayType *arrayType)
{
    string refmode = CsvGenerator::to_string(arrayType);
    string componentType = CsvGenerator::to_string(arrayType->getArrayElementType());
    size_t nElements = arrayType->getArrayNumElements();

    // Record array type entity
    writeEntity(pred::array_type::id, refmode);

    // Record array component type
    writeFact(pred::array_type::component_type, refmode, componentType);

    // Record array type size
    writeFact(pred::array_type::size, refmode, nElements);
}


void InstructionVisitor::visitStructType(const StructType *structType)
{
    string refmode = CsvGenerator::to_string(structType);
    size_t nFields = structType->getStructNumElements();

    // Record struct type entity
    writeEntity(pred::struct_type::id, refmode);

    if (structType->isOpaque()) {
        // Opaque structs carry no info about their internal structure
        writeProperty(pred::struct_type::opaque, refmode);
    } else {
        // Record struct field types
        for (size_t i = 0; i < nFields; i++)
        {
            string fieldType = CsvGenerator::to_string(
                structType->getStructElementType(i));

            writeFact(pred::struct_type::field_type, refmode, fieldType, i);
        }

        // Record number of fields
        writeFact(pred::struct_type::nfields, refmode, nFields);
    }
}


void InstructionVisitor::visitFunctionType(const FunctionType *functionType)
{
    string signature   = CsvGenerator::to_string(functionType);
    string returnType  = CsvGenerator::to_string(functionType->getReturnType());
    size_t nParameters = functionType->getFunctionNumParams();

    // Record function type entity
    writeEntity(pred::func_type::id, signature);

    // TODO: which predicate/entity do we need to update for varagrs?
    if (functionType->isVarArg())
        writeProperty(pred::func_type::varargs, signature);

    // Record return type
    writeFact(pred::func_type::return_type, signature, returnType);

    // Record function formal parameters
    for (size_t i = 0; i < nParameters; i++)
    {
        string paramType = CsvGenerator::to_string(functionType->getFunctionParamType(i));

        writeFact(pred::func_type::param_type, signature, paramType, i);
    }

    // Record number of formal parameters
    writeFact(pred::func_type::nparams, signature, nParameters);
}


void InstructionVisitor::visitVectorType(const VectorType *vectorType)
{
    string refmode = CsvGenerator::to_string(vectorType);
    size_t nElements = vectorType->getVectorNumElements();
    Type *componentType = vectorType->getVectorElementType();

    // Record vector type entity
    writeEntity(pred::vector_type::id, refmode);

    // Record vector component type
    string compTypeStr = CsvGenerator::to_string(componentType);
    writeFact(pred::vector_type::component_type, refmode, compTypeStr);

    // Record vector type size
    writeFact(pred::vector_type::size, refmode, nElements);
}


void CsvGenerator::initStreams()
{
    using namespace predicates;

    for (pred_t *pred : predicates::predicates())
    {
        operand_pred_t *operand_pred = dynamic_cast< operand_pred_t*>(pred);

        if (operand_pred) {
            path cpath = toPath(operand_pred->asConstant().c_str());
            path vpath = toPath(operand_pred->asVariable().c_str());

            // TODO: check if file open fails
            csvFiles[cpath] = new ofstream(cpath.c_str(), ios_base::out);
            csvFiles[vpath] = new ofstream(vpath.c_str(), ios_base::out);
        }
        else {
            path path = toPath(pred->c_str());
            csvFiles[path] = new ofstream(path.c_str(), ios_base::out);
        }
    }

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}
