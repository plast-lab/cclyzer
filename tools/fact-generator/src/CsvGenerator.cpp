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
        writeSimpleFact(pred::function::type, funcRef, typeSignature);

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            writeSimpleFact(pred::function::linkage, funcRef, linkage);

        if (!visibility.empty())
            writeSimpleFact(pred::function::visibility, funcRef, visibility);

        if (fi->getAlignment())
            writeSimpleFact(pred::function::alignment, funcRef, fi->getAlignment());

        if (fi->hasGC())
            writeSimpleFact(pred::function::gc, funcRef, fi->getGC());

        // Record calling convection if it not defaults to C
        if (fi->getCallingConv() != CallingConv::C)
            writeSimpleFact(pred::function::calling_conv, funcRef, to_string(fi->getCallingConv()));

        // Record function name
        writeSimpleFact(pred::function::name, funcRef, "@" + fi->getName().str());

        // Address not significant
        if (fi->hasUnnamedAddr())
            writeEntity(pred::function::unnamed_addr, funcRef);

        // Record function attributes TODO
        const AttributeSet &Attrs = fi->getAttributes();

        if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
            writeSimpleFact(pred::function::ret_attr, funcRef,
                            Attrs.getAsString(AttributeSet::ReturnIndex));

        vector<string> FuncnAttr;
        writeFnAttributes(Attrs, FuncnAttr);

        for (size_t i = 0; i < FuncnAttr.size(); i++)
            writeSimpleFact(pred::function::attr, funcRef, FuncnAttr[i]);

        // Nothing more to do for function declarations
        if (fi->isDeclaration()) {
            writeEntity(pred::function::id_decl, funcRef); // record function declaration
            continue;
        }

        // Record function definition entity
        writeEntity(pred::function::id_defn, funcRef);

        // Record section
        if(fi->hasSection())
            writeSimpleFact(pred::function::section, funcRef, fi->getSection());

        // Record function parameters
        {
            int index = 0;

            for (Function::const_arg_iterator
                     arg = fi->arg_begin(), arg_end = fi->arg_end();
                 arg != arg_end; arg++)
            {
                string varId = instrId + valueToString(arg, Mod);

                writeSimpleFact(pred::function::param, funcRef, varId, index++);
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
            writeEntity(pred::variable::id, bbRef);
            writeSimpleFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            BasicBlock *tmpBB = const_cast<BasicBlock *>(&bb);

            for (pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                string predBB = funcPrefix + valueToString(*pi, Mod);
                writeSimpleFact(pred::basic_block::predecessor, bbRef, predBB);
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

                    writeSimpleFact(pred::instruction::to, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    string nextInstrRef = instrId + std::to_string(counter);

                    // Record the instruction succession
                    writeSimpleFact(pred::instruction::next, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                writeSimpleFact(pred::instruction::function, instrRef, funcRef);

                // Record instruction's basic block entry (label)
                string bbEntry = instrId + valueToString(instr.getParent(), Mod);
                writeSimpleFact(pred::instruction::bb_entry, instrRef, bbEntry);

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
        writeEntity(pred::constant::id, refmode);
        writeSimpleFact(pred::constant::type, refmode, to_string(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record variable entity with its type
        writeEntity(pred::variable::id, refmode);
        writeSimpleFact(pred::variable::type, refmode, to_string(type));

        types.insert(type);
    }

    // Type accumulator that identifies simple types from complex ones
    TypeAccumulator<unordered_set<const llvm::Type *> > collector;

    // Set of all encountered types
    unordered_set<const llvm::Type *> collectedTypes = collector(types);

    // Add basic primitive types
    writeEntity(pred::primitive_type::id, "void");
    writeEntity(pred::primitive_type::id, "label");
    writeEntity(pred::primitive_type::id, "metadata");
    writeEntity(pred::primitive_type::id, "x86mmx");

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
            writeSimpleFact(pred::type::alloc_size, to_string(type), allocSize);
            writeSimpleFact(pred::type::store_size, to_string(type), storeSize);
            break;
        }
    }

    // Record each different kind of type
    switch (type->getTypeID()) { // Fallthrough is intended
      case llvm::Type::VoidTyID:
      case llvm::Type::LabelTyID:
      case llvm::Type::MetadataTyID:
          writeEntity(pred::primitive_type::id, to_string(type));
          break;
      case llvm::Type::HalfTyID: // Fallthrough to all 6 floating point types
      case llvm::Type::FloatTyID:
      case llvm::Type::DoubleTyID:
      case llvm::Type::X86_FP80TyID:
      case llvm::Type::FP128TyID:
      case llvm::Type::PPC_FP128TyID:
          assert(type->isFloatingPointTy());
          writeEntity(pred::fp_type::id, to_string(type));
          break;
      case llvm::Type::IntegerTyID:
          writeEntity(pred::integer_type::id, to_string(type));
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
    writeEntity(pred::ptr_type::id, refmode);

    // Record pointer element type
    writeSimpleFact(pred::ptr_type::component_type, refmode, to_string(elementType));

    // Record pointer address space
    if (unsigned addressSpace = ptrType->getPointerAddressSpace())
        writeSimpleFact(pred::ptr_type::addr_space, refmode, addressSpace);
}


void CsvGenerator::writeArrayType(const ArrayType *arrayType)
{
    string refmode = to_string(arrayType);
    size_t nElements = arrayType->getArrayNumElements();
    Type *componentType = arrayType->getArrayElementType();

    // Record array type entity
    writeEntity(pred::array_type::id, refmode);

    // Record array component type
    writeSimpleFact(pred::array_type::component_type, refmode, to_string(componentType));

    // Record array type size
    writeSimpleFact(pred::array_type::size, refmode, nElements);
}


void CsvGenerator::writeStructType(const StructType *structType)
{
    string refmode = to_string(structType);
    size_t nFields = structType->getStructNumElements();

    // Record struct type entity
    writeEntity(pred::struct_type::id, refmode);

    if (structType->isOpaque()) {
        // Opaque structs carry no info about their internal structure
        writeEntity(pred::struct_type::opaque, refmode);
    } else {
        // Record struct field types
        for (size_t i = 0; i < nFields; i++)
        {
            Type *fieldType = structType->getStructElementType(i);

            writeSimpleFact(pred::struct_type::field_type, refmode, to_string(fieldType), i);
        }

        // Record number of fields
        writeSimpleFact(pred::struct_type::nfields, refmode, nFields);
    }
}


void CsvGenerator::writeFunctionType(const FunctionType *functionType)
{
    string signature   = to_string(functionType);
    size_t nParameters = functionType->getFunctionNumParams();
    Type  *returnType  = functionType->getReturnType();

    // Record function type entity
    writeEntity(pred::func_type::id, signature);

    // TODO: which predicate/entity do we need to update for varagrs?
    if (functionType->isVarArg())
        writeEntity(pred::func_type::varargs, signature);

    // Record return type
    writeSimpleFact(pred::func_type::return_type, signature, to_string(returnType));

    // Record function formal parameters
    for (size_t i = 0; i < nParameters; i++)
    {
        Type *paramType = functionType->getFunctionParamType(i);

        writeSimpleFact(pred::func_type::param_type, signature, to_string(paramType), i);
    }

    // Record number of formal parameters
    writeSimpleFact(pred::func_type::nparams, signature, nParameters);
}


void CsvGenerator::writeVectorType(const VectorType *vectorType)
{
    string refmode = to_string(vectorType);
    size_t nElements = vectorType->getVectorNumElements();
    Type *componentType = vectorType->getVectorElementType();

    // Record vector type entity
    writeEntity(pred::vector_type::id, refmode);

    // Record vector component type
    writeSimpleFact(pred::vector_type::component_type, refmode, to_string(componentType));

    // Record vector type size
    writeSimpleFact(pred::vector_type::size, refmode, nElements);
}


void CsvGenerator::writeGlobalVar(const GlobalVariable *gv, string refmode)
{
    // Record global variable entity
    writeEntity(pred::global_var::id, refmode);

    // Serialize global variable properties
    string visibility = to_string(gv->getVisibility());
    string linkage    = to_string(gv->getLinkage());
    string varType    = to_string(gv->getType()->getElementType());
    string thrLocMode = to_string(gv->getThreadLocalMode());

    // Record external linkage
    if (!gv->hasInitializer() && gv->hasExternalLinkage())
        writeSimpleFact(pred::global_var::linkage, refmode, "external");

    // Record linkage
    if (!linkage.empty())
        writeSimpleFact(pred::global_var::linkage, refmode, linkage);

    // Record visibility
    if (!visibility.empty())
        writeSimpleFact(pred::global_var::visibility, refmode, visibility);

    // Record thread local mode
    if (!thrLocMode.empty())
        writeSimpleFact(pred::global_var::threadlocal_mode, refmode, thrLocMode);

    // TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized())
        writeSimpleFact(pred::global_var::flag, refmode, "externally_initialized");

    // Record flags and type
    const char * flag = gv->isConstant() ? "constant": "global";

    writeSimpleFact(pred::global_var::flag, refmode, flag);
    writeSimpleFact(pred::global_var::type, refmode, varType);

    // Record initializer
    if (gv->hasInitializer()) {
        string val = valueToString(gv->getInitializer(), gv->getParent()); // CHECK
        writeSimpleFact(pred::global_var::initializer, refmode, val);
    }

    // Record section
    if (gv->hasSection())
        writeSimpleFact(pred::global_var::section, refmode, gv->getSection());

    // Record alignment
    if (gv->getAlignment())
        writeSimpleFact(pred::global_var::align, refmode, gv->getAlignment());
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
    writeEntity(pred::alias::id, refmode);

    // Serialize alias properties
    string visibility = to_string(ga->getVisibility());
    string linkage    = to_string(ga->getLinkage());
    string aliasType  = to_string(ga->getType());

    // Record visibility
    if (!visibility.empty())
        writeSimpleFact(pred::alias::visibility, refmode, visibility);

    // Record linkage
    if (!linkage.empty())
        writeSimpleFact(pred::alias::linkage, refmode, linkage);

    // Record type
    writeSimpleFact(pred::alias::type, refmode, aliasType);

    // Record aliasee
    if (Aliasee) {
        string aliasee = valueToString(Aliasee, ga->getParent()); // CHECK
        writeSimpleFact(pred::alias::aliasee, refmode, aliasee);
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
