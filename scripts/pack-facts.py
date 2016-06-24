#!python

from cclyzer import runtime as rt
import argparse
import factgen
import os
import zipfile

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input_files', metavar='FILE', nargs='+',
                        help='LLVM bitcode file to be analyzed')
    parser.add_argument('-o', '--output_file', metavar='OUTFILE',
                        help='output file')
    # Set default values
    parser.set_defaults(output_file='facts.zip')

    # Parse arguments
    args = parser.parse_args()

    # Generate facts
    outdir = rt.FileManager().mkdtemp()
    factgen.run(args.input_files, outdir)

    # Create zip archive with generated facts
    with zipfile.ZipFile(args.output_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(outdir):
            for file in files:
                path = os.path.join(root, file)
                zipf.write(path, os.path.relpath(path, outdir))


if __name__ == '__main__':
    main()
