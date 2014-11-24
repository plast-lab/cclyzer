import atexit
import os
import logging
import shutil

from .. import settings
from tempfile import mkdtemp, mkstemp
from utils import singleton

class FileManager(object):
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """Initialize the file manager."""
        # Create XDG compliant cache directory
        default_cachedir = os.path.join(os.environ['HOME'], '.cache')
        xdg_cachedir = os.getenv('XDG_CACHE_HOME', default_cachedir)
        app_cachedir = os.path.join(xdg_cachedir, settings.APP_NAME)

        # Create cache directory if it doesn't exist
        if not os.path.exists(app_cachedir):
            makedirs(app_cachedir)

        self._dir = mkdtemp(prefix = '', dir = app_cachedir)
        self.logger = logging.getLogger(__name__)
        self.logger.info("Initializing file manager, rooted at %s", self._dir)

    def cleanup(self):
        shutil.rmtree(self._dir)

    @property
    def root_directory(self):
        return self._dir

    @atexit.register
    def cleanup_files():
        FileManager().cleanup()

    def mktemp(self, *f_args, **f_kwargs):
        fd, path = mkstemp(dir = self._dir, *f_args, **f_kwargs)
        os.close(fd)
        return path

    def mkdtemp(self, *f_args, **f_kwargs):
        path = mkdtemp(dir = self._dir, *f_args, **f_kwargs)
        return path

    def getpath(self, path):
        return os.path.join(self._dir, path)
