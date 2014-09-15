from string import Template


class TemplateMetaclass(type):
    """Instruments every class variable access so that it returns a
    string.Template.

    """

    def __getattribute__(self, name):
        return Template(super(TemplateMetaclass, self).__getattribute__(name))


class scripts(object):
    __metaclass__ = TemplateMetaclass

    LOAD_SCHEMA = '''
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
