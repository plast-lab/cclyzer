#include <string>

#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/Support/CFG.h"

#include "AuxiliaryMethods.hpp"
#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"

using namespace llvm;
using namespace std;
using namespace boost;

using namespace auxiliary_methods;
using namespace predicate_names;

char CsvGenerator::delim = '\t';
template<> CsvGenerator *Singleton<CsvGenerator>::INSTANCE = NULL;

//aggregate array for all predicate names

const int CsvGenerator::simplePredicatesNum = 183;

const char * CsvGenerator::simplePredicates[] = {
    basicBlockPred, globalVar, globalVarType,
    globalVarInit, globalVarSect, globalVarAlign,
    globalVarFlag, globalVarLink, globalVarVis,
    globalVarTlm, alias, aliasType,
    aliasLink, aliasVis, aliasAliasee,
    Func, FuncDecl, FuncUnnamedAddr, FuncLink,
    FuncVis, FuncCallConv, FuncSect,
    FuncAlign, FuncAttr, FuncGc,
    FuncName, FuncType, FuncParam,
    FuncRetAttr, FuncParamAttr, insnTo,
    insnFlag, insnNext, insnBBEntry,
    insnFunc, addInsn, faddInsn,
    subInsn, fsubInsn, mulInsn,
    fmulInsn, udivInsn, fdivInsn,
    sdivInsn, uremInsn, sremInsn,
    fremInsn, shlInsn, lshrInsn,
    ashrInsn, andInsn, orInsn,
    xorInsn, retInsn, retInsnVoid,
    brInsn, brCondInsn, brCondInsnIfTrue,
    brCondInsnIfFalse, brUncondInsn, brUncondInsnDest,
    switchInsn, switchInsnDefLabel, switchInsnCaseVal,
    switchInsnCaseLabel, switchInsnNCases, indirectbrInsn,
    indirectbrInsnLabel, indirectbrInsnNLabels, resumeInsn,
    unreachableInsn, invokeInsn, invokeInsnNormalLabel,
    invokeInsnExceptLabel, directInvokeInsn, indirectInvokeInsn,
    invokeInsnCallConv, invokeInsnRetAttr, invokeInsnParamAttr,
    invokeInsnFuncAttr, extractElemInsn, insertElemInsn,
    shuffleVectorInsn, constToInt, shuffleVectorInsnMask,
    extractValueInsn, extractValueInsnIndex, extractValueInsnNIndices,
    insertValueInsn, insertValueInsnIndex, insertValueInsnNIndices,
    allocaInsn, allocaInsnAlign, allocaInsnType,
    loadInsn, loadInsnAlign, loadInsnOrd,
    storeInsn, storeInsnAlign, storeInsnOrd,
    fenceInsn, fenceInsnOrd, atomicRMWInsn,
    atomicRMWInsnOrd, atomicRMWInsnOper, cmpxchgInsn,
    cmpxchgInsnOrd, cmpxchgInsnType, gepInsn,
    gepInsnNIndices, truncInsn, truncInsnToType,
    zextInsn, zextInsnToType, sextInsn,
    sextInsnToType, fptruncInsn, fptruncInsnToType,
    fpextInsn, fpextInsnToType, fptouiInsn,
    fptouiInsnToType, fptosiInsn, fptosiInsnToType,
    uitofpInsn, uitofpInsnToType, sitofpInsn,
    sitofpInsnToType, ptrtointInsn, ptrtointInsnToType,
    inttoptrInsn, inttoptrInsnToType, bitcastInsn,
    bitcastInsnToType, icmpInsn, icmpInsnCond,
    fcmpInsn, fcmpInsnCond, phiInsn, phiInsnType,
    phiInsnPairLabel, phiInsnNPairs, selectInsn,
    vaargInsn, vaargInsnType, callInsn,
    directCallInsn, indirectCallInsn, callCallConv,
    callInsnRetAttr, callInsnParamAttr, callInsnFuncAttr,
    landingpadInsn, landingpadInsnType, landingpadInsnFunc,
    landingpadInsnNClauses, primitiveType, intType,
    fpType, funcType, funcTypeVarArgs,
    funcTypeReturn, funcTypeParam, funcTypeNParams,
    ptrType, ptrTypeComp, ptrTypeAddrSpace,
    vectorType, vectorTypeComp, vectorTypeSize,
    arrayType, arrayTypeComp, arrayTypeSize,
    structType, structTypeField, structTypeNFields,
    opaqueStructType, ::immediate, immediateType,
    ::variable, variableType, landingpadInsnCatch,
    landingpadInsnFilter
};

const int CsvGenerator::operandPredicatesNum = 87;

const char * CsvGenerator::operandPredicates[] = {
    addInsnFirstOp, addInsnSecondOp, faddInsnFirstOp,
    faddInsnSecondOp, subInsnFirstOp, subInsnSecondOp,
    fsubInsnFirstOp, fsubInsnSecondOp, mulInsnFirstOp,
    mulInsnSecondOp, fmulInsnFirstOp, fmulInsnSecondOp,
    udivInsnFirstOp, udivInsnSecondOp, fdivInsnFirstOp,
    fdivInsnSecondOp, sdivInsnFirstOp, sdivInsnSecondOp,
    uremInsnFirstOp, uremInsnSecondOp, sremInsnFirstOp,
    sremInsnSecondOp, fremInsnFirstOp, fremInsnSecondOp,
    shlInsnFirstOp, shlInsnSecondOp, lshrInsnFirstOp,
    lshrInsnSecondOp, ashrInsnFirstOp, ashrInsnSecondOp,
    andInsnFirstOp, andInsnSecondOp, orInsnFirstOp,
    orInsnSecondOp, xorInsnFirstOp, xorInsnSecondOp,
    bitcastInsnFrom, uitofpInsnFrom, sitofpInsnFrom,
    inttoptrInsnFrom, ptrtointInsnFrom, truncInsnFrom,
    zextInsnFrom, sextInsnFrom, fptruncInsnFrom,
    fpextInsnFrom, fptouiInsnFrom, fptosiInsnFrom,
    retInsnOp, brCondInsnCondition, switchInsnOp,
    indirectbrInsnAddr, invokeInsnFunc, invokeInsnArg,
    resumeInsnOp, extractElemInsnBase, extractElemInsnIndex,
    insertElemInsnBase, insertElemInsnIndex, insertElemInsnValue,
    shuffleVectorInsnFirstVec, shuffleVectorInsnSecondVec, extractValueInsnBase,
    insertValueInsnBase, insertValueInsnValue, allocaInsnSize,
    loadInsnAddr, storeInsnValue, storeInsnAddr,
    atomicRMWInsnAddr, atomicRMWInsnValue, cmpxchgInsnAddr,
    cmpxchgInsnCmp, cmpxchgInsnNew, gepInsnBase,
    gepInsnIndex, icmpInsnFirstOp, icmpInsnSecondOp,
    fcmpInsnFirstOp, fcmpInsnSecondOp, phiInsnPairValue,
    selectInsnCond, selectInsnFirstOp, selectInsnSecondOp,
    callInsnFunction, callInsnArg, vaargInsnList
};


CsvGenerator::CsvGenerator(){
    //TODO: insert assertion that DirInfo has been initialized
    for(int i = 0; i < operandPredicatesNum; ++i){
        string csvFilenameImm = predNameWithOperandToFilename(operandPredicates[i], false),
            csvFilenameVar = predNameWithOperandToFilename(operandPredicates[i], true);

        filesystem::ofstream *csvFileImm = new filesystem::ofstream(csvFilenameImm.c_str(), ios_base::out),
            *csvFileVar = new filesystem::ofstream(csvFilenameVar.c_str(), ios_base::out);
        //TODO: check if file open fails
        csvFiles[csvFilenameImm] = csvFileImm;
        csvFiles[csvFilenameVar] = csvFileVar;
    }
}

void CsvGenerator::writeEntityToCsv(const char *predName, const string& entityRefmode){
    filesystem::ofstream *csvFile = getCsvFile(predNameToFilename(predName));
    (*csvFile) << entityRefmode << "\n";
}

void CsvGenerator::writeOperandPredicateToCsv(const char *predName, const string& entityRefmode, 
                                              const string& operandRefmode, bool operandType, int index){
    filesystem::ofstream *csvFile = getCsvFile(predNameWithOperandToFilename(predName, operandType));
    if(index == -1)
        (*csvFile) << entityRefmode << delim << operandRefmode << "\n";
    else
        (*csvFile) << entityRefmode << delim << index << delim << operandRefmode << "\n";
}

void CsvGenerator::processModule(const Module * Mod, string& path){

    // iterating over global variables in a module
    for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
        writeGlobalVar(gi, getRefmodeForValue(Mod, gi, path));
        types.insert(gi->getType());
    }

    // iterating over global alias in a module
    for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
        writeGlobalAlias(ga, getRefmodeForValue(Mod, ga, path));
        types.insert(ga->getType());
    }

    InstructionVisitor IV(variable, immediate, Mod);

    // iterating over functions in a module
    for (Module::const_iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
        string funcId = "<" + path + ">:" + string(fi->getName());
        string instrId = funcId + ":";
        IV.setInstrId(instrId);

        writePredicateToCsv(FuncType, funcId, printType(fi->getFunctionType()));

        types.insert(fi->getFunctionType());
        if(strlen(writeLinkage(fi->getLinkage()))) {
            writePredicateToCsv(FuncLink, funcId, writeLinkage(fi->getLinkage()));
        }
        if(strlen(writeVisibility(fi->getVisibility()))) {
            writePredicateToCsv(FuncVis, funcId, writeVisibility(fi->getVisibility()));
        }
        if(fi->getCallingConv() != CallingConv::C) {
            writePredicateToCsv(FuncCallConv, funcId, writeCallingConv(fi->getCallingConv()));
        }
        if(fi->getAlignment()) {
            writePredicateToCsv(FuncAlign, funcId, fi->getAlignment());
        }
        if(fi->hasGC()) {
            writePredicateToCsv(FuncGc, funcId, fi->getGC());
        }
        writePredicateToCsv(FuncName, funcId, "@" + fi->getName().str());

        if(fi->hasUnnamedAddr()) {
            writeEntityToCsv(FuncUnnamedAddr, funcId);
        }
        const AttributeSet &Attrs = fi->getAttributes();
        if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
            writePredicateToCsv(FuncRetAttr, funcId, Attrs.getAsString(AttributeSet::ReturnIndex));
        }
        vector<string> FuncnAttr;
        writeFnAttributes(Attrs, FuncnAttr);
        for (int i = 0; i < FuncnAttr.size(); ++i) {
            writePredicateToCsv(FuncAttr, funcId, FuncnAttr[i]);
        }
        if (!fi->isDeclaration()) {
            writeEntityToCsv(Func, funcId);
            if(fi->hasSection()) {
                writePredicateToCsv(FuncSect, funcId, fi->getSection());
            }
            int index = 0;
            for (Function::const_arg_iterator arg = fi->arg_begin(), arg_end = fi->arg_end(); arg != arg_end; ++arg) {
                string varId;
                varId = instrId + valueToString(arg, Mod);
                writePredicateToCsv(FuncParam, funcId, varId, index);
                variable[varId] = arg->getType();
                index++;
            }
        }
        else{
            writeEntityToCsv(FuncDecl, funcId);
            continue;
        }

        int counter = 0;
        //iterating over basic blocks in a function
        //REVIEW: There must be a way to move this whole logic inside InstructionVisitor, i.e., visit(Module M)
        for (Function::const_iterator bi = fi->begin(), bi_end = fi->end(); bi != bi_end; ++bi) {
            string bbId = funcId + ":";
            string varId;
            varId = bbId + valueToString(bi, Mod);
            writeEntityToCsv(::variable, varId);
            writePredicateToCsv(variableType, varId, "label");
            //No const_pred_iterator, damn you llvm
            BasicBlock* tmpBB = const_cast<BasicBlock*>((const BasicBlock*)bi);
            for(pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB); pi != pi_end; ++pi) {
                string predBB = bbId + valueToString(*pi, Mod);
                writePredicateToCsv(basicBlockPred, varId, predBB);
            }

            //iterating over instructions in a basic block
            for (BasicBlock::const_iterator i = bi->begin(), i_end = bi->end(); i != i_end; ++i) {
                ostringstream countStr;
                string varId; //TODO: clean up this mess. This variable shadows the outer one
                countStr << counter;
                string instrNum = instrId + countStr.str();
                counter++;
                if(!i->getType()->isVoidTy()) {
                    varId = instrId + valueToString(i, Mod);
                    writePredicateToCsv(insnTo, instrNum, varId);
                    variable[varId] = i->getType();
                }
                //TODO: remove this ugly trick
                if(++i != i_end){
                    i--;
                    if(const Instruction* next = dyn_cast<Instruction>(i->getNextNode())) {
                        ostringstream nextCountStr;
                        nextCountStr << counter;
                        string instrNext = instrId + nextCountStr.str();
                        writePredicateToCsv(insnNext, instrNum, instrNext);
                    }
                }
                else{
                    i--;
                }
                writePredicateToCsv(insnFunc, instrNum, funcId);

                varId = instrId + valueToString(i->getParent(), Mod);
                writePredicateToCsv(insnBBEntry, instrNum, varId);

                // Instruction Visitor
                IV.setInstrNum(instrNum);
                //Once again no const version in InstructionVisitor
                IV.visit(*(const_cast<Instruction*>((const Instruction*)i)));
            }
        }
    }

}


void CsvGenerator::writeVarsTypesAndImmediates(){

    // Immediate
    for (unordered_map<string, const Type *>::iterator it = immediate.begin(); it != immediate.end(); ++it) {
        string refmode = it->first;
        const Type *type = it->second;
        writeEntityToCsv(::immediate, refmode);
        writePredicateToCsv(immediateType, refmode, printType(type));
        types.insert(type);
    }
    // Variable
    for (unordered_map<string, const Type *>::iterator it = variable.begin(); it != variable.end(); ++it) {
        string refmode = it->first;
        const Type *type = it->second;
        writeEntityToCsv(::variable, refmode);
        writePredicateToCsv(variableType, refmode, printType(type));
        types.insert(it->second);
    }
    // Types
    for (unordered_set<const Type *>::iterator it = types.begin(); it != types.end(); ++it) {
        const Type *type = *it;
        identifyType(type, componentTypes);
    }

    //TODO: Do we need to write other primitives manually?
    writeEntityToCsv(primitiveType, "void");
    writeEntityToCsv(primitiveType, "label");
    writeEntityToCsv(primitiveType, "metadata");
    writeEntityToCsv(primitiveType, "x86mmx");

    //TODO: convert if-then-else to switch statement
    //TODO: eliminate common exps
    for (unordered_set<const Type *>::iterator it = componentTypes.begin(); it != componentTypes.end(); ++it) {
        const Type *type = *it;
        if (type->isIntegerTy()) {
            writeEntityToCsv(intType, printType(type));
        }
        else if(type->isFloatingPointTy()) {
            writeEntityToCsv(fpType, printType(type));
        }
        //TODO: check what other primitives neeed to go here
        else if(type->isVoidTy() || type->isLabelTy() || type->isMetadataTy()){
            writeEntityToCsv(primitiveType, printType(type));
        }
        else if(type->isPointerTy()) {
            writeEntityToCsv(ptrType, printType(type));
            writePredicateToCsv(ptrTypeComp, printType(type), printType(type->getPointerElementType()));
            if(unsigned AddressSpace = type->getPointerAddressSpace()) {
                writePredicateToCsv(ptrTypeAddrSpace, printType(type), AddressSpace);
            }
        }
        else if(type->isArrayTy()) {
            writeEntityToCsv(arrayType, printType(type));
            writePredicateToCsv(arrayTypeSize, printType(type), type->getArrayNumElements());
            writePredicateToCsv(arrayTypeComp, printType(type), printType(type->getArrayElementType()));
        }
        else if(type->isStructTy()) {
            const StructType *strTy = cast<StructType>(type);
            writeEntityToCsv(structType, printType(strTy));
            if(strTy->isOpaque()) {
                writeEntityToCsv(opaqueStructType, printType(strTy));
            }
            else {
                for (unsigned int i = 0; i < strTy->getStructNumElements(); ++i) {
                    writePredicateToCsv(structTypeField, printType(strTy), printType(strTy->getStructElementType(i)), i);
                }
                writePredicateToCsv(structTypeNFields, printType(strTy), strTy->getStructNumElements());
            }
        }
        else if(type->isVectorTy()) {
            writeEntityToCsv(vectorType, printType(type));
            writePredicateToCsv(vectorTypeComp, printType(type), printType(type->getVectorElementType()));
            writePredicateToCsv(vectorTypeSize, printType(type), type->getVectorNumElements());
        }
        else if(type->isFunctionTy()) {
            const FunctionType *funType = cast<FunctionType>(type);
            writeEntityToCsv(funcType, printType(funType));
            //TODO: which predicate/entity do we need to update for varagrs?
            if(funType->isVarArg())
                writeEntityToCsv(funcTypeVarArgs, printType(funType));
            writePredicateToCsv(funcTypeReturn, printType(funType), printType(funType->getReturnType()));

            for (unsigned int par = 0; par < funType->getFunctionNumParams(); ++par) {
                writePredicateToCsv(funcTypeParam, printType(funType), printType(funType->getFunctionParamType(par)), par);
            }
            writePredicateToCsv(funcTypeNParams, printType(funType), funType->getFunctionNumParams());
        }
        else {
            type->dump();
            errs() << "-" << type->getTypeID() << ": invalid type in componentTypes set.\n";
        }
    }

}

//auxiliary methods

void CsvGenerator::identifyType(const Type *elementType, unordered_set<const Type *> &componentTypes) {

    if(componentTypes.count(elementType) != 0) {
        return;
    }
    componentTypes.insert(elementType);
    if (isPrimitiveType(elementType) || elementType->isIntegerTy()) {
        return;
    }
    if (elementType->isArrayTy()) {
        identifyType(elementType->getArrayElementType(), componentTypes);
    }
    else if (elementType->isPointerTy()) {
        identifyType(elementType->getPointerElementType(), componentTypes);
    }
    else if (elementType->isStructTy()) {
        identifyStructType(elementType, componentTypes);
    }
    else if (elementType->isVectorTy()) {
        identifyType(elementType->getVectorElementType(), componentTypes);
    }
    else if(elementType->isFunctionTy()) {
        identifyFunctionType(elementType, componentTypes);
    }
    else {
        errs() << "Unrecognized type: " << printType(elementType) << " .\n";
    }
}

void CsvGenerator::identifyStructType(const Type *structType, unordered_set<const Type *> &componentTypes) {

    const StructType *strTy = cast<StructType>(structType);
    if(!strTy->isOpaque()) {
        for (unsigned int i = 0; i < strTy->getStructNumElements(); ++i) {
            identifyType(strTy->getStructElementType(i), componentTypes);
        }
    }
}

void CsvGenerator::identifyFunctionType(const Type *funcType, unordered_set<const Type *> &componentTypes) {

    const FunctionType *funcTy = dyn_cast<FunctionType>(funcType);
    identifyType(funcTy->getReturnType(), componentTypes);
    for (unsigned int par = 0; par < funcType->getFunctionNumParams(); ++par) {
        identifyType(funcTy->getFunctionParamType(par), componentTypes);
    }
}

const char* CsvGenerator::writeLinkage(GlobalValue::LinkageTypes LT) {

    const char *linkTy;

    switch (LT) {
    case GlobalValue::ExternalLinkage:      linkTy = "external";        break;
    case GlobalValue::PrivateLinkage:       linkTy = "private";         break;
    case GlobalValue::LinkerPrivateLinkage: linkTy = "linker_private";  break;
    case GlobalValue::LinkerPrivateWeakLinkage:
        linkTy = "linker_private_weak";
        break;
    case GlobalValue::InternalLinkage:      linkTy = "internal";        break;
    case GlobalValue::LinkOnceAnyLinkage:   linkTy = "linkonce";        break;
    case GlobalValue::LinkOnceODRLinkage:   linkTy = "linkonce_odr";    break;
    case GlobalValue::WeakAnyLinkage:       linkTy = "weak";            break;
    case GlobalValue::WeakODRLinkage:       linkTy = "weak_odr";        break;
    case GlobalValue::CommonLinkage:        linkTy = "common";          break;
    case GlobalValue::AppendingLinkage:     linkTy = "appending";       break;
    case GlobalValue::ExternalWeakLinkage:  linkTy = "extern_weak";     break;
    case GlobalValue::AvailableExternallyLinkage:
        linkTy = "available_externally";
        break;
    default: linkTy = "";   break;
    }
    return linkTy;
}

const char* CsvGenerator::writeVisibility(GlobalValue::VisibilityTypes Vis) {

    const char *visibility;
    switch (Vis) {
    case GlobalValue::DefaultVisibility:    visibility = "default";     break;
    case GlobalValue::HiddenVisibility:     visibility = "hidden";      break;
    case GlobalValue::ProtectedVisibility:  visibility = "protected";   break;
    default: visibility = "";   break;
    }
    return visibility;
}

void CsvGenerator::writeGlobalVar(const GlobalVariable *gv, string globalName) {

    string value_str;
    raw_string_ostream rso(value_str);

    value_str.clear();
    writeEntityToCsv(globalVar, globalName);
    if (!gv->hasInitializer() && gv->hasExternalLinkage()) {
        writePredicateToCsv(globalVarLink, globalName, "external");
    }
    if(strlen(writeLinkage(gv->getLinkage()))) {
        writePredicateToCsv(globalVarLink, globalName, writeLinkage(gv->getLinkage()));
    }
    if(strlen(writeVisibility(gv->getVisibility()))) {
        writePredicateToCsv(globalVarVis, globalName, writeVisibility(gv->getVisibility()));
    }
    if(strlen(writeThreadLocalModel(gv->getThreadLocalMode()))) {
        writePredicateToCsv(globalVarTlm, globalName, writeThreadLocalModel(gv->getThreadLocalMode()));
    }
    //TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized()) {
        writePredicateToCsv(globalVarFlag, globalName, "externally_initialized");
    }
    const char * flag;
    if(gv->isConstant()) {
        flag = "constant";
    }
    else {
        flag = "global";
    }
    writePredicateToCsv(globalVarFlag, globalName, flag);
    writePredicateToCsv(globalVarType, globalName, printType(gv->getType()->getElementType()));
    if(gv->hasInitializer()) {
        writePredicateToCsv(globalVarInit, globalName, valueToString(gv->getInitializer(), gv->getParent()));
    }
    if (gv->hasSection()) {
        writePredicateToCsv(globalVarSect, globalName, gv->getSection());
    }
    if(gv->getAlignment()) {
        writePredicateToCsv(globalVarAlign, globalName, gv->getAlignment());
    }
}

void CsvGenerator::writeGlobalAlias(const GlobalAlias *ga, string globalAlias) {

    // @<Name> = alias [Linkage] [Visibility] <AliaseeTy> @<Aliasee>
    string value_str;
    raw_string_ostream rso(value_str);

    value_str.clear();
    writeEntityToCsv(alias, globalAlias);
    if(strlen(writeVisibility(ga->getVisibility()))) {
        writePredicateToCsv(aliasVis, globalAlias, writeVisibility(ga->getVisibility()));
    }
    if(strlen(writeLinkage(ga->getLinkage()))) {
        writePredicateToCsv(aliasLink, globalAlias, writeLinkage(ga->getLinkage()));
    }
    writePredicateToCsv(aliasType, globalAlias, printType(ga->getType()));

    const Constant *Aliasee = ga->getAliasee();
    if(Aliasee != 0) {
        writePredicateToCsv(aliasAliasee, globalAlias, valueToString(Aliasee, ga->getParent()));
    }
}
