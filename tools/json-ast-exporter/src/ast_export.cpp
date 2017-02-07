#include <boost/filesystem.hpp>
#include <boost/filesystem/fstream.hpp>
#include <sstream>
#include <jsoncons/json.hpp>
#include <clang-c/Index.h>
#include "json_utils.hpp"
#include "ast_export.hpp"
#include "ast_visitor.hpp"
#include "Options.hpp"

namespace fs = boost::filesystem;
namespace ast_json =  cclyzer::ast_exporter::jsonexport;

void
ast_json::export_ast(const Options& options)
{
    using namespace jsoncons;
    using namespace cclyzer::ast_exporter;

    // Get source input iterators
    Options::input_file_iterator input_begin = options.input_file_begin();
    Options::input_file_iterator input_end = options.input_file_end();

    for (auto it = input_begin; it != input_end; ++it)
    {
        fs::path sourcefile = *it;

        // Create an index with excludeDeclsFromPCH = 1, displayDiagnostics = 0
        CXIndex index = clang_createIndex(1, 0);

        // Command line arguments required for parsing the TU
        constexpr const char *args[] = {
            "-std=c++11",
            "-I/usr/include",
            "-I/usr/local/include"
        };

        // Speed up parsing by skipping function bodies
        CXTranslationUnit translation_unit = clang_parseTranslationUnit(
            index, sourcefile.c_str(),
            args, std::extent<decltype(args)>::value,
            nullptr, 0,
            CXTranslationUnit_None /* CXTranslationUnit_KeepGoing */);

        // Get top-level cursor
        CXCursor cursor = clang_getTranslationUnitCursor(translation_unit);

        // Construct JSON AST
        json::array json_ast;
        clang_visitChildren(cursor, ast_json::visit, &json_ast);

        // Construct JSON lexical token info
        json json_tokens = json::array();
        ast_json::record_tokens(json_tokens, cursor, translation_unit);

        // Put everything in together in a single JSON node
        json j;

        j[ast_json::node::FILE]   = sourcefile.string();
        j[ast_json::node::TREE]   = std::move(json_ast);
        j[ast_json::node::TOKENS] = std::move(json_tokens);

        std::cout << pretty_print(j) << std::endl;

        // Release memory
        clang_disposeTranslationUnit(translation_unit);
        clang_disposeIndex(index);

        // Get output directory
        const fs::path outdir = options.output_dir();
        typedef boost::filesystem::ofstream ofstream;

        // Write to output directory, if one was given
        if (!outdir.empty()) {
            // Construct output path for JSON
            fs::path json_out = sourcefile.filename();
            json_out = outdir / json_out;
            json_out += ".json";

            // Write to output file
            ofstream output(json_out);
            output << pretty_print(j) << std::endl;
        }
    }
}
