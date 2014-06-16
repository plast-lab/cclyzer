#include <cstdlib>
#include <iostream>
#include <fcntl.h>
#include <fstream>
#include <google/protobuf/text_format.h>
#include <google/protobuf/io/zero_copy_stream_impl.h>

#include "blox/common/Common.pb.h"
#include "blox/compiler/BloxCompiler.pb.h"


using namespace std;
namespace common = blox::common::protocol;
namespace compiler = blox::compiler::protocol;

// Main function:  Reads the entire address book from a file and prints all
//   the information inside.
int main(int argc, char* argv[])
{
    // Verify that the version of the library that we linked against is
    // compatible with the version of the headers we compiled against.
    GOOGLE_PROTOBUF_VERIFY_VERSION;

    if (argc != 2)
    {
        cerr << "Usage:  " << argv[0] << " LBB_FILE" << endl;
        return -1;
    }

    compiler::CompilationUnitSummary compUnit;

    {
        int fileDescriptor = open(argv[1], O_RDONLY);

        if (fileDescriptor < 0)
        {
            std::cerr << " Error opening the file " << std::endl;
            return false;
        }

        google::protobuf::io::FileInputStream fileInput(fileDescriptor);
        fileInput.SetCloseOnDelete(true);

        if (!google::protobuf::TextFormat::Parse(&fileInput, &compUnit))
        {
            cerr << std::endl << "Failed to parse file!" << endl;
            return -1;
        }
    }

    // Optional:  Delete all global objects allocated by libprotobuf.
    google::protobuf::ShutdownProtobufLibrary();

    return EXIT_SUCCESS;
}
