import logging
from os import path

from .commands import CliCommand
from .. import Analysis
from ..project import ProjectManager
from ..runtime import Environment as env


# Initialize logger and project manager for this module
_logger = logging.getLogger(__name__)
_projects = ProjectManager()


class LoadModuleCommand(CliCommand):
    description = 'Load logic module to analysis'

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        # Gather logic module names
        module_names = [p.name for p in _projects]

        # Add positional module argument
        parser.add_argument('module', metavar='MODULE', choices=module_names,
                            help='Logic module to be loaded')
        # Add positional analysis argument
        parser.add_argument('analysis', metavar='ANALYSIS_DIR',
                            help='Analysis directory')
        # Add various flags
        parser.add_argument('--load-deps', action='store_true')

    @property
    def defaultconfig(self):
        configdir = env().user_config_dir
        return path.join(configdir, "config")

    def __init__(self, args):
        CliCommand.__init__(self, args)
        self._module = args.module
        self._analysis = Analysis.load(args.analysis)
        _logger.info('Loaded analysis from disk: %s', self.analysis)

    @property
    def module(self):
        return self._module

    @property
    def analysis(self):
        return self._analysis

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        _logger.info('Loading module %s', self.module)
        self.analysis.load_project(self.module)
        _logger.info('Module %s is loaded', self.module)
