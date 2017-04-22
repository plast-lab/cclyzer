import atexit
import os
import logging
import shutil
from .environment import Environment
from tempfile import mkdtemp, mkstemp
from utils import singleton

# Initialize logger for this module
_logger = logging.getLogger(__name__)


class FileManager(object):
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """Initialize the file manager."""
        env = Environment()
        self._tmpdir = mkdtemp(prefix='', dir=env.user_runtime_dir)
        self._cachedir = env.user_cache_dir
        _logger.info("Initializing file manager, rooted at %s", self._tmpdir)

    def cleanup(self):
        shutil.rmtree(self._tmpdir)

    @atexit.register
    def cleanup_files():
        FileManager().cleanup()

    def mktemp(self, *f_args, **f_kwargs):
        fd, path = mkstemp(dir=self._tmpdir, *f_args, **f_kwargs)
        os.close(fd)
        return path

    def mkdtemp(self, *f_args, **f_kwargs):
        path = mkdtemp(dir=self._tmpdir, *f_args, **f_kwargs)
        return path

    def getpath(self, path):
        return os.path.join(self._cachedir, path)
