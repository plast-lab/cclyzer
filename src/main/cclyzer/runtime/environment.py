import os
import tempfile
from .. import settings
from functools import wraps
from utils import singleton


class Environment():
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """XDG compliant system environment abstraction."""
        self._app = settings.APP_NAME

        # Create XDG compliant cache directory
        default_cachedir = os.path.join(os.environ['HOME'], '.cache')
        xdg_cachedir = os.getenv('XDG_CACHE_HOME', default_cachedir)
        app_cachedir = os.path.join(xdg_cachedir, self._app)

        # Create XDG compliant data directory
        default_datadir = os.path.expanduser('~/.local/share')
        xdg_datadir = os.getenv('XDG_DATA_HOME', default_datadir)
        app_datadir = os.path.join(xdg_datadir, self._app)

        # Create XDG compliant config directory
        default_configdir = os.path.join(os.environ['HOME'], '.config')
        xdg_configdir = os.getenv('XDG_CONFIG_HOME', default_configdir)
        app_configdir = os.path.join(xdg_configdir, self._app)

        # Create XDG compliant runtime directory
        default_runtimedir = tempfile.gettempdir()
        xdg_runtimedir = os.getenv('XDG_RUNTIME_DIR', default_runtimedir)
        app_runtimedir = os.path.join(xdg_runtimedir, self._app)

        self._cache_dir = app_cachedir
        self._data_dir = app_datadir
        self._config_dir = app_configdir
        self._runtime_dir = app_runtimedir

        # LogicBlox Home
        self._logicblox_home = os.getenv('LOGICBLOX_HOME')

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

    def __repr__(self):
        return (
            "{}("
            "cache_dir={cache_dir!r}, "
            "data_dir={data_dir!r}, "
            "config_dir={config_dir!r}, "
            "runtime_dir={runtime_dir!r}, "
            "logicblox_home={logicblox_home!r}"
            ")"
        ).format(
            self.__class__.__name__,
            # Fields of interest
            cache_dir=self._cache_dir,
            data_dir=self._data_dir,
            config_dir=self._config_dir,
            runtime_dir=self._runtime_dir,
            logicblox_home=self._logicblox_home
        )

    # --------------------------------------------------------------------------
    # Define directory-returning properties
    # --------------------------------------------------------------------------

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
        return os.path.join(self.user_config_dir, "config")

    @property
    def local_config_file(self):
        return os.path.join(".{}".format(self._app), "config")

    @property
    @mkdirs
    def user_log_dir(self):
        return os.path.join(self.user_cache_dir, 'logs')

    @property
    def user_log_file(self):
        logfile = "{}.log".format(self._app)
        return os.path.join(self.user_log_dir, logfile)

    @property
    def logicblox_home(self):
        return self._logicblox_home
