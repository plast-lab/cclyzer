#include <sstream>

#include "llvm/Support/raw_ostream.h"

#include "AuxiliaryMethods.hpp"

namespace auxiliary_methods {

    using namespace std;
    using namespace llvm;

    bool isPrimitiveType(const Type * Tp){
        return Tp->isVoidTy() || Tp->isHalfTy() ||
            Tp->isFloatTy() || Tp->isDoubleTy() ||
            Tp->isX86_FP80Ty() || Tp->isFP128Ty() ||
            Tp->isPPC_FP128Ty() || Tp->isLabelTy() ||
            Tp->isMetadataTy() || Tp->isX86_MMXTy();
    }

    string writeCallingConv(unsigned cc){

        string conv;

        switch (cc) {
            //TODO:CallingConv::C
        case CallingConv::Fast:				conv =  "fastcc"; 			break;
        case CallingConv::Cold:				conv =  "coldcc"; 			break;
        case CallingConv::X86_FastCall:		conv =  "x86_fastcallcc"; 	break;
        case CallingConv::X86_StdCall:		conv =  "x86_stdcallcc"; 	break;
        case CallingConv::X86_ThisCall:		conv =  "x86_thiscallcc"; 	break;
        case CallingConv::Intel_OCL_BI:		conv =  "intel_ocl_bicc"; 	break;
        case CallingConv::ARM_AAPCS:		conv =  "arm_aapcscc"; 		break;
        case CallingConv::ARM_AAPCS_VFP:	conv =  "arm_aapcs_vfpcc"; 	break;
        case CallingConv::ARM_APCS:			conv =  "arm_apcscc"; 		break;
        case CallingConv::MSP430_INTR:		conv =  "msp430_intrcc";	break;
        case CallingConv::PTX_Device:		conv =  "tx_device"; 		break;
        case CallingConv::PTX_Kernel:		conv =  "ptx_kernel";		break;
        default:
            conv = "cc" + static_cast<ostringstream*>(&(ostringstream()<< cc))->str();
            break;
        }
        return conv;
    }

    string printType(const Type *type){

        string type_str;
        raw_string_ostream rso(type_str);
        if(type->isStructTy()) {
            const StructType *STy = cast<StructType>(type);
            if(STy->isLiteral()) {
                type->print(rso);
                return rso.str();
            }
            if(!STy->getName().empty()) {
                rso << "%" << STy->getName();
                return rso.str();
            }
            rso << "%\"type " << STy << "\"";
        }
        else {
            type->print(rso);
        }
        return rso.str();
    }

    //TODO: do we need this guy?
    const char *writeThreadLocalModel(GlobalVariable::ThreadLocalMode TLM) {

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

    void writeFnAttributes(const AttributeSet Attrs, vector<string> &FnAttr) {

        AttributeSet AS;
        string AttrStr;
        if (Attrs.hasAttributes(AttributeSet::FunctionIndex)) {
            AS = Attrs.getFnAttributes();
        }
        unsigned idx = 0;
        for (unsigned e = AS.getNumSlots(); idx != e; ++idx) {
            if (AS.getSlotIndex(idx) == AttributeSet::FunctionIndex) {
                break;
            }
        }
        for (AttributeSet::iterator I = AS.begin(idx), E = AS.end(idx); I != E; ++I) {
            Attribute Attr = *I;
            if (!Attr.isStringAttribute()) {
                AttrStr = Attr.getAsString();
                FnAttr.push_back(AttrStr);
            }
        }
    }

    string valueToString(const Value * Val, const Module * Mod) {
        string rv;
        raw_string_ostream rso(rv);
        WriteAsOperand(rso, Val, false, Mod);
        return rv;
    }

}
