import abc
import logging
import string
import subprocess
from . import connect


class BloxScript(object):
    __metaclass__ = abc.ABCMeta

    def __init__(self, template, workspace, path):
        """Initialize a LogicBlox script."""
        self._template = template
        self._mapping = {'workspace': workspace}
        self._path = path

    def __getattr__(self, attr):
        return self._mapping(attr)

    def __setattr__(self, attr, value):
        # Treat all fields that don't start with underscore as
        # variable substitutions for the template
        if attr.startswith('_'):
            object.__setattr__(self, attr, value)
        else:
            self._mapping[attr] = value

    def run(self):
        """Execute this script."""

        # Create logger
        logger = logging.getLogger(__name__)

        # Get temporary file path
        path_to_script = self._path

        # Write contents of this LogicBlox script
        with open(path_to_script, mode='w') as script:
            # Create template from string
            tpl = string.Template(self._template)

            # Write template to file after variable substitution
            script.write(tpl.substitute(self._mapping))

        # Log event
        logger.info("bloxbatch -script %s", path_to_script)

        # Redirect error stream to file
        bloxbatch_log = path_to_script + '.log'
        record = logger.warning

        # Execute script
        with open(bloxbatch_log, 'w+') as errlog:
            try:
                # Call subprocess
                subprocess.check_call(
                    ['bloxbatch', '-script', path_to_script], stderr=errlog)
            except:
                record = logger.error

                # Print script contents
                with open(path_to_script, 'r') as script:
                    logger.error(script.read())

                raise
            finally:  # Go to the beginning of the log and add new log record
                errlog.seek(0)
                errors = connect.filter_errors(errlog)

                if errors.strip():
                    record("\n%s", errors)

    # Alias call method with run
    __call__ = run
