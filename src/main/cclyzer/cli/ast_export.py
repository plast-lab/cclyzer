import argparse
import astexport
import sys
import logging

from .commands import CliCommand


# Initialize logger for this module
_logger = logging.getLogger(__name__)


class AstExportCommand(CliCommand):
    description = 'Export AST to JSON'
    prefix_chars = ''

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        # Get all arguments to forward to library
        parser.add_argument('args', nargs=argparse.REMAINDER)

    def __init__(self, args):
        CliCommand.__init__(self, args)

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        # Prepend sub-command name to arguments
        arguments = [self.parser.prog] + self._args.args

        try:
            # Delegate to dynamic library call
            astexport.run(arguments)
        except astexport.ExportException, e:
            if e.error_code != 0:
                print >> sys.stderr, e.message
                exit(e.error_code)
