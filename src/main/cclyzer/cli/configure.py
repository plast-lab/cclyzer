# from utils.contextlib2 import stdout_redirected
from os import path
from .commands import CliCommand
from ..runtime import Environment as env
import logging


# Initialize logger for this module
_logger = logging.getLogger(__name__)


class Option(object):
    @classmethod
    def _options(cls):
        return filter(lambda fld: not fld.startswith('_'), vars(cls))

    @classmethod
    def label(cls):
        return cls.__label__

    @classmethod
    def messages(cls):
        return [(cls.__dict__[fld], fld) for fld in cls._options()]


class EntryPointsOption(Option):
    __label__ = "entrypoints"

    library = 'All functions considered entry points'
    user = 'User supplied entry point'
    main = 'Main function entry point. Default'


class ConfigCommand(CliCommand):
    description = 'Configure analysis'

    @classmethod
    def init_parser_args(cls, parser):
        """Add custom options to CLI subcommand parser.

        """
        parser.add_argument('-i', '--interactive', action='store_true')
        parser.add_argument('-f', '--file', metavar='config-file',
                            help='Use the given config file')

    @property
    def defaultconfig(self):
        configdir = env().user_config_dir
        return path.join(configdir, "config")

    def __init__(self, args):
        CliCommand.__init__(self, args)

        # -------------------------------------------------------
        # Determine configuration file
        # -------------------------------------------------------

        configfile = None

        # Custom configuration file
        if args.file:
            configfile = args.file

        # Default configuration file
        if not configfile:
            configfile = self.defaultconfig

        self.configfile = configfile
        self.options = []

        # -------------------------------------------------------
        # Interactive Customization
        # -------------------------------------------------------

        if args.interactive:
            self.interact()

    def interact(self):
        import inquirer

        dialog = [
            inquirer.List(
                EntryPointsOption.label(),
                message="Choose analysis entry points",
                choices=EntryPointsOption.messages(),
            ),
        ]
        self.options = inquirer.prompt(dialog)

    def run(self):
        """The main function that will be called by command-line execution
        of the tool.

        """
        _logger.info('Writing to configuration file %s', self.configfile)

        with open(self.configfile, 'w') as config:
            config.write("[Analysis]\n")
            for option, value in self.options.iteritems():
                config.write("\t{0} = {1}\n".format(option, value))
