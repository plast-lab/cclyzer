#ifndef __PREDICATE_NAMES_H__
#define __PREDICATE_NAMES_H__

#include <string>

class PredicateNames {

public:

	// Basic Blocks

	static const char * basicBlockPred;

	// Global

	static const char * globalVar;
	static const char * globalVarType;
	static const char * globalVarInit;
	static const char * globalVarSect;
	static const char * globalVarAlign;
	static const char * globalVarFlag;
	static const char * globalVarLink;
	static const char * globalVarVis;
	static const char * globalVarTlm;
	static const char * globalVarAddrSpace;
	static const char * globalVarUnnamed;
	static const char * alias;
	static const char * aliasType;
	static const char * aliasLink;
	static const char * aliasVis;
	static const char * aliasAliasee;

	// Function

	static const char * Func;
	static const char * FuncUnnamedAddr;
	static const char * FuncLink;
	static const char * FuncVis;
	static const char * FuncCallConv;
	static const char * FuncSect;
	static const char * FuncAlign;
	static const char * FuncAttr;
	static const char * FuncGc;
	static const char * FuncName;
	static const char * FuncType;
	static const char * FuncParam;
	static const char * FuncRetAttr;
	static const char * FuncParamAttr;

	// Instructions

	static const char * insnTo;
	static const char * insnFlag;
	static const char * insnNext;
	static const char * insnBBEntry;
	static const char * insnFunc;

	// Binary Instructions

	static const char * addInsn;
	static const char * addInsnFirstOp;
	static const char * addInsnSecondOp;

	static const char * faddInsn;
	static const char * faddInsnFirstOp;
	static const char * faddInsnSecondOp;

	static const char * subInsn;
	static const char * subInsnFirstOp;
	static const char * subInsnSecondOp;

	static const char * fsubInsn;
	static const char * fsubInsnFirstOp;
	static const char * fsubInsnSecondOp;

	static const char * mulInsn;
	static const char * mulInsnFirstOp;
	static const char * mulInsnSecondOp;

	static const char * fmulInsn;
	static const char * fmulInsnFirstOp;
	static const char * fmulInsnSecondOp;

	static const char * udivInsn;
	static const char * udivInsnFirstOp;
	static const char * udivInsnSecondOp;

	static const char * fdivInsn;
	static const char * fdivInsnFirstOp;
	static const char * fdivInsnSecondOp;

	static const char * sdivInsn;
	static const char * sdivInsnFirstOp;
	static const char * sdivInsnSecondOp;

	static const char * uremInsn;
	static const char * uremInsnFirstOp;
	static const char * uremInsnSecondOp;

	static const char * sremInsn;
	static const char * sremInsnFirstOp;
	static const char * sremInsnSecondOp;

	static const char * fremInsn;
	static const char * fremInsnFirstOp;
	static const char * fremInsnSecondOp;

	// Bitwise Binary Instructions

	static const char * shlInsn;
	static const char * shlInsnFirstOp;
	static const char * shlInsnSecondOp;

	static const char * lshrInsn;
	static const char * lshrInsnFirstOp;
	static const char * lshrInsnSecondOp;

	static const char * ashrInsn;
	static const char * ashrInsnFirstOp;
	static const char * ashrInsnSecondOp;

	static const char * andInsn;
	static const char * andInsnFirstOp;
	static const char * andInsnSecondOp;

	static const char * orInsn;
	static const char * orInsnFirstOp;
	static const char * orInsnSecondOp;

	static const char * xorInsn;
	static const char * xorInsnFirstOp;
	static const char * xorInsnSecondOp;

	// Terminator Instructions

	static const char * retInsn;
	static const char * retInsnVoid;
	static const char * retInsnOp;

	static const char * brInsn;
	static const char * brCondInsn;
	static const char * brCondInsnCondition;
	static const char * brCondInsnIfTrue;
	static const char * brCondInsnIfFalse;
	static const char * brUncondInsn;
	static const char * brUncondInsnDest;

	static const char * switchInsn;
	static const char * switchInsnOp;
	static const char * switchInsnDefLabel;
	static const char * switchInsnCaseVal;
	static const char * switchInsnCaseLabel;
	static const char * switchInsnNCases;

	static const char * indirectbrInsn;
	static const char * indirectbrInsnAddr;
	static const char * indirectbrInsnLabel;
	static const char * indirectbrInsnNLabels;

	static const char * resumeInsn;
	static const char * resumeInsnOp;

	static const char * unreachableInsn;

	static const char * invokeInsn;
	static const char * invokeInsnFunc;
	static const char * directInvokeInsn;
	static const char * indirectInvokeInsn;
	static const char * invokeInsnCallConv;
	static const char * invokeInsnArg;
	static const char * invokeInsnRetAttr;
	static const char * invokeInsnParamAttr;
	static const char * invokeInsnFuncAttr;
	static const char * invokeInsnNormalLabel;
	static const char * invokeInsnExceptLabel;

	// Vector Operations

	static const char * extractElemInsn;
	static const char * extractElemInsnBase;
	static const char * extractElemInsnIndex;

	static const char * insertElemInsn;
	static const char * insertElemInsnBase;
	static const char * insertElemInsnIndex;
	static const char * insertElemInsnValue;

	static const char * shuffleVectorInsn;
	static const char * shuffleVectorInsnFirstVec;
	static const char * shuffleVectorInsnSecondVec;
	static const char * shuffleVectorInsnMask;

	// Aggregate Operations

	static const char * extractValueInsn;
	static const char * extractValueInsnBase;
	static const char * extractValueInsnIndex;
	static const char * extractValueInsnNIndices;

	static const char * insertValueInsn;
	static const char * insertValueInsnBase;
	static const char * insertValueInsnValue;
	static const char * insertValueInsnIndex;
	static const char * insertValueInsnNIndices;

	// Memory Operations

	static const char * allocaInsn;
	static const char * allocaInsnAlign;
	static const char * allocaInsnSize;
	static const char * allocaInsnType;

	static const char * loadInsn;
	static const char * loadInsnAlign;
	static const char * loadInsnOrd;
	static const char * loadInsnAddr;

	static const char * storeInsn;
	static const char * storeInsnAlign;
	static const char * storeInsnOrd;
	static const char * storeInsnValue;
	static const char * storeInsnAddr;

	static const char * fenceInsn;
	static const char * fenceInsnOrd;

	static const char * atomicRMWInsn;
	static const char * atomicRMWInsnOrd;
	static const char * atomicRMWInsnOper;
	static const char * atomicRMWInsnAddr;
	static const char * atomicRMWInsnValue;

	static const char * cmpxchgInsn;
	static const char * cmpxchgInsnOrd;
	static const char * cmpxchgInsnAddr;
	static const char * cmpxchgInsnCmp;
	static const char * cmpxchgInsnNew;
	static const char * cmpxchgInsnType;

	static const char * gepInsn;
	static const char * gepInsnBase;
	static const char * gepInsnIndex;
	static const char * gepInsnNIndices;

	// Conversion Operations

	static const char * truncInsn;
	static const char * truncInsnFrom;
	static const char * truncInsnToType;

	static const char * zextInsn;
	static const char * zextInsnFrom;
	static const char * zextInsnToType;

	static const char * sextInsn;
	static const char * sextInsnFrom;
	static const char * sextInsnToType;

	static const char * fptruncInsn;
	static const char * fptruncInsnFrom;
	static const char * fptruncInsnToType;

	static const char * fpextInsn;
	static const char * fpextInsnFrom;
	static const char * fpextInsnToType;

	static const char * fptouiInsn;
	static const char * fptouiInsnFrom;
	static const char * fptouiInsnToType;

	static const char * fptosiInsn;
	static const char * fptosiInsnFrom;
	static const char * fptosiInsnToType;

	static const char * uitofpInsn;
	static const char * uitofpInsnFrom;
	static const char * uitofpInsnToType;

	static const char * sitofpInsn;
	static const char * sitofpInsnFrom;
	static const char * sitofpInsnToType;

	static const char * ptrtointInsn;
	static const char * ptrtointInsnFrom;
	static const char * ptrtointInsnToType;

	static const char * inttoptrInsn;
	static const char * inttoptrInsnFrom;
	static const char * inttoptrInsnToType;

	static const char * bitcastInsn;
	static const char * bitcastInsnFrom;
	static const char * bitcastInsnToType;

	// Other Operations

	static const char * icmpInsn;
	static const char * icmpInsnCond;
	static const char * icmpInsnFirstOp;
	static const char * icmpInsnSecondOp;

	static const char * fcmpInsn;
	static const char * fcmpInsnCond;
	static const char * fcmpInsnFirstOp;
	static const char * fcmpInsnSecondOp;

	static const char * phiInsn;
	static const char * phiInsnType;
	static const char * phiInsnPairValue;
	static const char * phiInsnPairLabel;
	static const char * phiInsnNPairs;

	static const char * selectInsn;
	static const char * selectInsnCond;
	static const char * selectInsnFirstOp;
	static const char * selectInsnSecondOp;

	static const char * vaargInsn;
	static const char * vaargInsnList;
	static const char * vaargInsnType;

	static const char * callInsn;
	static const char * callInsnFunction;
	static const char * directCallInsn;
	static const char * indirectCallInsn;
	static const char * callCallConv;
	static const char * callInsnArg;
	static const char * callInsnRetAttr;
	static const char * callInsnParamAttr;
	static const char * callInsnFuncAttr;

	static const char * landingpadInsn;
	static const char * landingpadInsnCleanup;
	static const char * landingpadInsnType;
	static const char * landingpadInsnFunc;
	static const char * landingpadInsnCatch;
	static const char * landingpadInsnFilter;
	static const char * landingpadInsnNClauses;

	// Types

	static const char * primitiveType;
	static const char * intType;
	static const char * fpType;

	static const char * funcType;
	static const char * funcTypeVarArgs;
	static const char * funcTypeReturn;
	static const char * funcTypeParam;
	static const char * funcTypeNParams;

	static const char * ptrType;
	static const char * ptrTypeComp;
	static const char * ptrTypeAddrSpace;

	static const char * vectorType;
	static const char * vectorTypeComp;
	static const char * vectorTypeSize;

	static const char * arrayType;
	static const char * arrayTypeComp;
	static const char * arrayTypeSize;

	static const char * structType;
	static const char * structTypeField;
	static const char * structTypeNFields;
	static const char * opaqueStructType;

	// Variables and Immediates

	static const char * immediate;
	static const char * immediateType;

	static const char * variable;
	static const char * variableType;

    //Auxiliary predicates

    static const char * constToInt;

	// methods for converting a predicate name into a filename

	static const std::string predNameToFilename(const char *);
	static const std::string predNameWithOperandToFilename(const char *, bool);	// predicate names witn operands
};

#endif
