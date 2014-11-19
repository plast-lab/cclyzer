import atexit
import os
import logging
import shutil

from tempfile import NamedTemporaryFile, mkdtemp
from utils import singleton

class FileManager(object):
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """Initialize the file manager."""
        self._dir = mkdtemp(prefix = 'copper-')
        print "Initializing file manager", self._dir
        logging.info("Initializing file manager rooted at %s", self._dir)

    def cleanup(self):
        shutil.rmtree(self._dir)

    @property
    def root_directory(self):
        return self._dir

    @atexit.register
    def cleanup_files():
        FileManager().cleanup()

    def gettempfile(self, *f_args, **f_kwargs):
        tmpfile = NamedTemporaryFile(dir = self.root_directory, delete = False, *f_args, **f_kwargs)
        tmpfile.manager = self
        self.register(tmpfile.name)
        return tmpfile

    def register(self, path):
        logging.debug("Adding temporary file %s", path)
