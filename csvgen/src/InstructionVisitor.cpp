#include <iostream>
#include <set>
#include <string>

#include "llvm/Assembly/Writer.h"
#include "llvm/IR/Module.h"

#include "functions.h"
#include "InstructionVisitor.h"
#include "PredicateNames.h"

using namespace llvm;
using namespace std;

void InstructionVisitor::logSimpleValue(const Value * Val, const char * predName){
    raw_string_ostream rso(value_str); //TODO: is value_str necessary here?
    const Type * ValType = Val->getType();
    value_str.clear();
    WriteAsOperand(rso, Val, 0, Mod);
    if(const Constant *c = dyn_cast<Constant>(Val)) {
        varId = instrNum + ":" + rso.str();
        immediate[varId] = ValType;
    }
    else {
        varId = instrId + rso.str();
        variable[varId] = ValType;
    }
    printFactsToFile(predNameToFilename(predName).c_str(), "%s\t%s\n", instrNum, varId);
}

void InstructionVisitor::logOperand(const Value * Operand, const char * predName){
    raw_string_ostream rso(value_str); //TODO: is value_str necessary here?
    int operandType; //whether we have a constant or variable operand
    const Type * OpType = Operand->getType();
    value_str.clear();
    WriteAsOperand(rso, Operand, 0, Mod);
    if(const Constant *c = dyn_cast<Constant>(Operand)) {
        operandType = 0;
        varId = instrNum + ":" + rso.str();
        immediate[varId] = OpType;
    }
    else {
        operandType = 1;
        varId = instrId + rso.str();
        variable[varId] = OpType;
    }
    printFactsToFile(predNameWithOperandToFilename(predName, operandType).c_str(), "%s\t%s\n", instrNum, varId);
}

//REVIEW: Do we need two predicate names for both left and right operand? Can't we just infer these names
//from BinOps' one
void InstructionVisitor::logBinaryOperator(BinaryOperator &BI, const char * predName, 
                                           const char * predNameLeftOp, const char * predNameRightOp){

    writeOptimizationInfoToFile(&BI, instrNum);
    printFactsToFile(predNameToFilename(predName).c_str(), "%s\n", instrNum);
    
    //Left Operand
    logOperand(BI.getOperand(0), predNameLeftOp);

    //Right Operand
    logOperand(BI.getOperand(1), predNameRightOp);
}

InstructionVisitor::InstructionVisitor(map<string, const Type *> &var,
                                       map<string, const Type *> &imm, Module *M): variable(var), immediate(imm), Mod(M) {
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

void InstructionVisitor::visitFsub(BinaryOperator &BI) {
    logBinaryOperator(BI, fsubInsn, fsubInsnFirstOp, fsubInsnSecondOp);
}

void InstructionVisitor::visitMul(BinaryOperator &BI) {
    logBinaryOperator(BI, mulInsn, mulInsnFirstOp, mulInsnSecondOp);
}

void InstructionVisitor::visitFMul(BinaryOperator &BI) {
    logBinaryOperator(BI, fmulInsn, fmulInsnFirstOp, fmulInsnSecondOp);
}

void InstructionVisitor::visitSdiv(BinaryOperator &BI) {
    logBinaryOperator(BI, sdivInsn, sdivInsnFirstOp, sdivInsnSecondOp);
}

void InstructionVisitor::visitFdiv(BinaryOperator &BI) {
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

    raw_string_ostream rso(value_str);
    printFactsToFile(predNameToFilename(retInsn).c_str(), "%s\n", instrNum);
    // ret <type> <value>
    if(RI.getReturnValue()) {
        logOperand(RI.getReturnValue(), retInsnOp);
    }
    // ret void
    else {
        printFactsToFile(predNameToFilename(retInsnVoid).c_str(), "%s\n", instrNum);
    }
}

void InstructionVisitor::visitBranchInst(BranchInst &BI) {

    raw_string_ostream rso(value_str);
    string error;

    printFactsToFile(predNameToFilename(brInsn).c_str(), "%s\n", instrNum);
    // br i1 <cond>, label <iftrue>, label <iffalse>
    if(BI.isConditional()) {
        printFactsToFile(predNameToFilename(brCondInsn).c_str(), "%s\n", instrNum);
        // Condition Operand
        logOperand(BI.getCondition(), brCondInsnCondition);

        // 'iftrue' label
        logSimpleValue(BI.getOperand(1), brCondInsnIfTrue);

        // 'iffalse' label
        logSimpleValue(BI.getOperand(2), brCondInsnIfFalse);
    }
    else {
        //br label <dest>
        printFactsToFile(predNameToFilename(brUncondInsn).c_str(), "%s\n", instrNum);
        logSimpleValue(BI.getOperand(0), brUncondInsnDest);
    }
}

void InstructionVisitor::visitSwitchInst(const SwitchInst &SI) {

    raw_string_ostream rso(value_str);

    //switch <intty> <value>, label <defaultdest> [ <intty> <val>, label <dest> ... ]
    printFactsToFile(predNameToFilename(switchInsn).c_str(), "%s\n", instrNum);
    //'value' Operand
    logOperand(SI.getOperand(0), switchInsnOp);

    //'defaultdest' label
    logSimpleValue(SI.getOperand(1), switchInsnDefLabel);
    
    //'case list' [constant, label]
    int index = 0;
    for(SwitchInst::ConstCaseIt Case = SI.case_begin(), CasesEnd = SI.case_end(); Case != CasesEnd; Case++){
        value_str.clear();
        const ConstantInt * CaseVal = Case.getCaseValue();
        WriteAsOperand(rso, CaseVal, 0, Mod);
        varId = instrNum + ":" + rso.str();
        printFactsToFile(predNameToFilename(switchInsnCaseVal).c_str(),
                         "%s\t%d\t%s\n", instrNum, index, varId);
        immediate[varId] = CaseVal->getType();

        value_str.clear();
        const BasicBlock * CaseLabel = Case.getCaseSuccessor();
        WriteAsOperand(rso, CaseLabel, 0, Mod);
        varId = instrId + rso.str();
        printFactsToFile(predNameToFilename(switchInsnCaseLabel).c_str(),
                         "%s\t%d\t%s\n", instrNum, index++, varId);
        variable[varId] = CaseLabel->getType();
    }
    printFactsToFile(predNameToFilename(switchInsnNCases).c_str(),
                     "%s\t%d\n", instrNum, SI.getNumCases());
}

void InstructionVisitor::visitIndirectBrInst(IndirectBrInst &IBR) {

    raw_string_ostream rso(value_str);

    //indirectbr <somety>* <address>, [ label <dest1>, label <dest2>, ... ]
    printFactsToFile(predNameToFilename(indirectbrInsn).c_str(), "%s\n", instrNum);
    //'address' Operand
    logOperand(IBR.getOperand(0), indirectbrInsnAddr);

    //'label' list
    for(unsigned i = 1; i < IBR.getNumOperands(); ++i) {
        value_str.clear();
        WriteAsOperand(rso, IBR.getOperand(i), 0, Mod);
        varId = instrId + rso.str();
        printFactsToFile(predNameToFilename(indirectbrInsnLabel).c_str(),
                         "%s\t%d\t%s\n", instrNum, i-1, varId);
        variable[varId] = IBR.getOperand(i)->getType();
    }
    printFactsToFile(predNameToFilename(indirectbrInsnNLabels).c_str(),
                     "%s\t%d\n", instrNum, IBR.getNumOperands()-1);
}

void InstructionVisitor::visitInvokeInst(InvokeInst &II) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(invokeInsn).c_str(), "%s\n", instrNum);
    Value *invokeOp = II.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(invokeOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());

    logOperand(II.getCalledValue(), invokeInsnFunc);

    if(II.getCalledFunction()) {
        printFactsToFile(predNameToFilename(directInvokeInsn).c_str(), "%s\n", instrNum);
    }
    else {
        printFactsToFile(predNameToFilename(indirectInvokeInsn).c_str(), "%s\n", instrNum);
    }
    //actual args
    for(unsigned op = 0; op < II.getNumArgOperands(); ++op) {
        int operandType;
        value_str.clear();
        WriteAsOperand(rso, II.getArgOperand(op), 0, Mod);
        const Type * ArgType = II.getArgOperand(op)->getType();
        if(Constant *c = dyn_cast<Constant>(II.getArgOperand(op))) {
            varId = instrNum + ":" + rso.str();
            immediate[varId] = ArgType;
        }
        else {
            varId = instrId + rso.str();
            variable[varId] = II.getArgOperand(op)->getType();
        }
        printFactsToFile(predNameWithOperandToFilename(invokeInsnArg, operandType).c_str(), "%s\t%d\t%s\n", instrNum, op, varId);
    }
    //'normal label'
    logOperand(II.getNormalDest(), invokeInsnNormalLabel);

    //'exception label'
    logOperand(II.getUnwindDest(), invokeInsnExceptLabel);

    //Function Attributes
    const AttributeSet &Attrs = II.getAttributes();
    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        printFactsToFile(predNameToFilename(invokeInsnRetAttr).c_str(),
                         "%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
    }
    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);
    for(int i = 0; i < FuncnAttr.size(); ++i) {
        printFactsToFile(predNameToFilename(invokeInsnFuncAttr).c_str(),
                         "%s\t%s\n", instrNum, FuncnAttr[i]);
    }
    //TODO: Why not CallingConv::C
    if (II.getCallingConv() != CallingConv::C) {
        printFactsToFile(predNameToFilename(invokeInsnCallConv).c_str(),
                         "%s\t%s\n", instrNum, writeCallingConv(II.getCallingConv()));
    }
}

void InstructionVisitor::visitResumeInst(ResumeInst &RI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(resumeInsn).c_str(), "%s\n", instrNum);
    logOperand(RI.getValue(), resumeInsnOp);
}

void InstructionVisitor::visitUnreachableInst(UnreachableInst &I) {
    printFactsToFile(predNameToFilename(unreachableInsn).c_str(), "%s\n", instrNum);
}

void InstructionVisitor::visitAllocaInst(AllocaInst &AI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(allocaInsn).c_str(), "%s\n", instrNum);
    printFactsToFile(predNameToFilename(allocaInsnType).c_str(), "%s\t%t\n", instrNum, printType(AI.getAllocatedType()));

    if(AI.isArrayAllocation()) {
        logOperand(AI.getArraySize(), allocaInsnSize);
    }
    if(AI.getAlignment()) {
        printFactsToFile(predNameToFilename(allocaInsnAlign).c_str(), "%s\t%d\n", instrNum, AI.getAlignment());
    }
}

void InstructionVisitor::visitLoadInst(LoadInst &LI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(loadInsn).c_str(), "%s\n", instrNum);
    logOperand(LI.getPointerOperand(), loadInsnAddr);

    writeVolatileFlag(instrNum, LI.isVolatile());
    if(LI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, LI.getOrdering(), LI.getSynchScope());
        if(strlen(ord)) {
            printFactsToFile(predNameToFilename(loadInsnOrd).c_str(), "%s\t%d\n", instrNum, ord);
        }
    }
    if(LI.getAlignment()) {
        printFactsToFile(predNameToFilename(loadInsnAlign).c_str(), "%s\t%d\n", instrNum, LI.getAlignment());
    }
}

void InstructionVisitor::visitVAArgInst(VAArgInst &VI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(vaargInsn).c_str(), "%s\n", instrNum);
    logOperand(VI.getPointerOperand(), vaargInsnList);

    printFactsToFile(predNameToFilename(vaargInsnType).c_str(), "%s\t%t\n", instrNum, printType(VI.getType()));
}

void InstructionVisitor::visitExtractValueInst(ExtractValueInst &EVI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(extractValueInsn).c_str(), "%s\n", instrNum);
    //Aggregate Operand
    logOperand(EVI.getOperand(0), extractValueInsnBase);

    //Constant Indices
    int index = 0;
    for (const unsigned *i = EVI.idx_begin(), *e = EVI.idx_end(); i != e; ++i) {
        printFactsToFile(predNameToFilename(extractValueInsnIndex).c_str(), "%s\t%d\t%s\n", instrNum, index, *i);
        index++;
    }
    printFactsToFile(predNameToFilename(extractValueInsnNIndices).c_str(), "%s\t%s\n", instrNum, EVI.getNumIndices());
}

void InstructionVisitor::visitTruncInst(TruncInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(truncInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), truncInsnFrom);

    printFactsToFile(predNameToFilename(truncInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitZExtInst(ZExtInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(zextInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), zextInsnFrom);

    printFactsToFile(predNameToFilename(zextInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitSExtInst(SExtInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(sextInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), sextInsnFrom);

    printFactsToFile(predNameToFilename(sextInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPTruncInst(FPTruncInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fptruncInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), fptruncInsnFrom);

    printFactsToFile(predNameToFilename(fptruncInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPExtInst(FPExtInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fpextInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), fpextInsnFrom);

    printFactsToFile(predNameToFilename(fpextInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPToUIInst(FPToUIInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fptouiInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), fptouiInsnFrom);

    printFactsToFile(predNameToFilename(fptouiInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitFPToSIInst(FPToSIInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fptosiInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), fptosiInsnFrom);

    printFactsToFile(predNameToFilename(fptosiInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitUIToFPInst(UIToFPInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(uitofpInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), uitofpInsnFrom);

    printFactsToFile(predNameToFilename(uitofpInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitSIToFPInst(SIToFPInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(sitofpInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), sitofpInsnFrom);

    printFactsToFile(predNameToFilename(sitofpInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitPtrToIntInst(PtrToIntInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(ptrtointInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), ptrtointInsnFrom);

    printFactsToFile(predNameToFilename(ptrtointInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitIntToPtrInst(IntToPtrInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(inttoptrInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), inttoptrInsnFrom);

    printFactsToFile(predNameToFilename(inttoptrInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitBitCastInst(BitCastInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(bitcastInsn).c_str(), "%s\n", instrNum);
    logOperand(I.getOperand(0), bitcastInsnFrom);

    printFactsToFile(predNameToFilename(bitcastInsnToType).c_str(), "%s\t%t\n", instrNum, printType(I.getType()));
}

void InstructionVisitor::visitStoreInst(StoreInst &SI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(storeInsn).c_str(), "%s\n", instrNum);
    logOperand(SI.getValueOperand(), storeInsnValue);

    logOperand(SI.getPointerOperand(), storeInsnAddr);

    writeVolatileFlag(instrNum, SI.isVolatile());
    if(SI.isAtomic()) {
        const char *ord = writeAtomicInfo(instrNum, SI.getOrdering(), SI.getSynchScope());
        if(strlen(ord)) {
            printFactsToFile(predNameToFilename(storeInsnOrd).c_str(), "%s\t%d\n", instrNum, ord);
        }
    }
    if(SI.getAlignment()) {
        printFactsToFile(predNameToFilename(storeInsnAlign).c_str(), "%s\t%d\n", instrNum, SI.getAlignment());
    }
}

void InstructionVisitor::visitAtomicCmpXchgInst(AtomicCmpXchgInst &AXI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(cmpxchgInsn).c_str(), "%s\n", instrNum);
    //ptrValue
    logOperand(AXI.getPointerOperand(), cmpxchgInsnAddr);

    //cmpValue
    logOperand(AXI.getCompareOperand(), cmpxchgInsnCmp);

    //newValue
    logOperand(AXI.getNewValOperand(), cmpxchgInsnNew);

    writeVolatileFlag(instrNum, AXI.isVolatile());
    const char *ord = writeAtomicInfo(instrNum, AXI.getOrdering(), AXI.getSynchScope());
    if(strlen(ord)) {
        printFactsToFile(predNameToFilename(cmpxchgInsnOrd).c_str(), "%s\t%d\n", instrNum, ord);
    }
}

void InstructionVisitor::visitAtomicRMWInst(AtomicRMWInst &AWI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(atomicRMWInsn).c_str(), "%s\n", instrNum);
    //ptrValue - LeftOperand
    logOperand(AWI.getPointerOperand(), atomicRMWInsnAddr);

    //valOperand - Right Operand
    logOperand(AWI.getValOperand(), atomicRMWInsnValue);

    writeVolatileFlag(instrNum, AWI.isVolatile());
    writeAtomicRMWOp(instrNum, AWI.getOperation());
    const char *ord = writeAtomicInfo(instrNum, AWI.getOrdering(), AWI.getSynchScope());
    if(strlen(ord)) {
        printFactsToFile(predNameToFilename(atomicRMWInsnOper).c_str(), "%s\t%d\n", instrNum, ord);
    }
}

void InstructionVisitor::visitFenceInst(FenceInst &FI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fenceInsn).c_str(), "%s\n", instrNum);
    //fence [singleThread]  <ordering>
    const char *ord = writeAtomicInfo(instrNum, FI.getOrdering(), FI.getSynchScope());
    if(strlen(ord)) {
        printFactsToFile(predNameToFilename(fenceInsnOrd).c_str(), "%s\t%d\n", instrNum, ord);
    }
}

void InstructionVisitor::visitGetElementPtrInst(GetElementPtrInst &GEP) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(gepInsn).c_str(), "%s\n", instrNum);
    logOperand(GEP.getPointerOperand(), gepInsnBase);

    for (unsigned index = 1; index < GEP.getNumOperands(); ++index) {
        int operandType;
        value_str.clear();
        WriteAsOperand(rso, GEP.getOperand(index), 0, Mod);
        if(Constant *c = dyn_cast<Constant>(GEP.getOperand(index))) {
            varId = instrNum + rso.str();
            operandType = 0;
            printFactsToFile(predNameToFilename(constToInt).c_str(), 
                             "%s\t%s\n", varId, c->getUniqueInteger().toString(10,true));
            immediate[varId] = GEP.getOperand(index)->getType();
        }
        else {
            varId = instrId + rso.str();
            operandType = 1;
            variable[varId] = GEP.getOperand(index)->getType();
        }
        printFactsToFile(predNameWithOperandToFilename(gepInsnIndex, operandType).c_str(),
                             "%s\t%d\t%s\n", instrNum, index-1, varId);
    }
    printFactsToFile(predNameToFilename(gepInsnNIndices).c_str(), "%s\t%d\n", instrNum, GEP.getNumIndices());
    if(GEP.isInBounds()) {
        printFactsToFile(predNameToFilename(insnFlag).c_str(), "%s\t%s\n", instrNum, "inbounds");
    }
}

void InstructionVisitor::visitPHINode(PHINode &PHI) {

    raw_string_ostream rso(value_str);

    // <result> = phi <ty> [ <val0>, <label0>], ...
    printFactsToFile(predNameToFilename(phiInsn).c_str(), "%s\n", instrNum);
    // type
    printFactsToFile(predNameToFilename(phiInsnType).c_str(), "%s\t%t\n", instrNum, printType(PHI.getType()));
    for(unsigned op = 0; op < PHI.getNumIncomingValues(); ++op) {
        int operandType;
        //value
        value_str.clear();
        WriteAsOperand(rso, PHI.getIncomingValue(op), 0, Mod);
        if(Constant *c = dyn_cast<Constant>(PHI.getIncomingValue(op))) {
            varId = instrNum + rso.str();
            operandType = 0;            
            immediate[varId] = PHI.getIncomingValue(op)->getType();
        }
        else {
            varId = instrId + rso.str();
            operandType = 1;
            variable[varId] = PHI.getIncomingValue(op)->getType();
        }
        printFactsToFile(predNameWithOperandToFilename(phiInsnPairValue, operandType).c_str(),
                         "%s\t%d\t%s\n", instrNum, op, varId);

        //<label>
        value_str.clear();
        WriteAsOperand(rso, PHI.getIncomingBlock(op), 0, Mod);
        varId = instrId + rso.str();
        printFactsToFile(predNameToFilename(phiInsnPairLabel).c_str(), "%s\t%d\t%s\n", instrNum, op, varId);
        variable[varId] = PHI.getIncomingBlock(op)->getType();
    }
    printFactsToFile(predNameToFilename(phiInsnNPairs).c_str(), "%s\t%d\n", instrNum, PHI.getNumIncomingValues());
}

void InstructionVisitor::visitSelectInst(SelectInst &SI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(selectInsn).c_str(), "%s\n", instrNum);
    //Condition
    logOperand(SI.getOperand(0), selectInsnCond);

    //Left Operand (true value)
    logOperand(SI.getOperand(1), selectInsnFirstOp);

    //Right Operand (false value)
    logOperand(SI.getOperand(2), selectInsnSecondOp);
}

void InstructionVisitor::visitInsertValueInst(InsertValueInst &IVI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(insertValueInsn).c_str(), "%s\n", instrNum);
    //Left Operand
    logOperand(IVI.getOperand(0), insertValueInsnBase);

    //Right Operand
    logOperand(IVI.getOperand(1), insertValueInsnValue);

    //Constant Indices
    int index = 0;
    for (const unsigned *i = IVI.idx_begin(), *e = IVI.idx_end(); i != e; ++i,index++) {
        printFactsToFile(predNameToFilename(insertValueInsnIndex).c_str(), "%s\t%d\t%s\n", instrNum, index, *i);
    }
    printFactsToFile(predNameToFilename(insertValueInsnNIndices).c_str(), "%s\t%s\n", instrNum, IVI.getNumIndices());
}

void InstructionVisitor::visitLandingPadInst(LandingPadInst &LI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(landingpadInsn).c_str(), "%s\n", instrNum);
    // type
    printFactsToFile(predNameToFilename(landingpadInsnType).c_str(), "%s\t%t\n", instrNum, printType(LI.getType()));

    // function
    logOperand(LI.getPersonalityFn(), landingpadInsnFunc);

    //cleanup
    if(LI.isCleanup()) {
        printFactsToFile(predNameToFilename(insnFlag).c_str(), "%s\t%s\n", instrNum, "cleanup");
    }
    //#clauses
    for (unsigned i = 0; i < LI.getNumClauses(); ++i) {
        //catch clause
        if(LI.isCatch(i)) {
            logOperand(LI.getClause(i), landingpadInsnCatch);
        }
        //filter clause
        else {
            logSimpleValue(LI.getClause(i), landingpadInsnFilter);
        }
    }
    printFactsToFile(predNameToFilename(landingpadInsnNClauses).c_str(), "%s\t%s\n", instrNum, LI.getNumClauses());
}

void InstructionVisitor::visitCallInst(CallInst &CI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(callInsn).c_str(), "%s\n", instrNum);
    Value *callOp = CI.getCalledValue();
    PointerType *ptrTy = cast<PointerType>(callOp->getType());
    FunctionType *funcTy = cast<FunctionType>(ptrTy->getElementType());
    Type *RetTy = funcTy->getReturnType();

    logOperand(callOp, callInsnFunction);

    if(CI.getCalledFunction()) {
        printFactsToFile(predNameToFilename(directCallInsn).c_str(), "%s\n", instrNum);
    }
    else {
        printFactsToFile(predNameToFilename(indirectCallInsn).c_str(), "%s\n", instrNum);
    }
    for(unsigned op = 0; op < CI.getNumArgOperands(); ++op) {
        int operandType;
        value_str.clear();
        WriteAsOperand(rso, CI.getArgOperand(op), 0, Mod);
        if(Constant *c = dyn_cast<Constant>(CI.getArgOperand(op))) {
            varId = instrNum + rso.str();
            operandType = 0;
            immediate[varId] = CI.getArgOperand(op)->getType();
        }
        else {
            varId = instrId + rso.str();
            operandType = 1;
            variable[varId] = CI.getArgOperand(op)->getType();
        }
        printFactsToFile(predNameWithOperandToFilename(callInsnArg, operandType).c_str(), "%s\t%d\t%s\n", instrNum, op, varId);
    }
    if(CI.isTailCall()) {
        printFactsToFile(predNameToFilename(insnFlag).c_str(), "%s\t%s\n", instrNum, "tail");
    }
    if (CI.getCallingConv() != CallingConv::C) {
        printFactsToFile(predNameToFilename(callCallConv).c_str(),
                         "%s\t%s\n", instrNum, writeCallingConv(CI.getCallingConv()));
    }
    const AttributeSet &Attrs = CI.getAttributes();
    if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
        printFactsToFile(predNameToFilename(callInsnRetAttr).c_str(), 
                         "%s\t%s\n", instrNum, Attrs.getAsString(AttributeSet::ReturnIndex));
    }
    vector<string> FuncnAttr;
    writeFnAttributes(Attrs, FuncnAttr);
    for(int i = 0; i < FuncnAttr.size(); ++i) {
        printFactsToFile(predNameToFilename(callInsnFuncAttr).c_str(), "%s\t%s\n", instrNum, FuncnAttr[i]);
    }
}

void InstructionVisitor::visitICmpInst(ICmpInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(icmpInsn).c_str(), "%s\n", instrNum);

    //Condition
    if(strlen(writePredicate(I.getPredicate()))) {
        printFactsToFile(predNameToFilename(icmpInsnCond).c_str(), "%s\t%s\n", instrNum, writePredicate(I.getPredicate()));
    }
    //Left Operand
    logOperand(I.getOperand(0), icmpInsnFirstOp);

    //Right Operand
    logOperand(I.getOperand(1), icmpInsnSecondOp);

}

void InstructionVisitor::visitFCmpInst(FCmpInst &I) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(fcmpInsn).c_str(), "%s\n", instrNum);

    //Condition
    if(strlen(writePredicate(I.getPredicate()))) {
        printFactsToFile(predNameToFilename(fcmpInsnCond).c_str(), "%s\t%s\n", instrNum, writePredicate(I.getPredicate()));
    }
    //Left Operand
    logOperand(I.getOperand(0), fcmpInsnFirstOp);

    //Right Operand
    logOperand(I.getOperand(1), fcmpInsnSecondOp);

}

void InstructionVisitor::visitExtractElementInst(ExtractElementInst &EEI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(extractElemInsn).c_str(), "%s\n", instrNum);
    //VectorOperand
    logOperand(EEI.getVectorOperand(), extractElemInsnBase);

    //indexValue
    logOperand(EEI.getIndexOperand(), extractElemInsnIndex);

}

void InstructionVisitor::visitInsertElementInst(InsertElementInst &IEI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(insertElemInsn).c_str(), "%s\n", instrNum);
    //vectorOperand
    logOperand(IEI.getOperand(0), insertElemInsnBase);

    //Value Operand
    logOperand(IEI.getOperand(1), insertElemInsnValue);

    //Index Operand
    logOperand(IEI.getOperand(2), insertElemInsnIndex);

}

void InstructionVisitor::visitShuffleVectorInst(ShuffleVectorInst &SVI) {

    raw_string_ostream rso(value_str);

    printFactsToFile(predNameToFilename(shuffleVectorInsn).c_str(), "%s\n", instrNum);
    //firstVector
    logOperand(SVI.getOperand(0), shuffleVectorInsnFirstVec);

    //secondVector
    logOperand(SVI.getOperand(1), shuffleVectorInsnSecondVec);

    //Mask
    logOperand(SVI.getOperand(2), shuffleVectorInsnMask);

}

void  InstructionVisitor::visitInstruction(Instruction &I) {

    errs() << I.getOpcodeName() << ": Unhandled instruction\n";
}
