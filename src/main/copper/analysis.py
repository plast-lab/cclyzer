import os
from .project import Project
from .analysis_steps import *

class Analysis(object):
    def __init__(self, config):
        self._config = config
        self._pipeline = [
            CleaningStep(),
            FactGenerationStep(),
            DatabaseCreationStep(),
            LoadProjectStep(Project.SYMBOL_LOOKUP),
            LoadProjectStep(Project.CALLGRAPH),
        ]

    @property
    def pipeline(self):
        return self._pipeline

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
        for step in self.pipeline:
            step.apply(self)
