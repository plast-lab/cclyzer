from . import BloxScript

class LoadSchemaScript(BloxScript):
    LOAD_SCHEMA_TEMPLATE = '''
    echo "Creating workspace $workspace ..."
    create --overwrite $workspace
    transaction
    echo "Installing compiled Datalog schema in $schema ..."
    installProject --dir $schema
    echo "Installing compiled Datalog import logic in $import ..."
    installProject --dir $import --libPath $schema
    echo "Importing entities"
    exec --storedBlock "import-entities"
    echo "Importing predicates"
    exec --storedBlock "import-predicates"
    commit
    '''

    def __init__(self, workspace, schema_path, import_path):
        """Initialize a script that loads the basic schema and imports
        facts into a workspace.

        """

        super(LoadSchemaScript, self).__init__(LOAD_SCHEMA_TEMPLATE, workspace)

        # Save to substituted variables
        self.schema  = schema_path
        self.imprort = import_path
