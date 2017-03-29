#ifndef JSON_UTILS_HPP__
#define JSON_UTILS_HPP__

#include <string>
#include <clang-c/Index.h>
#include <jsoncons/json.hpp>

namespace cclyzer {

    namespace ast_exporter {

        namespace jsonexport {

            typedef jsoncons::json json_t;

            // Recording routines
            void record_extent( json_t &, CXCursor );
            void record_extent(json_t &, CXSourceRange );
            void record_kind( json_t &, CXCursor );
            void record_spelling( json_t &, CXCursor );
            void record_tokens( json_t &, CXCursor, CXTranslationUnit );
            void record_token( json_t & , CXToken, CXTranslationUnit );

            // AST Node properties
            namespace node {
                const std::string FILE = "file";
                const std::string KIND = "kind";
                const std::string DATA = "data";

                const std::string START_LINE = "start_line";
                const std::string START_COLUMN = "start_column";
                const std::string START_OFFSET = "start_offset";

                const std::string END_LINE = "end_line";
                const std::string END_COLUMN = "end_column";
                const std::string END_OFFSET = "end_offset";

                const std::string TOKENS = "tokens";
                const std::string TREE = "ast";
            }

            // Lexical Token Properties
            namespace lex_token {
                const std::string KIND = "kind";
                const std::string DATA = "data";
                const std::string FILE = "file";
                const std::string LINE = "line";
                const std::string COLUMN = "column";
                const std::string OFFSET = "offset";
            }
        }
    }
}

#endif /* JSON_UTILS_HPP__ */
