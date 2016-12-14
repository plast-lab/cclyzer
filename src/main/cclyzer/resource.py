import logging
import shutil
from itertools import izip_longest
from os import chmod, path, makedirs, unlink
from pkg_resources import resource_isdir, resource_listdir, resource_stream
from . import runtime
from . import settings

# Initialize logger for this module
_logger = logging.getLogger(__name__)


class unpacked_binary(object):
    """A context manager that unpacks a binary resource to a temporary
    location.

    """
    def __init__(self, resource):
        self._resource = resource
        self._pkg = settings.RESOURCE_PKG

    def __enter__(self):
        # Compute resource path
        resource = self._resource
        path_to_resource = path.join('bin', resource)
        path_to_file = runtime.FileManager().getpath(path_to_resource)

        # Check if binary exists in cache
        if path.exists(path_to_file):
            # Open both cached and stored artifacts to compare
            cached_obj = open(path_to_file, 'rb')
            disk_obj = resource_stream(self._pkg, path_to_resource)

            # File hasn't changed; don't overwrite
            if all(a == b for (a, b) in izip_longest(disk_obj, cached_obj)):
                return path_to_file

            # Remove existing binary. If the file is being used, this is
            # safer than simply truncating it.
            unlink(path_to_file)

        _logger.info("Extracting binary %s to %s", resource, path_to_file)

        # Create parent directory
        parent_dir = path.dirname(path_to_file)
        if not path.exists(parent_dir):
            makedirs(parent_dir)

        # Create temporary executable file
        with open(path_to_file, 'wb') as binary:
            # Copy contents from resource stream
            for byte in resource_stream(self._pkg, path_to_resource):
                binary.write(byte)
            # Flush contents
            binary.flush()

        # Change permissions to mark it executable
        chmod(path_to_file, 0744)

        return path_to_file

    def __exit__(self, type, value, traceback):
        pass


class unpacked_project(object):
    """A context manager that unpacks a compiled Datalog project to a
    temporary location.

    """
    def __init__(self, project):
        self._project = project                      # project name
        self._pkg = settings.LOGIC_RESOURCE_PKG      # logic resources package name

    def __enter__(self):
        # Compute resource path
        project = self._project
        cached_logic_dir = runtime.FileManager().getpath('logic')
        cached_proj_dir = path.join(cached_logic_dir, project)

        # Check if project has been extracted before
        if path.exists(cached_proj_dir):
            # Compare signatures
            disk_signature = resource_stream(
                self._pkg, path.join(project, 'checksum')
            ).read().strip()

            cached_signature = open(
                path.join(cached_proj_dir, 'checksum'), 'rb'
            ).read().strip()

            # Project hasn't changed; don't overwrite
            if disk_signature == cached_signature:
                return cached_proj_dir

            # remove stale cached project
            shutil.rmtree(cached_proj_dir)

        _logger.info("Extracting project %s to %s", project, cached_proj_dir)

        resource_dirs = [project]

        # Iterate over all project files
        while resource_dirs:
            # Pop next resource directory
            res_dir = resource_dirs.pop(0)

            # Process its files
            for resource in resource_listdir(self._pkg, res_dir):
                # Skip empty resource paths (apparently, that can happen!!)
                if not resource:
                    continue

                # Compute path to resource
                path_to_resource = path.join(res_dir, resource)
                path_to_file = path.join(cached_logic_dir, path_to_resource)

                # Process resource directories recursively
                if resource_isdir(self._pkg, path_to_resource):
                    resource_dirs.append(path_to_resource)
                    continue

                _logger.debug("Extracting project file %s", path_to_resource)

                # Create parent directory
                parent_dir = path.dirname(path_to_file)
                if not path.exists(parent_dir):
                    makedirs(parent_dir)

                with open(path_to_file, 'w') as f:
                    # Copy contents from resource stream
                    for byte in resource_stream(self._pkg, path_to_resource):
                        f.write(byte)

        return cached_proj_dir

    def __exit__(self, type, value, traceback):
        pass
