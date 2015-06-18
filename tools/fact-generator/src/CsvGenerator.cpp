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

namespace fs = boost::filesystem;
namespace pred = predicates;


void CsvGenerator::processModule(const Module * Mod, string& path)
{
    // Get data layout of this module
    std::string layoutRef = Mod->getDataLayout();
    DataLayout *layout = new DataLayout(layoutRef);

    // Cache the data layout so that it is available at the
    // postprocessing step of recording the encountered types

    layouts.insert(layout);

    InstructionVisitor IV(this, Mod);

    // iterating over global variables in a module
    for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
        string refmode = getRefmodeForValue(Mod, gi, path);
        IV.visitGlobalVar(gi, refmode);
        types.insert(gi->getType());
    }

    // iterating over global alias in a module
    for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
        string refmode = getRefmodeForValue(Mod, ga, path);
        IV.visitGlobalAlias(ga, refmode);
        types.insert(ga->getType());
    }

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
        IV.writeFact(pred::function::type, funcRef, typeSignature);

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            IV.writeFact(pred::function::linkage, funcRef, linkage);

        if (!visibility.empty())
            IV.writeFact(pred::function::visibility, funcRef, visibility);

        if (fi->getAlignment())
            IV.writeFact(pred::function::alignment, funcRef, fi->getAlignment());

        if (fi->hasGC())
            IV.writeFact(pred::function::gc, funcRef, fi->getGC());

        // Record calling convection if it not defaults to C
        if (fi->getCallingConv() != CallingConv::C)
            IV.writeFact(pred::function::calling_conv, funcRef, to_string(fi->getCallingConv()));

        // Record function name
        IV.writeFact(pred::function::name, funcRef, "@" + fi->getName().str());

        // Address not significant
        if (fi->hasUnnamedAddr())
            IV.writeProperty(pred::function::unnamed_addr, funcRef);

        // Record function attributes TODO
        const AttributeSet &Attrs = fi->getAttributes();

        if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
            IV.writeFact(pred::function::ret_attr, funcRef,
                         Attrs.getAsString(AttributeSet::ReturnIndex));

        vector<string> FuncnAttr;
        writeFnAttributes(Attrs, FuncnAttr);

        for (size_t i = 0; i < FuncnAttr.size(); i++)
            IV.writeFact(pred::function::attr, funcRef, FuncnAttr[i]);

        // Nothing more to do for function declarations
        if (fi->isDeclaration()) {
            IV.writeEntity(pred::function::id_decl, funcRef); // record function declaration
            continue;
        }

        // Record function definition entity
        IV.writeEntity(pred::function::id_defn, funcRef);

        // Record section
        if(fi->hasSection())
            IV.writeFact(pred::function::section, funcRef, fi->getSection());

        // Record function parameters
        {
            int index = 0;

            for (Function::const_arg_iterator
                     arg = fi->arg_begin(), arg_end = fi->arg_end();
                 arg != arg_end; arg++)
            {
                string varId = instrId + valueToString(arg, Mod);

                IV.writeFact(pred::function::param, funcRef, varId, index++);
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
            IV.writeEntity(pred::variable::id, bbRef);
            IV.writeFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            BasicBlock *tmpBB = const_cast<BasicBlock *>(&bb);

            for (pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                string predBB = funcPrefix + valueToString(*pi, Mod);
                IV.writeFact(pred::basic_block::predecessor, bbRef, predBB);
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

                    IV.writeFact(pred::instruction::to, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    string nextInstrRef = instrId + std::to_string(counter);

                    // Record the instruction succession
                    IV.writeFact(pred::instruction::next, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                IV.writeFact(pred::instruction::function, instrRef, funcRef);

                // Record instruction's basic block entry (label)
                string bbEntry = instrId + valueToString(instr.getParent(), Mod);
                IV.writeFact(pred::instruction::bb_entry, instrRef, bbEntry);

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

    InstructionVisitor IV(this, (llvm::Module *) 0);

    // Record every constant encountered so far
    foreach (type_cache_t::value_type kv, constantTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record constant entity with its type
        IV.writeEntity(pred::constant::id, refmode);
        IV.writeFact(pred::constant::type, refmode, to_string(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record variable entity with its type
        IV.writeEntity(pred::variable::id, refmode);
        IV.writeFact(pred::variable::type, refmode, to_string(type));

        types.insert(type);
    }

    // Type accumulator that identifies simple types from complex ones
    TypeAccumulator<unordered_set<const llvm::Type *> > collector;

    // Set of all encountered types
    unordered_set<const llvm::Type *> collectedTypes = collector(types);

    // Add basic primitive types
    IV.writeEntity(pred::primitive_type::id, "void");
    IV.writeEntity(pred::primitive_type::id, "label");
    IV.writeEntity(pred::primitive_type::id, "metadata");
    IV.writeEntity(pred::primitive_type::id, "x86mmx");

    // Record each type encountered
    foreach (const Type *type, collectedTypes)
       IV.visitType(type);
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
