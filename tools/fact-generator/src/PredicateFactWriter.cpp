#include <vector>
#include "PredicateFactWriter.hpp"
#include "predicate.hpp"
#include "predicate_groups.hpp"

// Marks if predicate files have been initialized
bool PredicateFactWriter::INITIALIZED_PREDICATE_FILES = false;


PredicateFactWriter::PredicateFactWriter(FactWriter &writer)
    : writer(writer)
{
    // Create empty predicate files just once
    if (!INITIALIZED_PREDICATE_FILES) {
        CreatePredicateFiles(writer);
        INITIALIZED_PREDICATE_FILES = true;
    }
}


void PredicateFactWriter::CreatePredicateFiles(FactWriter &writer)
{
    using namespace predicates;

    std::vector<const char *> all_predicates;

    for (const pred_t *pred : predicates::predicates())
    {
        const operand_pred_t *operand_pred =
            dynamic_cast< const operand_pred_t*>(pred);

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
