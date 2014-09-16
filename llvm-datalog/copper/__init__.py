import os
import subprocess

from blox.template import scripts
from copper.resource import unpacked_binary, unpacked_project


class Project(object):
    pass

class Analysis(object):
    def __init__(self, obj):
        self._input_dir = obj.input_dir
        self._output_dir = obj.output_dir

def fact_generation(input_dir, output_dir):
    with unpacked_binary('fact-generator') as executable:
        return subprocess.call([executable, "-i", input_dir, "-o", output_dir])


def create_database(workspace, csv_dir):
    # Create script template
    tpl = scripts.LOAD_SCHEMA

    # Unpack required projects
    with unpacked_project('schema') as schema_project:
        with unpacked_project('import') as import_project:
            # Create LogicBlox script mappping
            mapping = {'workspace' : workspace,
                       'schema'    : schema_project,
                       'import'    : import_project,
            }
            # Create LogicBlox script
            with open('load-schema.lb', 'w') as script:
                script.write(tpl.substitute(mapping))

            # os.chdir(os.path.dirname(workspace))
            os.unlink('facts')
            os.symlink(csv_dir, 'facts')
            return subprocess.call(["bloxbatch", "-script", 'load-schema.lb'])
