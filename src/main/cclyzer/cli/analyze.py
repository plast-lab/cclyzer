from utils.contextlib2 import stdout_redirected
from .commands import CliCommand
from .timing_utils import task_timing
from ..analysis import Analysis
from ..analysis_config import AnalysisConfig


class AnalyzeCommand(CliCommand):
    description = 'Analyze LLVM bitcode'

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        parser.add_argument('input_files', metavar='FILE', nargs='+',
                            help='LLVM bitcode file to be analyzed')
        parser.add_argument('-o', '--output-dir', metavar='DIRECTORY', required=True,
                            help='output directory')
        parser.add_argument('-q', '--no-config-file', dest='read_config', action='store_false')
        parser.add_argument('--no-exports', dest='run_exports', action='store_false',
                            help='disable result query exports')
        parser.set_defaults(read_config=True)

    def __init__(self, args):
        CliCommand.__init__(self, args)

        # Initialize analysis
        config = AnalysisConfig.from_cli_options(args)
        analysis = Analysis(config)

        # Try loading yaml
        try:
            import yaml
        except ImportError:
            self.logger.warning('Cannot load yaml')
            args.read_config = False

        # Customized analysis
        if args.read_config:
            from ..config import CustomAnalysis
            analysis = CustomAnalysis(config)

        # Add query exporting steps
        if args.run_exports:
            analysis.enable_exports()

        self._analysis = analysis

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        analysis = self._analysis

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
