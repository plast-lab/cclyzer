import os
from .project import ProjectManager
from .analysis_steps import *
from .analysis_stats import AnalysisStatisticsBuilder as StatBuilder


class Analysis(object):
    def __init__(self, config, projects=ProjectManager()):
        self.logger = logging.getLogger(__name__)
        self._config = config
        self._stats = None
        self._loaded_projects = []
        self._projects = projects
        self._pipeline = [
            CleaningStep(),
            FactGenerationStep(),
            DatabaseCreationStep(),
            SanityCheckStep(projects.schema),
            UserOptionsStep(config.config_options('analysis')),
            LoadProjectStep(projects.symbol_lookup),
            LoadProjectStep(projects.callgraph),
            LoadProjectStep(config.points_to),
        ]

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

    def load_project(self, project):
        LoadProjectStep(project).apply(self)

    def run(self):
        # Run each step of pipeline
        for step in self.pipeline:
            # Record loaded project
            if isinstance(step, LoadProjectStep):
                self._loaded_projects.append(step.project)
            step.apply(self)

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
        self._pipeline.append(RunOutputQueriesStep(project))
