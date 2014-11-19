from . import BloxScript

class LoadProjectScript(BloxScript):
    LOAD_PROJECT_TEMPLATE = '''
    open $workspace
    transaction
    echo "Installing compiled Datalog project from $project ..."
    installProject --dir $project --libPath $libpath
    commit
    '''

    def __init__(self, workspace, project_path, library_path):
        "Initialize a script that loads a project into a workspace."
        super(LoadProjectScript, self).__init__(LOAD_PROJECT_TEMPLATE)

        # Transform to string, assuming a sequence was given
        if not isinstance(library_path, basestring):
            library_path = ':'.join(library_path)

        # Save to substituted variables
        self.project = project_path
        self.libpath = library_path
