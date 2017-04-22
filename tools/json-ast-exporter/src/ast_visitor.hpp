#ifndef AST_VISITOR_H
#define AST_VISITOR_H

#include <clang-c/Index.h>

namespace cclyzer {
    namespace ast_exporter {
        namespace jsonexport {
            CXChildVisitResult visit( CXCursor , CXCursor , CXClientData );
        }
    }
}

#endif /* AST_VISITOR_H */
