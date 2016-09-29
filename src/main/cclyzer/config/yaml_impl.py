import logging
import os
import shutil
import sys
import yaml
from pkg_resources import resource_stream
from utils import singleton
from .. import settings
from ..runtime import Environment
from ..project import Project, ProjectManager

CORRUPTED_METADATA_WARNING = '''
Configuration files contains corrupted project metadata. You should remove it!
'''

# Initialize logger for this module
_logger = logging.getLogger(__name__)


class YamlConfiguration(object):
    __metaclass__ = singleton.Singleton

    @staticmethod
    def read_logic_modules(projects):
        """Get the latest logic project metadata in YAML format."""

        # Create new empty list of logic modules
        modules = []

        # Read the latest project metadata
        for project in projects:
            # Create new module
            module = {
                'name': project.name,
                'dependencies': ', '.join(project.dependencies)
            }
            modules.append({'module': module})

        return modules

    def __init__(self, projects=ProjectManager()):
        self._config = Environment().user_config_file
        self._projects = projects
        self._data = None

        # Install default configuration
        if not os.path.exists(self._config):
            self.install_default_config()

        # Read the configuration file
        with open(self._config) as f:
            self._data = yaml.safe_load(f)

    def install_default_config(self):
        resources, default_conf = settings.RESOURCE_PKG, 'default_config.yaml'
        _logger.info("Installing configuration file to %s", self._config)

        with open(self._config, 'w') as conf:
            default_conf = resource_stream(resources, default_conf)
            shutil.copyfileobj(default_conf, conf)

    def _read_project_entry(self, entry):
        name = entry['name']
        deps = entry.get('dependencies', [])
        return Project(name, *deps)

    @property
    def logic_modules(self):
        projects = []

        # Read projects
        for module in self._data['Logic Modules']:
            project = self._read_project_entry(module['module'])
            projects.append(project)

        return projects

    @property
    def projects(self):
        projects = []

        # Read analysis steps
        for step in self._data['Analysis Steps'][2:]:
            # Create project based on configuration
            project = self._read_project_entry(step['step'])

            # Create project based on logic sources
            other = self._projects[project.name]

            # Perform sanity check
            if other is not None and project != other:
                _logger.warning(CORRUPTED_METADATA_WARNING)
                print >> sys.stderr, CORRUPTED_METADATA_WARNING
                project = other

            projects.append(project)

        return projects

    @property
    def statistics(self):
        stats = []

        # Read statistics
        for stat in self._data['Statistics']['Predicate Counts']:
            predicate = stat['predicate']
            header = stat.get('header', None)
            stats.append((predicate, header))
            # TODO check if the relevant project has been loaded

        return stats
