class AnalysisConfig(object):
    def __init__(self, input_dir, output_dir):
        self._input_dir = input_dir
        self._output_dir = output_dir

    @property
    def input_directory(self):
        return self._input_dir

    @property
    def output_directory(self):
        return self._output_dir

    @classmethod
    def from_cli_options(cls, options):
        return cls(options.input_dir, options.output_dir)
