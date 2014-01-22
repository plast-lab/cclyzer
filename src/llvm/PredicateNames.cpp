#include <string>
#include <fstream>
#include <set>

#include "PredicateNames.h"
#include "DirInfo.h"

using namespace std;

// Basic Blocks

const char * PredicateNames::basicBlockPred = "basicblock:pred_aux";

// Global

const char * PredicateNames::globalVar = "global_variable";
const char * PredicateNames::globalVarType = "global_variable:type";
const char * PredicateNames::globalVarInit = "global_variable:initializer";
const char * PredicateNames::globalVarSect = "global_variable:section";
const char * PredicateNames::globalVarAlign = "global_variable:align";
const char * PredicateNames::globalVarFlag = "global_variable:flag";
const char * PredicateNames::globalVarLink = "global_variable:linkage_type";
const char * PredicateNames::globalVarVis = "global_variable:visibility";
const char * PredicateNames::globalVarTlm = "global_variable:threadlocal_mode";

const char * PredicateNames::alias = "alias";
const char * PredicateNames::aliasType = "alias:type";
const char * PredicateNames::aliasLink = "alias:linkage_type";
const char * PredicateNames::aliasVis = "alias:visibility";
const char * PredicateNames::aliasAliasee = "alias:aliasee";

// Function

const char * PredicateNames::Func = "function";
const char * PredicateNames::FuncUnnamedAddr = "function:unnamed_addr";
const char * PredicateNames::FuncLink = "function:linkage_type";
const char * PredicateNames::FuncVis = "function:visibility";
const char * PredicateNames::FuncCallConv = "function:calling_convention";
const char * PredicateNames::FuncSect = "function:section";
const char * PredicateNames::FuncAlign = "function:alignment";
const char * PredicateNames::FuncAttr = "function:attributes";
const char * PredicateNames::FuncGc = "function:gc";
const char * PredicateNames::FuncName = "function:name";
const char * PredicateNames::FuncType = "function:type";
const char * PredicateNames::FuncParam = "function:param_tmp";
const char * PredicateNames::FuncRetAttr = "function:return_attribute";
const char * PredicateNames::FuncParamAttr = "function:param_attribute";

// Instructions

const char * PredicateNames::insnTo = "instruction:to";
const char * PredicateNames::insnFlag = "instruction:flag";
const char * PredicateNames::insnNext = "instruction:next";
const char * PredicateNames::insnBBEntry = "instruction:bb_entry";
const char * PredicateNames::insnFunc = "instruction:function";

// Binary Instructions

const char * PredicateNames::addInsn = "add_instruction";
const char * PredicateNames::addInsnFirstOp = "add_instruction:first_operand";
const char * PredicateNames::addInsnSecondOp = "add_instruction:second_operand";

const char * PredicateNames::faddInsn = "fadd_instruction";
const char * PredicateNames::faddInsnFirstOp = "fadd_instruction:first_operand";
const char * PredicateNames::faddInsnSecondOp = "fadd_instruction:second_operand";

const char * PredicateNames::subInsn = "sub_instruction";
const char * PredicateNames::subInsnFirstOp = "sub_instruction:first_operand";
const char * PredicateNames::subInsnSecondOp = "sub_instruction:second_operand";

const char * PredicateNames::fsubInsn = "fsub_instruction";
const char * PredicateNames::fsubInsnFirstOp = "fsub_instruction:first_operand";
const char * PredicateNames::fsubInsnSecondOp = "fsub_instruction:second_operand";

const char * PredicateNames::mulInsn = "mul_instruction";
const char * PredicateNames::mulInsnFirstOp = "mul_instruction:first_operand";
const char * PredicateNames::mulInsnSecondOp = "mul_instruction:second_operand";

const char * PredicateNames::fmulInsn = "fmul_instruction";
const char * PredicateNames::fmulInsnFirstOp = "fmul_instruction:first_operand";
const char * PredicateNames::fmulInsnSecondOp = "fmul_instruction:second_operand";

const char * PredicateNames::udivInsn = "udiv_instruction";
const char * PredicateNames::udivInsnFirstOp = "udiv_instruction:first_operand";
const char * PredicateNames::udivInsnSecondOp = "udiv_instruction:second_operand";

const char * PredicateNames::fdivInsn = "fdiv_instruction";
const char * PredicateNames::fdivInsnFirstOp = "fdiv_instruction:first_operand";
const char * PredicateNames::fdivInsnSecondOp = "fdiv_instruction:second_operand";

const char * PredicateNames::sdivInsn = "sdiv_instruction";
const char * PredicateNames::sdivInsnFirstOp = "sdiv_instruction:first_operand";
const char * PredicateNames::sdivInsnSecondOp = "sdiv_instruction:second_operand";

const char * PredicateNames::uremInsn = "urem_instruction";
const char * PredicateNames::uremInsnFirstOp = "urem_instruction:first_operand";
const char * PredicateNames::uremInsnSecondOp = "urem_instruction:second_operand";

const char * PredicateNames::sremInsn = "srem_instruction";
const char * PredicateNames::sremInsnFirstOp = "srem_instruction:first_operand";
const char * PredicateNames::sremInsnSecondOp = "srem_instruction:second_operand";

const char * PredicateNames::fremInsn = "frem_instruction";
const char * PredicateNames::fremInsnFirstOp = "frem_instruction:first_operand";
const char * PredicateNames::fremInsnSecondOp = "frem_instruction:second_operand";

// Bitwise Binary Instructions

const char * PredicateNames::shlInsn = "shl_instruction";
const char * PredicateNames::shlInsnFirstOp = "shl_instruction:first_operand";
const char * PredicateNames::shlInsnSecondOp = "shl_instruction:second_operand";

const char * PredicateNames::lshrInsn = "lshr_instruction";
const char * PredicateNames::lshrInsnFirstOp = "lshr_instruction:first_operand";
const char * PredicateNames::lshrInsnSecondOp = "lshr_instruction:second_operand";

const char * PredicateNames::ashrInsn = "ashr_instruction";
const char * PredicateNames::ashrInsnFirstOp = "ashr_instruction:first_operand";
const char * PredicateNames::ashrInsnSecondOp = "ashr_instruction:second_operand";

const char * PredicateNames::andInsn = "and_instruction";
const char * PredicateNames::andInsnFirstOp = "and_instruction:first_operand";
const char * PredicateNames::andInsnSecondOp = "and_instruction:second_operand";

const char * PredicateNames::orInsn = "or_instruction";
const char * PredicateNames::orInsnFirstOp = "or_instruction:first_operand";
const char * PredicateNames::orInsnSecondOp = "or_instruction:second_operand";

const char * PredicateNames::xorInsn = "xor_instruction";
const char * PredicateNames::xorInsnFirstOp = "xor_instruction:first_operand";
const char * PredicateNames::xorInsnSecondOp = "xor_instruction:second_operand";

// Terminator Instructions

const char * PredicateNames::retInsn = "ret_instruction";
const char * PredicateNames::retInsnVoid = "ret_instruction:void";
const char * PredicateNames::retInsnOp = "ret_instruction:value";

const char * PredicateNames::brInsn = "br_instruction";
const char * PredicateNames::brCondInsn = "br_cond_instruction";
const char * PredicateNames::brCondInsnCondition = "br_cond_instruction:condition";
const char * PredicateNames::brCondInsnIfTrue = "br_cond_instruction:iftrue";
const char * PredicateNames::brCondInsnIfFalse = "br_instruction:iffalse";
const char * PredicateNames::brUncondInsn = "br_uncond_instruction";
const char * PredicateNames::brUncondInsnDest = "br_uncond_instruction:dest";

const char * PredicateNames::switchInsn = "switch_instruction";
const char * PredicateNames::switchInsnOp = "switch_instruction:operand";
const char * PredicateNames::switchInsnDefLabel = "switch_instruction:default_label";
const char * PredicateNames::switchInsnCaseVal = "switch_instruction:case:value_tmp";
const char * PredicateNames::switchInsnCaseLabel = "switch_instruction:case:label_tmp";
const char * PredicateNames::switchInsnNCases = "switch_instruction:ncases";

const char * PredicateNames::indirectbrInsn = "indirectbr_instruction";
const char * PredicateNames::indirectbrInsnAddr = "indirectbr_instruction:address";
const char * PredicateNames::indirectbrInsnLabel = "indirectbr_instruction:label_tmp";
const char * PredicateNames::indirectbrInsnNLabels = "indirectbr_instruction:nlabels";

const char * PredicateNames::resumeInsn = "resume_instruction";
const char * PredicateNames::resumeInsnOp = "resume_instruction:operand";

const char * PredicateNames::unreachableInsn = "unreachable_instruction";

const char * PredicateNames::invokeInsn = "invoke_instruction";
const char * PredicateNames::invokeInsnFunc = "invoke_instruction:function";
const char * PredicateNames::directInvokeInsn = "direct_invoke_instruction";
const char * PredicateNames::indirectInvokeInsn = "indirect_invoke_instruction";
const char * PredicateNames::invokeInsnCallConv = "invoke_instruction:calling_convention";
const char * PredicateNames::invokeInsnArg = "invoke_instruction:arg";
const char * PredicateNames::invokeInsnRetAttr = "invoke_instruction:return_attribute";
const char * PredicateNames::invokeInsnParamAttr = "invoke_instruction:param_attribute";
const char * PredicateNames::invokeInsnFuncAttr = "invoke_instruction:function_attribute";
const char * PredicateNames::invokeInsnNormalLabel = "invoke_instruction:normal_label";
const char * PredicateNames::invokeInsnExceptLabel = "invoke_instruction:exception_label";

// Vector Operations

const char * PredicateNames::extractElemInsn = "extractelement_instruction";
const char * PredicateNames::extractElemInsnBase = "extractelement_instruction:base";
const char * PredicateNames::extractElemInsnIndex = "extractelement_instruction:index";

const char * PredicateNames::insertElemInsn = "insertelement_instruction";
const char * PredicateNames::insertElemInsnBase = "insertelement_instruction:base";
const char * PredicateNames::insertElemInsnIndex = "insertelement_instruction:index";
const char * PredicateNames::insertElemInsnValue = "insertelement_instruction:value";

const char * PredicateNames::shuffleVectorInsn = "shufflevector_instruction";
const char * PredicateNames::shuffleVectorInsnFirstVec = "shufflevector_instruction:first_vector";
const char * PredicateNames::shuffleVectorInsnSecondVec = "shufflevector_instruction:second_vector";
const char * PredicateNames::shuffleVectorInsnMask = "shufflevector_instruction:mask";

// Aggregate Operations

const char * PredicateNames::extractValueInsn = "extractvalue_instruction";
const char * PredicateNames::extractValueInsnBase = "extractvalue_instruction:base";
const char * PredicateNames::extractValueInsnIndex = "extractvalue_instruction:index_tmp";
const char * PredicateNames::extractValueInsnNIndices = "extractvalue_instruction:nindices";

const char * PredicateNames::insertValueInsn = "insertvalue_instruction";
const char * PredicateNames::insertValueInsnBase = "insertvalue_instruction:base";
const char * PredicateNames::insertValueInsnValue = "insertvalue_instruction:value";
const char * PredicateNames::insertValueInsnIndex = "insertvalue_instruction:index_tmp";
const char * PredicateNames::insertValueInsnNIndices = "insertvalue_instruction:nindices";

// Memory Operations

const char * PredicateNames::allocaInsn = "alloca_instruction";
const char * PredicateNames::allocaInsnAlign = "alloca_instruction:alignment";
const char * PredicateNames::allocaInsnSize = "alloca_instruction:size";
const char * PredicateNames::allocaInsnType = "alloca_instruction:type";

const char * PredicateNames::loadInsn = "load_instruction";
const char * PredicateNames::loadInsnAlign = "load_instruction:alignment";
const char * PredicateNames::loadInsnOrd = "load_instruction:ordering";
const char * PredicateNames::loadInsnAddr = "load_instruction:address";

const char * PredicateNames::storeInsn = "store_instruction";
const char * PredicateNames::storeInsnAlign = "store_instruction:alignment";
const char * PredicateNames::storeInsnOrd = "store_instruction:ordering";
const char * PredicateNames::storeInsnValue = "store_instruction:value";
const char * PredicateNames::storeInsnAddr = "store_instruction:address";

const char * PredicateNames::fenceInsn = "fence_instruction";
const char * PredicateNames::fenceInsnOrd = "fence_instruction:ordering";

const char * PredicateNames::atomicRMWInsn = "atomicrmw_instruction";
const char * PredicateNames::atomicRMWInsnOrd = "atomicrmw_instruction:ordering";
const char * PredicateNames::atomicRMWInsnOper = "atomicrmw_instruction:operation";
const char * PredicateNames::atomicRMWInsnAddr = "atomicrmw_instruction:address";
const char * PredicateNames::atomicRMWInsnValue = "atomicrmw_instruction:value";

const char * PredicateNames::cmpxchgInsn = "cmpxchg_instruction";
const char * PredicateNames::cmpxchgInsnOrd = "cmpxchg_instruction:ordering";
const char * PredicateNames::cmpxchgInsnAddr = "cmpxchg_instruction:address";
const char * PredicateNames::cmpxchgInsnCmp = "cmpxchg_instruction:cmp";
const char * PredicateNames::cmpxchgInsnNew = "cmpxchg_instruction:new";
const char * PredicateNames::cmpxchgInsnType = "cmpxchg_instruction:type";

const char * PredicateNames::gepInsn = "getelementptr_instruction";
const char * PredicateNames::gepInsnBase = "getelementptr_instruction:base";
const char * PredicateNames::gepInsnIndex = "getelementptr_instruction:index";
const char * PredicateNames::gepInsnNIndices = "getelementptr_instruction:nindices";

// Conversion Operations

const char * PredicateNames::truncInsn = "trunc_instruction";
const char * PredicateNames::truncInsnFrom = "trunc_instruction:from";
const char * PredicateNames::truncInsnToType = "trunc_instruction:to_type";

const char * PredicateNames::zextInsn = "zext_instruction";
const char * PredicateNames::zextInsnFrom = "zext_instruction:from";
const char * PredicateNames::zextInsnToType = "zext_instruction:to_type";

const char * PredicateNames::sextInsn = "sext_instruction";
const char * PredicateNames::sextInsnFrom = "sext_instruction:from";
const char * PredicateNames::sextInsnToType = "sext_instruction:to_type";

const char * PredicateNames::fptruncInsn = "fptrunc_instruction";
const char * PredicateNames::fptruncInsnFrom = "fptrunc_instruction:from";
const char * PredicateNames::fptruncInsnToType = "fptrunc_instruction:to_type";

const char * PredicateNames::fpextInsn = "fpext_instruction";
const char * PredicateNames::fpextInsnFrom = "fpext_instruction:from";
const char * PredicateNames::fpextInsnToType = "fpext_instruction:to_type";

const char * PredicateNames::fptouiInsn = "fptoui_instruction";
const char * PredicateNames::fptouiInsnFrom = "fptoui_instruction:from";
const char * PredicateNames::fptouiInsnToType = "fptrunc_instruction:to_type";

const char * PredicateNames::fptosiInsn = "fptosi_instruction";
const char * PredicateNames::fptosiInsnFrom = "fptosi_instruction:from";
const char * PredicateNames::fptosiInsnToType = "fptosi_instruction:to_type";

const char * PredicateNames::uitofpInsn = "uitofp_instruction";
const char * PredicateNames::uitofpInsnFrom = "uitofp_instruction:from";
const char * PredicateNames::uitofpInsnToType = "uitofp_instruction:to_type";

const char * PredicateNames::sitofpInsn = "sitofp_instruction";
const char * PredicateNames::sitofpInsnFrom = "sitofp_instruction:from";
const char * PredicateNames::sitofpInsnToType = "sitofp_instruction:to_type";

const char * PredicateNames::ptrtointInsn = "ptrtoint_instruction";
const char * PredicateNames::ptrtointInsnFrom = "ptrtoint_instruction:from";
const char * PredicateNames::ptrtointInsnToType = "ptrtoint_instruction:to_type";

const char * PredicateNames::inttoptrInsn = "inttoptr_instruction";
const char * PredicateNames::inttoptrInsnFrom = "inttoptr_instruction:from";
const char * PredicateNames::inttoptrInsnToType = "inttoptr_instruction:to_type";

const char * PredicateNames::bitcastInsn = "bitcast_instruction";
const char * PredicateNames::bitcastInsnFrom = "bitcast_instruction:from";
const char * PredicateNames::bitcastInsnToType = "bitcast_instruction:to_type";

// Other Operations

const char * PredicateNames::icmpInsn = "icmp_instruction";
const char * PredicateNames::icmpInsnCond = "icmp_instruction:condition";
const char * PredicateNames::icmpInsnFirstOp = "icmp_instruction:first_operand";
const char * PredicateNames::icmpInsnSecondOp = "icmp_instruction:second_operand";

const char * PredicateNames::fcmpInsn = "fcmp_instruction";
const char * PredicateNames::fcmpInsnCond = "fcmp_instruction:condition";
const char * PredicateNames::fcmpInsnFirstOp = "fcmp_instruction:first_operand";
const char * PredicateNames::fcmpInsnSecondOp = "fcmp_instruction:second_operand";

const char * PredicateNames::phiInsn = "phi_instruction";
const char * PredicateNames::phiInsnType = "phi_instruction:type";
const char * PredicateNames::phiInsnPairValue = "phi_instruction:pair:value";
const char * PredicateNames::phiInsnPairLabel = "phi_instruction:pair:label_tmp";
const char * PredicateNames::phiInsnNPairs = "phi_instruction:npairs";

const char * PredicateNames::selectInsn = "select_instruction";
const char * PredicateNames::selectInsnCond = "select_instruction:condition";
const char * PredicateNames::selectInsnFirstOp = "select_instruction:first_operand";
const char * PredicateNames::selectInsnSecondOp = "select_instruction:second_operand";

const char * PredicateNames::vaargInsn = "va_arg_instruction";
const char * PredicateNames::vaargInsnList = "va_arg_instruction:va_list";
const char * PredicateNames::vaargInsnType = "va_arg_instruction:type";

const char * PredicateNames::callInsn = "call_instruction";
const char * PredicateNames::callInsnFunction = "call_instruction:function";
const char * PredicateNames::directCallInsn = "direct_call_instruction";
const char * PredicateNames::indirectCallInsn = "indirect_call_instruction";
const char * PredicateNames::callCallConv = "call_instruction:calling_convention";
const char * PredicateNames::callInsnArg = "call_instruction:arg";
const char * PredicateNames::callInsnRetAttr = "call_instruction:return_attribute";
const char * PredicateNames::callInsnParamAttr = "call_instruction:param_attribute";
const char * PredicateNames::callInsnFuncAttr = "call_instruction:function_attribute";

const char * PredicateNames::landingpadInsn = "landingpad_instruction";
const char * PredicateNames::landingpadInsnType = "landingpad_instruction:type";
const char * PredicateNames::landingpadInsnFunc = "landingpad_instruction:pers_fn";
const char * PredicateNames::landingpadInsnCatch = "landingpad_instruction:clause:catch_tmp";
const char * PredicateNames::landingpadInsnFilter = "landingpad_instruction:clause:filter_tmp";
const char * PredicateNames::landingpadInsnNClauses = "landingpad_instruction:nclauses";

// Types

const char * PredicateNames::primitiveType = "primitive_type";
const char * PredicateNames::intType = "integer_type";
const char * PredicateNames::fpType = "fp_type";

const char * PredicateNames::funcType = "function_type";
const char * PredicateNames::funcTypeVarArgs = "function_type:varargs";
const char * PredicateNames::funcTypeReturn = "function_type:return";
const char * PredicateNames::funcTypeParam = "function_type:param_tmp";
const char * PredicateNames::funcTypeNParams = "function_type:nparams";

const char * PredicateNames::ptrType = "pointer_type";
const char * PredicateNames::ptrTypeComp = "pointer_type:component";
const char * PredicateNames::ptrTypeAddrSpace = "pointer_type:addr_space";

const char * PredicateNames::vectorType = "vector_type";
const char * PredicateNames::vectorTypeComp = "vector_type:component";
const char * PredicateNames::vectorTypeSize = "vector_type:size";

const char * PredicateNames::arrayType = "array_type";
const char * PredicateNames::arrayTypeComp = "array_type:component";
const char * PredicateNames::arrayTypeSize = "array_type:size";

const char * PredicateNames::structType = "struct_type";
const char * PredicateNames::structTypeField = "struct_type:field";
const char * PredicateNames::structTypeNFields = "struct_type:nfields";
const char * PredicateNames::opaqueStructType = "opaque_struct_type";

// Variables and Immediates

const char * PredicateNames::immediate = "immediate";
const char * PredicateNames::immediateType = "immediate:type";

const char * PredicateNames::variable = "variable";
const char * PredicateNames::variableType = "variable:type";

const string PredicateNames::predNameToFilename(const char * predName) {

	string filename = predName;
	string folder = DirInfo::entitiesDir;
	size_t pos = 0;
	while ((pos = filename.find(':', pos)) != string::npos) {
		filename[pos] = '-';
		folder = DirInfo::predicatesDir;
	}
	filename = folder + filename + ".dlm";

	return filename;
}

const string PredicateNames::predNameWithOperandToFilename(const char * predName, bool operand) {

	static set <string> operandFilenames;
	set<string>::iterator it;
	string filename = predName;
	size_t pos = 0;
	while ((pos = filename.find(':', pos)) != string::npos) {
		filename[pos] = '-';
	}
	// imm: operand = 0, var: operand = 1
	filename = DirInfo::factsDir + filename;
	const string imm = filename + "-imm.dlm";
	const string var = filename + "-var.dlm";

	// the other file must also be created
	filename = operand ? imm : var;

	if((it = operandFilenames.find(filename)) == operandFilenames.end()) {
		operandFilenames.insert(filename);
		ofstream csvFile(filename.c_str());
		csvFile.close();
	}
	return operand ? var : imm;
}
