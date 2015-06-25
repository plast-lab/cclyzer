#include <cassert>
#include <string>
#include <boost/foreach.hpp>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>

#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "predicate_groups.hpp"

#define foreach BOOST_FOREACH

using namespace llvm;
using namespace std;
using namespace boost;
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
                << ':' << gen.refmodeOf(c, Mod);

        // Record constant value
        gen.recordConstant(refmode.str(), type);
    }
    else {
        // Compute refmode for variable value
        refmode << instrId << gen.refmodeOf(Val, Mod);

        // Record variable value
        gen.recordVariable(refmode.str(), type);
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
                << ':' << gen.refmodeOf(c, Mod);

        // Record constant operand
        predname = predicate.asConstant().c_str();
        gen.recordConstant(refmode.str(), type);
    }
    else {
        refmode << instrId << gen.refmodeOf(Operand, Mod);

        // Record variable operand
        predname = predicate.asVariable().c_str();
        gen.recordVariable(refmode.str(), type);
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
        gen.writeFact(pred::ret::instr_void, iref);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI)
{
    refmode_t iref = recordInstruction(pred::br::instr);

    if (BI.isConditional()) {    // conditional branch
        // br i1 <cond>, label <iftrue>, label <iffalse>
        gen.writeFact(pred::br::instr_cond, iref);

        // Condition Operand
        writeInstrOperand(pred::br::condition, iref, BI.getCondition());

        // 'iftrue' and 'iffalse' labels
        writeInstrOperand(pred::br::cond_iftrue, iref, BI.getOperand(1));
        writeInstrOperand(pred::br::cond_iffalse, iref, BI.getOperand(2));
    }
    else {                      // unconditional branch
        // br label <dest>
        gen.writeFact(pred::br::instr_uncond, iref);
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

    gen.writeFact(pred::switch_::ncases, iref, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR)
{
    // indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    refmode_t iref = recordInstruction(pred::indirectbr::instr);

    // 'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i)
        writeInstrOperand(pred::indirectbr::label, iref, IBR.getOperand(i), i-1);

    gen.writeFact(pred::indirectbr::nlabels, iref, IBR.getNumOperands() - 1);
    writeInstrOperand(pred::indirectbr::address, iref, IBR.getOperand(0));
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II)
{
    refmode_t iref = recordInstruction(pred::invoke::instr);

    gen.writeFact(II.getCalledFunction()
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
        gen.writeFact(pred::invoke::ret_attr, iref, attrs);
    }

    writeFnAttributes(pred::invoke::fn_attr, iref, Attrs);

    // TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        refmode_t cconv = gen.refmodeOf(II.getCallingConv());
        gen.writeFact(pred::invoke::calling_conv, iref, cconv);
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

    gen.writeFact(pred::alloca::type, iref, gen.refmodeOf(AI.getAllocatedType()));

    if(AI.isArrayAllocation())
        writeInstrOperand(pred::alloca::size, iref, AI.getArraySize());

    if(AI.getAlignment())
        gen.writeFact(pred::alloca::alignment, iref, AI.getAlignment());
}

void InstructionVisitor::visitLoadInst(LoadInst &LI)
{
    refmode_t iref = recordInstruction(pred::load::instr);

    writeInstrOperand(pred::load::address, iref, LI.getPointerOperand());

    if (LI.isAtomic()) {
        const char *ord = writeAtomicInfo(iref, LI.getOrdering(), LI.getSynchScope());

        if (strlen(ord))
            gen.writeFact(pred::load::ordering, iref, ord);
    }

    if (LI.getAlignment())
        gen.writeFact(pred::load::alignment, iref, LI.getAlignment());

    if (LI.isVolatile())
        gen.writeFact(pred::load::isvolatile, iref);
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI)
{
    refmode_t iref = recordInstruction(pred::va_arg::instr);

    gen.writeFact(pred::va_arg::type, iref, gen.refmodeOf(VI.getType()));
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
        gen.writeFact(pred::extract_value::index, iref, *i, index);
        index++;
    }

    gen.writeFact(pred::extract_value::nindices, iref, EVI.getNumIndices());
}

void InstructionVisitor::visitStoreInst(StoreInst &SI)
{
    refmode_t iref = recordInstruction(pred::store::instr);

    writeInstrOperand(pred::store::value, iref, SI.getValueOperand());
    writeInstrOperand(pred::store::address, iref, SI.getPointerOperand());

    if (SI.isAtomic()) {
        const char *ord = writeAtomicInfo(iref, SI.getOrdering(), SI.getSynchScope());

        if(strlen(ord))
            gen.writeFact(pred::store::ordering, iref, ord);
    }

    if (SI.getAlignment())
        gen.writeFact(pred::store::alignment, iref, SI.getAlignment());

    if (SI.isVolatile())
        gen.writeFact(pred::store::isvolatile, iref);
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI)
{
    refmode_t iref = recordInstruction(pred::cmpxchg::instr);

    writeInstrOperand(pred::cmpxchg::address, iref, AXI.getPointerOperand());
    writeInstrOperand(pred::cmpxchg::cmp, iref, AXI.getCompareOperand());
    writeInstrOperand(pred::cmpxchg::new_, iref, AXI.getNewValOperand());

    if (AXI.isVolatile())
        gen.writeFact(pred::cmpxchg::isvolatile, iref);

    const char *ord = writeAtomicInfo(iref, AXI.getOrdering(), AXI.getSynchScope());

    if (strlen(ord))
        gen.writeFact(pred::cmpxchg::ordering, iref, ord);

    // TODO: type?
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI)
{
    refmode_t iref = recordInstruction(pred::atomicrmw::instr);

    writeInstrOperand(pred::atomicrmw::address, iref, AWI.getPointerOperand());
    writeInstrOperand(pred::atomicrmw::value, iref, AWI.getValOperand());

    if (AWI.isVolatile())
        gen.writeFact(pred::atomicrmw::isvolatile, iref);

    writeAtomicRMWOp(iref, AWI.getOperation());

    const char *ord = writeAtomicInfo(iref, AWI.getOrdering(), AWI.getSynchScope());

    if (strlen(ord))
        gen.writeFact(pred::atomicrmw::ordering, iref, ord);
}

void InstructionVisitor::visitFenceInst(FenceInst &FI)
{
    refmode_t iref = recordInstruction(pred::fence::instr);

    // fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(iref, FI.getOrdering(), FI.getSynchScope());

    if (strlen(ord))
        gen.writeFact(pred::fence::ordering, iref, ord);
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
                     << ':' << gen.refmodeOf(c, Mod);

            // Compute integer string representation
            string int_value = c->getUniqueInteger().toString(10, true);

            // Write constant to integer fact
            gen.writeFact(pred::constant::to_integer, constant.str(), int_value);
        }
    }

    gen.writeFact(pred::gep::nindices, iref, GEP.getNumIndices());

    if (GEP.isInBounds())
        gen.writeFact(pred::gep::inbounds, iref);
}

void InstructionVisitor::visitPHINode(PHINode &PHI)
{
    // <result> = phi <ty> [ <val0>, <label0>], ...
    refmode_t iref = recordInstruction(pred::phi::instr);

    // type
    gen.writeFact(pred::phi::type, iref, gen.refmodeOf(PHI.getType()));

    for (unsigned op = 0; op < PHI.getNumIncomingValues(); ++op)
    {
        writeInstrOperand(pred::phi::pair_value, iref, PHI.getIncomingValue(op), op);
        writeInstrOperand(pred::phi::pair_label, iref, PHI.getIncomingBlock(op), op);
    }

    gen.writeFact(pred::phi::npairs, iref, PHI.getNumIncomingValues());
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
        gen.writeFact(pred::insert_value::index, iref, *i, index);
    }

    gen.writeFact(pred::insert_value::nindices, iref, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI)
{
    refmode_t iref = recordInstruction(pred::landingpad::instr);

    gen.writeFact(pred::landingpad::type, iref, gen.refmodeOf(LI.getType()));
    writeInstrOperand(pred::landingpad::fn, iref, LI.getPersonalityFn());

    // cleanup
    if (LI.isCleanup())
        gen.writeFact(pred::landingpad::cleanup, iref);

    // #clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i)
    {
        const pred_t &pred_clause = LI.isCatch(i)
            ? pred::landingpad::catch_clause
            : pred::landingpad::filter_clause;

        gen.writeFact(pred_clause, iref, LI.getClause(i), i);
    }

    gen.writeFact(pred::landingpad::nclauses, iref, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI)
{
    refmode_t iref = recordInstruction(pred::call::instr);

    gen.writeFact(CI.getCalledFunction()
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
        gen.writeFact(pred::call::tail, iref);

    if (CI.getCallingConv() != CallingConv::C) {
        refmode_t cconv = gen.refmodeOf(CI.getCallingConv());
        gen.writeFact(pred::call::calling_conv, iref, cconv);
    }

    // Attributes
    const AttributeSet &Attrs = CI.getAttributes();

    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        string attrs = Attrs.getAsString(AttributeSet::ReturnIndex);
        gen.writeFact(pred::call::ret_attr, iref, attrs);
    }

    writeFnAttributes(pred::call::fn_attr, iref, Attrs);

    // TODO: parameter attributes?
}

void InstructionVisitor::visitICmpInst(ICmpInst &I)
{
    refmode_t iref = recordInstruction(pred::icmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        gen.writeFact(pred::icmp::condition, iref, writePredicate(I.getPredicate()));

    // Operands
    writeInstrOperand(pred::icmp::first_operand, iref, I.getOperand(0));
    writeInstrOperand(pred::icmp::second_operand, iref, I.getOperand(1));
}

void InstructionVisitor::visitFCmpInst(FCmpInst &I)
{
    refmode_t iref = recordInstruction(pred::fcmp::instr);

    // Condition
    if (strlen(writePredicate(I.getPredicate())))
        gen.writeFact(pred::fcmp::condition, iref, writePredicate(I.getPredicate()));

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
            gen.writeFact(pred::instruction::flag, instrId, "fast");
        }
        else {
            if(fpo->hasNoNaNs()) {
                gen.writeFact(pred::instruction::flag, instrId, "nnan");
            }
            if(fpo->hasNoInfs()) {
                gen.writeFact(pred::instruction::flag, instrId, "ninf");
            }
            if(fpo->hasNoSignedZeros()) {
                gen.writeFact(pred::instruction::flag, instrId, "nsz");
            }
            if(fpo->hasAllowReciprocal()) {
                gen.writeFact(pred::instruction::flag, instrId, "arcp");
            }
        }
    }
    if (const OverflowingBinaryOperator *obo = dyn_cast<OverflowingBinaryOperator>(u)) {
        if(obo->hasNoUnsignedWrap()) {
            gen.writeFact(pred::instruction::flag, instrId, "nuw");
        }
        if(obo->hasNoSignedWrap()) {
            gen.writeFact(pred::instruction::flag, instrId, "nsw");
        }
    }
    else if (const PossiblyExactOperator *div = dyn_cast<PossiblyExactOperator>(u)) {
        if(div->isExact()) {
            gen.writeFact(pred::instruction::flag, instrId, "exact");
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
        gen.writeFact(pred::instruction::flag, instrId, "singlethread");

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
        gen.writeFact(pred::atomicrmw::operation, instrId, oper);
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
    gen.writeFact(pred::alias::id, refmode);

    // Serialize alias properties
    refmode_t visibility = gen.refmodeOf(ga->getVisibility());
    refmode_t linkage    = gen.refmodeOf(ga->getLinkage());
    refmode_t aliasType  = gen.refmodeOf(ga->getType());

    // Record visibility
    if (!visibility.empty())
        gen.writeFact(pred::alias::visibility, refmode, visibility);

    // Record linkage
    if (!linkage.empty())
        gen.writeFact(pred::alias::linkage, refmode, linkage);

    // Record type
    gen.writeFact(pred::alias::type, refmode, aliasType);

    // Record aliasee
    if (Aliasee) {
        refmode_t aliasee = gen.refmodeOf(Aliasee, ga->getParent());
        gen.writeFact(pred::alias::aliasee, refmode, aliasee);
    }
}


void InstructionVisitor::visitGlobalVar(const GlobalVariable *gv, const string &refmode)
{
    // Record global variable entity
    gen.writeFact(pred::global_var::id, refmode);

    // Serialize global variable properties
    refmode_t visibility = gen.refmodeOf(gv->getVisibility());
    refmode_t linkage    = gen.refmodeOf(gv->getLinkage());
    refmode_t varType    = gen.refmodeOf(gv->getType()->getElementType());
    refmode_t thrLocMode = gen.refmodeOf(gv->getThreadLocalMode());

    // Record external linkage
    if (!gv->hasInitializer() && gv->hasExternalLinkage())
        gen.writeFact(pred::global_var::linkage, refmode, "external");

    // Record linkage
    if (!linkage.empty())
        gen.writeFact(pred::global_var::linkage, refmode, linkage);

    // Record visibility
    if (!visibility.empty())
        gen.writeFact(pred::global_var::visibility, refmode, visibility);

    // Record thread local mode
    if (!thrLocMode.empty())
        gen.writeFact(pred::global_var::threadlocal_mode, refmode, thrLocMode);

    // TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized())
        gen.writeFact(pred::global_var::flag, refmode, "externally_initialized");

    // Record flags and type
    const char * flag = gv->isConstant() ? "constant": "global";

    gen.writeFact(pred::global_var::flag, refmode, flag);
    gen.writeFact(pred::global_var::type, refmode, varType);

    // Record initializer
    if (gv->hasInitializer()) {
        refmode_t val = gen.refmodeOf(gv->getInitializer(), gv->getParent()); // CHECK
        gen.writeFact(pred::global_var::initializer, refmode, val);
    }

    // Record section
    if (gv->hasSection())
        gen.writeFact(pred::global_var::section, refmode, gv->getSection());

    // Record alignment
    if (gv->getAlignment())
        gen.writeFact(pred::global_var::align, refmode, gv->getAlignment());
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

void InstructionVisitor::writeFnAttributes(
    const pred_t &predicate,
    const refmode_t &refmode,
    const AttributeSet Attrs)
{
    AttributeSet AS;

    if (Attrs.hasAttributes(AttributeSet::FunctionIndex))
        AS = Attrs.getFnAttributes();

    unsigned idx = 0;

    for (unsigned e = AS.getNumSlots(); idx != e; ++idx) {
        if (AS.getSlotIndex(idx) == AttributeSet::FunctionIndex)
            break;
    }

    for (AttributeSet::iterator I = AS.begin(idx), E = AS.end(idx); I != E; ++I)
    {
        Attribute Attr = *I;

        if (!Attr.isStringAttribute()) {
            string AttrStr = Attr.getAsString();
            gen.writeFact(predicate, refmode, Attr.getAsString());
        }
    }
}
