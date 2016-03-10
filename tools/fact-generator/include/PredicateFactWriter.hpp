#ifndef PREDICATE_FACT_WRITER_HPP__
#define PREDICATE_FACT_WRITER_HPP__

#include "FactWriter.hpp"
#include "RefmodeEngine.hpp"
#include "predicate.hpp"

namespace cclyzer {
    class PredicateFactWriter;
}

class cclyzer::PredicateFactWriter
{
  public:
    PredicateFactWriter(FactWriter &writer);

    FactWriter &getWriter() {
        return writer;
    }

    /* Delegation to fact writer instance  */

    void writeFact(const Predicate &pred,
                   const refmode_t &refmode) {
        writer.writeFact(pred.c_str(), refmode);
    }

    template <typename V, typename ...Vs>
    void writeFact(const Predicate &pred,
                   const refmode_t &refmode,
                   const V val, const Vs&... vals) {
        writer.writeFact(pred.c_str(), refmode, val, vals...);
    }

  protected:
    /* Create all predicate files */
    static void CreatePredicateFiles(FactWriter &);

    /* All predicate files have been created (initially empty) */
    static bool INITIALIZED_PREDICATE_FILES;

  private:
    /* Fact writer */
    FactWriter &writer;
};


#endif /* PREDICATE_FACT_WRITER_HPP__ */
