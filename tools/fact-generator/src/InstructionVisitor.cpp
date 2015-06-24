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
namespace fs = boost::filesystem;

//TODO: why do we store the volatile property with two different ways?
//      (see writeVolatileFlag and :volatile for some entities)

//TODO: Remove these if(strlen(...)) checks

void InstructionVisitor::writeInstrOperand(
    const pred_t &predicate,    // the operand predicate
    const refmode_t &instr,     // the instruction refmode
    const Value * Val,          // the operand value
    int index)                  // an optional index
{
    // Value refmode and type
    ostringstream refmode;
    const Type * type = Val->getType();
    const char *predname = predicate.c_str();

    if (const Constant *c = dyn_cast<Constant>(Val)) {
        // Compute refmode for constant value
        refmode << instr
                << ':' << immediateOffset++
                << ':' << valueToString(c, Mod);

        // Record constant value
        csvGen->recordConstant(refmode.str(), type);
    }
    else {
        // Compute refmode for variable value
        refmode << instrId << valueToString(Val, Mod);

        // Record variable value
        csvGen->recordVariable(refmode.str(), type);
    }

    // Write value fact
    if (index == -1) {
        writer.writeFact(predname, instr, refmode.str());
    } else {
        writer.writeFact(predname, instr, refmode.str(), index);
    }
}

void InstructionVisitor::writeInstrOperand(
    const operand_pred_t &predicate, // the operand predicate
    const refmode_t &instr,          // the instruction refmode
    const Value * Operand,           // the operand value
    int index)                       // an optional index
{
    // Operand refmode and type
    ostringstream refmode;
    const Type * type = Operand->getType();
    const char *predname;

    if (const Constant *c = dyn_cast<Constant>(Operand)) {
        // Compute refmode for constant
        refmode << instr
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
    if (index == -1) {
        writer.writeFact(predname, instr, refmode.str());
    } else {
        writer.writeFact(predname, instr, refmode.str(), index);
    }
}

void InstructionVisitor::visitTruncInst(llvm::TruncInst &I) {
    _visitCastInst<pred::trunc>(I);
}

void InstructionVisitor::visitZExtInst(llvm::ZExtInst &I) {
    _visitCastInst<pred::zext>(I);
}

void InstructionVisitor::visitSExtInst(llvm::SExtInst &I) {
    _visitCastInst<pred::sext>(I);
}

void InstructionVisitor::visitFPTruncInst(llvm::FPTruncInst &I) {
    _visitCastInst<pred::fptrunc>(I);
}

void InstructionVisitor::visitFPExtInst(llvm::FPExtInst &I) {
    _visitCastInst<pred::fpext>(I);
}

void InstructionVisitor::visitFPToUIInst(llvm::FPToUIInst &I) {
    _visitCastInst<pred::fptoui>(I);
}

void InstructionVisitor::visitFPToSIInst(llvm::FPToSIInst &I) {
    _visitCastInst<pred::fptosi>(I);
}

void InstructionVisitor::visitUIToFPInst(llvm::UIToFPInst &I) {
    _visitCastInst<pred::uitofp>(I);
}

void InstructionVisitor::visitSIToFPInst(llvm::SIToFPInst &I) {
    _visitCastInst<pred::sitofp>(I);
}

void InstructionVisitor::visitPtrToIntInst(llvm::PtrToIntInst &I) {
    _visitCastInst<pred::ptrtoint>(I);
}

void InstructionVisitor::visitIntToPtrInst(llvm::IntToPtrInst &I) {
    _visitCastInst<pred::inttoptr>(I);
}

void InstructionVisitor::visitBitCastInst(llvm::BitCastInst &I) {
    _visitCastInst<pred::bitcast>(I);
}

void InstructionVisitor::visitAdd(BinaryOperator &BI) {
    _visitBinaryInst<pred::add>(BI);
}

void InstructionVisitor::visitFAdd(BinaryOperator &BI) {
    _visitBinaryInst<pred::fadd>(BI);
}

void InstructionVisitor::visitSub(BinaryOperator &BI) {
    _visitBinaryInst<pred::sub>(BI);
}

void InstructionVisitor::visitFSub(BinaryOperator &BI) {
    _visitBinaryInst<pred::fsub>(BI);
}

void InstructionVisitor::visitMul(BinaryOperator &BI) {
    _visitBinaryInst<pred::mul>(BI);
}

void InstructionVisitor::visitFMul(BinaryOperator &BI) {
    _visitBinaryInst<pred::fmul>(BI);
}

void InstructionVisitor::visitSDiv(BinaryOperator &BI) {
    _visitBinaryInst<pred::sdiv>(BI);
}

void InstructionVisitor::visitFDiv(BinaryOperator &BI) {
    _visitBinaryInst<pred::fdiv>(BI);
}

void InstructionVisitor::visitUDiv(BinaryOperator &BI) {
    _visitBinaryInst<pred::udiv>(BI);
}

void InstructionVisitor::visitSRem(BinaryOperator &BI) {
    _visitBinaryInst<pred::srem>(BI);
}

void InstructionVisitor::visitFRem(BinaryOperator &BI) {
    _visitBinaryInst<pred::frem>(BI);
}

void InstructionVisitor::visitURem(BinaryOperator &BI) {
    _visitBinaryInst<pred::urem>(BI);
}

void InstructionVisitor::visitShl(BinaryOperator &BI) {
    _visitBinaryInst<pred::shl>(BI);
}

void InstructionVisitor::visitLShr(BinaryOperator &BI) {
    _visitBinaryInst<pred::lshr>(BI);
}

void InstructionVisitor::visitAShr(BinaryOperator &BI) {
    _visitBinaryInst<pred::ashr>(BI);
}

void InstructionVisitor::visitAnd(BinaryOperator &BI) {
    _visitBinaryInst<pred::and_>(BI);
}

void InstructionVisitor::visitOr(BinaryOperator &BI) {
    _visitBinaryInst<pred::or_>(BI);
}

void InstructionVisitor::visitXor(BinaryOperator &BI) {
    _visitBinaryInst<pred::xor_>(BI);
}

void InstructionVisitor::visitReturnInst(ReturnInst &RI)
{
    refmode_t iref = recordInstruction(pred::ret::instr);

    if (RI.getReturnValue()) {  // with returned value
        writeInstrOperand(pred::ret::operand, iref, RI.getReturnValue());
    }
    else {                      // w/o returned value
        writeFact(pred::ret::instr_void, iref);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI)
{
    refmode_t iref = recordInstruction(pred::br::instr);

    if (BI.isConditional()) {    // conditional branch
        // br i1 <cond>, label <iftrue>, label <iffalse>
        writeFact(pred::br::instr_cond, iref);

        // Condition Operand
        writeInstrOperand(pred::br::condition, iref, BI.getCondition());

        // 'iftrue' and 'iffalse' labels
        writeInstrOperand(pred::br::cond_iftrue, iref, BI.getOperand(1));
        writeInstrOperand(pred::br::cond_iffalse, iref, BI.getOperand(2));
    }
    else {                      // unconditional branch
        // br label <dest>
        writeFact(pred::br::instr_uncond, iref);
        writeInstrOperand(pred::br::uncond_dest, iref, BI.getOperand(0));
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI)
{
    // switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    refmode_t iref = recordInstruction(pred::switch_::instr);

    writeInstrOperand(pred::switch_::operand, iref, SI.getOperand(0));
    writeInstrOperand(pred::switch_::default_label, iref, SI.getOperand(1));

    // 'case list' [constant, label]
    int index = 0;

    for(SwitchInst::ConstCaseIt
            Case = SI.case_begin(), CasesEnd = SI.case_end();
        Case != CasesEnd; Case++)
    {
        writeInstrOperand(pred::switch_::case_value,
                          iref, Case.getCaseValue(), index);

        writeInstrOperand(pred::switch_::case_label,
                          iref, Case.getCaseSuccessor(), index++);
    }

    writeFact(pred::switch_::ncases, iref, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR)
{
    // indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    refmode_t iref = recordInstruction(pred::indirectbr::instr);

    // 'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i)
        writeInstrOperand(pred::indirectbr::label, iref, IBR.getOperand(i), i-1);

    writeFact(pred::indirectbr::nlabels, iref, IBR.getNumOperands() - 1);
    writeInstrOperand(pred::indirectbr::address, iref, IBR.getOperand(0));
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II)
{
    refmode_t iref = recordInstruction(pred::invoke::instr);

    writeFact(II.getCalledFunction()
              ? pred::invoke::instr_direct
              : pred::invoke::instr_indirect, iref);

    Value *invokeOp = II.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

    // invoke instruction function
    writeInstrOperand(pred::invoke::function, iref, invokeOp);

    // actual args
    for (unsigned op = 0; op < II.getNumArgOperands(); ++op)
        writeInstrOperand(pred::invoke::arg, iref, II.getArgOperand(op), op);

    writeInstrOperand(pred::invoke::normal_label, iref, II.getNormalDest());
    writeInstrOperand(pred::invoke::exc_label, iref, II.getUnwindDest());

    // Function Attributes
    const AttributeSet &Attrs = II.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
    {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        writeFact(pred::invoke::ret_attr, iref, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i) {
        writeFact(pred::invoke::fn_attr, iref, FuncnAttr[i]);
    }

    // TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        refmode_t cconv = refmodeOf(II.getCallingConv());
        writeFact(pred::invoke::calling_conv, iref, cconv);
    }

    // TODO: param attributes?
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI)
{
    refmode_t iref = recordInstruction(pred::resume::instr);
    writeInstrOperand(pred::resume::operand, iref, RI.getValue());
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    recordInstruction(pred::instruction::unreachable);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI)
{
    refmode_t iref = recordInstruction(pred::alloca::instr);

    writeFact(pred::alloca::type, iref, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation())
        writeInstrOperand(pred::alloca::size, iref, AI.getArraySize());

    if(AI.getAlignment())
        writeFact(pred::alloca::alignment, iref, AI.getAlignment());
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    refmode_t iref = recordInstruction(pred::load::instr);

    writeInstrOperand(pred::load::address, iref, LI.getPointerOperand());

    if (LI.isAtomic()) {
        const char *ord = writeAtomicInfo(iref, LI.getOrdering(), LI.getSynchScope());

        if (strlen(ord))
            writeFact(pred::load::ordering, iref, ord);
    }

    if (LI.getAlignment())
        writeFact(pred::load::alignment, iref, LI.getAlignment());

    if (LI.isVolatile())
        writeFact(pred::load::isvolatile, iref);
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI)
{
    refmode_t iref = recordInstruction(pred::va_arg::instr);

    writeFact(pred::va_arg::type, iref, printType(VI.getType()));
    writeInstrOperand(pred::va_arg::va_list, iref, VI.getPointerOperand());
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI)
{
    refmode_t iref = recordInstruction(pred::extract_value::instr);

    // Aggregate Operand
    writeInstrOperand(pred::extract_value::base, iref, EVI.getOperand(0));

    // Constant Indices
    int index = 0;

    for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
        writeFact(pred::extract_value::index, iref, *i, index);
        index++;
    }

    writeFact(pred::extract_value::nindices, iref, EVI.getNumIndices());
}

void InstructionVisitor::visitStoreInst(StoreInst &SI)
{
    refmode_t iref = recordInstruction(pred::store::instr);

    writeInstrOperand(pred::store::value, iref, SI.getValueOperand());
    writeInstrOperand(pred::store::address, iref, SI.getPointerOperand());

    if (SI.isAtomic()) {
        const char *ord = writeAtomicInfo(iref, SI.getOrdering(), SI.getSynchScope());

        if(strlen(ord))
            writeFact(pred::store::ordering, iref, ord);
    }

    if (SI.getAlignment())
        writeFact(pred::store::alignment, iref, SI.getAlignment());

    if (SI.isVolatile())
        writeFact(pred::store::isvolatile, iref);
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI)
{
    refmode_t iref = recordInstruction(pred::cmpxchg::instr);

    writeInstrOperand(pred::cmpxchg::address, iref, AXI.getPointerOperand());
    writeInstrOperand(pred::cmpxchg::cmp, iref, AXI.getCompareOperand());
    writeInstrOperand(pred::cmpxchg::new_, iref, AXI.getNewValOperand());

    if (AXI.isVolatile())
        writeFact(pred::cmpxchg::isvolatile, iref);

    const char *ord = writeAtomicInfo(iref, AXI.getOrdering(), AXI.getSynchScope());

    if (strlen(ord))
        writeFact(pred::cmpxchg::ordering, iref, ord);

    // TODO: type?
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI)
{
    refmode_t iref = recordInstruction(pred::atomicrmw::instr);

    writeInstrOperand(pred::atomicrmw::address, iref, AWI.getPointerOperand());
    writeInstrOperand(pred::atomicrmw::value, iref, AWI.getValOperand());

    if (AWI.isVolatile())
        writeFact(pred::atomicrmw::isvolatile, iref);

    writeAtomicRMWOp(iref, AWI.getOperation());

    const char *ord = writeAtomicInfo(iref, AWI.getOrdering(), AWI.getSynchScope());

    if (strlen(ord))
        writeFact(pred::atomicrmw::ordering, iref, ord);
}

void InstructionVisitor::visitFenceInst(FenceInst &FI)
{
    refmode_t iref = recordInstruction(pred::fence::instr);

    // fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(iref, FI.getOrdering(), FI.getSynchScope());

    if (strlen(ord))
        writeFact(pred::fence::ordering, iref, ord);
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP)
{
    refmode_t iref = recordInstruction(pred::gep::instr);
    writeInstrOperand(pred::gep::base, iref, GEP.getPointerOperand());

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index)
    {
        int immOffset = immediateOffset;
        const Value * GepOperand = GEP.getOperand(index);

        writeInstrOperand(pred::gep::index, iref, GepOperand, index - 1);

        if (const Constant *c = dyn_cast<Constant>(GepOperand)) {
            ostringstream constant;

            // Compute constant refmode
            constant << iref
                     << ':' << immOffset
                     << ':' << valueToString(c, Mod);

            // Compute integer string representation
            string int_value = c->getUniqueInteger().toString(10, true);

            // Write constant to integer fact
            writeFact(pred::constant::to_integer, constant.str(), int_value);
        }
    }

    writeFact(pred::gep::nindices, iref, GEP.getNumIndices());

    if (GEP.isInBounds())
        writeFact(pred::gep::inbounds, iref);
}

void InstructionVisitor::visitPHINode(PHINode &PHI)
{
    // <result> = phi <ty> [ <val0>, <label0>], ...
    refmode_t iref = recordInstruction(pred::phi::instr);

    // type
    writeFact(pred::phi::type, iref, printType(PHI.getType()));

    for (unsigned op = 0; op < PHI.getNumIncomingValues(); ++op)
    {
        writeInstrOperand(pred::phi::pair_value, iref, PHI.getIncomingValue(op), op);
        writeInstrOperand(pred::phi::pair_label, iref, PHI.getIncomingBlock(op), op);
    }

    writeFact(pred::phi::npairs, iref, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI)
{
    refmode_t iref = recordInstruction(pred::select::instr);

    // Condition and operands
    writeInstrOperand(pred::select::condition, iref, SI.getOperand(0));
    writeInstrOperand(pred::select::first_operand, iref, SI.getOperand(1));
    writeInstrOperand(pred::select::second_operand, iref, SI.getOperand(2));
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI)
{
    refmode_t iref = recordInstruction(pred::insert_value::instr);

    writeInstrOperand(pred::insert_value::base, iref, IVI.getOperand(0));
    writeInstrOperand(pred::insert_value::value, iref, IVI.getOperand(1));

    // Constant Indices
    int index = 0;

    for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end();
         i != e; ++i,index++)
    {
        writeFact(pred::insert_value::index, iref, *i, index);
    }

    writeFact(pred::insert_value::nindices, iref, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI)
{
    refmode_t iref = recordInstruction(pred::landingpad::instr);

    writeFact(pred::landingpad::type, iref, printType(LI.getType()));
    writeInstrOperand(pred::landingpad::fn, iref, LI.getPersonalityFn());

    // cleanup
    if (LI.isCleanup())
        writeFact(pred::landingpad::cleanup, iref);

    // #clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i)
    {
        const pred_t &pred_clause = LI.isCatch(i)
            ? pred::landingpad::catch_clause
            : pred::landingpad::filter_clause;

        writeFact(pred_clause, iref, LI.getClause(i), i);
    }

    writeFact(pred::landingpad::nclauses, iref, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI)
{
    refmode_t iref = recordInstruction(pred::call::instr);

    writeFact(CI.getCalledFunction()
              ? pred::call::instr_direct
              : pred::call::instr_indirect, iref);

    Value *callOp = CI.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(callOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
    Type *RetTy = funcTy->getReturnType();

    writeInstrOperand(pred::call::function, iref, callOp);

    for (unsigned op = 0; op < CI.getNumArgOperands(); ++op)
        writeInstrOperand(pred::call::arg, iref, CI.getArgOperand(op), op);

    if(CI.isTailCall())
        writeFact(pred::call::tail, iref);

    if (CI.getCallingConv() != CallingConv::C) {
        refmode_t cconv = refmodeOf(CI.getCallingConv());
        writeFact(pred::call::calling_conv, iref, cconv);
    }

    // Attributes
    const AttributeSet &Attrs = CI.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        writeFact(pred::call::ret_attr, iref, attrs);
    }

    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);

    for (unsigned i = 0; i < FuncnAttr.size(); ++i)
        writeFact(pred::call::fn_attr, iref, FuncnAttr[i]);

    // TODO: parameter attributes?
}

void InstructionVisitor::visitICmpInst(ICmpInst &I)
{
    refmode_t iref = recordInstruction(pred::icmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        writeFact(pred::icmp::condition, iref, writePredicate(I.getPredicate()));

    // Operands
    writeInstrOperand(pred::icmp::first_operand, iref, I.getOperand(0));
    writeInstrOperand(pred::icmp::second_operand, iref, I.getOperand(1));
}

void InstructionVisitor::visitFCmpInst(FCmpInst &I)
{
    refmode_t iref = recordInstruction(pred::fcmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        writeFact(pred::fcmp::condition, iref, writePredicate(I.getPredicate()));

    // Operands
    writeInstrOperand(pred::fcmp::first_operand, iref, I.getOperand(0));
    writeInstrOperand(pred::fcmp::second_operand, iref, I.getOperand(1));
}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI)
{
    refmode_t iref = recordInstruction(pred::extract_element::instr);

    writeInstrOperand(pred::extract_element::base, iref, EEI.getVectorOperand());
    writeInstrOperand(pred::extract_element::index, iref, EEI.getIndexOperand());
}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI)
{
    refmode_t iref = recordInstruction(pred::insert_element::instr);

    writeInstrOperand(pred::insert_element::base, iref, IEI.getOperand(0));
    writeInstrOperand(pred::insert_element::value, iref, IEI.getOperand(1));
    writeInstrOperand(pred::insert_element::index, iref, IEI.getOperand(2));
}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI)
{
    refmode_t iref = recordInstruction(pred::shuffle_vector::instr);

    writeInstrOperand(pred::shuffle_vector::first_vector, iref, SVI.getOperand(0));
    writeInstrOperand(pred::shuffle_vector::second_vector, iref, SVI.getOperand(1));
    writeInstrOperand(pred::shuffle_vector::mask, iref, SVI.getOperand(2));
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


void InstructionVisitor::visitGlobalAlias(const GlobalAlias *ga, const refmode_t &refmode)
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
    writeFact(pred::alias::id, refmode);

    // Serialize alias properties
    refmode_t visibility = refmodeOf(ga->getVisibility());
    refmode_t linkage    = refmodeOf(ga->getLinkage());
    refmode_t aliasType  = refmodeOf(ga->getType());

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


void InstructionVisitor::visitGlobalVar(const GlobalVariable *gv, const string &refmode)
{
    // Record global variable entity
    writeFact(pred::global_var::id, refmode);

    // Serialize global variable properties
    refmode_t visibility = refmodeOf(gv->getVisibility());
    refmode_t linkage    = refmodeOf(gv->getLinkage());
    refmode_t varType    = refmodeOf(gv->getType()->getElementType());
    refmode_t thrLocMode = refmodeOf(gv->getThreadLocalMode());

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
            refmode_t typeRef = refmodeOf(type);

            writeFact(pred::type::alloc_size, typeRef, allocSize);
            writeFact(pred::type::store_size, typeRef, storeSize);
            break;
        }
    }

    refmode_t tref = refmodeOf(type);

    // Record each different kind of type
    switch (type->getTypeID()) { // Fallthrough is intended
      case llvm::Type::VoidTyID:
      case llvm::Type::LabelTyID:
      case llvm::Type::MetadataTyID:
          writeFact(pred::primitive_type::id, tref);
          break;
      case llvm::Type::HalfTyID: // Fallthrough to all 6 floating point types
      case llvm::Type::FloatTyID:
      case llvm::Type::DoubleTyID:
      case llvm::Type::X86_FP80TyID:
      case llvm::Type::FP128TyID:
      case llvm::Type::PPC_FP128TyID:
          assert(type->isFloatingPointTy());
          writeFact(pred::fp_type::id, tref);
          break;
      case llvm::Type::IntegerTyID:
          writeFact(pred::integer_type::id, tref);
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
    refmode_t tref = refmodeOf(ptrType);
    refmode_t elementType = refmodeOf(ptrType->getPointerElementType());

    // Record pointer type entity
    writeFact(pred::ptr_type::id, tref);

    // Record pointer element type
    writeFact(pred::ptr_type::component_type, tref, elementType);

    // Record pointer address space
    if (unsigned addressSpace = ptrType->getPointerAddressSpace())
        writeFact(pred::ptr_type::addr_space, tref, addressSpace);
}


void InstructionVisitor::visitArrayType(const ArrayType *arrayType)
{
    refmode_t tref = refmodeOf(arrayType);
    refmode_t componentType = refmodeOf(arrayType->getArrayElementType());
    size_t nElements = arrayType->getArrayNumElements();

    writeFact(pred::array_type::id, tref);
    writeFact(pred::array_type::component_type, tref, componentType);
    writeFact(pred::array_type::size, tref, nElements);
}


void InstructionVisitor::visitStructType(const StructType *structType)
{
    refmode_t tref = refmodeOf(structType);
    size_t nFields = structType->getStructNumElements();

    // Record struct type entity
    writeFact(pred::struct_type::id, tref);

    if (structType->isOpaque()) {
        // Opaque structs carry no info about their internal structure
        writeFact(pred::struct_type::opaque, tref);
    } else {
        // Record struct field types
        for (size_t i = 0; i < nFields; i++)
        {
            refmode_t fieldType = refmodeOf(
                structType->getStructElementType(i));

            writeFact(pred::struct_type::field_type, tref, fieldType, i);
        }

        // Record number of fields
        writeFact(pred::struct_type::nfields, tref, nFields);
    }
}


void InstructionVisitor::visitFunctionType(const FunctionType *functionType)
{
    refmode_t signature  = refmodeOf(functionType);
    refmode_t returnType = refmodeOf(functionType->getReturnType());
    size_t nParameters = functionType->getFunctionNumParams();

    // Record function type entity
    writeFact(pred::func_type::id, signature);

    // TODO: which predicate/entity do we need to update for varagrs?
    if (functionType->isVarArg())
        writeFact(pred::func_type::varargs, signature);

    // Record return type
    writeFact(pred::func_type::return_type, signature, returnType);

    // Record function formal parameters
    for (size_t i = 0; i < nParameters; i++)
    {
        refmode_t paramType = refmodeOf(functionType->getFunctionParamType(i));

        writeFact(pred::func_type::param_type, signature, paramType, i);
    }

    // Record number of formal parameters
    writeFact(pred::func_type::nparams, signature, nParameters);
}


void InstructionVisitor::visitVectorType(const VectorType *vectorType)
{
    refmode_t tref = refmodeOf(vectorType);
    size_t nElements = vectorType->getVectorNumElements();
    Type *componentType = vectorType->getVectorElementType();

    // Record vector type entity
    writeFact(pred::vector_type::id, tref);

    // Record vector component type
    refmode_t compref = refmodeOf(componentType);
    writeFact(pred::vector_type::component_type, tref, compref);

    // Record vector type size
    writeFact(pred::vector_type::size, tref, nElements);
}


void CsvGenerator::initStreams()
{
    using namespace predicates;

    std::vector<const char *> all_predicates;

    for (pred_t *pred : predicates::predicates())
    {
        operand_pred_t *operand_pred = dynamic_cast< operand_pred_t*>(pred);

        if (operand_pred) {
            pred_t cpred = operand_pred->asConstant();
            pred_t vpred = operand_pred->asVariable();

            all_predicates.push_back(cpred.c_str());
            all_predicates.push_back(vpred.c_str());
        }
        else {
            all_predicates.push_back(pred->c_str());
        }
    }

    writer.init_streams(all_predicates);

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}
