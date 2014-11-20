import abc
import copper
import os
import string
import subprocess

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

        # Get temporary file path
        path_to_script = copper.runtime.FileManager().mktemp(suffix = '.lb')

        # Write contents of this LogicBlox script
        with open(path_to_script, mode = 'w') as script:
            # Create template from string
            tpl = string.Template(self._template)
            
            # Write template to file after variable substitution
            contents = script.write(tpl.substitute(self._mapping))

        # Execute script
        return subprocess.check_call(['bloxbatch', '-script', path_to_script])


    # Alias call method with run
    __call__ = run
