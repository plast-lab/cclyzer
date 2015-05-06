#ifndef PREDICATE_NAMES_H__
#define PREDICATE_NAMES_H__

namespace predicate_names
{
    typedef const char *pred_t;

    struct predicate_group {
        typedef const char *pred_t;
    };

    // Basic Blocks

    struct basic_block : public predicate_group {
        static pred_t predecessor;
    };

    // Global

    struct global_var : public predicate_group {
        static pred_t id;
        static pred_t type;
        static pred_t initializer;
        static pred_t section;
        static pred_t align;
        static pred_t flag;
        static pred_t linkage;
        static pred_t visibility;
        static pred_t threadlocal_mode;
    };

    struct alias : public predicate_group {
        static pred_t id;
        static pred_t type;
        static pred_t linkage;
        static pred_t visibility;
        static pred_t aliasee;
    };

    // Function

    struct function : public predicate_group {
        static pred_t id_defn;
        static pred_t id_decl;
        static pred_t unnamed_addr;
        static pred_t linkage;
        static pred_t visibility;
        static pred_t calling_conv;
        static pred_t section;
        static pred_t alignment;
        static pred_t attr;
        static pred_t gc;
        static pred_t name;
        static pred_t type;
        static pred_t param;
        static pred_t ret_attr;
        static pred_t param_attr;
    };

    // Instructions

    struct instruction : public predicate_group {
        static pred_t to;
        static pred_t flag;
        static pred_t next;
        static pred_t bb_entry;
        static pred_t function;
        static pred_t unreachable; // terminator also
    };

    // Binary Instructions

    struct add : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct fadd : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct sub : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct fsub : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct mul : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct fmul : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct udiv : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct fdiv : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct sdiv : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct urem : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct srem : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct frem : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    // Bitwise Binary Instructions

    struct shl : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct lshr : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct ashr : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct and_ : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct or_ : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct xor_ : predicate_group {
        static pred_t instr;
        static pred_t first_operand;
        static pred_t second_operand;
    };


    // Terminator Instructions

    struct ret : predicate_group {
        static pred_t instr;
        static pred_t instr_void;
        static pred_t operand;
    };

    struct br : predicate_group {
        static pred_t instr;
        static pred_t instr_cond;
        static pred_t condition;
        static pred_t cond_iftrue;
        static pred_t cond_iffalse;
        static pred_t instr_uncond;
        static pred_t uncond_dest;
    };

    struct switch_ : predicate_group {
        static pred_t instr;
        static pred_t operand;
        static pred_t default_label;
        static pred_t case_value;
        static pred_t case_label;
        static pred_t ncases;
    };

    struct indirectbr : public predicate_group {
        static pred_t instr;
        static pred_t address;
        static pred_t label;
        static pred_t nlabels;
    };

    struct resume : public predicate_group {
        static pred_t instr;
        static pred_t operand;
    };

    struct invoke : public predicate_group {
        static pred_t instr;
        static pred_t function;
        static pred_t instr_direct;
        static pred_t instr_indirect;
        static pred_t calling_conv;
        static pred_t arg;
        static pred_t ret_attr;
        static pred_t param_attr;
        static pred_t fn_attr;
        static pred_t normal_label;
        static pred_t exc_label;
    };

    // Vector Operations

    struct extract_element : public predicate_group {
        static pred_t instr;
        static pred_t base;
        static pred_t index;
    };

    struct insert_element : public predicate_group {
        static pred_t instr;
        static pred_t base;
        static pred_t index;
        static pred_t value;
    };

    struct shuffle_vector : public predicate_group {
        static pred_t instr;
        static pred_t first_vector;
        static pred_t second_vector;
        static pred_t mask;
    };

    // Aggregate Operations

    struct extract_value : public predicate_group {
        static pred_t instr;
        static pred_t base;
        static pred_t index;
        static pred_t nindices;
    };

    struct insert_value : public predicate_group {
        static pred_t instr;
        static pred_t base;
        static pred_t value;
        static pred_t index;
        static pred_t nindices;
    };

    // Memory Operations

    struct alloca : public predicate_group {
        static pred_t instr;
        static pred_t alignment;
        static pred_t size;
        static pred_t type;
    };

    struct load : public predicate_group {
        static pred_t instr;
        static pred_t alignment;
        static pred_t ordering;
        static pred_t address;
        static pred_t isvolatile;
    };

    struct store : public predicate_group {
        static pred_t instr;
        static pred_t alignment;
        static pred_t ordering;
        static pred_t value;
        static pred_t address;
        static pred_t isvolatile;
    };

    struct fence : public predicate_group {
        static pred_t instr;
        static pred_t ordering;
    };

    struct atomicrmw : public predicate_group {
        static pred_t instr;
        static pred_t ordering;
        static pred_t operation;
        static pred_t address;
        static pred_t value;
        static pred_t isvolatile;
    };

    struct cmpxchg : public predicate_group {
        static pred_t instr;
        static pred_t ordering;
        static pred_t address;
        static pred_t cmp;
        static pred_t new_;
        static pred_t type;
        static pred_t isvolatile;
    };

    struct gep : public predicate_group {
        static pred_t instr;
        static pred_t base;
        static pred_t index;
        static pred_t nindices;
        static pred_t inbounds;
    };

    // Conversion Operations

    struct trunc : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct zext : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct sext : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct fptrunc : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct fpext : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct fptoui : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct fptosi : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct uitofp : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct sitofp : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct ptrtoint : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct inttoptr : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    struct bitcast : public predicate_group {
        static pred_t instr;
        static pred_t from_operand;
        static pred_t to_type;
    };

    // Other Operations

    struct icmp : public predicate_group {
        static pred_t instr;
        static pred_t condition;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct fcmp : public predicate_group {
        static pred_t instr;
        static pred_t condition;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct phi : public predicate_group {
        static pred_t instr;
        static pred_t type;
        static pred_t pair_value;
        static pred_t pair_label;
        static pred_t npairs;
    };

    struct select : public predicate_group {
        static pred_t instr;
        static pred_t condition;
        static pred_t first_operand;
        static pred_t second_operand;
    };

    struct va_arg : public predicate_group {
        static pred_t instr;
        static pred_t va_list;
        static pred_t type;
    };

    struct call : public predicate_group {
        static pred_t instr;
        static pred_t function;
        static pred_t instr_direct;
        static pred_t instr_indirect;
        static pred_t calling_conv;
        static pred_t arg;
        static pred_t ret_attr;
        static pred_t param_attr;
        static pred_t fn_attr;
        static pred_t tail;
    };

    struct landingpad : predicate_group {
        static pred_t instr;
        static pred_t type;
        static pred_t fn;
        static pred_t catch_clause;
        static pred_t filter_clause;
        static pred_t nclauses;
        static pred_t cleanup;
    };

    // Types

    struct primitive_type : public predicate_group {
        static pred_t id;
    };

    struct integer_type : public predicate_group {
        static pred_t id;
    };

    struct fp_type : public predicate_group {
        static pred_t id;
    };

    struct type : public predicate_group {
        static pred_t alloc_size;
        static pred_t store_size;
    };

    struct func_type : public predicate_group {
        static pred_t id;
        static pred_t varargs;
        static pred_t return_type;
        static pred_t param_type;
        static pred_t nparams;
    };

    struct ptr_type : public predicate_group {
        static pred_t id;
        static pred_t component_type;
        static pred_t addr_space;
    };

    struct vector_type : public predicate_group {
        static pred_t id;
        static pred_t component_type;
        static pred_t size;
    };

    struct array_type : public predicate_group {
        static pred_t id;
        static pred_t component_type;
        static pred_t size;
    };

    struct struct_type : predicate_group {
        static pred_t id;
        static pred_t field_type;
        static pred_t nfields;
        static pred_t opaque;
    };

    // Variables and constants

    struct variable : predicate_group {
        static pred_t id;
        static pred_t type;
    };

    struct constant : predicate_group {
        static pred_t id;
        static pred_t type;
        static pred_t expr;
        static pred_t to_integer;
    };
}

#endif
