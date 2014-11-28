class AnalysisConfig(object):
    def __init__(self, options):
        self._input_dir = options.input_dir
        self._output_dir = options.output_dir

    @property
    def input_directory(self):
        return self._input_dir

    @property
    def output_directory(self):
        return self._output_dir
