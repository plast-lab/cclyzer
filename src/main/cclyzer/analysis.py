import logging
import os
import pickle
from .project import Project, ProjectManager
from .analysis_steps import *
from .analysis_stats import AnalysisStatisticsBuilder as StatBuilder

# Logger for this module
_logger = logging.getLogger(__name__)


class Analysis(object):
    def __init__(self, config, projects=ProjectManager()):
        self._config = config
        self._stats = None
        self._loaded_projects = []
        self._projects = projects

        # Default pipeline of analysis steps
        pipeline = [
            _CleaningStep(),
            _FactGenerationStep(),
            _DatabaseCreationStep(),
            _SanityCheckStep(projects.schema),
            _UserOptionsStep(config.config_options('analysis')),
            _LoadProjectStep(projects.symbol_lookup),
            _LoadProjectStep(projects.callgraph),
            _LoadProjectStep(projects.debuginfo),
            _LoadProjectStep(config.points_to),
        ]

        # List of required project modules
        proj_whitelist = set(('schema', 'import',))

        # Decide if step should run in the actual pipeline
        def keep_step(step):
            # Check if step is associated with project
            if hasattr(step, 'project'):
                project = step.project

                # Transform project name to match canonicalized option
                projname = project.cname
                option = config.config_option('module', projname)

                # User configuration disabled project load
                usr_disabled = (option or '').lower() in ('off', 'no')

                # Log inclusion check
                _logger.info("Checking inclusion for module %s: %s", projname, option)

                # Check if project is mark as required
                if project.name in proj_whitelist:
                    # Warn about ignoring user request
                    if option and usr_disabled:
                        _logger.warn(
                            "Project %s could not be disabled" % project.name)
                    return True

                # Check if module was disabled by command-line option
                if usr_disabled:
                    return False

                # Mark projects as required
                proj_whitelist.add(project.name)
                proj_whitelist.update(project.dependencies)

            # By default, keep step in the pipeline
            return True

        # Filtered pipeline (in reverse order, to find dependencies)
        self._pipeline = [step for step in reversed(pipeline) if keep_step(step)]
        self._pipeline.reverse()
        _logger.info("Loaded modules %s", proj_whitelist)

    @property
    def loaded_projects(self):
        return self._loaded_projects

    @property
    def pipeline(self):
        return [step.check() for step in self._pipeline]

    @property
    def stats(self):
        # Compute stats if needed
        if self._stats is None:
            self.compute_stats()
        return self._stats

    @property
    def input_files(self):
        return [os.path.abspath(f) for f in self._config.input_files]

    @property
    def output_directory(self):
        return os.path.abspath(self._config.output_directory)

    @property
    def facts_directory(self):
        return os.path.join(self.output_directory, 'facts')

    def facts_file(self, predicate):
        filename = predicate.replace(':', '-') + '.dlm'
        return os.path.join(self.facts_directory, filename)

    @property
    def database_directory(self):
        return os.path.join(self.output_directory, 'db')

    @property
    def results_directory(self):
        return os.path.join(self.output_directory, 'results')

    @property
    def pickle_file(self):
        return os.path.join(self.output_directory, 'analysis.pickle')

    def save(self):
        with open(self.pickle_file, 'wb') as f:
            pickle.dump(self, f)

    def load_project(self, project):
        project = self.__find_project(project)

        # Check previous load
        if project in self._loaded_projects:
            raise ProjectLoadError("Already loaded", project)

        # Check project dependencies
        self.__check_deps(project, deps_only=True)

        # Load project
        _LoadProjectStep(project).apply(self)
        self._loaded_projects.append(step.project)

    def run(self):
        # Run each step of pipeline
        for step in self.pipeline:
            # Record loaded project
            if isinstance(step, _LoadProjectStep):
                self._loaded_projects.append(step.project)
            if isinstance(step, _DatabaseCreationStep):
                self._loaded_projects.append(self._projects.schema)
            step.apply(self)

        # Report loaded projects
        projects = [p.name for p in self.loaded_projects]
        _logger.info('Projects loaded: %s', projects)

        # Compute stats
        self.compute_stats()

    def compute_stats(self):
        self._stats = (
            StatBuilder(self)
            .count('instruction')
            .count('function_decl', title='functions')
            .count('function', title='app functions')
            .count('callgraph|reachable_function')
            .count('callgraph|callgraph:fn_edge', title='call-graph edges')
            .count('points_to|var_points_to', title='var-points-to')
            .count('points_to|constant_points_to', title='constant-points-to')
            .count('points_to|ptr_points_to', title='deref-points-to')
            .count('points_to|stack_allocation')
            .count('points_to|heap_allocation')
            .count('points_to|global_allocation')
            .count('points_to|allocation:size')
            .count('points_to|allocation:type')
            .count('points_to|type_compatible')
            .build()
        )

    def enable_exports(self, project=None):
        if project is None:
            project = self._config.points_to

        project = self.__find_project(project)

        # Check project dependencies
        try:
            self.__check_deps(project)
            self._pipeline.append(_RunOutputQueriesStep(project))
        except ProjectLoadError:
            _logger.info('Exported facts were disabled')

    def __find_project(self, project):
        # Find project instance, if string was given
        if isinstance(project, basestring):
            project = self._projects[project]

        # Check type of project
        if not isinstance(project, Project):
            raise ValueError('Non-project argument')

        return project

    def __check_deps(self, project, deps_only=False):
        '''Check that project dependencies are loaded'''
        assert isinstance(project, Project)
        deps = project.dependencies

        # Check that project is loaded as well
        if not deps_only:
            deps += (project,)

        # Check project dependencies
        for dep in deps:
            if self._projects[dep] not in self._loaded_projects:
                raise ProjectLoadError("Missing dependency: " + dep, project)


class ProjectLoadError(ValueError):
    '''Raise when loading a project was unsuccessful'''
    def __init__(self, message, project, *args):
        assert isinstance(project, Project)
        self.message = message
        self.project = project
        super(ProjectLoadError, self).__init__(message, project.name, *args)
