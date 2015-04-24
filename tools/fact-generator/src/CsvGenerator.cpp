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

    // Cache the data layout so that it is available at the
    // postprocessing step of recording the encountered types

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
        string funcRef = "<" + path + ">:" + string(fi->getName());
        string instrId = funcRef + ":";
        IV.setInstrId(instrId);

        // Record function type
        types.insert(fi->getFunctionType());

        // Serialize function properties
        string visibility = to_string(fi->getVisibility());
        string linkage = to_string(fi->getLinkage());
        string typeSignature = to_string(fi->getFunctionType());

        // Record function type signature
        writeSimpleFact(pred::FuncType, funcRef, typeSignature);

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            writeSimpleFact(pred::FuncLink, funcRef, linkage);

        if (!visibility.empty())
            writeSimpleFact(pred::FuncVis, funcRef, visibility);

        if (fi->getAlignment())
            writeSimpleFact(pred::FuncAlign, funcRef, fi->getAlignment());

        if (fi->hasGC())
            writeSimpleFact(pred::FuncGc, funcRef, fi->getGC());

        // Record calling convection if it not defaults to C
        if (fi->getCallingConv() != CallingConv::C)
            writeSimpleFact(pred::FuncCallConv, funcRef, to_string(fi->getCallingConv()));

        // Record function name
        writeSimpleFact(pred::FuncName, funcRef, "@" + fi->getName().str());

        // Address not significant
        if (fi->hasUnnamedAddr())
            writeEntity(pred::FuncUnnamedAddr, funcRef);

        // Record function attributes TODO
        const AttributeSet &Attrs = fi->getAttributes();

        if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
            writeSimpleFact(pred::FuncRetAttr, funcRef, Attrs.getAsString(AttributeSet::ReturnIndex));

        vector<string> FuncnAttr;
        writeFnAttributes(Attrs, FuncnAttr);

        for (size_t i = 0; i < FuncnAttr.size(); i++)
            writeSimpleFact(pred::FuncAttr, funcRef, FuncnAttr[i]);

        // Nothing more to do for function declarations
        if (fi->isDeclaration()) {
            writeEntity(pred::FuncDecl, funcRef); // record function declaration
            continue;
        }

        // Record function definition entity
        writeEntity(pred::Func, funcRef);

        // Record section
        if(fi->hasSection())
            writeSimpleFact(pred::FuncSect, funcRef, fi->getSection());

        // Record function parameters
        {
            int index = 0;

            for (Function::const_arg_iterator
                     arg = fi->arg_begin(), arg_end = fi->arg_end();
                 arg != arg_end; arg++)
            {
                string varId = instrId + valueToString(arg, Mod);

                writeSimpleFact(pred::FuncParam, funcRef, varId, index++);
                recordVariable(varId, arg->getType());
            }
        }

        int counter = 0;

        // iterating over basic blocks in a function
        //REVIEW: There must be a way to move this whole logic inside InstructionVisitor, i.e., visit(Module M)
        foreach (const llvm::BasicBlock &bb, *fi)
        {
            string funcPrefix = funcRef + ":";
            string bbRef = funcPrefix + valueToString(&bb, Mod);

            // Record basic block entry as a label
            writeEntity(pred::variable, bbRef);
            writeSimpleFact(pred::variableType, bbRef, "label");

            // Record basic block predecessors
            BasicBlock *tmpBB = const_cast<BasicBlock *>(&bb);

            for (pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                string predBB = funcPrefix + valueToString(*pi, Mod);
                writeSimpleFact(pred::basicBlockPred, bbRef, predBB);
            }

            // Store last instruction
            const llvm::Instruction &lastInstr = bb.back();

            // iterating over basic block instructions
            foreach (const llvm::Instruction &instr, bb)
            {
                // Compute instruction refmode
                string instrRef = instrId + std::to_string(counter++);

                // Record instruction target variable if such exists
                if (!instr.getType()->isVoidTy()) {
                    string targetVar = instrId + valueToString(&instr, Mod);

                    writeSimpleFact(pred::insnTo, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    string nextInstrRef = instrId + std::to_string(counter);

                    // Record the instruction succession
                    writeSimpleFact(pred::insnNext, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                writeSimpleFact(pred::insnFunc, instrRef, funcRef);

                // Record instruction's basic block entry (label)
                string bbEntry = instrId + valueToString(instr.getParent(), Mod);
                writeSimpleFact(pred::insnBBEntry, instrRef, bbEntry);

                // Instruction Visitor TODO
                IV.setInstrNum(instrRef);

                // Visit instruction
                IV.visit(const_cast<llvm::Instruction &>(instr));
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
    unordered_set<const llvm::Type *> collectedTypes = collector(types);

    // Add basic primitive types
    writeEntity(pred::primitiveType, "void");
    writeEntity(pred::primitiveType, "label");
    writeEntity(pred::primitiveType, "metadata");
    writeEntity(pred::primitiveType, "x86mmx");

    // Record each type encountered
    foreach (const Type *type, collectedTypes)
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


string CsvGenerator::to_string(CallingConv::ID cc)
{
    string conv;

    switch (cc) {
        //TODO:CallingConv::C
      case CallingConv::Fast:             conv =  "fastcc";           break;
      case CallingConv::Cold:             conv =  "coldcc";           break;
      case CallingConv::X86_FastCall:     conv =  "x86_fastcallcc";   break;
      case CallingConv::X86_StdCall:      conv =  "x86_stdcallcc";    break;
      case CallingConv::X86_ThisCall:     conv =  "x86_thiscallcc";   break;
      case CallingConv::Intel_OCL_BI:     conv =  "intel_ocl_bicc";   break;
      case CallingConv::ARM_AAPCS:        conv =  "arm_aapcscc";      break;
      case CallingConv::ARM_AAPCS_VFP:    conv =  "arm_aapcs_vfpcc";  break;
      case CallingConv::ARM_APCS:         conv =  "arm_apcscc";       break;
      case CallingConv::MSP430_INTR:      conv =  "msp430_intrcc";    break;
      case CallingConv::PTX_Device:       conv =  "tx_device";        break;
      case CallingConv::PTX_Kernel:       conv =  "ptx_kernel";       break;
      default:
          conv = "cc" + static_cast<ostringstream*>(&(ostringstream() << cc))->str();
          break;
    }
    return conv;
}
