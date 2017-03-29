#include <jsoncons/json.hpp>
#include "ast_visitor.hpp"
#include "json_utils.hpp"

namespace ast_json = cclyzer::ast_exporter::jsonexport;

CXChildVisitResult
ast_json::visit( CXCursor cursor, CXCursor parent, CXClientData clientData )
{
    using namespace jsoncons;
    CXSourceLocation location = clang_getCursorLocation( cursor );

    // Ignore non-local entities (from include directives)
    if (clang_Location_isFromMainFile(location) == 0)
        return CXChildVisit_Continue;

    // JSON object for this node
    json node;

    // JSON array object for children nodes
    json::array children;

    // Record node's kind and spelling
    ast_json::record_kind(node, cursor);
    ast_json::record_spelling(node, cursor);

    // Record node's source code range
    ast_json::record_extent(node, cursor);

    // Record node's lexical tokens
    // ast_json::record_tokens(node, cursor);

    // Record node children
    clang_visitChildren(cursor, ast_json::visit, &children);

    if (children.size() > 0)
        node["children"] = std::move(children);

    // Add JSON object to JSON tree being constructed
    reinterpret_cast<json::array*>(clientData)->add(node);

    return CXChildVisit_Continue;
}
