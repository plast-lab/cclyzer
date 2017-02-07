#include "ast_export.hpp"
#include "Options.hpp"


int main(int argc, char *argv[])
{
    using namespace cclyzer::ast_exporter;

    try
    {
        // Parse command line
        Options options(argc, argv);

        // Export AST in JSON form
        jsonexport::export_ast(options);
    }
    catch (int errorcode) {
        exit(errorcode);
    }

    return 0;
}
