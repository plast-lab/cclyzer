from .project import ProjectManager

class AnalysisConfig(object):
    def __init__(self, *inputfiles, **kwargs):
        self._projects = ProjectManager()
        self._input_files = list(inputfiles)
        self._output_dir = kwargs.pop('output_dir')
        self._points_to = 'points_to'
        self._options = kwargs

    @property
    def input_files(self):
        return self._input_files

    @property
    def output_directory(self):
        return self._output_dir

    @property
    def points_to(self):
        return getattr(self._projects, self._points_to)

    @classmethod
    def from_cli_options(cls, clioptions):
        # Get basic options
        options = vars(clioptions)
        inputfiles = options.pop('input_files')
        runpearce = options.pop('pearce', False)

        # Create configuration
        config = cls(*inputfiles, **options)

        # Run Pearce points-to analysis
        if runpearce:
            config._points_to = 'pearce_paste04'

        return config
