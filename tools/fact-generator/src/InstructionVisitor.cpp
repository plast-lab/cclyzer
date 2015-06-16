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

void InstructionVisitor::writeValue(pred_t predicate, const Value * Val, int index)
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
    csvGen->writeSimpleFact(predicate, instrNum, refmode.str(), index);
}

void InstructionVisitor::writeOperand(pred_t predicate, const Value * Operand, int index)
{
    // Operand refmode and type
    ostringstream refmode;
    const Type * type = Operand->getType();

    // Operand category is either constant or variable
    Operand::Type category;

    if (const Constant *c = dyn_cast<Constant>(Operand)) {
        // Compute refmode for constant
        refmode << instrNum
                << ':' << immediateOffset++
                << ':' << valueToString(c, Mod);

        // Record constant operand
        category = Operand::Type::IMMEDIATE;
        csvGen->recordConstant(refmode.str(), type);
    }
    else {
        refmode << instrId << valueToString(Operand, Mod);

        // Record variable operand
        category = Operand::Type::VARIABLE;
        csvGen->recordVariable(refmode.str(), type);
    }

    // Write operand fact
    csvGen->writeOperandFact(predicate, instrNum, refmode.str(), category, index);
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
        writeOperand(pred::ret::operand, RI.getReturnValue());
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
        writeOperand(pred::br::condition, BI.getCondition());

        // 'iftrue' and 'iffalse' labels
        writeValue(pred::br::cond_iftrue, BI.getOperand(1));
        writeValue(pred::br::cond_iffalse, BI.getOperand(2));
    }
    else {                      // unconditional branch
        // br label <dest>
        csvGen->writeEntity(pred::br::instr_uncond, instrNum);
        writeValue(pred::br::uncond_dest, BI.getOperand(0));
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI)
{
    // switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    csvGen->writeEntity(pred::switch_::instr, instrNum);

    // 'value' Operand
    writeOperand(pred::switch_::operand, SI.getOperand(0));

    // 'defaultdest' label
    writeValue(pred::switch_::default_label, SI.getOperand(1));

    // 'case list' [constant, label]
    int index = 0;

    for(SwitchInst::ConstCaseIt
            Case = SI.case_begin(), CasesEnd = SI.case_end();
        Case != CasesEnd; Case++)
    {
        writeValue(pred::switch_::case_value, Case.getCaseValue(), index);
        writeValue(pred::switch_::case_label, Case.getCaseSuccessor(), index++);
    }
    csvGen->writeSimpleFact(pred::switch_::ncases, instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR)
{
    // indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    csvGen->writeEntity(pred::indirectbr::instr, instrNum);

    // 'address' Operand
    writeOperand(pred::indirectbr::address, IBR.getOperand(0));

    // 'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i)
        writeValue(pred::indirectbr::label, IBR.getOperand(i), i-1);

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
    writeOperand(pred::invoke::function, invokeOp);

    // actual args
    for (unsigned op = 0; op < II.getNumArgOperands(); ++op)
        writeOperand(pred::invoke::arg, II.getArgOperand(op), op);

    // 'normal label'
    writeValue(pred::invoke::normal_label, II.getNormalDest());

    // 'exception label'
    writeValue(pred::invoke::exc_label, II.getUnwindDest());

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
    writeOperand(pred::resume::operand, RI.getValue());
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    csvGen->writeEntity(pred::instruction::unreachable, instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI)
{
    csvGen->writeEntity(pred::alloca::instr, instrNum);
    csvGen->writeSimpleFact(pred::alloca::type, instrNum, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation())
        writeOperand(pred::alloca::size, AI.getArraySize());

    if(AI.getAlignment())
        csvGen->writeSimpleFact(pred::alloca::alignment, instrNum, AI.getAlignment());
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    csvGen->writeEntity(pred::load::instr, instrNum);
    writeOperand(pred::load::address, LI.getPointerOperand());

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
    writeOperand(pred::va_arg::va_list, VI.getPointerOperand());
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI)
{
    csvGen->writeEntity(pred::extract_value::instr, instrNum);

    // Aggregate Operand
    writeOperand(pred::extract_value::base, EVI.getOperand(0));

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
    writeOperand(pred::store::value, SI.getValueOperand());
    writeOperand(pred::store::address, SI.getPointerOperand());

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
    writeOperand(pred::cmpxchg::address, AXI.getPointerOperand());

    // cmpValue
    writeOperand(pred::cmpxchg::cmp, AXI.getCompareOperand());

    // newValue
    writeOperand(pred::cmpxchg::new_, AXI.getNewValOperand());

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
    writeOperand(pred::atomicrmw::address, AWI.getPointerOperand());

    // valOperand - Right Operand
    writeOperand(pred::atomicrmw::value, AWI.getValOperand());

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
    writeOperand(pred::gep::base, GEP.getPointerOperand());

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index)
    {
        int immOffset = immediateOffset;
        const Value * GepOperand = GEP.getOperand(index);

        writeOperand(pred::gep::index, GepOperand, index - 1);

        if (const Constant *c = dyn_cast<Constant>(GepOperand)) {
            ostringstream constant;

            // Compute constant refmode
            constant << instrNum
                     << ':' << immOffset
                     << ':' << valueToString(c, Mod);

            // Compute integer string representation
            string int_value = c->getUniqueInteger().toString(10, true);

            // Write constant to integer fact
            csvGen->writeSimpleFact(pred::constant::to_integer, constant.str(), int_value);
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
        writeOperand(pred::phi::pair_value, PHI.getIncomingValue(op), op);
        writeValue(pred::phi::pair_label, PHI.getIncomingBlock(op), op);
    }

    csvGen->writeSimpleFact(pred::phi::npairs, instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI)
{
    csvGen->writeEntity(pred::select::instr, instrNum);

    // Condition
    writeOperand(pred::select::condition, SI.getOperand(0));

    // Left Operand (true value)
    writeOperand(pred::select::first_operand, SI.getOperand(1));

    // Right Operand (false value)
    writeOperand(pred::select::second_operand, SI.getOperand(2));
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI)
{
    csvGen->writeEntity(pred::insert_value::instr, instrNum);

    // Left Operand
    writeOperand(pred::insert_value::base, IVI.getOperand(0));

    // Right Operand
    writeOperand(pred::insert_value::value, IVI.getOperand(1));

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
    writeValue(pred::landingpad::fn, LI.getPersonalityFn());

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

    writeOperand(pred::call::function, callOp);

    for (unsigned op = 0; op < CI.getNumArgOperands(); ++op)
        writeOperand(pred::call::arg, CI.getArgOperand(op), op);

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
    writeOperand(pred::icmp::first_operand, I.getOperand(0));

    // Right Operand
    writeOperand(pred::icmp::second_operand, I.getOperand(1));

}

void InstructionVisitor::visitFCmpInst(FCmpInst &I)
{
    csvGen->writeEntity(pred::fcmp::instr, instrNum);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        csvGen->writeSimpleFact(pred::fcmp::condition, instrNum,
                                writePredicate(I.getPredicate()));

    // Left Operand
    writeOperand(pred::fcmp::first_operand, I.getOperand(0));

    // Right Operand
    writeOperand(pred::fcmp::second_operand, I.getOperand(1));
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI)
{
    csvGen->writeEntity(pred::extract_element::instr, instrNum);

    // VectorOperand
    writeOperand(pred::extract_element::base, EEI.getVectorOperand());

    // indexValue
    writeOperand(pred::extract_element::index, EEI.getIndexOperand());

}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI)
{
    csvGen->writeEntity(pred::insert_element::instr, instrNum);

    // vectorOperand
    writeOperand(pred::insert_element::base, IEI.getOperand(0));

    // Value Operand
    writeOperand(pred::insert_element::value, IEI.getOperand(1));

    // Index Operand
    writeOperand(pred::insert_element::index, IEI.getOperand(2));
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI)
{
    csvGen->writeEntity(pred::shuffle_vector::instr, instrNum);

    // firstVector
    writeOperand(pred::shuffle_vector::first_vector, SVI.getOperand(0));

    // secondVector
    writeOperand(pred::shuffle_vector::second_vector, SVI.getOperand(1));

    // Mask
    writeValue(pred::shuffle_vector::mask, SVI.getOperand(2));

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
