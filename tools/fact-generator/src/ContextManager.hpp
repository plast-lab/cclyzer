#ifndef CONTEXT_MANAGER_HPP_
#define CONTEXT_MANAGER_HPP_

#include <sstream>
#include <vector>

#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Value.h>


namespace cclyzer
{
    // Class that encapsulates any state that the refmode engine needs
    class ContextManager
    {
        // Single context item
        struct Context {
            Context(const llvm::Value& v, const std::string& prefix)
                : anchor(&v), prefix(prefix)
                , isFunction(llvm::isa<llvm::Function>(v)) {}

            Context(const std::string& prefix)
                : anchor(nullptr), prefix(prefix)
                , isFunction(false) {}

            // Container of local context. Can be global variable,
            // function, block, instruction, etc.
            const llvm::Value *anchor;

            // Mapping numbers to unnamed values
            std::map<const llvm::Value*,unsigned> numbering;

            std::string prefix;

            bool isFunction;
        };

      public:
        // Type definitions
        typedef Context context;
        typedef std::vector<context>::iterator iterator;
        typedef std::vector<context>::const_iterator const_iterator;
        typedef std::vector<context>::reverse_iterator reverse_iterator;
        typedef std::vector<context>::const_reverse_iterator const_reverse_iterator;

        ContextManager(const llvm::Module& module, const std::string& path)
            : mod(module), instrIndex(0), constantIndex(0)
        {
            // Compute global prefix for this module
            std::stringstream prefix;
            prefix << '<' << path <<  '>' << std::flush;

            // Add context
            contexts.push_back(Context(prefix.str()));
        }

        virtual ~ContextManager() {
            contexts.pop_back();
        }

        /// Record that a local context has been entered.  ctx is an IR
        /// "container" of some sort which is being considered for
        /// structural equivalence: global variables, functions, blocks,
        /// instructions, etc.
        void pushContext(const llvm::Value& ctx)
        {
            std::string prefix;

            // Compute prefix for fully qualified value names under given
            // context

            if (const llvm::Function *fctx = llvm::dyn_cast<llvm::Function>(&ctx)) {
                prefix = fctx->getName();
                instrIndex = 0;
            }
            else if (const llvm::BasicBlock *bbctx = llvm::dyn_cast<llvm::BasicBlock>(&ctx)) {
                prefix = bbctx->getName();
            }
            else if (llvm::isa<llvm::Instruction>(ctx)) {
                prefix = std::to_string(instrIndex++);
                constantIndex = 0;
            }

            contexts.push_back(Context(ctx, prefix));
        }

        /// Record that a local context has been exited.
        void popContext() {
            contexts.pop_back();
        }

        iterator begin() { return contexts.begin(); }
        iterator end()   { return contexts.end(); }

        const_iterator begin() const { return contexts.begin(); }
        const_iterator end()   const { return contexts.end(); }

        reverse_iterator rbegin() { return contexts.rbegin(); }
        reverse_iterator rend()   { return contexts.rend(); }

        const_reverse_iterator rbegin() const { return contexts.rbegin(); }
        const_reverse_iterator rend()   const { return contexts.rend(); }

        inline unsigned instrCount() { return instrIndex; }
        inline unsigned constantCount() { return constantIndex++; }
        inline const llvm::Module& module() const { return mod; }

      private:
        // Tracking local contexts
        std::vector<Context> contexts;

        // Current module and path
        const llvm::Module& mod;

        // Instruction and constant indices
        unsigned instrIndex;
        unsigned constantIndex;
    };
} // end of namespace cclyzer

#endif /* CONTEXT_MANAGER_HPP_ */
