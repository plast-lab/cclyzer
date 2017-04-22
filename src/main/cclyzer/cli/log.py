from collections import deque
import logging
import sys
from .commands import CliCommand
from ..runtime import Environment


class LogCommand(CliCommand):
    description = 'Display logged messages'

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        parser.add_argument('-n', '--lines', metavar='K', type=int,
                            help='output the last K lines')

    def __init__(self, args):
        CliCommand.__init__(self, args)

        # Path to log file
        env = Environment()
        self._logfile = env.user_log_file
        self._lines = args.lines or 10
        assert self._lines > 0, "Number of lines must be positive"

        # Disable logging for this command
        logging.disable(logging.INFO)

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        with open(self._logfile) as log:
            for line in deque(log, self._lines):
                sys.stdout.write(line)
            sys.stdout.flush()
