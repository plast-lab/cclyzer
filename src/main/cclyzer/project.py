import collections
import logging
from os import path
from pkg_resources import resource_stream, resource_listdir, resource_isdir
from utils import singleton
from . import settings
from .runtime import FileManager
from .resource import unpacked_project

# Initialize logger for this module
_logger = logging.getLogger(__name__)


class Project(object):
    def __init__(self, name, *dependencies):
        self._name = name
        self._deps = tuple(dependencies)

    def __repr__(self):
        return (
            "{0}(name={1.name!r}, dependencies={1.dependencies!r})"
        ).format(self.__class__.__name__, self)

    @property
    def name(self):
        return self._name

    @property
    def cname(self):
        """Return canonicalized name of project."""
        return self.canonicalized_name(self.name)

    @staticmethod
    def canonicalized_name(pname):
        return pname.replace('-', '_')

    @property
    def dependencies(self):
        return self._deps

    def __eq__(self, other):
        if not isinstance(other, self.__class__):
            return NotImplemented

        if self.name != other.name:
            return False

        return set(self._deps) == set(other.dependencies)

    def __ne__(self, other):
        result = self.__eq__(other)
        return result if result is NotImplemented else not result


class UnpackedProject(Project):
    """Adapts the Project class by automatically unpacking the project
    resource.

    """
    def __init__(self, project):
        self._proj = project
        self.context = unpacked_project(project.name)

    def __getattr__(self, attr):
        """Delegate everything to the underlying project."""
        return getattr(self._proj, attr)

    def __enter__(self):
        self._path = self.context.__enter__()
        return self

    def __exit__(self, type, value, traceback):
        self._path = None
        self.context.__exit__(type, value, traceback)

    @property
    def path(self):
        """Return the filesystem path where this project is
        unpacked.

        """
        if not self._path:
            raise ValueError("Project is not in extracted state")
        return self._path


# Project metadata
Metadata = collections.namedtuple("Metadata", ["project", "deps"])


class ProjectManager(object):
    __metaclass__ = singleton.Singleton

    def __init__(self):
        """Initialize the project manager."""
        _logger.info("Initializing project manager")
        self._projects = {}

        metadata = {}           # a dict from internal names to project name, dependencies
        logic_resource_pkg = settings.LOGIC_RESOURCE_PKG

        # Iterate over all project files
        for project in resource_listdir(logic_resource_pkg, '.'):
            # Skip empty resource paths (apparently, that can happen!!)
            if not project:
                continue

            # Skip ordinary files
            if not resource_isdir(logic_resource_pkg, project):
                continue

            # Construct project path
            project_dir = project

            # Find project file
            for resource in resource_listdir(logic_resource_pkg, project_dir):
                if resource.endswith(".project"):
                    # Compute path to resource
                    path_to_resource = path.join(project_dir, resource)
                    path_to_file = FileManager().mktemp()

                    # Read contents of project file
                    with open(path_to_file, 'w') as f:
                        # Copy contents from resource stream
                        for byte in resource_stream(logic_resource_pkg, path_to_resource):
                            f.write(byte)

                    # Extract metadata from project file
                    internal_name, deps = self.__extract_metadata(path_to_file)
                    metadata[internal_name] = Metadata(project, deps)

                    break

        # 2nd pass to create and store projects. This way the internal
        # names are entirely hidden from the user.
        for (i, (project, deps)) in metadata.iteritems():
            p = Project(project, *[metadata[d].project for d in deps])
            p.internal_name = i
            self._projects[project] = p
            setattr(self, project.replace('-', '_'), p)
            _logger.info("Found project %s that depends on: %s", project, p.dependencies)

    def __extract_metadata(self, filename):
        # The fields to be searched
        project_name = None
        project_libraries = []

        with open(filename, 'r') as proj:
            for line in proj:
                # Skip empty lines
                if line.strip() == "" or line.startswith("//"):
                    continue

                # Get key-value pair
                value, key = [x.strip() for x in line.split(",", 1)]

                # Find required fields by key
                if key == 'projectname':
                    project_name = value
                elif key == 'library':
                    project_libraries.append(value)

        return project_name, project_libraries

    def __getitem__(self, projectname):
        return self._projects[projectname]

    def __len__(self):
        return len(self._projects)

    def __iter__(self):
        return self._projects.values().__iter__()
