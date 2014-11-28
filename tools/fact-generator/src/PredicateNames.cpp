#include "PredicateNames.hpp"

namespace predicate_names{

// Basic Blocks

    const char * basicBlockPred = "basicblock:pred_aux";

// Global

    const char * globalVar = "global_variable";
    const char * globalVarType = "global_variable:type";
    const char * globalVarInit = "global_variable:initializer";
    const char * globalVarSect = "global_variable:section";
    const char * globalVarAlign = "global_variable:align";
    const char * globalVarFlag = "global_variable:flag";
    const char * globalVarLink = "global_variable:linkage_type";
    const char * globalVarVis = "global_variable:visibility";
    const char * globalVarTlm = "global_variable:threadlocal_mode";

    const char * alias = "alias";
    const char * aliasType = "alias:type";
    const char * aliasLink = "alias:linkage_type";
    const char * aliasVis = "alias:visibility";
    const char * aliasAliasee = "alias:aliasee";

// Function

    const char * Func = "function";
    const char * FuncDecl = "function_decl";
    const char * FuncUnnamedAddr = "function:unnamed_addr";
    const char * FuncLink = "function:linkage_type";
    const char * FuncVis = "function:visibility";
    const char * FuncCallConv = "function:calling_convention";
    const char * FuncSect = "function:section";
    const char * FuncAlign = "function:alignment";
    const char * FuncAttr = "function:attributes";
    const char * FuncGc = "function:gc";
    const char * FuncName = "function:name";
    const char * FuncType = "function:type";
    const char * FuncParam = "function:param";
    const char * FuncRetAttr = "function:return_attribute";
    const char * FuncParamAttr = "function:param_attribute";

// Instructions

    const char * insnTo = "instruction:to";
    const char * insnFlag = "instruction:flag";
    const char * insnNext = "instruction:next";
    const char * insnBBEntry = "instruction:bb_entry";
    const char * insnFunc = "instruction:function";

// Binary Instructions

    const char * addInsn = "add_instruction";
    const char * addInsnFirstOp = "add_instruction:first_operand";
    const char * addInsnSecondOp = "add_instruction:second_operand";

    const char * faddInsn = "fadd_instruction";
    const char * faddInsnFirstOp = "fadd_instruction:first_operand";
    const char * faddInsnSecondOp = "fadd_instruction:second_operand";

    const char * subInsn = "sub_instruction";
    const char * subInsnFirstOp = "sub_instruction:first_operand";
    const char * subInsnSecondOp = "sub_instruction:second_operand";

    const char * fsubInsn = "fsub_instruction";
    const char * fsubInsnFirstOp = "fsub_instruction:first_operand";
    const char * fsubInsnSecondOp = "fsub_instruction:second_operand";

    const char * mulInsn = "mul_instruction";
    const char * mulInsnFirstOp = "mul_instruction:first_operand";
    const char * mulInsnSecondOp = "mul_instruction:second_operand";

    const char * fmulInsn = "fmul_instruction";
    const char * fmulInsnFirstOp = "fmul_instruction:first_operand";
    const char * fmulInsnSecondOp = "fmul_instruction:second_operand";

    const char * udivInsn = "udiv_instruction";
    const char * udivInsnFirstOp = "udiv_instruction:first_operand";
    const char * udivInsnSecondOp = "udiv_instruction:second_operand";

    const char * fdivInsn = "fdiv_instruction";
    const char * fdivInsnFirstOp = "fdiv_instruction:first_operand";
    const char * fdivInsnSecondOp = "fdiv_instruction:second_operand";

    const char * sdivInsn = "sdiv_instruction";
    const char * sdivInsnFirstOp = "sdiv_instruction:first_operand";
    const char * sdivInsnSecondOp = "sdiv_instruction:second_operand";

    const char * uremInsn = "urem_instruction";
    const char * uremInsnFirstOp = "urem_instruction:first_operand";
    const char * uremInsnSecondOp = "urem_instruction:second_operand";

    const char * sremInsn = "srem_instruction";
    const char * sremInsnFirstOp = "srem_instruction:first_operand";
    const char * sremInsnSecondOp = "srem_instruction:second_operand";

    const char * fremInsn = "frem_instruction";
    const char * fremInsnFirstOp = "frem_instruction:first_operand";
    const char * fremInsnSecondOp = "frem_instruction:second_operand";

// Bitwise Binary Instructions

    const char * shlInsn = "shl_instruction";
    const char * shlInsnFirstOp = "shl_instruction:first_operand";
    const char * shlInsnSecondOp = "shl_instruction:second_operand";

    const char * lshrInsn = "lshr_instruction";
    const char * lshrInsnFirstOp = "lshr_instruction:first_operand";
    const char * lshrInsnSecondOp = "lshr_instruction:second_operand";

    const char * ashrInsn = "ashr_instruction";
    const char * ashrInsnFirstOp = "ashr_instruction:first_operand";
    const char * ashrInsnSecondOp = "ashr_instruction:second_operand";

    const char * andInsn = "and_instruction";
    const char * andInsnFirstOp = "and_instruction:first_operand";
    const char * andInsnSecondOp = "and_instruction:second_operand";

    const char * orInsn = "or_instruction";
    const char * orInsnFirstOp = "or_instruction:first_operand";
    const char * orInsnSecondOp = "or_instruction:second_operand";

    const char * xorInsn = "xor_instruction";
    const char * xorInsnFirstOp = "xor_instruction:first_operand";
    const char * xorInsnSecondOp = "xor_instruction:second_operand";

// Terminator Instructions

    const char * retInsn = "ret_instruction";
    const char * retInsnVoid = "ret_instruction:void";
    const char * retInsnOp = "ret_instruction:value";

    const char * brInsn = "br_instruction";
    const char * brCondInsn = "br_cond_instruction";
    const char * brCondInsnCondition = "br_cond_instruction:condition";
    const char * brCondInsnIfTrue = "br_cond_instruction:iftrue";
    const char * brCondInsnIfFalse = "br_cond_instruction:iffalse";
    const char * brUncondInsn = "br_uncond_instruction";
    const char * brUncondInsnDest = "br_uncond_instruction:dest";

    const char * switchInsn = "switch_instruction";
    const char * switchInsnOp = "switch_instruction:operand";
    const char * switchInsnDefLabel = "switch_instruction:default_label";
    const char * switchInsnCaseVal = "switch_instruction:case:value";
    const char * switchInsnCaseLabel = "switch_instruction:case:label";
    const char * switchInsnNCases = "switch_instruction:ncases";

    const char * indirectbrInsn = "indirectbr_instruction";
    const char * indirectbrInsnAddr = "indirectbr_instruction:address";
    const char * indirectbrInsnLabel = "indirectbr_instruction:label";
    const char * indirectbrInsnNLabels = "indirectbr_instruction:nlabels";

    const char * resumeInsn = "resume_instruction";
    const char * resumeInsnOp = "resume_instruction:operand";

    const char * unreachableInsn = "unreachable_instruction";

    const char * invokeInsn = "invoke_instruction";
    const char * invokeInsnFunc = "invoke_instruction:function";
    const char * directInvokeInsn = "direct_invoke_instruction";
    const char * indirectInvokeInsn = "indirect_invoke_instruction";
    const char * invokeInsnCallConv = "invoke_instruction:calling_convention";
    const char * invokeInsnArg = "invoke_instruction:arg";
    const char * invokeInsnRetAttr = "invoke_instruction:return_attribute";
    const char * invokeInsnParamAttr = "invoke_instruction:param_attribute";
    const char * invokeInsnFuncAttr = "invoke_instruction:function_attribute";
    const char * invokeInsnNormalLabel = "invoke_instruction:normal_label";
    const char * invokeInsnExceptLabel = "invoke_instruction:exception_label";

// Vector Operations

    const char * extractElemInsn = "extractelement_instruction";
    const char * extractElemInsnBase = "extractelement_instruction:base";
    const char * extractElemInsnIndex = "extractelement_instruction:index";

    const char * insertElemInsn = "insertelement_instruction";
    const char * insertElemInsnBase = "insertelement_instruction:base";
    const char * insertElemInsnIndex = "insertelement_instruction:index";
    const char * insertElemInsnValue = "insertelement_instruction:value";

    const char * shuffleVectorInsn = "shufflevector_instruction";
    const char * shuffleVectorInsnFirstVec = "shufflevector_instruction:first_vector";
    const char * shuffleVectorInsnSecondVec = "shufflevector_instruction:second_vector";
    const char * shuffleVectorInsnMask = "shufflevector_instruction:mask";

// Aggregate Operations

    const char * extractValueInsn = "extractvalue_instruction";
    const char * extractValueInsnBase = "extractvalue_instruction:base";
    const char * extractValueInsnIndex = "extractvalue_instruction:index";
    const char * extractValueInsnNIndices = "extractvalue_instruction:nindices";

    const char * insertValueInsn = "insertvalue_instruction";
    const char * insertValueInsnBase = "insertvalue_instruction:base";
    const char * insertValueInsnValue = "insertvalue_instruction:value";
    const char * insertValueInsnIndex = "insertvalue_instruction:index";
    const char * insertValueInsnNIndices = "insertvalue_instruction:nindices";

// Memory Operations

    const char * allocaInsn = "alloca_instruction";
    const char * allocaInsnAlign = "alloca_instruction:alignment";
    const char * allocaInsnSize = "alloca_instruction:size";
    const char * allocaInsnType = "alloca_instruction:type";

    const char * loadInsn = "load_instruction";
    const char * loadInsnAlign = "load_instruction:alignment";
    const char * loadInsnOrd = "load_instruction:ordering";
    const char * loadInsnAddr = "load_instruction:address";
    const char * loadInsnVolatile = "load_instruction:volatile";

    const char * storeInsn = "store_instruction";
    const char * storeInsnAlign = "store_instruction:alignment";
    const char * storeInsnOrd = "store_instruction:ordering";
    const char * storeInsnValue = "store_instruction:value";
    const char * storeInsnAddr = "store_instruction:address";
    const char * storeInsnVolatile = "store_instruction:volatile";

    const char * fenceInsn = "fence_instruction";
    const char * fenceInsnOrd = "fence_instruction:ordering";

    const char * atomicRMWInsn = "atomicrmw_instruction";
    const char * atomicRMWInsnOrd = "atomicrmw_instruction:ordering";
    const char * atomicRMWInsnOper = "atomicrmw_instruction:operation";
    const char * atomicRMWInsnAddr = "atomicrmw_instruction:address";
    const char * atomicRMWInsnValue = "atomicrmw_instruction:value";
    const char * atomicRMWInsnVolatile = "atomicrmw_instruction:volatile";

    const char * cmpxchgInsn = "cmpxchg_instruction";
    const char * cmpxchgInsnOrd = "cmpxchg_instruction:ordering";
    const char * cmpxchgInsnAddr = "cmpxchg_instruction:address";
    const char * cmpxchgInsnCmp = "cmpxchg_instruction:cmp";
    const char * cmpxchgInsnNew = "cmpxchg_instruction:new";
    const char * cmpxchgInsnType = "cmpxchg_instruction:type";
    const char * cmpxchgInsnVolatile = "cmpxchg_instruction:volatile";

    const char * gepInsn = "getelementptr_instruction";
    const char * gepInsnBase = "getelementptr_instruction:base";
    const char * gepInsnIndex = "getelementptr_instruction:index";
    const char * gepInsnNIndices = "getelementptr_instruction:nindices";
    const char * gepInsnInbounds = "getelementptr_instruction:inbounds";

// Conversion Operations

    const char * truncInsn = "trunc_instruction";
    const char * truncInsnFrom = "trunc_instruction:from";
    const char * truncInsnToType = "trunc_instruction:to_type";

    const char * zextInsn = "zext_instruction";
    const char * zextInsnFrom = "zext_instruction:from";
    const char * zextInsnToType = "zext_instruction:to_type";

    const char * sextInsn = "sext_instruction";
    const char * sextInsnFrom = "sext_instruction:from";
    const char * sextInsnToType = "sext_instruction:to_type";

    const char * fptruncInsn = "fptrunc_instruction";
    const char * fptruncInsnFrom = "fptrunc_instruction:from";
    const char * fptruncInsnToType = "fptrunc_instruction:to_type";

    const char * fpextInsn = "fpext_instruction";
    const char * fpextInsnFrom = "fpext_instruction:from";
    const char * fpextInsnToType = "fpext_instruction:to_type";

    const char * fptouiInsn = "fptoui_instruction";
    const char * fptouiInsnFrom = "fptoui_instruction:from";
    const char * fptouiInsnToType = "fptoui_instruction:to_type";

    const char * fptosiInsn = "fptosi_instruction";
    const char * fptosiInsnFrom = "fptosi_instruction:from";
    const char * fptosiInsnToType = "fptosi_instruction:to_type";

    const char * uitofpInsn = "uitofp_instruction";
    const char * uitofpInsnFrom = "uitofp_instruction:from";
    const char * uitofpInsnToType = "uitofp_instruction:to_type";

    const char * sitofpInsn = "sitofp_instruction";
    const char * sitofpInsnFrom = "sitofp_instruction:from";
    const char * sitofpInsnToType = "sitofp_instruction:to_type";

    const char * ptrtointInsn = "ptrtoint_instruction";
    const char * ptrtointInsnFrom = "ptrtoint_instruction:from";
    const char * ptrtointInsnToType = "ptrtoint_instruction:to_type";

    const char * inttoptrInsn = "inttoptr_instruction";
    const char * inttoptrInsnFrom = "inttoptr_instruction:from";
    const char * inttoptrInsnToType = "inttoptr_instruction:to_type";

    const char * bitcastInsn = "bitcast_instruction";
    const char * bitcastInsnFrom = "bitcast_instruction:from";
    const char * bitcastInsnToType = "bitcast_instruction:to_type";

// Other Operations

    const char * icmpInsn = "icmp_instruction";
    const char * icmpInsnCond = "icmp_instruction:condition";
    const char * icmpInsnFirstOp = "icmp_instruction:first_operand";
    const char * icmpInsnSecondOp = "icmp_instruction:second_operand";

    const char * fcmpInsn = "fcmp_instruction";
    const char * fcmpInsnCond = "fcmp_instruction:condition";
    const char * fcmpInsnFirstOp = "fcmp_instruction:first_operand";
    const char * fcmpInsnSecondOp = "fcmp_instruction:second_operand";

    const char * phiInsn = "phi_instruction";
    const char * phiInsnType = "phi_instruction:type";
    const char * phiInsnPairValue = "phi_instruction:pair:value";
    const char * phiInsnPairLabel = "phi_instruction:pair:label";
    const char * phiInsnNPairs = "phi_instruction:npairs";

    const char * selectInsn = "select_instruction";
    const char * selectInsnCond = "select_instruction:condition";
    const char * selectInsnFirstOp = "select_instruction:first_operand";
    const char * selectInsnSecondOp = "select_instruction:second_operand";

    const char * vaargInsn = "va_arg_instruction";
    const char * vaargInsnList = "va_arg_instruction:va_list";
    const char * vaargInsnType = "va_arg_instruction:type";

    const char * callInsn = "call_instruction";
    const char * callInsnFunction = "call_instruction:raw_function";
    const char * directCallInsn = "direct_call_instruction";
    const char * indirectCallInsn = "indirect_call_instruction";
    const char * callCallConv = "call_instruction:calling_convention";
    const char * callInsnArg = "call_instruction:arg";
    const char * callInsnRetAttr = "call_instruction:return_attribute";
    const char * callInsnParamAttr = "call_instruction:param_attribute";
    const char * callInsnFuncAttr = "call_instruction:function_attribute";
    const char * callInsnTail = "call_instruction:tail";

    const char * landingpadInsn = "landingpad_instruction";
    const char * landingpadInsnType = "landingpad_instruction:type";
    const char * landingpadInsnFunc = "landingpad_instruction:pers_fn";
    const char * landingpadInsnCatch = "landingpad_instruction:clause:catch_tmp";
    const char * landingpadInsnFilter = "landingpad_instruction:clause:filter_tmp";
    const char * landingpadInsnNClauses = "landingpad_instruction:nclauses";
    const char * landingpadInsnCleanup = "landingpad_instruction:cleanup";

// Types

    const char * primitiveType = "primitive_type";
    const char * intType = "integer_type";
    const char * fpType = "fp_type";

    const char * funcType = "function_type";
    const char * funcTypeVarArgs = "function_type:varargs";
    const char * funcTypeReturn = "function_type:return";
    const char * funcTypeParam = "function_type:param";
    const char * funcTypeNParams = "function_type:nparams";

    const char * ptrType = "pointer_type";
    const char * ptrTypeComp = "pointer_type:component";
    const char * ptrTypeAddrSpace = "pointer_type:addr_space";

    const char * vectorType = "vector_type";
    const char * vectorTypeComp = "vector_type:component";
    const char * vectorTypeSize = "vector_type:size";

    const char * arrayType = "array_type";
    const char * arrayTypeComp = "array_type:component";
    const char * arrayTypeSize = "array_type:size";

    const char * structType = "struct_type";
    const char * structTypeField = "struct_type:field";
    const char * structTypeNFields = "struct_type:nfields";
    const char * opaqueStructType = "opaque_struct_type";

// Variables and Immediates

    const char * immediate = "immediate";
    const char * immediateType = "immediate:type";

    const char * variable = "variable";
    const char * variableType = "variable:type";

// Constants

    const char * constExpr = "constant_expression";

// Auxiliary predicates

    const char * constToInt = "constant:to_int";

}
