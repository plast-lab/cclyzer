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
        parser.add_argument('-q', '--no-config-file', dest='read_local_config',
                            action='store_false', help='disable local configuration')
        parser.add_argument('--no-user-config-file', dest='read_user_config',
                            action='store_false', help='disable user configuration')
        parser.add_argument('--no-exports', dest='run_exports', action='store_false',
                            help='disable result query exports')
        parser.add_argument('--pearce', dest='pearce', action='store_true',
                            help='run Pearce points-to analysis')
        parser.add_argument('--config', nargs=2, metavar=('OPTION', 'VALUE'),
                            action='append', help='override configuration variable')
        parser.add_argument('--json-out', dest='export_json', action='store_true',
                            help='export analysis results to JSON')
        # Set default values
        parser.set_defaults(read_local_config=True, read_user_config=True, config=[])

    def __init__(self, args):
        CliCommand.__init__(self, args)

        # Initialize analysis
        config = AnalysisConfig.from_cli_options(args)
        analysis = Analysis(config)

        # Add query exporting steps
        if args.run_exports:
            analysis.enable_exports()

        # Add json export step
        if args.export_json:
            analysis.enable_json_exports()

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
