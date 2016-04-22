from os import path
import shutil
import sys
from .commands import CliCommand
from ..runtime import Environment

class LogCommand(CliCommand):
    description = 'Display logged messages'

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        pass

    def __init__(self, args):
        CliCommand.__init__(self, args)

        # Path to log file
        env = Environment()
        self._logfile = env.user_log_file

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        with open(self._logfile) as log:
            shutil.copyfileobj(log, sys.stdout)
