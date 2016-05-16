import abc
import blox.connect
import factgen
import logging
import os
import shutil
import subprocess
from utils.contextlib2 import cd
from . import runtime
from .resource import unpacked_binary, unpacked_project
from .project import UnpackedProject


class AnalysisStep(object):
    __metaclass__ = abc.ABCMeta

    def __init__(self):
        self.manager = runtime.FileManager()
        self.env = runtime.Environment()
        self.logger = logging.getLogger(__name__)

    def check(self):
        return self

    @abc.abstractmethod
    def apply(self, analysis):
        pass

    @abc.abstractproperty
    def message(self):
        pass


class FactGenerationStep(AnalysisStep):
    def apply(self, analysis):
        input_files = analysis.input_files
        outdir = analysis.facts_directory

        self.logger.info("LLVM Bitcode Input: %s", ', '.join(input_files))
        self.logger.info("Exporting facts to %s ...", outdir)

        # Create empty directory
        os.makedirs(outdir)

        # Generate facts
        factgen.run(input_files, outdir)

        self.logger.info("Stored facts into %s", outdir)

    @property
    def message(self):
        return 'generated facts'


class DatabaseCreationStep(AnalysisStep):
    def apply(self, analysis):
        dbdir = analysis.database_directory
        factdir = analysis.facts_directory

        self.logger.info("Loading data from %s ...", factdir)

        # Unpack required projects
        with unpacked_project('schema') as schema_project:
            with unpacked_project('import') as import_project:
                # Temporarily switch directory so that facts can be loaded
                with cd(analysis.output_directory):
                    # Execute script while ignoring output
                    blox.LoadSchemaScript(
                        workspace=dbdir,
                        script_path=self.manager.mktemp(suffix='.lb'),
                        schema_path=schema_project,
                        import_path=import_project
                    ).run()

        self.logger.info("Stored database in %s", dbdir)

    @property
    def message(self):
        return 'imported facts to database'

    def check(self):
        # Ensure that LOGICBLOX_HOME has been set
        if not self.env.logicblox_home:
            raise EnvironmentError("Environment variable LOGICBLOX_HOME is not set")

        return self


class LoadProjectStep(AnalysisStep):
    def __init__(self, project):
        AnalysisStep.__init__(self)
        self._project = project

    def apply(self, analysis):
        self.extract_then_apply(analysis)

    def extract_then_apply(self, analysis, project=None, unpacked_deps=None, libpath=[]):
        # Handle optional arguments and apply default values if needed
        project = project or self._project

        if unpacked_deps is None:
            unpacked_deps = list(project.dependencies)

        if not unpacked_deps:   # All dependencies have been extracted
            with UnpackedProject(project) as project:
                # Log project installation event
                self.logger.info("Installing project %s ...", project.name)

                # Execute script while ignoring output
                return (
                    blox.LoadProjectScript(
                        workspace=analysis.database_directory,
                        script_path=self.manager.mktemp(suffix='.lb'),
                        project_path=project.path,
                        library_path=libpath
                    ).run()
                )
        else:                   # We have remaining dependencies
            with unpacked_project(unpacked_deps.pop()) as dep_path:
                # Add unpacked project to library path
                libpath.append(dep_path)
                # Recursively unpack the remaining dependencies
                return self.extract_then_apply(analysis, project, unpacked_deps, libpath)

    @property
    def project(self):
        return self._project

    @property
    def message(self):
        return 'installed %s project' % self._project.name


class CleaningStep(AnalysisStep):
    def apply(self, analysis):
        # Remove previous analysis results
        if os.path.exists(analysis.output_directory):
            shutil.rmtree(analysis.output_directory)

    @property
    def message(self):
        return 'cleaned previous contents'


class SanityCheckStep(AnalysisStep):
    def __init__(self, project):
        AnalysisStep.__init__(self)
        self._project = project

    def apply(self, analysis):
        # Create database connector
        connector = blox.connect.Connector(analysis.database_directory)

        # Execute relevant block
        connector.execute_block('activate-sanity')

    @property
    def message(self):
        return 'enable {} sanity checks'.format(self._project.name)


class RunOutputQueriesStep(AnalysisStep):
    def __init__(self, project):
        AnalysisStep.__init__(self)
        self._project = project

    def apply(self, analysis):
        # Do nothing if project is not loaded
        if self._project not in analysis.loaded_projects:
            return

        # Create database connector
        connector = blox.connect.Connector(analysis.database_directory)

        # Create empty directory
        outdir = analysis.results_directory
        os.makedirs(outdir)

        # Compute query block name
        blockname = '{}-queries'.format(self._project.name)
        self.logger.info("Executing named block %s", blockname)

        # Execute relevant block
        with cd(outdir):
            connector.execute_block(blockname)

    @property
    def message(self):
        return 'run {} output queries'.format(self._project.name)


class UserOptionsStep(AnalysisStep):
    def __init__(self, options):
        AnalysisStep.__init__(self)
        self._options = list(options)
        self._prefix = 'user_options'

    @staticmethod
    def canonical_option(option):
        return option.replace('-', '_')

    def enable_option(self, option, value=None):
        """Return predicate initialization."""
        # Canonicalize option
        option = self.canonical_option(option)

        # Compute predicate name
        predicate = ':'.join([self._prefix, option])

        # Functional predicate case
        if value is not None:
            return '+{0}[] = "{1}".'.format(predicate, value)

        return '+{0}().'.format(predicate)

    def declare_option(self, option, value=None):
        """Return predicate declaration."""
        # Canonicalize option
        option = self.canonical_option(option)

        # Compute predicate name
        predicate = ':'.join([self._prefix, option])

        # Functional predicate case
        if value is not None:
            return '{0}[] = value -> string(value).'.format(predicate)

        return '{0}() -> .'.format(predicate)

    def apply(self, analysis):
        # Do nothing when no options are given
        if not self._options: return

        # Create database connector
        connector = blox.connect.Connector(analysis.database_directory)

        # Compute logic
        lines = [self.declare_option(opt, val) for (opt, val) in self._options]
        logic = '\n'.join(lines)
        self.logger.info("Adding logic:\n%s", logic)
        connector.add_logic(logic)

        lines = [self.enable_option(opt, val) for (opt, val) in self._options]
        logic = '\n'.join(lines)
        self.logger.info("Executing logic:\n%s", logic)

        # Execute relevant logic
        connector.execute_logic(logic)

    @property
    def message(self):
        return 'add user options'
