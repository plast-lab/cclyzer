import os
import shutil
import subprocess

from blox.template import scripts
from copper.resource import unpacked_binary, unpacked_project
from functools import wraps

class Project(object):
    pass

class Analysis(object):

    def __init__(self, obj):
        self._input_dir = obj.input_dir
        self._output_dir = obj.output_dir

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
        print "Exporting facts ..." ###
        with unpacked_binary('fact-generator') as executable:
            ret = subprocess.call([executable, "-i", indir, "-o", outdir])
        # Error checking
        if ret != 0:
            raise SystemError()
        # Store path to this output directory
        os.unlink('facts')
        os.symlink(outdir, 'facts')
        print "Stored facts in %s" % outdir
        return self


    @inside_output_subdir('db')
    def create_database(self):
        # Create script template
        tpl = scripts.LOAD_SCHEMA

        # Unpack required projects
        with unpacked_project('schema') as schema_project:
            with unpacked_project('import') as import_project:
                # Create LogicBlox script mappping
                mapping = {'workspace' : self._output_dir,
                           'schema'    : schema_project,
                           'import'    : import_project,
                }
                # Create LogicBlox script
                with open('load-schema.lb', 'w') as script:
                    script.write(tpl.substitute(mapping))

                return subprocess.call(["bloxbatch", "-script", 'load-schema.lb'])
