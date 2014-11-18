from .resource import unpacked_project

class Project(object):
    pass

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
