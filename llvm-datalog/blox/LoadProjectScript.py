from . import BloxScript

class LoadProjectScript(BloxScript):
    LOAD_PROJECT_TEMPLATE = '''
    open $workspace
    transaction
    echo "Installing compiled Datalog project from $project ..."
    installProject --dir $project --libPath $libpath
    commit
    '''

    def __init__(self):
        "Initialize a script that loads a project into a workspace."
        super(LoadProjectScript, self).__init__(LOAD_PROJECT_TEMPLATE)


    def with_project_path(self, path):
        """The filesystem path to the project that is to be loaded."""

        # Save to substituted variables
        self._mapping['project'] = path

        return self


    def with_library_path(self, library_path):
        """The LIBRARY_PATH that will be used to search for dependencies."""

        # Transform to string, assuming a sequence was given
        if not isinstance(library_path, basestring):
            library_path = ':'.join(library_path)

        # Save to substituted variables
        self._mapping['libpath'] = library_path

        return self
