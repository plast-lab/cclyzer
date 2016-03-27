#include <llvm/IR/Constants.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"


using cclyzer::FactGenerator;
namespace pred = cclyzer::predicates;


void
FactGenerator::writeGlobalAlias(const llvm::GlobalAlias& ga, const refmode_t& refmode)
{
    //------------------------------------------------------------------
    // A global alias introduces a /second name/ for the aliasee value
    // (which can be either function, global variable, another alias
    // or bitcast of global value). It has the following form:
    //
    // @<Name> = alias [Linkage] [Visibility] <AliaseeTy> @<Aliasee>
    //------------------------------------------------------------------

    // Get aliasee value as llvm constant
    const llvm::Constant *Aliasee = ga.getAliasee();

    // Record alias entity
    writeFact(pred::alias::id, refmode);

    // Serialize alias properties
    refmode_t visibility = refmodeOf(ga.getVisibility());
    refmode_t linkage    = refmodeOf(ga.getLinkage());
    refmode_t aliasType  = refmodeOf(ga.getType());

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
        // Record aliasee constant and generate refmode for it
        refmode_t aliasee = writeConstant(*Aliasee);

        // Record aliasee
        writeFact(pred::alias::aliasee, refmode, aliasee);
    }
}


void
FactGenerator::writeGlobalVar(const llvm::GlobalVariable& gv, const refmode_t& refmode)
{
    // Record global variable entity
    writeFact(pred::global_var::id, refmode);

    // Serialize global variable properties
    refmode_t visibility = refmodeOf(gv.getVisibility());
    refmode_t linkage    = refmodeOf(gv.getLinkage());
    refmode_t varType    = refmodeOf(gv.getType()->getElementType());
    refmode_t thrLocMode = refmodeOf(gv.getThreadLocalMode());

    // Record external linkage
    if (!gv.hasInitializer() && gv.hasExternalLinkage())
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
    if (gv.isExternallyInitialized())
        writeFact(pred::global_var::flag, refmode, "externally_initialized");

    // Record flags and type
    const char *flag = gv.isConstant() ? "constant": "global";

    writeFact(pred::global_var::flag, refmode, flag);
    writeFact(pred::global_var::type, refmode, varType);

    // Record initializer
    if (gv.hasInitializer()) {
        const llvm::Constant *initializer = gv.getInitializer();
        refmode_t init_ref = writeConstant(*initializer);

        writeFact(pred::global_var::initializer, refmode, init_ref);
    }

    // Record section
    if (gv.hasSection())
        writeFact(pred::global_var::section, refmode, gv.getSection());

    // Record alignment
    if (gv.getAlignment())
        writeFact(pred::global_var::align, refmode, gv.getAlignment());
}
