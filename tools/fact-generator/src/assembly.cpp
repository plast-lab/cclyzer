#include <string>
#include <boost/algorithm/string/replace.hpp>
#include <llvm/IR/InlineAsm.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"

using cclyzer::FactGenerator;
using llvm::cast;
using llvm::isa;
namespace pred = cclyzer::predicates;

static std::string canonicalize(const std::string& in)
{
    std::string base(in);
    boost::replace_all(base, "\t", "\\t");
    boost::replace_all(base, "\n", "\\n");
    return base;
}

cclyzer::refmode_t
FactGenerator::writeAsm(const llvm::InlineAsm &asmVal)
{
    using namespace llvm;

    refmode_t refmode = refmodeOfInlineAsm(&asmVal);
    const llvm::Type *type = asmVal.getType();

    // Record inline ASM as constant entity with its type
    writeFact(pred::constant::id, refmode);
    writeFact(pred::constant::type, refmode, refmodeOf(type));
    types.insert(type);

    // Record its attributes separately
    std::string constraints = asmVal.getConstraintString();
    std::string assem = asmVal.getAsmString();

    writeFact(pred::inline_asm::id, refmode);
    writeFact(pred::inline_asm::constraints, refmode, canonicalize(constraints));
    writeFact(pred::inline_asm::text, refmode, canonicalize(assem));

    return refmode;
}
