#include <cassert>
#include <string>

#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"

#include "AuxiliaryMethods.hpp"
#include "InstructionVisitor.hpp"
#include "PredicateNames.hpp"

using namespace llvm;
using namespace std;
using namespace boost;

using namespace auxiliary_methods;
using namespace predicate_names;

namespace pred = predicate_names;

//TODO: why do we store the volatile property with two different ways?
//      (see writeVolatileFlag and :volatile for some entities)

//TODO: Remove these if(strlen(...)) checks

void InstructionVisitor::logSimpleValue(const Value * Val, const char * predName, int index){
    const Type * ValType = Val->getType();

    if(const Constant *c = dyn_cast<Constant>(Val)) {
        ostringstream immOffset;
        immOffset << immediateOffset;
        varId = instrNum + ":" + immOffset.str() + ":" + valueToString(c, Mod);
        immediateOffset++;
        csvGen->recordConstant(varId, ValType);
    }
    else {
        varId = instrId + valueToString(Val, Mod);
        csvGen->recordVariable(varId, ValType);
    }
    csvGen->writeSimpleFact(predName, instrNum, varId, index);
}

void InstructionVisitor::logOperand(const Value * Operand, const char * predName, int index)
{
    Operand::Type operandType; //whether we have a constant or variable operand
    const Type * OpType = Operand->getType();

    if(const Constant *c = dyn_cast<Constant>(Operand)) {
        operandType = Operand::Type::IMMEDIATE;
        ostringstream immOffset;
        immOffset << immediateOffset;
        varId = instrNum + ":" + immOffset.str() + ":" + valueToString(c, Mod);
        immediateOffset++;
        csvGen->recordConstant(varId, OpType);
    }
    else {
        operandType = Operand::Type::VARIABLE;
        varId = instrId + valueToString(Operand, Mod);
        csvGen->recordVariable(varId, OpType);
    }

    csvGen->writeOperandFact(predName, instrNum, varId, operandType, index);
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
    csvGen->writeEntity(pred::ret::instr, instrNum);

    if(RI.getReturnValue()) {   // with returned value
        logOperand(RI.getReturnValue(), pred::ret::operand);
    }
    else {                      // w/o returned value
        csvGen->writeEntity(pred::ret::instr_void, instrNum);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI) {

    string error;

    csvGen->writeEntity(pred::br::instr, instrNum);

    if(BI.isConditional()) {    // conditional branch
        // br i1 <cond>, label <iftrue>, label <iffalse>
        csvGen->writeEntity(pred::br::instr_cond, instrNum);

        // Condition Operand
        logOperand(BI.getCondition(), pred::br::condition);

        // 'iftrue' and 'iffalse' labels
        logSimpleValue(BI.getOperand(1), pred::br::cond_iftrue);
        logSimpleValue(BI.getOperand(2), pred::br::cond_iffalse);
    }
    else {                      // unconditional branch
        // br label <dest>
        csvGen->writeEntity(pred::br::instr_uncond, instrNum);
        logSimpleValue(BI.getOperand(0), pred::br::uncond_dest);
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI)
{
    // switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    csvGen->writeEntity(pred::switch_::instr, instrNum);

    // 'value' Operand
    logOperand(SI.getOperand(0), pred::switch_::operand);

    // 'defaultdest' label
    logSimpleValue(SI.getOperand(1), pred::switch_::default_label);

    // 'case list' [constant, label]
    int index = 0;

    for(SwitchInst::ConstCaseIt
            Case = SI.case_begin(), CasesEnd = SI.case_end();
        Case != CasesEnd; Case++)
    {
        logSimpleValue(Case.getCaseValue(), pred::switch_::case_value, index);
        logSimpleValue(Case.getCaseSuccessor(), pred::switch_::case_label, index++);
    }
    csvGen->writeSimpleFact(pred::switch_::ncases, instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR)
{
    // indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    csvGen->writeEntity(pred::indirectbr::instr, instrNum);

    // 'address' Operand
    logOperand(IBR.getOperand(0), pred::indirectbr::address);

    // 'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i)
        logSimpleValue(IBR.getOperand(i), pred::indirectbr::label, i-1);

    csvGen->writeSimpleFact(pred::indirectbr::nlabels, instrNum, IBR.getNumOperands() - 1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II)
{
    csvGen->writeEntity(pred::invoke::instr, instrNum);
    csvGen->writeEntity(II.getCalledFunction()
                        ? pred::invoke::instr_direct
                        : pred::invoke::instr_indirect, instrNum);

    Value *invokeOp = II.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

    // invoke instruction function
    logOperand(invokeOp, pred::invoke::function);

    // actual args
    for (unsigned op = 0; op < II.getNumArgOperands(); ++op)
        logOperand(II.getArgOperand(op), pred::invoke::arg, op);

    // 'normal label'
    logSimpleValue(II.getNormalDest(), pred::invoke::normal_label);

    // 'exception label'
    logSimpleValue(II.getUnwindDest(), pred::invoke::exc_label);

    // Function Attributes
    const AttributeSet &Attrs = II.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
    {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        csvGen->writeSimpleFact(pred::invoke::ret_attr, instrNum, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i) {
        csvGen->writeSimpleFact(pred::invoke::fn_attr, instrNum, FuncnAttr[i]);
    }

    // TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        string cconv = to_string(II.getCallingConv());
        csvGen->writeSimpleFact(pred::invoke::calling_conv, instrNum, cconv);
    }

    // TODO: param attributes?
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI)
{
    csvGen->writeEntity(pred::resume::instr, instrNum);
    logOperand(RI.getValue(), pred::resume::operand);
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    csvGen->writeEntity(pred::instruction::unreachable, instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI)
{
    csvGen->writeEntity(pred::alloca::instr, instrNum);
    csvGen->writeSimpleFact(pred::alloca::type, instrNum, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation())
        logOperand(AI.getArraySize(), pred::alloca::size);

    if(AI.getAlignment())
        csvGen->writeSimpleFact(pred::alloca::alignment, instrNum, AI.getAlignment());
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    csvGen->writeEntity(pred::load::instr, instrNum);
    logOperand(LI.getPointerOperand(), pred::load::address);

    if (LI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());

        if(strlen(ord))
            csvGen->writeSimpleFact(pred::load::ordering, instrNum, ord);
    }

    if (LI.getAlignment())
        csvGen->writeSimpleFact(pred::load::alignment, instrNum, LI.getAlignment());

    if (LI.isVolatile())
        csvGen->writeEntity(pred::load::isvolatile, instrNum);
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI)
{
    csvGen->writeEntity(pred::va_arg::instr, instrNum);
    csvGen->writeSimpleFact(pred::va_arg::type, instrNum, printType(VI.getType()));
    logOperand(VI.getPointerOperand(), pred::va_arg::va_list);
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI)
{
    csvGen->writeEntity(pred::extract_value::instr, instrNum);

    // Aggregate Operand
    logOperand(EVI.getOperand(0), pred::extract_value::base);

    // Constant Indices
    int index = 0;

    for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
        csvGen->writeSimpleFact(pred::extract_value::index, instrNum, *i, index);
        index++;
    }

    csvGen->writeSimpleFact(pred::extract_value::nindices, instrNum, EVI.getNumIndices());
}

void InstructionVisitor::visitStoreInst(StoreInst &SI)
{
    csvGen->writeEntity(pred::store::instr, instrNum);
    logOperand(SI.getValueOperand(), pred::store::value);
    logOperand(SI.getPointerOperand(), pred::store::address);

    if(SI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());

        if(strlen(ord))
            csvGen->writeSimpleFact(pred::store::ordering, instrNum, ord);
    }

    if (SI.getAlignment())
        csvGen->writeSimpleFact(pred::store::alignment, instrNum, SI.getAlignment());

    if (SI.isVolatile())
        csvGen->writeEntity(pred::store::isvolatile, instrNum);
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI)
{
    csvGen->writeEntity(pred::cmpxchg::instr, instrNum);

    // ptrValue
    logOperand(AXI.getPointerOperand(), pred::cmpxchg::address);

    // cmpValue
    logOperand(AXI.getCompareOperand(), pred::cmpxchg::cmp);

    // newValue
    logOperand(AXI.getNewValOperand(), pred::cmpxchg::new_);

    if (AXI.isVolatile())
        csvGen->writeEntity(pred::cmpxchg::isvolatile, instrNum);

    const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());

    if (strlen(ord))
        csvGen->writeSimpleFact(pred::cmpxchg::ordering, instrNum, ord);

    // TODO: type?
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI)
{
    csvGen->writeEntity(pred::atomicrmw::instr, instrNum);

    // ptrValue - LeftOperand
    logOperand(AWI.getPointerOperand(), pred::atomicrmw::address);

    // valOperand - Right Operand
    logOperand(AWI.getValOperand(), pred::atomicrmw::value);

    if (AWI.isVolatile())
        csvGen->writeEntity(pred::atomicrmw::isvolatile, instrNum);

    writeAtomicRMWOp(instrNum, AWI.getOperation());

    const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());

    if (strlen(ord))
        csvGen->writeSimpleFact(pred::atomicrmw::ordering, instrNum, ord);
}

void InstructionVisitor::visitFenceInst(FenceInst &FI)
{
    csvGen->writeEntity(pred::fence::instr, instrNum);

    // fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());

    if(strlen(ord))
        csvGen->writeSimpleFact(pred::fence::ordering, instrNum, ord);
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    csvGen->writeEntity(pred::gep::instr, instrNum);
    logOperand(GEP.getPointerOperand(), pred::gep::base);

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index)
    {
        int immOffset = immediateOffset;
        const Value * GepOperand = GEP.getOperand(index);

        logOperand(GepOperand, pred::gep::index, index - 1);

        if (const Constant *c = dyn_cast<Constant>(GepOperand)) {
            stringstream immStr;
            immStr << immOffset;
            varId = instrNum + ":" + immStr.str() + ":" + valueToString(c, Mod);

            csvGen->writeSimpleFact(pred::constant::to_integer, varId,
                                    c->getUniqueInteger().toString(10, true));
        }
    }

    csvGen->writeSimpleFact(pred::gep::nindices, instrNum, GEP.getNumIndices());

    if (GEP.isInBounds())
        csvGen->writeEntity(pred::gep::inbounds, instrNum);
}

void InstructionVisitor::visitPHINode(PHINode &PHI)
{
    // <result> = phi <ty> [ <val0>, <label0>], ...
    csvGen->writeEntity(pred::phi::instr, instrNum);

    // type
    csvGen->writeSimpleFact(pred::phi::type, instrNum, printType(PHI.getType()));

    for (unsigned op = 0; op < PHI.getNumIncomingValues(); ++op)
    {
        logOperand(PHI.getIncomingValue(op), pred::phi::pair_value, op);
        logSimpleValue(PHI.getIncomingBlock(op), pred::phi::pair_label, op);
    }

    csvGen->writeSimpleFact(pred::phi::npairs, instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI)
{
    csvGen->writeEntity(pred::select::instr, instrNum);

    // Condition
    logOperand(SI.getOperand(0), pred::select::condition);

    // Left Operand (true value)
    logOperand(SI.getOperand(1), pred::select::first_operand);

    // Right Operand (false value)
    logOperand(SI.getOperand(2), pred::select::second_operand);
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI)
{
    csvGen->writeEntity(pred::insert_value::instr, instrNum);

    // Left Operand
    logOperand(IVI.getOperand(0), pred::insert_value::base);

    // Right Operand
    logOperand(IVI.getOperand(1), pred::insert_value::value);

    // Constant Indices
    int index = 0;

    for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end();
         i != e; ++i,index++)
    {
        csvGen->writeSimpleFact(pred::insert_value::index, instrNum, *i, index);
    }

    csvGen->writeSimpleFact(pred::insert_value::nindices, instrNum, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI)
{
    csvGen->writeEntity(pred::landingpad::instr, instrNum);

    // type
    csvGen->writeSimpleFact(pred::landingpad::type, instrNum, printType(LI.getType()));

    // function
    logSimpleValue(LI.getPersonalityFn(), pred::landingpad::fn);

    // cleanup
    if(LI.isCleanup())
        csvGen->writeEntity(pred::landingpad::cleanup, instrNum);

    // #clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i)
    {
        pred_t pred_clause = LI.isCatch(i)
            ? pred::landingpad::catch_clause
            : pred::landingpad::filter_clause;

        csvGen->writeSimpleFact(pred_clause, instrNum, LI.getClause(i), i);
    }

    csvGen->writeSimpleFact(pred::landingpad::nclauses, instrNum, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI)
{
    csvGen->writeEntity(pred::call::instr, instrNum);
    csvGen->writeEntity(CI.getCalledFunction()
                        ? pred::call::instr_direct
                        : pred::call::instr_indirect, instrNum);

    Value *callOp = CI.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(callOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
    Type *RetTy = funcTy->getReturnType();

    logOperand(callOp, pred::call::function);

    for (unsigned op = 0; op < CI.getNumArgOperands(); ++op)
        logOperand(CI.getArgOperand(op), pred::call::arg, op);

    if(CI.isTailCall())
        csvGen->writeEntity(pred::call::tail, instrNum);

    if (CI.getCallingConv() != CallingConv::C) {
        string cconv = to_string(CI.getCallingConv());
        csvGen->writeSimpleFact(pred::call::calling_conv, instrNum, cconv);
    }

    // Attributes
    const AttributeSet &Attrs = CI.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        csvGen->writeSimpleFact(pred::call::ret_attr, instrNum, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i)
        csvGen->writeSimpleFact(pred::call::fn_attr, instrNum, FuncnAttr[i]);

    // TODO: parameter attributes?
}

void InstructionVisitor::visitICmpInst(ICmpInst &I)
{
    csvGen->writeEntity(pred::icmp::instr, instrNum);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        csvGen->writeSimpleFact(pred::icmp::condition, instrNum,
                                writePredicate(I.getPredicate()));

    // Left Operand
    logOperand(I.getOperand(0), pred::icmp::first_operand);

    // Right Operand
    logOperand(I.getOperand(1), pred::icmp::second_operand);

}

void InstructionVisitor::visitFCmpInst(FCmpInst &I)
{
    csvGen->writeEntity(pred::fcmp::instr, instrNum);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        csvGen->writeSimpleFact(pred::fcmp::condition, instrNum,
                                writePredicate(I.getPredicate()));

    // Left Operand
    logOperand(I.getOperand(0), pred::fcmp::first_operand);

    // Right Operand
    logOperand(I.getOperand(1), pred::fcmp::second_operand);
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI)
{
    csvGen->writeEntity(pred::extract_element::instr, instrNum);

    // VectorOperand
    logOperand(EEI.getVectorOperand(), pred::extract_element::base);

    // indexValue
    logOperand(EEI.getIndexOperand(), pred::extract_element::index);

}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI)
{
    csvGen->writeEntity(pred::insert_element::instr, instrNum);

    // vectorOperand
    logOperand(IEI.getOperand(0), pred::insert_element::base);

    // Value Operand
    logOperand(IEI.getOperand(1), pred::insert_element::value);

    // Index Operand
    logOperand(IEI.getOperand(2), pred::insert_element::index);
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI)
{
    csvGen->writeEntity(pred::shuffle_vector::instr, instrNum);

    // firstVector
    logOperand(SVI.getOperand(0), pred::shuffle_vector::first_vector);

    // secondVector
    logOperand(SVI.getOperand(1), pred::shuffle_vector::second_vector);

    // Mask
    logSimpleValue(SVI.getOperand(2), pred::shuffle_vector::mask);

}

void  InstructionVisitor::visitInstruction(Instruction &I) {

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

void InstructionVisitor::writeOptimizationInfoToFile(const User *u, string instrId) {

    if (const FPMathOperator *fpo = dyn_cast<const FPMathOperator>(u)) {
        if(fpo->hasUnsafeAlgebra()) {
            csvGen->writeSimpleFact(pred::instruction::flag, instrId, "fast");
        }
        else {
            if(fpo->hasNoNaNs()) {
                csvGen->writeSimpleFact(pred::instruction::flag, instrId, "nnan");
            }
            if(fpo->hasNoInfs()) {
                csvGen->writeSimpleFact(pred::instruction::flag, instrId, "ninf");
            }
            if(fpo->hasNoSignedZeros()) {
                csvGen->writeSimpleFact(pred::instruction::flag, instrId, "nsz");
            }
            if(fpo->hasAllowReciprocal()) {
                csvGen->writeSimpleFact(pred::instruction::flag, instrId, "arcp");
            }
        }
    }
    if (const OverflowingBinaryOperator *obo = dyn_cast<OverflowingBinaryOperator>(u)) {
        if(obo->hasNoUnsignedWrap()) {
            csvGen->writeSimpleFact(pred::instruction::flag, instrId, "nuw");
        }
        if(obo->hasNoSignedWrap()) {
            csvGen->writeSimpleFact(pred::instruction::flag, instrId, "nsw");
        }
    }
    else if (const PossiblyExactOperator *div = dyn_cast<PossiblyExactOperator>(u)) {
        if(div->isExact()) {
            csvGen->writeSimpleFact(pred::instruction::flag, instrId, "exact");
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
        csvGen->writeSimpleFact(pred::instruction::flag, instrId, "singlethread");

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
        csvGen->writeSimpleFact(pred::atomicrmw::operation, instrId, oper);
}
