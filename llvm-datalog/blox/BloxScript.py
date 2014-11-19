import abc
import os
import string
import subprocess
from tempfile import NamedTemporaryFile

class BloxScript(object):
    __metaclass__ = abc.ABCMeta

    def __init__(self, template):
        """Initialize a LogicBlox script."""
        self._template = template
        self._mapping = {}

    def __getattr__(self, attr):
        return self._mapping(attr)

    def run():
        """Execute this script."""

        # Create LogicBlox script as temporary file
        with NamedTemporaryFile(suffix = '.lb', dir = os.getcwd()) as script:
            # Create template from string
            tpl = string.Template(self._template)
            
            # Write template to file after variable substitution
            contents = script.write(tpl.substitute(self._mapping))

            # Execute script
            return subprocess.check_call(['bloxbatch', '-script', script])

    def with_workspace(self, workspace):
        """The workspace on which this script will be executed."""
        self._mapping['workspace'] = workspace
        return self

    # Alias call method with run
    __call__ = run
