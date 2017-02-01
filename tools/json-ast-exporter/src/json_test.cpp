#include <sstream>
#include <jsoncons/json.hpp>
#include <jsoncons/json_filter.hpp>

#include "Options.hpp"

namespace fs = boost::filesystem;


int main(int argc, char *argv[])
{
    using namespace jsoncons;
    using namespace cclyzer::ast_exporter;

    // Parse command line
    Options options(argc, argv);

    // Get output directory
    const fs::path outdir = options.output_dir();

    // Get source input iterators
    Options::input_file_iterator input_begin = options.input_file_begin();
    Options::input_file_iterator input_end = options.input_file_end();

    std::string s = R"({"first":1, "second":2,"fourth":3,"fifth":4})";

    json_serializer serializer(std::cout);

    // Filters can be chained
    rename_name_filter filter2("fifth", "fourth", serializer);
    rename_name_filter filter1("fourth", "third", filter2);

    // A filter can be passed to any function that takes
    // a json_input_handler ...
    std::cout << "(1) ";
    std::istringstream is(s);
    json_reader reader(is, filter1);
    reader.read();
    std::cout << std::endl;

    // or a json_output_handler
    std::cout << "(2) ";
    ojson j = ojson::parse(s);
    j.dump(filter1);
    std::cout << std::endl;

    return 0;
}
