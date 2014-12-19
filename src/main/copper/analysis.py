import os
from .project import ProjectManager
from .analysis_steps import *
from .analysis_stats import AnalysisStatisticsBuilder as StatBuilder


class Analysis(object):
    def __init__(self, config, projects=ProjectManager()):
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
        return self._pipeline

    @property
    def stats(self):
        # Compute stats if needed
        if self._stats is None:
            self.compute_stats()
        return self._stats

    @property
    def input_directory(self):
        return os.path.abspath(self._config.input_directory)

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
            .count('callgraph:edge')
            .count('var_points_to', 'var-points-to')
            .count('ptr_points_to', 'ptr-points-to')
            .build()
        )
