from .yaml_impl import YamlConfiguration as UserConfiguration
from .. import Analysis
from ..project import ProjectManager
from ..analysis_stats import AnalysisStatisticsBuilder as StatBuilder
from ..analysis_steps import (
    _CleaningStep, _FactGenerationStep, _DatabaseCreationStep,
    _LoadProjectStep, _SanityCheckStep)


class CustomAnalysis(Analysis):
    def __init__(self, config, projects=ProjectManager()):
        super(self.__class__, self).__init__(config, projects)

        self._userconfig = UserConfiguration(projects)

        # Basic pipeline steps
        custom_pipeline = [
            _CleaningStep(),
            _FactGenerationStep(),
            _DatabaseCreationStep(),
            _SanityCheckStep(projects.SCHEMA),
        ]

        # Add steps to custom pipeline based on config file
        for project in self._userconfig.projects:
            step = _LoadProjectStep(project)
            custom_pipeline.append(step)

        # Customize pipeline
        self._pipeline = custom_pipeline

    def compute_stats(self):
        builder = StatBuilder(self)

        # Create custom stats based on config file
        for (predicate, header) in self._userconfig.statistics:
            builder.count(predicate, header)

        self._stats = builder.build()
