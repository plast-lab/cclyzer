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

    std::vector<std::string> all_predicates;

    for (const pred_t *pred : predicates::predicates())
    {
        const operand_pred_t *operand_pred =
            dynamic_cast< const operand_pred_t*>(pred);

        if (operand_pred) {
            const pred_t &cpred = operand_pred->asConstant();
            const pred_t &vpred = operand_pred->asVariable();

            all_predicates.push_back(cpred);
            all_predicates.push_back(vpred);
        }
        else {
            all_predicates.push_back(*pred);
        }
    }

    writer.init_streams(all_predicates);

    // TODO: Consider closing streams and opening them lazily, so as
    // not to exceed the maximum number of open file descriptors
}
