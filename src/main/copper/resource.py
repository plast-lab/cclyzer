import logging
import shutil
from itertools import izip_longest
from os import chmod, path, makedirs, unlink
from pkg_resources import resource_stream, resource_listdir
from . import runtime
from . import settings


class unpacked_binary(object):
    """A context manager that unpacks a binary resource to a temporary
    location.

    """
    def __init__(self, resource):
        self._resource = resource
        self.logger = logging.getLogger(__name__)

    def __enter__(self):
        # Compute resource path
        resource = self._resource
        path_to_resource = path.join('bin', resource)
        path_to_file = runtime.FileManager().getpath(path_to_resource)

        # Check if binary exists in cache
        if path.exists(path_to_file):
            # Open both cached and stored artifacts to compare
            fileobj = resource_stream(settings.RESOURCE_DIR, path_to_resource)
            cached_fileobj = open(path_to_file, 'rb')

            # File hasn't changed; don't overwrite
            if all(b1 == b2 for (b1,b2) in izip_longest(fileobj, cached_fileobj)):
                return path_to_file

            # Remove existing binary. If the file is being used, this is
            # safer than simply truncating it.
            unlink(path_to_file)

        self.logger.info("Extracting binary %s to %s", resource, path_to_file)

        # Create parent directory
        parent_dir = path.dirname(path_to_file)
        if not path.exists(parent_dir):
            makedirs(parent_dir)

        # Create temporary executable file
        with open(path_to_file, 'wb') as binary:
            # Copy contents from resource stream
            for byte in resource_stream(settings.RESOURCE_DIR, path_to_resource):
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
        self._project = project
        self.logger = logging.getLogger(__name__)

    def __enter__(self):
        # Compute resource path
        project = self._project
        base_dir = path.join('logic', project)
        root_dir = runtime.FileManager().getpath(base_dir)

        # Check if project has been extracted before
        if path.exists(root_dir):
            shutil.rmtree(root_dir)

        self.logger.info("Extracting project %s to %s", project, root_dir)

        # Iterate over all project files
        for resource in resource_listdir(settings.RESOURCE_DIR, base_dir):
            # Skip empty resource paths (apparently, that can happen!!)
            if not resource:
                continue

            # Compute path to resource
            path_to_resource = path.join(base_dir, resource)
            path_to_file = path.join(root_dir, resource)

            self.logger.debug("Extracting project file %s", path_to_resource)

            # Create parent directory
            parent_dir = path.dirname(path_to_file)
            if not path.exists(parent_dir):
                makedirs(parent_dir)

            with open(path_to_file, 'w') as f:
                # Copy contents from resource stream
                for byte in resource_stream(settings.RESOURCE_DIR, path_to_resource):
                    f.write(byte)

        return root_dir

    def __exit__(self, type, value, traceback):
        pass
