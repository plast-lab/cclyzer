import argparse
import os
import shutil

from copper import *

def main():
    # Create CLI parser
    parser = argparse.ArgumentParser(description='Analyze LLVM bitcode.')
    parser.add_argument('-i', '--input-dir', metavar='DIRECTORY', required = True,
                        help='directory containing LLVM bitcode files to be analyzed')
    parser.add_argument('-o', '--output-dir', metavar='DIRECTORY', required = True,
                        help='output directory')
    # Parse arguments
    args = parser.parse_args()

    # Create analysis
    analysis = Analysis(args)

    # Create empty CSV directory
    csv_dir = os.path.join(args.output_dir, 'facts')

    print "Cleaning up older facts ..."
    if os.path.exists(csv_dir):
        shutil.rmtree(csv_dir)

    os.makedirs(csv_dir)

    # Generate facts
    print "Exporting facts ..."
    fact_generation(input_dir = args.input_dir, output_dir = csv_dir)
    print "Stored facts in %s" % csv_dir

    # Create empty workspace
    workspace = os.path.join(args.output_dir, 'db')

    # Create database
    print "Importing to database ... %s" % workspace
    create_database(workspace, csv_dir)

if __name__ == '__main__':
    main()
