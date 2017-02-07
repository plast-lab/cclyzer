#ifndef AST_EXPORT_H
#define AST_EXPORT_H

#include <clang-c/Index.h>
#include "Options.hpp"

namespace cclyzer {
    namespace ast_exporter {
        namespace jsonexport {
            void export_ast(const Options & );
        }
    }
}

#endif /* AST_EXPORT_H */
