#ifndef PREDICATE_GROUPS_HPP__
#define PREDICATE_GROUPS_HPP__

#include <map>
#include <string>
#include "Singleton.hpp"


class PredicateGroup
{
  public:
    virtual ~PredicateGroup() = 0;

  protected:
    typedef std::string string;

    PredicateGroup(string name) {
        predicates[ENTITY] = groupName = name;
    }

    void addPredicate(string predName) {
        predicates[predName] = groupName + ':' + predName;
    }

    string getPredicate(string id) {
        return predicates[id];
    }

    string getEntity() {
        return predicates[ENTITY];
    }

  private:
    static string ENTITY;
    string groupName;
    std::map<string,string> predicates;

    // Derived classes should be non-copyable
    PredicateGroup(const PredicateGroup&);
    PredicateGroup& operator=(const PredicateGroup&);
};


class InstrPredicateGroup : public PredicateGroup
{
  protected:
    InstrPredicateGroup(string name) : PredicateGroup(name) {}

  public:
    string getInstruction() {
        return getEntity();
    }
};


namespace PredicateGroups
{
    class UnaryInstr : public InstrPredicateGroup
    {
      public:
        string getOperand() {
            return getPredicate(SINGLE_OPERAND);
        }

      protected:
        UnaryInstr(string name)
            : InstrPredicateGroup(name)
        {
            addPredicate(SINGLE_OPERAND);
        }

      private:
        static string SINGLE_OPERAND;
    };


    class BinaryInstr : public InstrPredicateGroup
    {
      public:
        string getFirstOperand() {
            return getPredicate(FIRST_OPERAND);
        }

        string getSecondOperand() {
            return getPredicate(SECOND_OPERAND);
        }

      protected:
        BinaryInstr(string name)
            : InstrPredicateGroup(name)
        {
            addPredicate(FIRST_OPERAND);
            addPredicate(SECOND_OPERAND);
        }

      private:
        static string FIRST_OPERAND;
        static string SECOND_OPERAND;
    };


    class CastInstr : public InstrPredicateGroup
    {
      public:
        string getFromOperand() {
            return getPredicate(FROM_OPERAND);
        }

        string getToType() {
            return getPredicate(TO_TYPE);
        }

      protected:
        CastInstr(const char *name)
            : InstrPredicateGroup(name)
        {
            addPredicate(FROM_OPERAND);
            addPredicate(TO_TYPE);
        }

      private:
        static string FROM_OPERAND;
        static string TO_TYPE;
    };


    /* Arithmetic Binary Instruction Predicate Groups */

    class AddInstr : public BinaryInstr,
                     public Singleton<AddInstr>
    {
      protected:
        friend class Singleton<AddInstr>;
        AddInstr() : BinaryInstr("add_instruction") {}
    };

    class FAddInstr : public BinaryInstr,
                      public Singleton<FAddInstr>
    {
      protected:
        friend class Singleton<FAddInstr>;
        FAddInstr() : BinaryInstr("fadd_instruction") {}
    };

    class SubInstr : public BinaryInstr,
                     public Singleton<SubInstr>
    {
      protected:
        friend class Singleton<SubInstr>;
        SubInstr() : BinaryInstr("sub_instruction") {}
    };

    class FSubInstr : public BinaryInstr,
                      public Singleton<FSubInstr>
    {
      protected:
        friend class Singleton<FSubInstr>;
        FSubInstr() : BinaryInstr("fsub_instruction") {}
    };

    class MulInstr : public BinaryInstr,
                     public Singleton<MulInstr>
    {
      protected:
        friend class Singleton<MulInstr>;
        MulInstr() : BinaryInstr("mul_instruction") {}
    };

    class FMulInstr : public BinaryInstr,
                      public Singleton<FMulInstr>
    {
      protected:
        friend class Singleton<FMulInstr>;
        FMulInstr() : BinaryInstr("fmul_instruction") {}
    };

    class UDivInstr : public BinaryInstr,
                      public Singleton<UDivInstr>
    {
      protected:
        friend class Singleton<UDivInstr>;
        UDivInstr() : BinaryInstr("udiv_instruction") {}
    };

    class FDivInstr : public BinaryInstr,
                      public Singleton<FDivInstr>
    {
      protected:
        friend class Singleton<FDivInstr>;
        FDivInstr() : BinaryInstr("fdiv_instruction") {}
    };

    class SDivInstr : public BinaryInstr,
                      public Singleton<SDivInstr>
    {
      protected:
        friend class Singleton<SDivInstr>;
        SDivInstr() : BinaryInstr("sdiv_instruction") {}
    };

    class URemInstr : public BinaryInstr,
                      public Singleton<URemInstr>
    {
      protected:
        friend class Singleton<URemInstr>;
        URemInstr() : BinaryInstr("urem_instruction") {}
    };

    class SRemInstr : public BinaryInstr,
                      public Singleton<SRemInstr>
    {
      protected:
        friend class Singleton<SRemInstr>;
        SRemInstr() : BinaryInstr("srem_instruction") {}
    };

    class FRemInstr : public BinaryInstr,
                      public Singleton<FRemInstr>
    {
      protected:
        friend class Singleton<FRemInstr>;
        FRemInstr() : BinaryInstr("frem_instruction") {}
    };



    /* Bitwise Binary Instruction Predicate Groups */

    class ShlInstr : public BinaryInstr,
                     public Singleton<ShlInstr>
    {
      protected:
        friend class Singleton<ShlInstr>;
        ShlInstr() : BinaryInstr("shl_instruction") {}
    };

    class LShrInstr : public BinaryInstr,
                      public Singleton<LShrInstr>
    {
      protected:
        friend class Singleton<LShrInstr>;
        LShrInstr() : BinaryInstr("lshr_instruction") {}
    };

    class AShrInstr : public BinaryInstr,
                      public Singleton<AShrInstr>
    {
      protected:
        friend class Singleton<AShrInstr>;
        AShrInstr() : BinaryInstr("ashr_instruction") {}
    };

    class AndInstr : public BinaryInstr,
                     public Singleton<AndInstr>
    {
      protected:
        friend class Singleton<AndInstr>;
        AndInstr() : BinaryInstr("and_instruction") {}
    };

    class OrInstr : public BinaryInstr,
                    public Singleton<OrInstr>
    {
      protected:
        friend class Singleton<OrInstr>;
        OrInstr() : BinaryInstr("or_instruction") {}
    };

    class XorInstr : public BinaryInstr,
                     public Singleton<XorInstr>
    {
      protected:
        friend class Singleton<XorInstr>;
        XorInstr() : BinaryInstr("xor_instruction") {}
    };



    /* Cast Instruction Predicate Groups */

    class TruncInstr : public CastInstr,
                       public Singleton<TruncInstr>
    {
      protected:
        friend class Singleton<TruncInstr>;
        TruncInstr() : CastInstr("trunc_instruction") {}
    };

    class ZExtInstr : public CastInstr,
                      public Singleton<ZExtInstr>
    {
      protected:
        friend class Singleton<ZExtInstr>;
        ZExtInstr() : CastInstr("zext_instruction") {}
    };

    class SExtInstr : public CastInstr,
                      public Singleton<SExtInstr>
    {
      protected:
        friend class Singleton<SExtInstr>;
        SExtInstr() : CastInstr("sext_instruction") {}
    };

    class FPTruncInstr : public CastInstr,
                         public Singleton<FPTruncInstr>
    {
      protected:
        friend class Singleton<FPTruncInstr>;
        FPTruncInstr() : CastInstr("fptrunc_instruction") {}
    };

    class FPExtInstr : public CastInstr,
                       public Singleton<FPExtInstr>
    {
      protected:
        friend class Singleton<FPExtInstr>;
        FPExtInstr() : CastInstr("fpext_instruction") {}
    };

    class FPToUIInstr : public CastInstr,
                        public Singleton<FPToUIInstr>
    {
      protected:
        friend class Singleton<FPToUIInstr>;
        FPToUIInstr() : CastInstr("fptoui_instruction") {}
    };

    class FPToSIInstr : public CastInstr,
                        public Singleton<FPToSIInstr>
    {
      protected:
        friend class Singleton<FPToSIInstr>;
        FPToSIInstr() : CastInstr("fptosi_instruction") {}
    };

    class SIToFPInstr : public CastInstr,
                        public Singleton<SIToFPInstr>
    {
      protected:
        friend class Singleton<SIToFPInstr>;
        SIToFPInstr() : CastInstr("sitofp_instruction") {}
    };

    class UIToFPInstr : public CastInstr,
                        public Singleton<UIToFPInstr>
    {
      protected:
        friend class Singleton<UIToFPInstr>;
        UIToFPInstr() : CastInstr("uitofp_instruction") {}
    };

    class PtrToIntInstr : public CastInstr,
                          public Singleton<PtrToIntInstr>
    {
      protected:
        friend class Singleton<PtrToIntInstr>;
        PtrToIntInstr() : CastInstr("ptrtoint_instruction") {}
    };

    class IntToPtrInstr : public CastInstr,
                          public Singleton<IntToPtrInstr>
    {
      protected:
        friend class Singleton<IntToPtrInstr>;
        IntToPtrInstr() : CastInstr("inttoptr_instruction") {}
    };

    class BitcastInstr : public CastInstr,
                         public Singleton<BitcastInstr>
    {
      protected:
        friend class Singleton<BitcastInstr>;
        BitcastInstr() : CastInstr("bitcast_instruction") {}
    };


    /* Terminator Instruction Predicate Groups */

    class RetInstr : public InstrPredicateGroup,
                     public Singleton<RetInstr>
    {
      protected:
        friend class Singleton<RetInstr>;

        RetInstr() : InstrPredicateGroup("ret_instruction") {
            addPredicate(OPERAND);
            addPredicate(VOID_SUBTYPE);
        }

      public:
        string getValue() {
            return getPredicate(OPERAND);
        }

        string getVoidSubtype() {
            return getPredicate(VOID_SUBTYPE);
        }

      private:
        static string OPERAND;
        static string VOID_SUBTYPE;
    };

    class IndirectBranchInstr : public InstrPredicateGroup,
                                public Singleton<IndirectBranchInstr>
    {
      protected:
        friend class Singleton<IndirectBranchInstr>;

        IndirectBranchInstr()
            : InstrPredicateGroup("indirectbr_instruction")
        {
            addPredicate(ADDRESS);
            addPredicate(LABEL);
            addPredicate(NLABELS);
        }

      public:
        string getAddress() {
            return getPredicate(ADDRESS);
        }

        string getLabel() {
            return getPredicate(LABEL);
        }

        string getNumberOfLabels() {
            return getPredicate(NLABELS);
        }

      private:
        static string ADDRESS;
        static string LABEL;
        static string NLABELS;
    };

    class ResumeInstr : public UnaryInstr,
                        public Singleton<ResumeInstr>
    {
      protected:
        friend class Singleton<ResumeInstr>;
        ResumeInstr() : UnaryInstr("resume_instruction") {}
    };

}

#endif /* PREDICATE_GROUPS_HPP__ */
