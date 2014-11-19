import abc
import os
import string
import subprocess
from tempfile import NamedTemporaryFile

class BloxScript(object):
    __metaclass__ = abc.ABCMeta

    def __init__(self, template, workspace):
        """Initialize a LogicBlox script."""
        self._template = template
        self._mapping  = {'workspace' : workspace}

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

        # Create LogicBlox script as temporary file
        with NamedTemporaryFile(suffix = '.lb', dir = os.getcwd(), delete = False) as script:
            # Create template from string
            tpl = string.Template(self._template)
            
            # Write template to file after variable substitution
            contents = script.write(tpl.substitute(self._mapping))

            # Save path to script
            path_to_script = script.name

        # Execute script and remove it at the end
        try:
            return subprocess.check_call(['bloxbatch', '-script', path_to_script])
        finally:
            os.unlink(path_to_script)


    # Alias call method with run
    __call__ = run
