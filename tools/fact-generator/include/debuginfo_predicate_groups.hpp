#ifndef DEBUG_INFO_PREDICATE_GROUPS_H__
#define DEBUG_INFO_PREDICATE_GROUPS_H__

#include "predicate_groups.hpp"

namespace cclyzer { namespace predicates
{
    //----------------------------------------------------
    // Debug Info predicate group definitions
    //----------------------------------------------------

    struct di_entry : public predicate_group {
    };

    // scope entries
    struct di_scope_entry : public predicate_group {
        static entity_pred_t id;
    };

    // typedef entries
    struct di_typedef_entry : public predicate_group {
        static entity_pred_t id;
    };

    // global variable entries
    struct di_global_var : public predicate_group {
        static entity_pred_t id;
        static pred_t name;
        static pred_t scope;
    };

    // file entries
    struct di_file : public predicate_group {
        static entity_pred_t id;
        static pred_t filename;
        static pred_t directory;
    };

    // namespace entries
    struct di_namespace : public predicate_group {
        static entity_pred_t id;
        static pred_t name;
        static pred_t file;
        static pred_t line;
        static pred_t scope;
    };

    // type entries
    struct di_type : public predicate_group {
        static entity_pred_t id;
        static pred_t name;
        static pred_t line;
        static pred_t flag;
        static pred_t bitsize;
        static pred_t bitalign;
        static pred_t bitoffset;

        struct scope {
            static pred_t node;
            static pred_t raw;
        };
    };

    struct di_basic_type : public predicate_group {
        static entity_pred_t id;
    };

    struct di_composite_type : public predicate_group {
        static entity_pred_t id;
        static pred_t file;
        static pred_t abi_id;
        static pred_t field;
        static pred_t template_param;

        struct vtable {
            static pred_t node;
            static pred_t raw;
        };

        struct basetype {
            static pred_t node;
            static pred_t raw;
        };
    };

    struct di_derived_type : public predicate_group {
        static entity_pred_t id;
        static pred_t kind;
        static pred_t file;

        struct basetype {
            static pred_t node;
            static pred_t raw;
        };
    };

    struct di_subroutine_type : public predicate_group {
        static entity_pred_t id;
        static pred_t type_elem;
        static pred_t raw_type_elem;
    };

    // template parameter entries
    struct di_template_param : public predicate_group {
        static entity_pred_t id;
        static pred_t name;

        struct type {
            static pred_t node;
            static pred_t raw;
        };
    };

    struct di_template_type_param : public predicate_group {
        static entity_pred_t id;
    };

    struct di_template_value_param : public predicate_group {
        static entity_pred_t id;
    };


}} // end of namespace cclyzer::predicates

#endif
