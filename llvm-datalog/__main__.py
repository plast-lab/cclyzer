import argparse
import copper

def main():
    # Create CLI parser
    parser = argparse.ArgumentParser(description='Analyze LLVM bitcode.')
    parser.add_argument('-i', '--input-dir', metavar='DIRECTORY', required = True,
                        help='directory containing LLVM bitcode files to be analyzed')
    parser.add_argument('-o', '--output-dir', metavar='DIRECTORY', required = True,
                        help='output directory')

    args = parser.parse_args()       # parse arguments
    analysis = copper.Analysis(args) # create analysis
    analysis.generate_facts()        # generate CSV facts
    analysis.create_database()       # create database

if __name__ == '__main__':
    main()
