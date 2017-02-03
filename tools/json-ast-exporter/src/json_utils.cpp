#include <string>
#include <clang-c/Index.h>
#include <jsoncons/json.hpp>

#include "json_utils.hpp"

namespace ast_json = cclyzer::ast_exporter::jsonexport;


void
ast_json::record_extent(json_t& obj, CXCursor cursor)
{
    // Get cursor extent
    CXSourceRange extent = clang_getCursorExtent( cursor );
    record_extent(obj, extent);
}


void
ast_json::record_extent(json_t& obj, CXSourceRange extent)
{
    CXSourceLocation startlocation = clang_getRangeStart( extent );
    CXSourceLocation endlocation   = clang_getRangeEnd( extent );

    // Get exact source locations
    unsigned int startline = 0, startcolumn = 0, startoffset = 0;
    unsigned int endline   = 0, endcolumn   = 0, endoffset   = 0;

    clang_getSpellingLocation(
        startlocation, nullptr, &startline, &startcolumn, &startoffset );

    clang_getSpellingLocation(
          endlocation, nullptr,   &endline,   &endcolumn,   &endoffset );

    // Record source location
    obj[node::START_LINE] = startline;
    obj[node::START_COLUMN] = startcolumn;
    obj[node::START_OFFSET] = startoffset;

    obj[node::END_LINE] = endline;
    obj[node::END_COLUMN] = endcolumn;
    obj[node::END_OFFSET] = endoffset;
}


void
ast_json::record_kind(json_t& obj, CXCursor cursor)
{
    // Get cursor kind
    CXCursorKind cursorkind = clang_getCursorKind(cursor);

    // Get textual representation of kind
    CXString kindname  = clang_getCursorKindSpelling(cursorkind);
    std::string result = clang_getCString(kindname);

    // Record kind
    obj[node::KIND] = result;

    // Release memory
    clang_disposeString(kindname);
}


void
ast_json::record_spelling(json_t& obj, CXCursor cursor)
{
    // Get cursor spelling
    CXString cursorspelling = clang_getCursorSpelling(cursor);

    // Record spelling
    std::string result = clang_getCString(cursorspelling);
    obj[node::DATA] = result;

    // Release memory
    clang_disposeString(cursorspelling);
}


void
ast_json::record_tokens(
    json_t& obj, CXCursor cursor, CXTranslationUnit translation_unit)
{
    // Get source code extent of node
    CXSourceRange extent = clang_getCursorExtent(cursor);

    // Tokenize node's contents
    CXToken *tokens;
    unsigned int nTokens;

    clang_tokenize(translation_unit, extent, &tokens, &nTokens);

    // JSONize every token
    for (unsigned i = 0; i < nTokens; i++)
    {
        const CXToken& token = tokens[i];
        json_t jsontoken;

        record_token(jsontoken, token, translation_unit);
        obj.add(jsontoken);
    }

    // Release tokens
    clang_disposeTokens(translation_unit, tokens, nTokens);
}


void
ast_json::record_token(
    json_t& obj, CXToken token, CXTranslationUnit translation_unit)
{
    // Record token kind
    switch (clang_getTokenKind(token)) {
      case CXToken_Punctuation:
          obj[lex_token::KIND] = "punctuation";
          break;
      case CXToken_Keyword:
          obj[lex_token::KIND] = "keyword";
          break;
      case CXToken_Identifier:
          obj[lex_token::KIND] = "identifier";
          break;
      case CXToken_Literal:
          obj[lex_token::KIND] = "literal";
          break;
      case CXToken_Comment:
          obj[lex_token::KIND] = "comment";
          break;
    }

    // Get attributes
    CXString spelling = clang_getTokenSpelling(translation_unit, token);
    CXSourceRange extent = clang_getTokenExtent(translation_unit, token);

    obj[lex_token::DATA] = std::string(clang_getCString(spelling));
    record_extent(obj, extent);

    // Reclaim memory
    clang_disposeString(spelling);
}
