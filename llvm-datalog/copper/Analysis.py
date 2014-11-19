import os
import shutil
import subprocess

from functools import wraps

from .resource import unpacked_binary, unpacked_project
from .project import Project, UnpackedProject

class Analysis(object):

    def __init__(self, obj):
        self._input_dir = obj.input_dir
        self._output_dir = obj.output_dir
        self._projects = []

    def inside_output_subdir(subdir):
        """Decorator that temporarily changes output directory."""
        def wrapper(f):
            @wraps(f)
            def wrapped(self, *f_args, **f_kwargs):
                old_dir = self._output_dir
                try:
                    # Change output directory
                    self._output_dir = os.path.join(old_dir, subdir)
                    # Call original method
                    return f(self, *f_args, **f_kwargs)
                finally:
                    # Change back to original directory
                    self._output_dir = old_dir
            return wrapped
        return wrapper

    def clear(f):
        """Decorator that erases output directory."""
        @wraps(f)
        def wrapped(self, *f_args, **f_kwargs):
            print "Cleaning up older facts ..." ####
            # Clear previous contents
            if os.path.exists(self._output_dir):
                shutil.rmtree(self._output_dir)
            # Call original method
            return f(self, *f_args, **f_kwargs)
        return wrapped

    @clear
    @inside_output_subdir('facts')
    def generate_facts(self):
        indir, outdir = self._input_dir, self._output_dir
        # Create empty directory
        os.makedirs(outdir)
        # Generate facts
        print "Exporting facts ..."
        with unpacked_binary('fact-generator') as executable:
            subprocess.check_call([executable, "-i", indir, "-o", outdir])
        # Store path to this output directory
        os.unlink('facts')
        os.symlink(outdir, 'facts')
        print "Stored facts in %s" % outdir
        return self


    @inside_output_subdir('db')
    def create_database(self):
        print "Loading data ..."
        # Unpack required projects
        with unpacked_project('schema') as schema_project:
            with unpacked_project('import') as import_project:
                # Execute script while ignoring output
                return (
                    blox.LoadSchemaScript()
                    .with_workspace(self._output_dir)
                    .with_schema_path(schema_project)
                    .with_import_path(import_project)
                    .run()
                )
        # Store workspace location
        self._workspace = self._output_dir
        print "Stored database in %s" % self._workspace
        return self

    @property
    def workspace(self):
        return self._workspace


    def load_project(self, project):
        self._load_project(project, project.deps, [])
        self._projects.append(project)
        return self


    def _load_project(self, project, unpacked_deps, libpath):
        # Base case
        if not unpacked_deps:
            with UnpackedProject(project) as project:
                # Execute script while ignoring output
                return (
                    blox.LoadProjectScript()
                    .with_workspace(self.workspace)
                    .with_project_path(project.path)
                    .with_library_path(libpath)
                    .run()
                )
        # We have unpacked dependencies
        with unpacked_project(unpacked_deps.pop()) as dep_path:
            # Add unpacked project to library path
            libpath.append(dep_path)
            # Recursively unpack the remaining dependencies
            return self._load_project(project, unpacked_deps, libpath)
