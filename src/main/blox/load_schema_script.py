from . import BloxScript


class LoadSchemaScript(BloxScript):
    TEMPLATE = '''
    echo "Creating workspace $workspace ..."
    create --overwrite $workspace
    transaction
    echo "Installing compiled Datalog schema in $schema_path ..."
    installProject --dir $schema_path
    echo "Installing compiled Datalog import logic in $import_path ..."
    installProject --dir $import_path --libPath $schema_path
    echo "Importing entities"
    exec --storedBlock "import-entities"
    echo "Importing predicates"
    exec --storedBlock "import-predicates"
    commit
    '''

    def __init__(self, workspace, script_path, schema_path, import_path):
        """Initialize a script that loads the basic schema and imports
        facts into a workspace.

        """
        BloxScript.__init__(self, LoadSchemaScript.TEMPLATE, workspace, script_path)

        # Save to substituted variables
        self.schema_path = schema_path
        self.import_path = import_path
