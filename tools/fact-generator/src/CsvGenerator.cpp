#include <boost/foreach.hpp>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>
#include <llvm/Support/CFG.h>
#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "TypeAccumulator.hpp"

#define foreach BOOST_FOREACH

using namespace llvm;
using namespace std;
using namespace boost;

using namespace auxiliary_methods;
using namespace predicate_names;

namespace fs = boost::filesystem;
namespace pred = predicate_names;

// aggregate array for all predicate names

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
    loadInsn, loadInsnAlign, loadInsnOrd, loadInsnVolatile,
    storeInsn, storeInsnAlign, storeInsnOrd, storeInsnVolatile,
    fenceInsn, fenceInsnOrd, atomicRMWInsn, atomicRMWInsnVolatile,
    atomicRMWInsnOrd, atomicRMWInsnOper, cmpxchgInsn, cmpxchgInsnVolatile,
    cmpxchgInsnOrd, cmpxchgInsnType, gepInsn, gepInsnInbounds,
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
    vaargInsn, vaargInsnType, callInsn, callInsnTail,
    directCallInsn, indirectCallInsn, callCallConv,
    callInsnRetAttr, callInsnParamAttr, callInsnFuncAttr,
    landingpadInsn, landingpadInsnType, landingpadInsnFunc,
    landingpadInsnCleanup,landingpadInsnNClauses, primitiveType,
    intType, fpType, funcType, funcTypeVarArgs,
    funcTypeReturn, funcTypeParam, funcTypeNParams,
    ptrType, ptrTypeComp, ptrTypeAddrSpace,
    vectorType, vectorTypeComp, vectorTypeSize,
    typeAllocSize, typeStoreSize,
    arrayType, arrayTypeComp, arrayTypeSize,
    structType, structTypeField, structTypeNFields,
    opaqueStructType, ::immediate, immediateType,
    ::variable, variableType, landingpadInsnCatch,
    landingpadInsnFilter, constExpr
};

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


void CsvGenerator::initStreams()
{
    for (const char *pred : operandPredicates) {
        path ipath = toPath(pred, Operand::Type::IMMEDIATE);
        path vpath = toPath(pred, Operand::Type::VARIABLE);

        // TODO: check if file open fails
        csvFiles[ipath] = new ofstream(ipath.c_str(), ios_base::out);
        csvFiles[vpath] = new ofstream(vpath.c_str(), ios_base::out);
    }

    for (const char *pred : simplePredicates) {
        path path = toPath(pred);
        csvFiles[path] = new ofstream(path.c_str(), ios_base::out);
    }

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}



void CsvGenerator::processModule(const Module * Mod, string& path)
{
    // Get data layout of this module
    std::string layoutRef = Mod->getDataLayout();
    DataLayout *layout = new DataLayout(layoutRef);
    layouts.insert(layout);

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

    InstructionVisitor IV(this, Mod);

    // iterating over functions in a module
    for (Module::const_iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi) {
        string funcId = "<" + path + ">:" + string(fi->getName());
        string instrId = funcId + ":";
        IV.setInstrId(instrId);

        writeSimpleFact(FuncType, funcId, printType(fi->getFunctionType()));

        types.insert(fi->getFunctionType());

        // Serialize function properties
        string visibility = to_string(fi->getVisibility());
        string linkage = to_string(fi->getLinkage());

        // Record function linkage
        if (!linkage.empty())
            writeSimpleFact(pred::FuncLink, funcId, linkage);

        // Record function visibility
        if (!visibility.empty())
            writeSimpleFact(pred::FuncVis, funcId, visibility);

        if (fi->getCallingConv() != CallingConv::C)
            writeSimpleFact(FuncCallConv, funcId, writeCallingConv(fi->getCallingConv()));

        if (fi->getAlignment())
            writeSimpleFact(FuncAlign, funcId, fi->getAlignment());

        if(fi->hasGC())
            writeSimpleFact(FuncGc, funcId, fi->getGC());

        writeSimpleFact(FuncName, funcId, "@" + fi->getName().str());

        if(fi->hasUnnamedAddr()) {
            writeEntity(FuncUnnamedAddr, funcId);
        }
        const AttributeSet &Attrs = fi->getAttributes();
        if (Attrs.hasAttributes(AttributeSet::ReturnIndex)) {
            writeSimpleFact(FuncRetAttr, funcId, Attrs.getAsString(AttributeSet::ReturnIndex));
        }
        vector<string> FuncnAttr;
        writeFnAttributes(Attrs, FuncnAttr);
        for (int i = 0; i < FuncnAttr.size(); ++i) {
            writeSimpleFact(FuncAttr, funcId, FuncnAttr[i]);
        }
        if (!fi->isDeclaration()) {
            writeEntity(Func, funcId);
            if(fi->hasSection()) {
                writeSimpleFact(FuncSect, funcId, fi->getSection());
            }
            int index = 0;
            for (Function::const_arg_iterator arg = fi->arg_begin(), arg_end = fi->arg_end(); arg != arg_end; ++arg) {
                string varId;
                varId = instrId + valueToString(arg, Mod);
                writeSimpleFact(FuncParam, funcId, varId, index);
                recordVariable(varId, arg->getType());
                index++;
            }
        }
        else{
            writeEntity(FuncDecl, funcId);
            continue;
        }

        int counter = 0;
        //iterating over basic blocks in a function
        //REVIEW: There must be a way to move this whole logic inside InstructionVisitor, i.e., visit(Module M)
        for (Function::const_iterator bi = fi->begin(), bi_end = fi->end(); bi != bi_end; ++bi) {
            string bbId = funcId + ":";
            string varId;
            varId = bbId + valueToString(bi, Mod);
            writeEntity(::variable, varId);
            writeSimpleFact(variableType, varId, "label");
            //No const_pred_iterator, damn you llvm
            BasicBlock* tmpBB = const_cast<BasicBlock*>((const BasicBlock*)bi);
            for(pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB); pi != pi_end; ++pi) {
                string predBB = bbId + valueToString(*pi, Mod);
                writeSimpleFact(basicBlockPred, varId, predBB);
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
                    writeSimpleFact(insnTo, instrNum, varId);
                    recordVariable(varId, i->getType());
                }
                //TODO: remove this ugly trick
                if(++i != i_end){
                    i--;
                    if(const Instruction* next = dyn_cast<Instruction>(i->getNextNode())) {
                        ostringstream nextCountStr;
                        nextCountStr << counter;
                        string instrNext = instrId + nextCountStr.str();
                        writeSimpleFact(insnNext, instrNum, instrNext);
                    }
                }
                else{
                    i--;
                }
                writeSimpleFact(insnFunc, instrNum, funcId);

                varId = instrId + valueToString(i->getParent(), Mod);
                writeSimpleFact(insnBBEntry, instrNum, varId);

                // Instruction Visitor
                IV.setInstrNum(instrNum);
                //Once again no const version in InstructionVisitor
                IV.visit(*(const_cast<Instruction*>((const Instruction*)i)));
            }
        }
    }

}


void CsvGenerator::writeVarsTypesAndImmediates()
{
    using llvm_extra::TypeAccumulator;
    using boost::unordered_set;

    // Record every constant encountered so far
    foreach (type_cache_t::value_type kv, constantTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record constant entity with its type
        writeEntity(pred::immediate, refmode);
        writeSimpleFact(pred::immediateType, refmode, to_string(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record variable entity with its type
        writeEntity(pred::variable, refmode);
        writeSimpleFact(pred::variableType, refmode, to_string(type));

        types.insert(type);
    }

    // Type accumulator that identifies simple types from complex ones
    TypeAccumulator<unordered_set<const llvm::Type *> > collector;

    // Set of all encountered types
    unordered_set<const llvm::Type *> componentTypes = collector(types);

    // Add basic primitive types
    writeEntity(pred::primitiveType, "void");
    writeEntity(pred::primitiveType, "label");
    writeEntity(pred::primitiveType, "metadata");
    writeEntity(pred::primitiveType, "x86mmx");

    // Record each type encountered
    foreach (const Type *type, componentTypes)
       writeType(type);
}



//-------------------------------------------------------------------
// Methods for recording different kinds of LLVM types.
//-------------------------------------------------------------------


void CsvGenerator::writeType(const Type *type)
{
    // Record type sizes while skipping unsized types (e.g.,
    // labels, functions)

    if (type->isSized()) {
        // Iterate over every cached data layout
        foreach (const DataLayout *DL, layouts)
        {
            // TODO: address the case when the data layout does
            // not contain information about this type. This will
            // happen when we analyze multiple compilation units
            // (modules) at once.

            uint64_t allocSize = DL->getTypeAllocSize(const_cast<Type *>(type));
            uint64_t storeSize = DL->getTypeStoreSize(const_cast<Type *>(type));

            // Store size of type in bytes
            writeSimpleFact(pred::typeAllocSize, to_string(type), allocSize);
            writeSimpleFact(pred::typeStoreSize, to_string(type), storeSize);
            break;
        }
    }

    // Record each different kind of type
    switch (type->getTypeID()) { // Fallthrough is intended
      case llvm::Type::VoidTyID:
      case llvm::Type::LabelTyID:
      case llvm::Type::MetadataTyID:
          writeEntity(pred::primitiveType, to_string(type));
          break;
      case llvm::Type::HalfTyID: // Fallthrough to all 6 floating point types
      case llvm::Type::FloatTyID:
      case llvm::Type::DoubleTyID:
      case llvm::Type::X86_FP80TyID:
      case llvm::Type::FP128TyID:
      case llvm::Type::PPC_FP128TyID:
          assert(type->isFloatingPointTy());
          writeEntity(pred::fpType, to_string(type));
          break;
      case llvm::Type::IntegerTyID:
          writeEntity(pred::intType, to_string(type));
          break;
      case llvm::Type::FunctionTyID:
          writeFunctionType(cast<FunctionType>(type));
          break;
      case llvm::Type::StructTyID:
          writeStructType(cast<StructType>(type));
          break;
      case llvm::Type::ArrayTyID:
          writeArrayType(cast<ArrayType>(type));
          break;
      case llvm::Type::PointerTyID:
          writePointerType(cast<PointerType>(type));
          break;
      case llvm::Type::VectorTyID:
          writeVectorType(cast<VectorType>(type));
          break;
      case llvm::Type::X86_MMXTyID: // TODO: handle this type
          break;
      default:
          type->dump();
          llvm::errs() << "-" << type->getTypeID()
                       << ": invalid type encountered.\n";
    }
}


void CsvGenerator::writePointerType(const PointerType *ptrType)
{
    string refmode = to_string(ptrType);
    Type *elementType = ptrType->getPointerElementType();

    // Record pointer type entity
    writeEntity(pred::ptrType, refmode);

    // Record pointer element type
    writeSimpleFact(pred::ptrTypeComp, refmode, to_string(elementType));

    // Record pointer address space
    if (unsigned addressSpace = ptrType->getPointerAddressSpace())
        writeSimpleFact(pred::ptrTypeAddrSpace, refmode, addressSpace);
}


void CsvGenerator::writeArrayType(const ArrayType *arrayType)
{
    string refmode = to_string(arrayType);
    size_t nElements = arrayType->getArrayNumElements();
    Type *componentType = arrayType->getArrayElementType();

    // Record array type entity
    writeEntity(pred::arrayType, refmode);

    // Record array component type
    writeSimpleFact(pred::arrayTypeComp, refmode, to_string(componentType));

    // Record array type size
    writeSimpleFact(pred::arrayTypeSize, refmode, nElements);
}


void CsvGenerator::writeStructType(const StructType *structType)
{
    string refmode = to_string(structType);
    size_t nFields = structType->getStructNumElements();

    // Record struct type entity
    writeEntity(pred::structType, refmode);

    if (structType->isOpaque()) {
        // Opaque structs carry no info about their internal structure
        writeEntity(pred::opaqueStructType, refmode);
    } else {
        // Record struct field types
        for (size_t i = 0; i < nFields; i++)
        {
            Type *fieldType = structType->getStructElementType(i);

            writeSimpleFact(pred::structTypeField, refmode, to_string(fieldType), i);
        }

        // Record number of fields
        writeSimpleFact(pred::structTypeNFields, refmode, nFields);
    }
}


void CsvGenerator::writeFunctionType(const FunctionType *functionType)
{
    string signature   = to_string(functionType);
    size_t nParameters = functionType->getFunctionNumParams();
    Type  *returnType  = functionType->getReturnType();

    // Record function type entity
    writeEntity(pred::funcType, signature);

    // TODO: which predicate/entity do we need to update for varagrs?
    if (functionType->isVarArg())
        writeEntity(pred::funcTypeVarArgs, signature);

    // Record return type
    writeSimpleFact(pred::funcTypeReturn, signature, to_string(returnType));

    // Record function formal parameters
    for (size_t i = 0; i < nParameters; i++)
    {
        Type *paramType = functionType->getFunctionParamType(i);

        writeSimpleFact(pred::funcTypeParam, signature, to_string(paramType), i);
    }

    // Record number of formal parameters
    writeSimpleFact(pred::funcTypeNParams, signature, nParameters);
}


void CsvGenerator::writeVectorType(const VectorType *vectorType)
{
    string refmode = to_string(vectorType);
    size_t nElements = vectorType->getVectorNumElements();
    Type *componentType = vectorType->getVectorElementType();

    // Record vector type entity
    writeEntity(pred::vectorType, refmode);

    // Record vector component type
    writeSimpleFact(pred::vectorTypeComp, refmode, to_string(componentType));

    // Record vector type size
    writeSimpleFact(pred::vectorTypeSize, refmode, nElements);
}


void CsvGenerator::writeGlobalVar(const GlobalVariable *gv, string refmode)
{
    // Record global variable entity
    writeEntity(pred::globalVar, refmode);

    // Serialize global variable properties
    string visibility = to_string(gv->getVisibility());
    string linkage    = to_string(gv->getLinkage());
    string varType    = to_string(gv->getType()->getElementType());
    string thrLocMode = to_string(gv->getThreadLocalMode());

    // Record external linkage
    if (!gv->hasInitializer() && gv->hasExternalLinkage())
        writeSimpleFact(pred::globalVarLink, refmode, "external");

    // Record linkage
    if (!linkage.empty())
        writeSimpleFact(pred::globalVarLink, refmode, linkage);

    // Record visibility
    if (!visibility.empty())
        writeSimpleFact(pred::globalVarVis, refmode, visibility);

    // Record thread local mode
    if (!thrLocMode.empty())
        writeSimpleFact(pred::globalVarTlm, refmode, thrLocMode);

    // TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized())
        writeSimpleFact(pred::globalVarFlag, refmode, "externally_initialized");

    // Record flags and type
    const char * flag = gv->isConstant() ? "constant": "global";

    writeSimpleFact(pred::globalVarFlag, refmode, flag);
    writeSimpleFact(pred::globalVarType, refmode, varType);

    // Record initializer
    if (gv->hasInitializer()) {
        string val = valueToString(gv->getInitializer(), gv->getParent()); // CHECK
        writeSimpleFact(pred::globalVarInit, refmode, val);
    }

    // Record section
    if (gv->hasSection())
        writeSimpleFact(pred::globalVarSect, refmode, gv->getSection());

    // Record alignment
    if (gv->getAlignment())
        writeSimpleFact(pred::globalVarAlign, refmode, gv->getAlignment());
}


void CsvGenerator::writeGlobalAlias(const GlobalAlias *ga, string refmode)
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
    writeEntity(pred::alias, refmode);

    // Serialize alias properties
    string visibility = to_string(ga->getVisibility());
    string linkage    = to_string(ga->getLinkage());
    string aliasType  = to_string(ga->getType());

    // Record visibility
    if (!visibility.empty())
        writeSimpleFact(pred::aliasVis, refmode, visibility);

    // Record linkage
    if (!linkage.empty())
        writeSimpleFact(pred::aliasLink, refmode, linkage);

    // Record type
    writeSimpleFact(pred::aliasType, refmode, aliasType);

    // Record aliasee
    if (Aliasee) {
        string aliasee = valueToString(Aliasee, ga->getParent()); // CHECK
        writeSimpleFact(pred::aliasAliasee, refmode, aliasee);
    }
}



//-------------------------------------------------------------------
// Static serializing methods for various LLVM enum-like types
//-------------------------------------------------------------------

string CsvGenerator::to_string(GlobalValue::LinkageTypes LT)
{
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


string CsvGenerator::to_string(GlobalValue::VisibilityTypes Vis)
{
    const char *visibility;

    switch (Vis) {
      case GlobalValue::DefaultVisibility:    visibility = "default";     break;
      case GlobalValue::HiddenVisibility:     visibility = "hidden";      break;
      case GlobalValue::ProtectedVisibility:  visibility = "protected";   break;
      default: visibility = "";   break;
    }

    return visibility;
}


string CsvGenerator::to_string(GlobalVariable::ThreadLocalMode TLM)
{
    const char *tlm;

    switch (TLM) {
      case GlobalVariable::NotThreadLocal:
          tlm = "";
          break;
      case GlobalVariable::GeneralDynamicTLSModel:
          tlm = "thread_local";
          break;
      case GlobalVariable::LocalDynamicTLSModel:
          tlm = "thread_local(localdynamic)";
          break;
      case GlobalVariable::InitialExecTLSModel:
          tlm = "thread_local(initialexec)";
          break;
      case GlobalVariable::LocalExecTLSModel:
          tlm = "thread_local(localexec)";
          break;
      default: tlm = ""; break;
    }
    return tlm;
}
