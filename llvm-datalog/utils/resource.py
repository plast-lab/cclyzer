import os
import shutil
import subprocess

from blox.template import scripts
from pkg_resources import resource_stream, resource_listdir
from string import Template
from tempfile import NamedTemporaryFile, mkdtemp


class constants(object):
    RESOURCE_DIR = 'resources'  # base resource directory


class unpacked_binary(constants):
    def __init__(self, resource):
        self._resource = resource

    def __enter__(self):
        # Compute resource path
        resource = self._resource
        path_to_resource = os.path.join('bin', resource)

        # Create temporary executable file
        with NamedTemporaryFile(suffix = resource, delete = False) as tempfile:
            # Copy contents from resource stream
            for byte in resource_stream(self.RESOURCE_DIR, path_to_resource):
                tempfile.write(byte)
            tempfile.flush()
            # Store temporary file's name
            self._executable = tempfile.name

        # Change permissions to mark it executable
        os.chmod(self._executable, 0744)

        return self._executable

    def __exit__(self, type, value, traceback):
        os.unlink(self._executable)


class unpacked_project(constants):
    def __init__(self, project):
        self._project = project
        self._outdir = mkdtemp(suffix = project)

    def __enter__(self):
        # Compute resource path
        project = self._project
        base_dir = os.path.join('logic', project)

        # Iterate over all project files
        for resource in resource_listdir(self.RESOURCE_DIR, base_dir):
            # Skip empty resource paths (apparently, that can happen!!)
            if not resource:
                continue
            # Compute path to resource
            path_to_resource = os.path.join(base_dir, resource)
            with open(os.path.join(self._outdir, resource), 'w') as tempfile:
                # Copy contents from resource stream
                for byte in resource_stream(self.RESOURCE_DIR, path_to_resource):
                    tempfile.write(byte)

        return self._outdir

    def __exit__(self, type, value, traceback):
        shutil.rmtree(self._outdir)



def fact_generation(input_dir, output_dir):
    with unpacked_binary('fact-generator') as executable:
        return subprocess.call([executable, "-i", input_dir, "-o", output_dir])


def create_database(workspace, csv_dir):
    # Create script template
    tpl = Template(scripts.LOAD_SCHEMA)

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
