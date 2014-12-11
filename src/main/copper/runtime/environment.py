import os
import tempfile
from .. import settings
from functools import wraps
from utils import singleton

class Environment():
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """XDG compliant system environment abstraction."""

        # Create XDG compliant cache directory
        default_cachedir = os.path.join(os.environ['HOME'], '.cache')
        xdg_cachedir = os.getenv('XDG_CACHE_HOME', default_cachedir)
        app_cachedir = os.path.join(xdg_cachedir, settings.APP_NAME)

        # Create XDG compliant data directory
        default_datadir = os.path.expanduser('~/.local/share')
        xdg_datadir = os.getenv('XDG_DATA_HOME', default_datadir)
        app_datadir = os.path.join(xdg_datadir, settings.APP_NAME)

        # Create XDG compliant config directory
        default_configdir = os.path.join(os.environ['HOME'], '.config')
        xdg_configdir = os.getenv('XDG_CONFIG_HOME', default_configdir)
        app_configdir = os.path.join(xdg_configdir, settings.APP_NAME)

        # Create XDG compliant runtime directory
        default_runtimedir = tempfile.gettempdir()
        xdg_runtimedir = os.getenv('XDG_RUNTIME_DIR', default_runtimedir)
        app_runtimedir = os.path.join(xdg_runtimedir, settings.APP_NAME)

        self._cache_dir = app_cachedir
        self._data_dir = app_datadir
        self._config_dir = app_configdir
        self._runtime_dir = app_runtimedir


    def mkdirs(prop):
        """Decorator that targets directory returning properties.

        In case the returned directory does not exist, it creates it
        along with all of its parent directories.
        """
        @wraps(prop)
        def wrapped(self):
            # Get application directory by caling original method
            appdir = prop(self)
            # Create non-existing directories
            if not os.path.exists(appdir):
                os.makedirs(appdir)
            # Return application directory
            return appdir
        return wrapped



    # Define directory-returning properties

    @property
    @mkdirs
    def user_cache_dir(self):
        return self._cache_dir

    @property
    @mkdirs
    def user_data_dir(self):
        return self._data_dir

    @property
    @mkdirs
    def user_config_dir(self):
        return self._config_dir

    @property
    @mkdirs
    def user_runtime_dir(self):
        return self._runtime_dir

    @property
    def user_config_file(self):
        baseconf = "{}.yaml".format(settings.APP_NAME)
        return os.path.join(self.user_config_dir, baseconf)
