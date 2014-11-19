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

    def __init__(self):
        """Initialize a script that loads the basic schema and imports
        facts into a workspace.

        """
        super(LoadSchemaScript, self).__init__(LOAD_SCHEMA_TEMPLATE)


    def with_schema_path(self, path):
        """The filesystem path to the schema project."""

        # Save to substituted variables
        self._mapping['schema'] = path

        return self


    def with_import_path(self, path):
        """The filesystem path to the import project."""

        # Save to substituted variables
        self._mapping['import'] = path

        return self
