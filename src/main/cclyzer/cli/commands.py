import argparse
import logging
import sys
from abc import ABCMeta, abstractmethod
from .logging_utils import setup_logging


class CliCommandMeta(ABCMeta):
    def __init__(cls, name, bases, dct):
        if not hasattr(cls, 'registry'):
            # this is the base class.  Create an empty registry
            cls.registry = {}

            # create the top level parser
            cls.parser = argparse.ArgumentParser() # TODO add description
            cls.subparsers = cls.parser.add_subparsers(
                dest = 'subcommand_name',
                title = 'subcommands'
            )
        else:
            # Sanity check
            assert name.endswith('Command')

            # this is a derived class.  Add cls to the registry
            subcommand_id = name[:-len('Command')].lower()
            cls.registry[subcommand_id] = cls

            # Create and initialize subparser
            cls.parser = cls.subparsers.add_parser(
                subcommand_id,
                description = dct.get('description')
            )

            cls.init_parser_args(cls.parser)

        super(CliCommandMeta, cls).__init__(name, bases, dct)


class CliCommand(object):
    __metaclass__ = CliCommandMeta

    def __init__(self, args):
        self.logger = logging.getLogger(__name__)
        self._args = args

    @classmethod
    def get_command(cls):
        # Get command line arguments
        args = cls.parser.parse_args()

        # Create new subcommand instance
        cmd_name = args.subcommand_name
        subcommand = cls.registry[cmd_name](args)

        # Return subcommand
        return subcommand

    @abstractmethod
    def run(self): pass

def main():
    with setup_logging() as logger:
        try:
            # Parse args to get subcommand
            command = CliCommand.get_command()

            # Run subcommand
            logger.info('Started')
            command.run()
        except Exception as e:
            logger.exception('')
            print >> sys.stderr, 'Exiting ...'
            exit(1)
        finally:
            logger.info('Finished')
