from .project import ProjectManager

class AnalysisConfig(object):
    def __init__(self, input_files, output_dir):
        self._input_files = input_files
        self._output_dir = output_dir

    @property
    def input_files(self):
        return self._input_files

    @property
    def output_directory(self):
        return self._output_dir

    @property
    def points_to(self, projects=ProjectManager()):
        if not hasattr(self, '_points_to'):
            self._points_to = projects.POINTS_TO
        return self._points_to

    @classmethod
    def from_cli_options(cls, options, projects=ProjectManager()):
        config = cls(options.input_files, options.output_dir)

        # Run Pearce points-to analysis
        if options.pearce:
            config._points_to = projects.PEARCE_PASTE04

        return config
