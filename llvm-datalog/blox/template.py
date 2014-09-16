import contextlib
import os

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


@contextlib.contextmanager
def make_temp_script(template, mapping):
    # Crate LogicBlox script as temporary file
    script = NamedTemporaryFile(suffix = '.lb', dir = os.getcwd(), delete = False)
    # Write contents by substituting variables to template
    script.write(template.substitute(mapping))
    # Close file and yield control
    script.close()
    yield script.name
    # Remove file
    os.unlink(script.name)
