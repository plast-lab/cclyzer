#include <sstream>
#include "LLVMEnums.hpp"

using std::string;
using namespace std;
using namespace llvm;


string LLVMEnumSerializer::to_string(CallingConv::ID cc)
{
    string conv;

    switch (cc) {
      // TODO: CallingConv::C
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


string LLVMEnumSerializer::to_string(GlobalVariable::ThreadLocalMode TLM)
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


string LLVMEnumSerializer::to_string(GlobalValue::LinkageTypes LT)
{
    const char *linkTy;

    switch (LT) {
      case GlobalValue::ExternalLinkage:      linkTy = "external";        break;
      case GlobalValue::PrivateLinkage:       linkTy = "private";         break;
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


string LLVMEnumSerializer::to_string(GlobalValue::VisibilityTypes Vis)
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


string LLVMEnumSerializer::to_string(llvm::AtomicOrdering ordering)
{
    const char *atomic;

    switch (ordering) {
      case Unordered: atomic = "unordered";            break;
      case Monotonic: atomic = "monotonic";            break;
      case Acquire: atomic = "acquire";                break;
      case Release: atomic = "release";                break;
      case AcquireRelease: atomic = "acq_rel";         break;
      case SequentiallyConsistent: atomic = "seq_cst"; break;
          // TODO: NotAtomic?
      default: atomic = ""; break;
    }
    return atomic;
}
