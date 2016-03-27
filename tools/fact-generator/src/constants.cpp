#include <string>
#include <llvm/IR/Constants.h>
#include "predicate_groups.hpp"
#include "FactGenerator.hpp"

using cclyzer::FactGenerator;
using llvm::cast;
using llvm::isa;
namespace pred = cclyzer::predicates;



//------------------------------------------------------------------------------
// Top-level method that records every kinds of constant
//------------------------------------------------------------------------------

cclyzer::refmode_t
FactGenerator::writeConstant(const llvm::Constant &c)
{
    using namespace llvm;

    refmode_t refmode = refmodeOfConstant(&c);

    // Record constant entity with its type
    writeFact(pred::constant::id, refmode);
    writeFact(pred::constant::type, refmode, refmodeOf(c.getType()));
    types.insert(c.getType());

    if (isa<ConstantPointerNull>(c)) {
        writeFact(pred::nullptr_constant::id, refmode);
    }
    else if (isa<ConstantInt>(c)) {
        writeFact(pred::integer_constant::id, refmode);

        // Compute integer string representation
        std::string int_value = c.getUniqueInteger().toString(10, true);

        // Write constant to integer fact
        writeFact(pred::constant::to_integer, refmode, int_value);
    }
    else if (isa<ConstantFP>(c)) {
        writeFact(pred::fp_constant::id, refmode);
    }
    else if (isa<Function>(c)) {
        const Function &func = cast<Function>(c);
        const std::string funcname = "@" + func.getName().str();

        writeFact(pred::function_constant::id, refmode);
        writeFact(pred::function_constant::name, refmode, funcname);
    }
    else if (isa<GlobalVariable>(c)) {
        const GlobalVariable &global_var = cast<GlobalVariable>(c);
        const std::string varname = "@" + global_var.getName().str();

        writeFact(pred::global_variable_constant::id, refmode);
        writeFact(pred::global_variable_constant::name, refmode, varname);
    }
    else if (isa<ConstantExpr>(c)) {
        writeConstantExpr(cast<ConstantExpr>(c), refmode);
    }
    else if (isa<ConstantArray>(c)) {
        writeConstantArray(cast<ConstantArray>(c), refmode);
    }
    else if (isa<ConstantStruct>(c)) {
        writeConstantStruct(cast<ConstantStruct>(c), refmode);
    }
    else if (isa<ConstantVector>(c)) {
        writeConstantVector(cast<ConstantVector>(c), refmode);
    }

    return refmode;
}



//------------------------------------------------------------------------------
// Method that records every kind of constant expression
//------------------------------------------------------------------------------

void
FactGenerator::writeConstantExpr(const llvm::ConstantExpr &expr,
                                 const refmode_t &refmode)
{
    writeFact(pred::constant_expr::id, refmode);

    if (expr.isCast()) {
        refmode_t opref;

        switch (expr.getOpcode()) {
          case llvm::Instruction::BitCast:
              opref = writeConstant(*expr.getOperand(0));

              writeFact(pred::bitcast_constant_expr::id, refmode);
              writeFact(pred::bitcast_constant_expr::from_constant, refmode, opref);
              break;
          case llvm::Instruction::IntToPtr:
              opref = writeConstant(*expr.getOperand(0));

              writeFact(pred::inttoptr_constant_expr::id, refmode);
              writeFact(pred::inttoptr_constant_expr::from_int_constant, refmode, opref);
              break;
          case llvm::Instruction::PtrToInt:
              opref = writeConstant(*expr.getOperand(0));

              writeFact(pred::ptrtoint_constant_expr::id, refmode);
              writeFact(pred::ptrtoint_constant_expr::from_ptr_constant, refmode, opref);
              break;
        }
    }
    else if (expr.isGEPWithNoNotionalOverIndexing()) {
        unsigned nOperands = expr.getNumOperands();

        for (unsigned i = 0; i < nOperands; i++)
        {
            const llvm::Constant *c = cast<llvm::Constant>(expr.getOperand(i));

            refmode_t index_ref = writeConstant(*c);

            if (i > 0)
                writeFact(pred::gep_constant_expr::index, refmode, i - 1, index_ref);
            else
                writeFact(pred::gep_constant_expr::base, refmode, index_ref);
        }

        writeFact(pred::gep_constant_expr::nindices, refmode, nOperands - 1);
        writeFact(pred::gep_constant_expr::id, refmode);
    }
    else {
        // TODO
    }
}




//------------------------------------------------------------------------------
// Template Method for similar constant constructs
//------------------------------------------------------------------------------


template<typename PredGroup, class ConstantType> void
FactGenerator::writeConstantWithOperands(const ConstantType &base,
                                         const refmode_t &refmode)
{
    unsigned nOperands = base.getNumOperands();

    for (unsigned i = 0; i < nOperands; i++)
    {
        const llvm::Constant *c = base.getOperand(i);

        refmode_t index_ref = writeConstant(*c);
        writeFact(PredGroup::index, refmode, i, index_ref);
    }

    writeFact(PredGroup::size, refmode, nOperands);
    writeFact(PredGroup::id, refmode);
}


void FactGenerator::writeConstantArray(const llvm::ConstantArray &array,
                                       const refmode_t &refmode)
{
    writeConstantWithOperands<pred::constant_array>(array, refmode);
}


void FactGenerator::writeConstantStruct(const llvm::ConstantStruct &st,
                                        const refmode_t &refmode)
{
    writeConstantWithOperands<pred::constant_struct>(st, refmode);
}


void FactGenerator::writeConstantVector(const llvm::ConstantVector &v,
                                        const refmode_t &refmode)
{
    writeConstantWithOperands<pred::constant_vector>(v, refmode);
}
