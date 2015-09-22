import os
from .project import ProjectManager
from .analysis_steps import *
from .analysis_stats import AnalysisStatisticsBuilder as StatBuilder


class Analysis(object):
    def __init__(self, config, projects=ProjectManager()):
        self.logger = logging.getLogger(__name__)
        self._config = config
        self._stats = None
        self._pipeline = [
            CleaningStep(),
            FactGenerationStep(),
            DatabaseCreationStep(),
            SanityCheckStep(projects.SCHEMA),
            LoadProjectStep(projects.SYMBOL_LOOKUP),
            LoadProjectStep(projects.CALLGRAPH),
            LoadProjectStep(projects.POINTS_TO),
        ]


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

    @property
    def database_directory(self):
        return os.path.join(self.output_directory, 'db')

    def load_project(self, project):
        LoadProjectStep(project).apply(self)

    def run(self):
        # Run each step of pipeline
        for step in self.pipeline:
            step.apply(self)

        # Compute stats
        self.compute_stats()

    def compute_stats(self):
        self._stats = (
            StatBuilder(self)
            .count('instruction')
            .count('reachable_function')
            .count('callgraph:fn_edge', 'call-graph edges')
            .count('var_points_to', 'var-points-to')
            .count('constant_points_to', 'constant-points-to')
            .count('ptr_points_to', 'ptr-points-to')
            .count('stack_allocation')
            .count('heap_allocation')
            .count('global_allocation')
            .count('allocation:size')
            .count('allocation:type')
            .count('array_allocation')
            .build()
        )
