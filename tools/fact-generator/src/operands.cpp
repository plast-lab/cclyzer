#include <string>
#include <llvm/IR/DataLayout.h>
#include <llvm/IR/Type.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"
#include "TypeVisitor.hpp"
#include "TypeAccumulator.hpp"

using cclyzer::FactGenerator;
namespace pred = cclyzer::predicates;


void
FactGenerator::writeOperands(const llvm::DataLayout &layout)
{
    using llvm_utils::TypeAccumulator;
    typedef type_cache_t::iterator operand_iterator;

    // Record every constant encountered so far
    for (operand_iterator
             it = constantTypes.begin(), end = constantTypes.end();
         it != end; ++it)
    {
        refmode_t refmode = it->first;
        const llvm::Type *type = it->second;

        // Record constant entity with its type
        writeFact(pred::constant::id, refmode);
        writeFact(pred::constant::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Record every variable encountered so far
    for (operand_iterator
             it = variableTypes.begin(), end = variableTypes.end();
         it != end; ++it)
    {
        refmode_t refmode = it->first;
        const llvm::Type *type = it->second;

        // Record variable entity with its type
        writeFact(pred::variable::id, refmode);
        writeFact(pred::variable::type, refmode, refmodeOf(type));

        types.insert(type);
    }

    // Add basic primitive types
    writeFact(pred::primitive_type::id, "void");
    writeFact(pred::primitive_type::id, "label");
    writeFact(pred::primitive_type::id, "metadata");
    writeFact(pred::primitive_type::id, "x86mmx");

    // Find types contained in the types encountered so far, but not
    // referenced directly

    TypeAccumulator alltypes;
    alltypes.accumulate(types.begin(), types.end());

    // Create type visitor
    TypeVisitor TV(*this, layout);

    // Record each type encountered
    for(TypeAccumulator::const_iterator
            it = alltypes.begin(), end = alltypes.end(); it != end; ++it)
    {
        TV.visitType(*it);
    }
}
