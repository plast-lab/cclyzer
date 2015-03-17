#ifndef PREDICATE_NAMES_H__
#define PREDICATE_NAMES_H__

namespace predicate_names {

// Basic Blocks

    extern const char * basicBlockPred;

// Global

    extern const char * globalVar;
    extern const char * globalVarType;
    extern const char * globalVarInit;
    extern const char * globalVarSect;
    extern const char * globalVarAlign;
    extern const char * globalVarFlag;
    extern const char * globalVarLink;
    extern const char * globalVarVis;
    extern const char * globalVarTlm;

    extern const char * alias;
    extern const char * aliasType;
    extern const char * aliasLink;
    extern const char * aliasVis;
    extern const char * aliasAliasee;

// Function

    extern const char * Func;
    extern const char * FuncDecl;
    extern const char * FuncUnnamedAddr;
    extern const char * FuncLink;
    extern const char * FuncVis;
    extern const char * FuncCallConv;
    extern const char * FuncSect;
    extern const char * FuncAlign;
    extern const char * FuncAttr;
    extern const char * FuncGc;
    extern const char * FuncName;
    extern const char * FuncType;
    extern const char * FuncParam;
    extern const char * FuncRetAttr;
    extern const char * FuncParamAttr;

// Instructions

    extern const char * insnTo;
    extern const char * insnFlag;
    extern const char * insnNext;
    extern const char * insnBBEntry;
    extern const char * insnFunc;

// Binary Instructions

    extern const char * addInsn;
    extern const char * addInsnFirstOp;
    extern const char * addInsnSecondOp;

    extern const char * faddInsn;
    extern const char * faddInsnFirstOp;
    extern const char * faddInsnSecondOp;

    extern const char * subInsn;
    extern const char * subInsnFirstOp;
    extern const char * subInsnSecondOp;

    extern const char * fsubInsn;
    extern const char * fsubInsnFirstOp;
    extern const char * fsubInsnSecondOp;

    extern const char * mulInsn;
    extern const char * mulInsnFirstOp;
    extern const char * mulInsnSecondOp;

    extern const char * fmulInsn;
    extern const char * fmulInsnFirstOp;
    extern const char * fmulInsnSecondOp;

    extern const char * udivInsn;
    extern const char * udivInsnFirstOp;
    extern const char * udivInsnSecondOp;

    extern const char * fdivInsn;
    extern const char * fdivInsnFirstOp;
    extern const char * fdivInsnSecondOp;

    extern const char * sdivInsn;
    extern const char * sdivInsnFirstOp;
    extern const char * sdivInsnSecondOp;

    extern const char * uremInsn;
    extern const char * uremInsnFirstOp;
    extern const char * uremInsnSecondOp;

    extern const char * sremInsn;
    extern const char * sremInsnFirstOp;
    extern const char * sremInsnSecondOp;

    extern const char * fremInsn;
    extern const char * fremInsnFirstOp;
    extern const char * fremInsnSecondOp;

// Bitwise Binary Instructions

    extern const char * shlInsn;
    extern const char * shlInsnFirstOp;
    extern const char * shlInsnSecondOp;

    extern const char * lshrInsn;
    extern const char * lshrInsnFirstOp;
    extern const char * lshrInsnSecondOp;

    extern const char * ashrInsn;
    extern const char * ashrInsnFirstOp;
    extern const char * ashrInsnSecondOp;

    extern const char * andInsn;
    extern const char * andInsnFirstOp;
    extern const char * andInsnSecondOp;

    extern const char * orInsn;
    extern const char * orInsnFirstOp;
    extern const char * orInsnSecondOp;

    extern const char * xorInsn;
    extern const char * xorInsnFirstOp;
    extern const char * xorInsnSecondOp;

// Terminator Instructions

    extern const char * retInsn;
    extern const char * retInsnVoid;
    extern const char * retInsnOp;

    extern const char * brInsn;
    extern const char * brCondInsn;
    extern const char * brCondInsnCondition;
    extern const char * brCondInsnIfTrue;
    extern const char * brCondInsnIfFalse;
    extern const char * brUncondInsn;
    extern const char * brUncondInsnDest;

    extern const char * switchInsn;
    extern const char * switchInsnOp;
    extern const char * switchInsnDefLabel;
    extern const char * switchInsnCaseVal;
    extern const char * switchInsnCaseLabel;
    extern const char * switchInsnNCases;

    extern const char * indirectbrInsn;
    extern const char * indirectbrInsnAddr;
    extern const char * indirectbrInsnLabel;
    extern const char * indirectbrInsnNLabels;

    extern const char * resumeInsn;
    extern const char * resumeInsnOp;

    extern const char * unreachableInsn;

    extern const char * invokeInsn;
    extern const char * invokeInsnFunc;
    extern const char * directInvokeInsn;
    extern const char * indirectInvokeInsn;
    extern const char * invokeInsnCallConv;
    extern const char * invokeInsnArg;
    extern const char * invokeInsnRetAttr;
    extern const char * invokeInsnParamAttr;
    extern const char * invokeInsnFuncAttr;
    extern const char * invokeInsnNormalLabel;
    extern const char * invokeInsnExceptLabel;

// Vector Operations

    extern const char * extractElemInsn;
    extern const char * extractElemInsnBase;
    extern const char * extractElemInsnIndex;

    extern const char * insertElemInsn;
    extern const char * insertElemInsnBase;
    extern const char * insertElemInsnIndex;
    extern const char * insertElemInsnValue;

    extern const char * shuffleVectorInsn;
    extern const char * shuffleVectorInsnFirstVec;
    extern const char * shuffleVectorInsnSecondVec;
    extern const char * shuffleVectorInsnMask;

// Aggregate Operations

    extern const char * extractValueInsn;
    extern const char * extractValueInsnBase;
    extern const char * extractValueInsnIndex;
    extern const char * extractValueInsnNIndices;

    extern const char * insertValueInsn;
    extern const char * insertValueInsnBase;
    extern const char * insertValueInsnValue;
    extern const char * insertValueInsnIndex;
    extern const char * insertValueInsnNIndices;

// Memory Operations

    extern const char * allocaInsn;
    extern const char * allocaInsnAlign;
    extern const char * allocaInsnSize;
    extern const char * allocaInsnType;

    extern const char * loadInsn;
    extern const char * loadInsnAlign;
    extern const char * loadInsnOrd;
    extern const char * loadInsnAddr;
    extern const char * loadInsnVolatile;

    extern const char * storeInsn;
    extern const char * storeInsnAlign;
    extern const char * storeInsnOrd;
    extern const char * storeInsnValue;
    extern const char * storeInsnAddr;
    extern const char * storeInsnVolatile;

    extern const char * fenceInsn;
    extern const char * fenceInsnOrd;

    extern const char * atomicRMWInsn;
    extern const char * atomicRMWInsnOrd;
    extern const char * atomicRMWInsnOper;
    extern const char * atomicRMWInsnAddr;
    extern const char * atomicRMWInsnValue;
    extern const char * atomicRMWInsnVolatile;

    extern const char * cmpxchgInsn;
    extern const char * cmpxchgInsnOrd;
    extern const char * cmpxchgInsnAddr;
    extern const char * cmpxchgInsnCmp;
    extern const char * cmpxchgInsnNew;
    extern const char * cmpxchgInsnType;
    extern const char * cmpxchgInsnVolatile;

    extern const char * gepInsn;
    extern const char * gepInsnBase;
    extern const char * gepInsnIndex;
    extern const char * gepInsnNIndices;
    extern const char * gepInsnInbounds;

// Conversion Operations

    extern const char * truncInsn;
    extern const char * truncInsnFrom;
    extern const char * truncInsnToType;

    extern const char * zextInsn;
    extern const char * zextInsnFrom;
    extern const char * zextInsnToType;

    extern const char * sextInsn;
    extern const char * sextInsnFrom;
    extern const char * sextInsnToType;

    extern const char * fptruncInsn;
    extern const char * fptruncInsnFrom;
    extern const char * fptruncInsnToType;

    extern const char * fpextInsn;
    extern const char * fpextInsnFrom;
    extern const char * fpextInsnToType;

    extern const char * fptouiInsn;
    extern const char * fptouiInsnFrom;
    extern const char * fptouiInsnToType;

    extern const char * fptosiInsn;
    extern const char * fptosiInsnFrom;
    extern const char * fptosiInsnToType;

    extern const char * uitofpInsn;
    extern const char * uitofpInsnFrom;
    extern const char * uitofpInsnToType;

    extern const char * sitofpInsn;
    extern const char * sitofpInsnFrom;
    extern const char * sitofpInsnToType;

    extern const char * ptrtointInsn;
    extern const char * ptrtointInsnFrom;
    extern const char * ptrtointInsnToType;

    extern const char * inttoptrInsn;
    extern const char * inttoptrInsnFrom;
    extern const char * inttoptrInsnToType;

    extern const char * bitcastInsn;
    extern const char * bitcastInsnFrom;
    extern const char * bitcastInsnToType;

// Other Operations

    extern const char * icmpInsn;
    extern const char * icmpInsnCond;
    extern const char * icmpInsnFirstOp;
    extern const char * icmpInsnSecondOp;

    extern const char * fcmpInsn;
    extern const char * fcmpInsnCond;
    extern const char * fcmpInsnFirstOp;
    extern const char * fcmpInsnSecondOp;

    extern const char * phiInsn;
    extern const char * phiInsnType;
    extern const char * phiInsnPairValue;
    extern const char * phiInsnPairLabel;
    extern const char * phiInsnNPairs;

    extern const char * selectInsn;
    extern const char * selectInsnCond;
    extern const char * selectInsnFirstOp;
    extern const char * selectInsnSecondOp;

    extern const char * vaargInsn;
    extern const char * vaargInsnList;
    extern const char * vaargInsnType;

    extern const char * callInsn;
    extern const char * callInsnFunction;
    extern const char * directCallInsn;
    extern const char * indirectCallInsn;
    extern const char * callCallConv;
    extern const char * callInsnArg;
    extern const char * callInsnRetAttr;
    extern const char * callInsnParamAttr;
    extern const char * callInsnFuncAttr;
    extern const char * callInsnTail;

    extern const char * landingpadInsn;
    extern const char * landingpadInsnType;
    extern const char * landingpadInsnFunc;
    extern const char * landingpadInsnCatch;
    extern const char * landingpadInsnFilter;
    extern const char * landingpadInsnNClauses;
    extern const char * landingpadInsnCleanup;

// Types

    extern const char * primitiveType;
    extern const char * intType;
    extern const char * fpType;

    extern const char * funcType;
    extern const char * funcTypeVarArgs;
    extern const char * funcTypeReturn;
    extern const char * funcTypeParam;
    extern const char * funcTypeNParams;

    extern const char * ptrType;
    extern const char * ptrTypeComp;
    extern const char * ptrTypeAddrSpace;

    extern const char * vectorType;
    extern const char * vectorTypeComp;
    extern const char * vectorTypeSize;

    extern const char * arrayType;
    extern const char * arrayTypeComp;
    extern const char * arrayTypeSize;

    extern const char * structType;
    extern const char * structTypeField;
    extern const char * structTypeNFields;
    extern const char * opaqueStructType;

    extern const char * typeAllocSize;
    extern const char * typeStoreSize;

// Variables and Immediates

    extern const char * immediate;
    extern const char * immediateType;

    extern const char * variable;
    extern const char * variableType;

// Constants

    extern const char * constExpr;

// Auxiliary predicates

    extern const char * constToInt;

}

#endif
