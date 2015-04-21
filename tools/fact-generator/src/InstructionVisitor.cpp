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

//REVIEW: Do we need two predicate names for both left and right operand? Can't we just infer these names
//from BinOps' one
void InstructionVisitor::logBinaryOperator(BinaryOperator &BI, const char * predName, 
                                           const char * predNameLeftOp, const char * predNameRightOp){

    writeOptimizationInfoToFile(&BI, instrNum);
    csvGen->writeEntity(predName, instrNum);

    //Left Operand
    logOperand(BI.getOperand(0), predNameLeftOp);

    //Right Operand
    logOperand(BI.getOperand(1), predNameRightOp);
}

void InstructionVisitor::visitAdd(BinaryOperator &BI) {
    logBinaryOperator(BI, addInsn, addInsnFirstOp, addInsnSecondOp);
}

void InstructionVisitor::visitFAdd(BinaryOperator &BI) {
    logBinaryOperator(BI, faddInsn, faddInsnFirstOp, faddInsnSecondOp);
}

void InstructionVisitor::visitSub(BinaryOperator &BI) {
    logBinaryOperator(BI, subInsn, subInsnFirstOp, subInsnSecondOp);
}

void InstructionVisitor::visitFSub(BinaryOperator &BI) {
    logBinaryOperator(BI, fsubInsn, fsubInsnFirstOp, fsubInsnSecondOp);
}

void InstructionVisitor::visitMul(BinaryOperator &BI) {
    logBinaryOperator(BI, mulInsn, mulInsnFirstOp, mulInsnSecondOp);
}

void InstructionVisitor::visitFMul(BinaryOperator &BI) {
    logBinaryOperator(BI, fmulInsn, fmulInsnFirstOp, fmulInsnSecondOp);
}

void InstructionVisitor::visitSDiv(BinaryOperator &BI) {
    logBinaryOperator(BI, sdivInsn, sdivInsnFirstOp, sdivInsnSecondOp);
}

void InstructionVisitor::visitFDiv(BinaryOperator &BI) {
    logBinaryOperator(BI, fdivInsn, fdivInsnFirstOp, fdivInsnSecondOp);
}

void InstructionVisitor::visitUDiv(BinaryOperator &BI) {
    logBinaryOperator(BI, udivInsn, udivInsnFirstOp, udivInsnSecondOp);
}

void InstructionVisitor::visitSRem(BinaryOperator &BI) {
    logBinaryOperator(BI, sremInsn, sremInsnFirstOp, sremInsnSecondOp);
}

void InstructionVisitor::visitFRem(BinaryOperator &BI) {
    logBinaryOperator(BI, fremInsn, fremInsnFirstOp, fremInsnSecondOp);
}

void InstructionVisitor::visitURem(BinaryOperator &BI) {
    logBinaryOperator(BI, uremInsn, uremInsnFirstOp, uremInsnSecondOp);
}

void InstructionVisitor::visitShl(BinaryOperator &BI) {
    logBinaryOperator(BI, shlInsn, shlInsnFirstOp, shlInsnSecondOp);
}

void InstructionVisitor::visitLShr(BinaryOperator &BI) {
    logBinaryOperator(BI, lshrInsn, lshrInsnFirstOp, lshrInsnSecondOp);
}

void InstructionVisitor::visitAShr(BinaryOperator &BI) {
    logBinaryOperator(BI, ashrInsn, ashrInsnFirstOp, ashrInsnSecondOp);
}

void InstructionVisitor::visitAnd(BinaryOperator &BI) {
    logBinaryOperator(BI, andInsn, andInsnFirstOp, andInsnSecondOp);
}

void InstructionVisitor::visitOr(BinaryOperator &BI) {
    logBinaryOperator(BI, orInsn, orInsnFirstOp, orInsnSecondOp);
}

void InstructionVisitor::visitXor(BinaryOperator &BI) {
    logBinaryOperator(BI, xorInsn, xorInsnFirstOp, xorInsnSecondOp);
}

void InstructionVisitor::visitReturnInst(ReturnInst &RI) {

    csvGen->writeEntity(retInsn, instrNum);
    // ret <type> <value>
    if(RI.getReturnValue()) {
        logOperand(RI.getReturnValue(), retInsnOp);
    }
    // ret void
    else {
        csvGen->writeEntity(retInsnVoid, instrNum);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI) {

    string error;

    csvGen->writeEntity(brInsn, instrNum);
    // br i1 <cond>, label <iftrue>, label <iffalse>
    if(BI.isConditional()) {
        csvGen->writeEntity(brCondInsn, instrNum);
        // Condition Operand
        logOperand(BI.getCondition(), brCondInsnCondition);

        // 'iftrue' label
        logSimpleValue(BI.getOperand(1), brCondInsnIfTrue);

        // 'iffalse' label
        logSimpleValue(BI.getOperand(2), brCondInsnIfFalse);
    }
    else {
        //br label <dest>
        csvGen->writeEntity(brUncondInsn, instrNum);
        logSimpleValue(BI.getOperand(0), brUncondInsnDest);
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI) {

    //switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    csvGen->writeEntity(switchInsn, instrNum);
    //'value' Operand
    logOperand(SI.getOperand(0), switchInsnOp);

    //'defaultdest' label
    logSimpleValue(SI.getOperand(1), switchInsnDefLabel);

    //'case list' [constant, label]
    int index = 0;
    for(SwitchInst::ConstCaseIt Case = SI.case_begin(), CasesEnd = SI.case_end(); Case != CasesEnd; Case++){
        logSimpleValue(Case.getCaseValue(), switchInsnCaseVal, index);

        logSimpleValue(Case.getCaseSuccessor(), switchInsnCaseLabel, index++);
    }
    csvGen->writeSimpleFact(switchInsnNCases, instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR) {

    //indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    csvGen->writeEntity(indirectbrInsn, instrNum);
    //'address' Operand
    logOperand(IBR.getOperand(0), indirectbrInsnAddr);

    //'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i) {
        logSimpleValue(IBR.getOperand(i), indirectbrInsnLabel, i-1);
    }
    csvGen->writeSimpleFact(indirectbrInsnNLabels, instrNum, IBR.getNumOperands()-1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II) {

    csvGen->writeEntity(invokeInsn, instrNum);
    Value *invokeOp = II.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

    logOperand(II.getCalledValue(), invokeInsnFunc);

    if(II.getCalledFunction()) {
        csvGen->writeEntity(directInvokeInsn, instrNum);
    }
    else {
        csvGen->writeEntity(indirectInvokeInsn, instrNum);
    }
    //actual args
    for(unsigned op = 0; op < II.getNumArgOperands(); ++op)
        logOperand(II.getArgOperand(op), invokeInsnArg, op);

    //'normal label'
    logSimpleValue(II.getNormalDest(), invokeInsnNormalLabel);

    //'exception label'
    logSimpleValue(II.getUnwindDest(), invokeInsnExceptLabel);

    //Function Attributes
    const AttributeSet &Attrs = II.getAttributes();
    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        csvGen->writeSimpleFact(invokeInsnRetAttr, instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
    }
    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);
    for(int i = 0; i < FuncnAttr.size(); ++i) {
        csvGen->writeSimpleFact(invokeInsnFuncAttr, instrNum, FuncnAttr[i]);
    }
    //TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        csvGen->writeSimpleFact(invokeInsnCallConv, instrNum, writeCallingConv(II.getCallingConv()));
    }
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI) {

    csvGen->writeEntity(resumeInsn, instrNum);
    logOperand(RI.getValue(), resumeInsnOp);
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    csvGen->writeEntity(unreachableInsn, instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI) {

    csvGen->writeEntity(allocaInsn, instrNum);
    csvGen->writeSimpleFact(allocaInsnType, instrNum, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation()) {
        logOperand(AI.getArraySize(), allocaInsnSize);
    }
    if(AI.getAlignment()) {
        csvGen->writeSimpleFact(allocaInsnAlign, instrNum, AI.getAlignment());
    }
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    csvGen->writeEntity(loadInsn, instrNum);
    logOperand(LI.getPointerOperand(), loadInsnAddr);

    if(LI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());
        if(strlen(ord)) {
            csvGen->writeSimpleFact(loadInsnOrd, instrNum, ord);
        }
    }
    if(LI.getAlignment()) {
        csvGen->writeSimpleFact(loadInsnAlign, instrNum, LI.getAlignment());
    }
    if(LI.isVolatile()) {
        csvGen->writeEntity(loadInsnVolatile, instrNum);
    }
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI) {

    csvGen->writeEntity(vaargInsn, instrNum);
    logOperand(VI.getPointerOperand(), vaargInsnList);

    csvGen->writeSimpleFact(vaargInsnType, instrNum, printType(VI.getType()));
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI) {

    csvGen->writeEntity(extractValueInsn, instrNum);
    //Aggregate Operand
    logOperand(EVI.getOperand(0), extractValueInsnBase);

    //Constant Indices
    int index = 0;
    for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
        csvGen->writeSimpleFact(extractValueInsnIndex, instrNum, *i, index);
        index++;
    }
    csvGen->writeSimpleFact(extractValueInsnNIndices, instrNum, EVI.getNumIndices());
}

void InstructionVisitor::visitTruncInst(TruncInst &I) {

    csvGen->writeEntity(truncInsn, instrNum);
    logOperand(I.getOperand(0), truncInsnFrom);

    csvGen->writeSimpleFact(truncInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitZExtInst(ZExtInst &I) {

    csvGen->writeEntity(zextInsn, instrNum);
    logOperand(I.getOperand(0), zextInsnFrom);

    csvGen->writeSimpleFact(zextInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitSExtInst(SExtInst &I) {

    csvGen->writeEntity(sextInsn, instrNum);
    logOperand(I.getOperand(0), sextInsnFrom);

    csvGen->writeSimpleFact(sextInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPTruncInst(FPTruncInst &I) {

    csvGen->writeEntity(fptruncInsn, instrNum);
    logOperand(I.getOperand(0), fptruncInsnFrom);

    csvGen->writeSimpleFact(fptruncInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPExtInst(FPExtInst &I) {

    csvGen->writeEntity(fpextInsn, instrNum);
    logOperand(I.getOperand(0), fpextInsnFrom);

    csvGen->writeSimpleFact(fpextInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPToUIInst(FPToUIInst &I) {

    csvGen->writeEntity(fptouiInsn, instrNum);
    logOperand(I.getOperand(0), fptouiInsnFrom);

    csvGen->writeSimpleFact(fptouiInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPToSIInst(FPToSIInst &I) {

    csvGen->writeEntity(fptosiInsn, instrNum);
    logOperand(I.getOperand(0), fptosiInsnFrom);

    csvGen->writeSimpleFact(fptosiInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitUIToFPInst(UIToFPInst &I) {

    csvGen->writeEntity(uitofpInsn, instrNum);
    logOperand(I.getOperand(0), uitofpInsnFrom);

    csvGen->writeSimpleFact(uitofpInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitSIToFPInst(SIToFPInst &I) {

    csvGen->writeEntity(sitofpInsn, instrNum);
    logOperand(I.getOperand(0), sitofpInsnFrom);

    csvGen->writeSimpleFact(sitofpInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitPtrToIntInst(PtrToIntInst &I) {

    csvGen->writeEntity(ptrtointInsn, instrNum);
    logOperand(I.getOperand(0), ptrtointInsnFrom);

    csvGen->writeSimpleFact(ptrtointInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitIntToPtrInst(IntToPtrInst &I) {

    csvGen->writeEntity(inttoptrInsn, instrNum);
    logOperand(I.getOperand(0), inttoptrInsnFrom);

    csvGen->writeSimpleFact(inttoptrInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitBitCastInst(BitCastInst &I) {

    csvGen->writeEntity(bitcastInsn, instrNum);
    logOperand(I.getOperand(0), bitcastInsnFrom);

    csvGen->writeSimpleFact(bitcastInsnToType, instrNum, printType(I.getType()));
}

void InstructionVisitor::visitStoreInst(StoreInst &SI) {

    csvGen->writeEntity(storeInsn, instrNum);
    logOperand(SI.getValueOperand(), storeInsnValue);

    logOperand(SI.getPointerOperand(), storeInsnAddr);

    if(SI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());
        if(strlen(ord)) {
            csvGen->writeSimpleFact(storeInsnOrd, instrNum, ord);
        }
    }
    if(SI.getAlignment()) {
        csvGen->writeSimpleFact(storeInsnAlign, instrNum, SI.getAlignment());
    }
    if(SI.isVolatile()) {
        csvGen->writeEntity(storeInsnVolatile, instrNum);
    }
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI) {

    csvGen->writeEntity(cmpxchgInsn, instrNum);
    //ptrValue
    logOperand(AXI.getPointerOperand(), cmpxchgInsnAddr);

    //cmpValue
    logOperand(AXI.getCompareOperand(), cmpxchgInsnCmp);

    //newValue
    logOperand(AXI.getNewValOperand(), cmpxchgInsnNew);

    if(AXI.isVolatile()) {
        csvGen->writeEntity(cmpxchgInsn, instrNum);
    }

    const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());
    if(strlen(ord)) {
        csvGen->writeSimpleFact(cmpxchgInsnOrd, instrNum, ord);
    }
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI) {

    csvGen->writeEntity(atomicRMWInsn, instrNum);
    //ptrValue - LeftOperand
    logOperand(AWI.getPointerOperand(), atomicRMWInsnAddr);

    //valOperand - Right Operand
    logOperand(AWI.getValOperand(), atomicRMWInsnValue);

    if(AWI.isVolatile()) {
        csvGen->writeEntity(atomicRMWInsnVolatile, instrNum);
    }

    writeAtomicRMWOp(instrNum, AWI.getOperation());
    const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());
    if(strlen(ord)) {
        csvGen->writeSimpleFact(atomicRMWInsnOrd, instrNum, ord);
    }
}

void InstructionVisitor::visitFenceInst(FenceInst &FI) {

    csvGen->writeEntity(fenceInsn, instrNum);
    //fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());
    if(strlen(ord)) {
        csvGen->writeSimpleFact(fenceInsnOrd, instrNum, ord);
    }
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP) {

    csvGen->writeEntity(gepInsn, instrNum);
    logOperand(GEP.getPointerOperand(), gepInsnBase);

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index) {
        int immOffset = immediateOffset;
        const Value * GepOperand = GEP.getOperand(index);
        logOperand(GepOperand, gepInsnIndex, index-1);
        if(const Constant *c = dyn_cast<Constant>(GepOperand)) {
            stringstream immStr;
            immStr << immOffset;
            varId = instrNum + ":" + immStr.str() + ":" + valueToString(c, Mod);
            csvGen->writeSimpleFact(constToInt, varId, c->getUniqueInteger().toString(10,true));
        }
    }
    csvGen->writeSimpleFact(gepInsnNIndices, instrNum, GEP.getNumIndices());
    if(GEP.isInBounds()) {
        csvGen->writeEntity(gepInsnInbounds, instrNum);
    }
}

void InstructionVisitor::visitPHINode(PHINode &PHI) {

    // <result> = phi <ty> [ <val0>, <label0>], ...
    csvGen->writeEntity(phiInsn, instrNum);
    // type
    csvGen->writeSimpleFact(phiInsnType, instrNum, printType(PHI.getType()));
    for(int op = 0; op < PHI.getNumIncomingValues(); ++op) {
        logOperand(PHI.getIncomingValue(op), phiInsnPairValue, op);

        //<label>
        logSimpleValue(PHI.getIncomingBlock(op), phiInsnPairLabel, op);
    }
    csvGen->writeSimpleFact(phiInsnNPairs, instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI) {

    csvGen->writeEntity(selectInsn, instrNum);
    //Condition
    logOperand(SI.getOperand(0), selectInsnCond);

    //Left Operand (true value)
    logOperand(SI.getOperand(1), selectInsnFirstOp);

    //Right Operand (false value)
    logOperand(SI.getOperand(2), selectInsnSecondOp);
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI) {

    csvGen->writeEntity(insertValueInsn, instrNum);
    //Left Operand
    logOperand(IVI.getOperand(0), insertValueInsnBase);

    //Right Operand
    logOperand(IVI.getOperand(1), insertValueInsnValue);

    //Constant Indices
    int index = 0;
    for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end(); i != e; ++i,index++) {
        csvGen->writeSimpleFact(insertValueInsnIndex, instrNum, *i, index);
    }
    csvGen->writeSimpleFact(insertValueInsnNIndices, instrNum, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI) {

    csvGen->writeEntity(landingpadInsn, instrNum);
    // type
    csvGen->writeSimpleFact(landingpadInsnType, instrNum, printType(LI.getType()));

    // function
    logSimpleValue(LI.getPersonalityFn(), landingpadInsnFunc);

    //cleanup
    if(LI.isCleanup()) {
        csvGen->writeEntity(landingpadInsnCleanup, instrNum);
    }
    //#clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i) {
        //catch clause
        if(LI.isCatch(i))
            csvGen->writeSimpleFact(landingpadInsnCatch, instrNum, LI.getClause(i), i);
        else
            csvGen->writeSimpleFact(landingpadInsnFilter, instrNum, LI.getClause(i), i);
    }
    csvGen->writeSimpleFact(landingpadInsnNClauses, instrNum, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI) {

    csvGen->writeEntity(callInsn, instrNum);
    Value *callOp = CI.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(callOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
    Type *RetTy = funcTy->getReturnType();

    logOperand(callOp, callInsnFunction);

    if(CI.getCalledFunction()) {
        csvGen->writeEntity(directCallInsn, instrNum);
    }
    else {
        csvGen->writeEntity(indirectCallInsn, instrNum);
    }

    for(unsigned op = 0; op < CI.getNumArgOperands(); ++op)
        logOperand(CI.getArgOperand(op), callInsnArg, op);

    if(CI.isTailCall()) {
        csvGen->writeEntity(callInsnTail, instrNum);
    }
    if (CI.getCallingConv() != CallingConv::C) {
        csvGen->writeSimpleFact(callCallConv, instrNum, writeCallingConv(CI.getCallingConv()));
    }
    const AttributeSet &Attrs = CI.getAttributes();
    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        csvGen->writeSimpleFact(callInsnRetAttr, instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
    }
    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);
    for(int i = 0; i < FuncnAttr.size(); ++i) {
        csvGen->writeSimpleFact(callInsnFuncAttr, instrNum, FuncnAttr[i]);
    }
}

void InstructionVisitor::visitICmpInst(ICmpInst &I) {

    csvGen->writeEntity(icmpInsn, instrNum);

    //Condition
    if(strlen(writePredicate(I.getPredicate()))) {
        csvGen->writeSimpleFact(icmpInsnCond, instrNum, writePredicate(I.getPredicate()));
    }
    //Left Operand
    logOperand(I.getOperand(0), icmpInsnFirstOp);

    //Right Operand
    logOperand(I.getOperand(1), icmpInsnSecondOp);

}

void InstructionVisitor::visitFCmpInst(FCmpInst &I) {

    csvGen->writeEntity(fcmpInsn, instrNum);

    //Condition
    if(strlen(writePredicate(I.getPredicate()))) {
        csvGen->writeSimpleFact(fcmpInsnCond, instrNum, writePredicate(I.getPredicate()));
    }
    //Left Operand
    logOperand(I.getOperand(0), fcmpInsnFirstOp);

    //Right Operand
    logOperand(I.getOperand(1), fcmpInsnSecondOp);

}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI) {

    csvGen->writeEntity(extractElemInsn, instrNum);
    //VectorOperand
    logOperand(EEI.getVectorOperand(), extractElemInsnBase);

    //indexValue
    logOperand(EEI.getIndexOperand(), extractElemInsnIndex);

}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI) {

    csvGen->writeEntity(insertElemInsn, instrNum);
    //vectorOperand
    logOperand(IEI.getOperand(0), insertElemInsnBase);

    //Value Operand
    logOperand(IEI.getOperand(1), insertElemInsnValue);

    //Index Operand
    logOperand(IEI.getOperand(2), insertElemInsnIndex);

}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI) {

    csvGen->writeEntity(shuffleVectorInsn, instrNum);
    //firstVector
    logOperand(SVI.getOperand(0), shuffleVectorInsnFirstVec);

    //secondVector
    logOperand(SVI.getOperand(1), shuffleVectorInsnSecondVec);

    //Mask
    logSimpleValue(SVI.getOperand(2), shuffleVectorInsnMask);

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
            csvGen->writeSimpleFact(insnFlag, instrId, "fast");
        }
        else {
            if(fpo->hasNoNaNs()) {
                csvGen->writeSimpleFact(insnFlag, instrId, "nnan");
            }
            if(fpo->hasNoInfs()) {
                csvGen->writeSimpleFact(insnFlag, instrId, "ninf");
            }
            if(fpo->hasNoSignedZeros()) {
                csvGen->writeSimpleFact(insnFlag, instrId, "nsz");
            }
            if(fpo->hasAllowReciprocal()) {
                csvGen->writeSimpleFact(insnFlag, instrId, "arcp");
            }
        }
    }
    if (const OverflowingBinaryOperator *obo = dyn_cast<OverflowingBinaryOperator>(u)) {
        if(obo->hasNoUnsignedWrap()) {
            csvGen->writeSimpleFact(insnFlag, instrId, "nuw");
        }
        if(obo->hasNoSignedWrap()) {
            csvGen->writeSimpleFact(insnFlag, instrId, "nsw");
        }
    }
    else if (const PossiblyExactOperator *div = dyn_cast<PossiblyExactOperator>(u)) {
        if(div->isExact()) {
            csvGen->writeSimpleFact(insnFlag, instrId, "exact");
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
    //default synchScope: crossthread
    if(synchScope == SingleThread) {
        csvGen->writeSimpleFact(insnFlag, instrId, "singlethread");
    }
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
        csvGen->writeSimpleFact(atomicRMWInsnOper, instrId, oper);
}
