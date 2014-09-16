import os
import subprocess

from string import Template
from tempfile import NamedTemporaryFile

class TemplateMetaclass(type):
    """Instruments every class variable access so that it returns a
    string.Template.

    """

    def __getattribute__(self, name):
        return Template(super(TemplateMetaclass, self).__getattribute__(name))


class scripts(object):
    __metaclass__ = TemplateMetaclass

    LOAD_SCHEMA = '''
    echo "Creating workspace $workspace ..."
    create --overwrite $workspace
    transaction
    echo "Installing compiled Datalog schema in $schema ..."
    installProject --dir $schema
    echo "Installing compiled Datalog import logic in $import ..."
    installProject --dir $import --libPath $schema
    echo "Importing entities"
    exec --storedBlock "import-entities"
    echo "Importing predicates"
    exec --storedBlock "import-predicates"
    commit
    '''

    LOAD_PROJECT = '''
    open $workspace
    transaction
    echo "Installing compiled Datalog project from $project ..."
    installProject --dir $project --libPath $libpath
    commit
    '''


class make_temp_script(object):
    def __init__(self, template, mapping):
        self._contents = template.substitute(mapping)

    def __enter__(self):
        # Create LogicBlox script as temporary file
        with NamedTemporaryFile(suffix = '.lb', dir = os.getcwd(), delete = False) as script:
            # Write contents by substituting variables to template
            script.write(self._contents)
            # Store file name
            self._script = script.name
        return self._script

    def __exit__(self, type, value, traceback):
        os.unlink(self._script)


def run_script(template, mapping):
    with make_temp_script(template, mapping) as script:
        return subprocess.check_call(['bloxbatch', '-script', script])
