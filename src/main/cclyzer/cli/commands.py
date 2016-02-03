import argparse
import logging
import sys
from utils.contextlib2 import stdout_redirected
from .logging_utils import setup_logging
from .timing_utils import task_timing
from ..analysis import Analysis
from ..analysis_config import AnalysisConfig


def run():
    """The main function that will be called by command-line execution
    of the tool.

    """
    logger = logging.getLogger(__name__)

    # Create CLI parser
    parser = argparse.ArgumentParser(description='Analyze LLVM bitcode.')
    parser.add_argument('input_files', metavar='FILE', nargs='+',
                        help='LLVM bitcode file to be analyzed')
    parser.add_argument('-o', '--output-dir', metavar='DIRECTORY', required=True,
                        help='output directory')
    parser.add_argument('-q', '--no-config-file', dest='read_config', action='store_false')
    parser.add_argument('--no-exports', dest='run_exports', action='store_false',
                        help='disable result query exports')
    parser.set_defaults(read_config=True)

    # Initialize analysis
    opts = parser.parse_args()
    config = AnalysisConfig.from_cli_options(opts)
    analysis = Analysis(config)

    # Try loading yaml
    try:
        import yaml
    except ImportError:
        logging.getLogger().warning('Cannot load yaml')
        opts.read_config = False

    # Customized analysis
    if opts.read_config:
        from ..config import CustomAnalysis
        analysis = CustomAnalysis(config)

    # Add query exporting steps
    if opts.run_exports:
        analysis.enable_exports()

    # Dynamically decorate each analysis step
    for step in analysis.pipeline:
        # Time step plus redirect stdout to /dev/null
        step.apply = task_timing(step.message)(
            stdout_redirected()(
                step.apply
            )
        )

    # Run analysis while timing each step, plus total time
    with task_timing('total time'):
        analysis.run()

    # Print statistics
    print "\n\n[Statistics]\n"
    print analysis.stats


def main():
    with setup_logging() as logger:
        try:
            run()
        except Exception as e:
            logger.exception('')
            print >> sys.stderr, 'Exiting ...'
            exit(1)
