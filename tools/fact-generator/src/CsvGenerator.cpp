#include <boost/foreach.hpp>
#include <llvm/IR/Module.h>
#include <llvm/IR/Operator.h>
#include <llvm/Support/CFG.h>
#include "predicate_groups.hpp"
#include "CsvGenerator.hpp"
#include "InstructionVisitor.hpp"
#include "TypeVisitor.hpp"
#include "TypeAccumulator.hpp"

#define foreach BOOST_FOREACH


using namespace llvm;
using namespace std;
using namespace boost;
namespace fs = boost::filesystem;
namespace pred = predicates;


void CsvGenerator::processModule(const Module * Mod, string& path)
{
    InstructionVisitor IV(*this, Mod);

    // iterating over global variables in a module
    for (Module::const_global_iterator gi = Mod->global_begin(), E = Mod->global_end(); gi != E; ++gi) {
        string refmode = getRefmodeForValue(Mod, gi, path);
        visitGlobalVar(gi, refmode);
        types.insert(gi->getType());
    }

    // iterating over global alias in a module
    for (Module::const_alias_iterator ga = Mod->alias_begin(), E = Mod->alias_end(); ga != E; ++ga) {
        string refmode = getRefmodeForValue(Mod, ga, path);
        visitGlobalAlias(ga, refmode);
        types.insert(ga->getType());
    }

    // iterating over functions in a module
    for (Module::const_iterator fi = Mod->begin(), fi_end = Mod->end(); fi != fi_end; ++fi)
    {
        Context C(*this, fi);

        refmode_t funcref = refmodeOf(fi, path);
        string instrId = funcref + ":";
        IV.setInstrId(instrId);

        // Record function type
        types.insert(fi->getFunctionType());

        // Serialize function properties
        refmode_t visibility = refmodeOf(fi->getVisibility());
        refmode_t linkage = refmodeOf(fi->getLinkage());
        refmode_t typeSignature = refmodeOf(fi->getFunctionType());

        // Record function type signature
        writeFact(pred::function::type, funcref, typeSignature);

        // Record function linkage, visibility, alignment, and GC
        if (!linkage.empty())
            writeFact(pred::function::linkage, funcref, linkage);

        if (!visibility.empty())
            writeFact(pred::function::visibility, funcref, visibility);

        if (fi->getAlignment())
            writeFact(pred::function::alignment, funcref, fi->getAlignment());

        if (fi->hasGC())
            writeFact(pred::function::gc, funcref, fi->getGC());

        // Record calling convection if it not defaults to C
        if (fi->getCallingConv() != CallingConv::C) {
            refmode_t cconv = refmodeOf(fi->getCallingConv());
            writeFact(pred::function::calling_conv, funcref, cconv);
        }

        // Record function name
        writeFact(pred::function::name, funcref, "@" + fi->getName().str());

        // Address not significant
        if (fi->hasUnnamedAddr())
            writeFact(pred::function::unnamed_addr, funcref);

        // Record function attributes TODO
        const AttributeSet &Attrs = fi->getAttributes();

        if (Attrs.hasAttributes(AttributeSet::ReturnIndex))
            writeFact(pred::function::ret_attr, funcref,
                         Attrs.getAsString(AttributeSet::ReturnIndex));

        writeFnAttributes(pred::function::attr, funcref, Attrs);

        // Nothing more to do for function declarations
        if (fi->isDeclaration()) {
            writeFact(pred::function::id_decl, funcref); // record function declaration
            continue;
        }

        // Record function definition entity
        writeFact(pred::function::id_defn, funcref);

        // Record section
        if(fi->hasSection())
            writeFact(pred::function::section, funcref, fi->getSection());

        // Record function parameters
        {
            int index = 0;

            for (Function::const_arg_iterator
                     arg = fi->arg_begin(), arg_end = fi->arg_end();
                 arg != arg_end; arg++)
            {
                string varId = instrId + refmodeOf(arg, Mod);

                writeFact(pred::function::param, funcref, varId, index++);
                recordVariable(varId, arg->getType());
            }
        }

        int counter = 0;

        // iterating over basic blocks in a function
        //REVIEW: There must be a way to move this whole logic inside InstructionVisitor, i.e., visit(Module M)
        foreach (const llvm::BasicBlock &bb, *fi)
        {
            Context C(*this, &bb);

            string funcPrefix = funcref + ":";
            string bbRef = funcPrefix + refmodeOf(&bb, Mod);

            // Record basic block entry as a label
            writeFact(pred::variable::id, bbRef);
            writeFact(pred::variable::type, bbRef, "label");

            // Record basic block predecessors
            BasicBlock *tmpBB = const_cast<BasicBlock *>(&bb);

            for (pred_iterator pi = pred_begin(tmpBB), pi_end = pred_end(tmpBB);
                 pi != pi_end; ++pi)
            {
                string predBB = funcPrefix + refmodeOf(*pi, Mod);
                writeFact(pred::basic_block::predecessor, bbRef, predBB);
            }

            // Store last instruction
            const llvm::Instruction &lastInstr = bb.back();

            // iterating over basic block instructions
            foreach (const llvm::Instruction &instr, bb)
            {
                Context C(*this, &instr);

                // Compute instruction refmode
                string instrRef = instrId + std::to_string(counter++);

                // Record instruction target variable if such exists
                if (!instr.getType()->isVoidTy()) {
                    string targetVar = instrId + refmodeOf(&instr, Mod);

                    writeFact(pred::instruction::to, instrRef, targetVar);
                    recordVariable(targetVar, instr.getType());
                }

                // Record successor instruction
                if (&instr != &lastInstr) {
                    // Compute refmode of next instruction
                    string nextInstrRef = instrId + std::to_string(counter);

                    // Record the instruction succession
                    writeFact(pred::instruction::next, instrRef, nextInstrRef);
                }

                // Record instruction's container function
                writeFact(pred::instruction::function, instrRef, funcref);

                // Record instruction's basic block entry (label)
                string bbEntry = instrId + refmodeOf(instr.getParent(), Mod);
                writeFact(pred::instruction::bb_entry, instrRef, bbEntry);

                // Instruction Visitor TODO
                IV.setInstrNum(instrRef);

                // Visit instruction
                IV.visit(const_cast<llvm::Instruction &>(instr));
            }
        }
    }
}


void CsvGenerator::visitGlobalAlias(const GlobalAlias *ga, const refmode_t &refmode)
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
    writeFact(pred::alias::id, refmode);

    // Serialize alias properties
    refmode_t visibility = refmodeOf(ga->getVisibility());
    refmode_t linkage    = refmodeOf(ga->getLinkage());
    refmode_t aliasType  = refmodeOf(ga->getType());

    // Record visibility
    if (!visibility.empty())
        writeFact(pred::alias::visibility, refmode, visibility);

    // Record linkage
    if (!linkage.empty())
        writeFact(pred::alias::linkage, refmode, linkage);

    // Record type
    writeFact(pred::alias::type, refmode, aliasType);

    // Record aliasee
    if (Aliasee) {
        refmode_t aliasee = refmodeOf(Aliasee, ga->getParent());
        writeFact(pred::alias::aliasee, refmode, aliasee);
    }
}


void CsvGenerator::visitGlobalVar(const GlobalVariable *gv, const string &refmode)
{
    // Record global variable entity
    writeFact(pred::global_var::id, refmode);

    // Serialize global variable properties
    refmode_t visibility = refmodeOf(gv->getVisibility());
    refmode_t linkage    = refmodeOf(gv->getLinkage());
    refmode_t varType    = refmodeOf(gv->getType()->getElementType());
    refmode_t thrLocMode = refmodeOf(gv->getThreadLocalMode());

    // Record external linkage
    if (!gv->hasInitializer() && gv->hasExternalLinkage())
        writeFact(pred::global_var::linkage, refmode, "external");

    // Record linkage
    if (!linkage.empty())
        writeFact(pred::global_var::linkage, refmode, linkage);

    // Record visibility
    if (!visibility.empty())
        writeFact(pred::global_var::visibility, refmode, visibility);

    // Record thread local mode
    if (!thrLocMode.empty())
        writeFact(pred::global_var::threadlocal_mode, refmode, thrLocMode);

    // TODO: in lb schema - AddressSpace & hasUnnamedAddr properties
    if (gv->isExternallyInitialized())
        writeFact(pred::global_var::flag, refmode, "externally_initialized");

    // Record flags and type
    const char * flag = gv->isConstant() ? "constant": "global";

    writeFact(pred::global_var::flag, refmode, flag);
    writeFact(pred::global_var::type, refmode, varType);

    // Record initializer
    if (gv->hasInitializer()) {
        refmode_t val = refmodeOf(gv->getInitializer(), gv->getParent()); // CHECK
        writeFact(pred::global_var::initializer, refmode, val);
    }

    // Record section
    if (gv->hasSection())
        writeFact(pred::global_var::section, refmode, gv->getSection());

    // Record alignment
    if (gv->getAlignment())
        writeFact(pred::global_var::align, refmode, gv->getAlignment());
}


void CsvGenerator::writeFnAttributes(
    const pred_t &predicate,
    const refmode_t &refmode,
    const AttributeSet Attrs)
{
    AttributeSet AS;

    if (Attrs.hasAttributes(AttributeSet::FunctionIndex))
        AS = Attrs.getFnAttributes();

    unsigned idx = 0;

    for (unsigned e = AS.getNumSlots(); idx != e; ++idx) {
        if (AS.getSlotIndex(idx) == AttributeSet::FunctionIndex)
            break;
    }

    for (AttributeSet::iterator I = AS.begin(idx), E = AS.end(idx); I != E; ++I)
    {
        Attribute Attr = *I;

        if (!Attr.isStringAttribute()) {
            string AttrStr = Attr.getAsString();
            writeFact(predicate, refmode, Attr.getAsString());
        }
    }
}


void CsvGenerator::writeVarsTypesAndImmediates(const llvm::DataLayout &layout)
{
    using llvm_extra::TypeAccumulator;
    using boost::unordered_set;

    // Record every constant encountered so far
    foreach (type_cache_t::value_type kv, constantTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record constant entity with its type
        writeFact(pred::constant::id, refmode);
        writeFact(pred::constant::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    foreach (type_cache_t::value_type kv, variableTypes) {
        string refmode = kv.first;
        const Type *type = kv.second;

        // Record variable entity with its type
        writeFact(pred::variable::id, refmode);
        writeFact(pred::variable::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Type accumulator that identifies simple types from complex ones
    TypeAccumulator<unordered_set<const llvm::Type *> > collector;

    // Set of all encountered types
    unordered_set<const llvm::Type *> collectedTypes = collector(types);

    // Add basic primitive types
    writeFact(pred::primitive_type::id, "void");
    writeFact(pred::primitive_type::id, "label");
    writeFact(pred::primitive_type::id, "metadata");
    writeFact(pred::primitive_type::id, "x86mmx");

    // Create type visitor
    TypeVisitor TV(*this, layout);

    // Record each type encountered
    foreach (const Type *type, collectedTypes)
       TV.visitType(type);
}


void CsvGenerator::initStreams()
{
    using namespace predicates;

    std::vector<const char *> all_predicates;

    for (pred_t *pred : predicates::predicates())
    {
        operand_pred_t *operand_pred = dynamic_cast< operand_pred_t*>(pred);

        if (operand_pred) {
            pred_t cpred = operand_pred->asConstant();
            pred_t vpred = operand_pred->asVariable();

            all_predicates.push_back(cpred.c_str());
            all_predicates.push_back(vpred.c_str());
        }
        else {
            all_predicates.push_back(pred->c_str());
        }
    }

    writer.init_streams(all_predicates);

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}
