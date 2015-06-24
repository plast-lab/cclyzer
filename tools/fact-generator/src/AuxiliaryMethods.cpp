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
        return rso.str();
    }

}
