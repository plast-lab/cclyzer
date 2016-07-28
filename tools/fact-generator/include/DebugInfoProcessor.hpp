#ifndef DEBUG_INFO_PROCESSOR_HPP__
#define DEBUG_INFO_PROCESSOR_HPP__

#include <map>
#include <llvm/IR/DebugInfo.h>
#include "Demangler.hpp"
#include "FactWriter.hpp"
#include "ForwardingFactWriter.hpp"
#include "RefmodeEngine.hpp"

namespace cclyzer {
    class DebugInfoProcessor;
}

class cclyzer::DebugInfoProcessor
    : private Demangler,
      private ForwardingFactWriter
{
  public:
    DebugInfoProcessor(FactWriter& writer, RefmodeEngine& engine)
        : ForwardingFactWriter(writer), refmEngine(engine) {}

    /* Delegate to debug info finder */

    void
    processModule(const llvm::Module &module) {
        debugInfoFinder.processModule(module);
    }

    void
    processDeclare(const llvm::Module &module,
                   const llvm::DbgDeclareInst *inst) {
        debugInfoFinder.processDeclare(module, inst);
    }

    void
    processValue(const llvm::Module &module,
                 const llvm::DbgValueInst *inst) {
        debugInfoFinder.processValue(module, inst);
    }

    void reset() { debugInfoFinder.reset(); }


    /* Process debug info node and record its attributes */
    template<typename T, typename writer>
    struct di_recorder
    {
        typedef DebugInfoProcessor DIProc;

        static refmode_t
        record(const T& dinode, DIProc& proc)
        {
            const llvm::DINode& node = llvm::cast<llvm::DINode>(dinode);
            auto& nodeIds = proc.nodeIds;
            auto& eng = proc.refmEngine;

            // Check if node has been processed before
            auto search = nodeIds.find(&node);

            if (search != nodeIds.end())
                return search->second;

            // Generate refmode for this node
            refmode_t nodeId = eng.refmode<llvm::DINode>(node);

            // Process and record node attributes
            writer::write(dinode, nodeId, proc);

            return nodeIds[&node] = nodeId;
        }
    };


    /* Fact-generating methods */

    struct write_di_node {
        typedef DebugInfoProcessor DIProc;
    };

    struct write_di_file : public write_di_node {
        static void write(const llvm::DIFile &, const refmode_t &, DIProc &);
    };

    struct write_di_namespace : public write_di_node {
        static void write(const llvm::DINamespace &, const refmode_t &, DIProc &);
    };

    struct write_di_scope : public write_di_node {
        static void write(const llvm::DIScope &, const refmode_t &, DIProc &);
    };

    struct write_di_type : public write_di_node {
        static void write(const llvm::DIType &, const refmode_t &, DIProc &);
    };

    struct write_di_basic_type : public write_di_node {
        static void write(const llvm::DIBasicType &, const refmode_t &, DIProc &);
    };

    struct write_di_composite_type : public write_di_node {
        static void write(const llvm::DICompositeType &, const refmode_t &, DIProc &);
    };

    struct write_di_derived_type : public write_di_node {
        static void write(const llvm::DIDerivedType &, const refmode_t &, DIProc &);
    };

    struct write_di_subroutine_type : public write_di_node {
        static void write(const llvm::DISubroutineType &, const refmode_t &, DIProc &);
    };


    /* Type aliases for common recording operations */

    typedef di_recorder<llvm::DIFile, write_di_file> record_di_file;
    typedef di_recorder<llvm::DINamespace, write_di_namespace> record_di_namespace;
    typedef di_recorder<llvm::DIScope, write_di_scope> record_di_scope;
    typedef di_recorder<llvm::DIType, write_di_type> record_di_type;

    void
    postProcess(const llvm::Module &, const std::string &);

    void
    postProcessType(const llvm::DICompositeType &, const std::string &);

    void
    postProcessType(const llvm::DICompositeType &tp) {
        postProcessType(tp, "");
    }

    void
    postProcessTypedef(const llvm::DIDerivedType &, const std::string &);

  protected:

    /* Helper method to write common type attributes */
    void write_di_type_common(const llvm::DIType &, const refmode_t &);

    /* Helper method to write union attributes */
    template<typename P, typename writer, typename T>
    void recordUnionAttribute(const refmode_t &, const llvm::TypedDINodeRef<T> & );

    // Construct a mapping from type ID to type name
    void CollectTypeIDs();

    // Append debug info scope to stream
    template<typename Stream>
    void printScope(Stream &stream, const llvm::DIScopeRef &outerScope);

    // Generate refmode for debug info composite type
    refmode_t refmodeOf(const llvm::DICompositeType &,
                        const std::string &altName = "");

    // Generate refmode for debug info global variable
    refmode_t refmodeOf(const llvm::DIGlobalVariable &,
                        const std::string &);
  private:
    /* Debug Info */
    llvm::DebugInfoFinder debugInfoFinder;

    /* Mapping from DIType ID to type name  */
    std::map<std::string, refmode_t> typeNameByID;

    /* Refmode Engine */
    RefmodeEngine &refmEngine;

    /* Cache of processed nodes */
    std::map<const llvm::DINode *, refmode_t> nodeIds;
};

#endif /* DEBUG_INFO_PROCESSOR_HPP__ */
