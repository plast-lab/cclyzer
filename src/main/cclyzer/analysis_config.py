from os import path
import logging
from .runtime import Environment
from .project import ProjectManager

# Initialize logger for this module
_logger = logging.getLogger(__name__)


class AnalysisConfig(object):
    def __init__(self, *inputfiles, **kwargs):
        self._projects = ProjectManager()
        self._env = Environment()
        self._input_files = list(inputfiles)
        self._output_dir = kwargs.pop('output_dir')
        self._points_to = 'points_to'
        self._confopt = {}

        # Configuration files
        configfiles = []

        # Read any existing local configuration file
        if kwargs.pop('read_local_config', False):
            configfiles.append(self._env.local_config_file)

        # Read any existing user configuration file
        if kwargs.pop('read_user_config', False):
            configfiles.append(self._env.user_config_file)

        # Initialize configurations
        self.configure(kwargs.pop('config', []), configfiles)
        self._options = kwargs

    def __getstate__(self):
        # Copy object's state
        state = self.__dict__.copy()
        # Remove unpicklable entries
        del state['_projects']
        del state['_env']
        return state

    def __setstate__(self, state):
        # Restore instance attributes
        self.__dict__.update(state)
        # Restore unpicklable entries
        self._projects = ProjectManager()
        self._env = Environment()

    def __repr__(self):
        return (
            "{}("
            "inputfiles={input_files!r}, "
            "output_dir={output_dir!r}, "
            "config={config!r}"
            ")"
        ).format(
            self.__class__.__name__,
            # Fields of interest
            input_files=self.input_files,
            output_dir=self.output_directory,
            config=self._confopt
        )

    @property
    def input_files(self):
        return self._input_files

    @property
    def output_directory(self):
        return self._output_dir

    @output_directory.setter
    def output_directory(self, value):
        self._output_dir = value

    @property
    def points_to(self):
        return getattr(self._projects, self._points_to)

    @classmethod
    def from_cli_options(cls, clioptions):
        # Get basic options
        options = vars(clioptions)
        inputfiles = options.pop('input_files')
        runpearce = options.pop('pearce', False)

        # Create configuration
        config = cls(*inputfiles, **options)

        # Run Pearce points-to analysis
        if runpearce:
            config._points_to = 'pearce_paste04'

        return config

    def _set_config_option(self, section, option, value):
        # Canonicalize option name and then set its value
        option = option.replace('-', '_')
        self._confopt.setdefault(section, {})[option] = value
        _logger.info("Config [%s]: %s = %s", section, option, value)

    def config_option(self, section, option):
        return self._confopt.get(section, {}).get(option, None)

    def config_options(self, section):
        return self._confopt.get(section, {}).iteritems()

    def configure(self, overrides, files):
        # Read overriden configurations
        for key, value in overrides:
            # Get section and option name
            if '.' in key:
                section, option = key.split('.', 1)
            else:
                # section defaults to analysis
                section, option = 'analysis', key

            # Store option
            self._set_config_option(section, option, value)

        # Configuration files
        for configfile in files:
            self.read_config_file(configfile)

    def read_config_file(self, configfile):
        # Check that configuration file exists
        if not path.isfile(configfile):
            return

        # Only import when configuration files exist
        from ConfigParser import SafeConfigParser as ConfigParser

        # Read configuration file
        parser = ConfigParser()
        parser.read(configfile)

        # Store all options
        for section in parser.sections():
            for option, value in parser.items(section):
                # Skip already set option
                if self.config_option(section, option) is None:
                    self._set_config_option(section, option, value)
