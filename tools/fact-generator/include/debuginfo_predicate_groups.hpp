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


}} // end of namespace cclyzer::predicates

#endif
