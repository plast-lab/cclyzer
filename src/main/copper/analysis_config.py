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

    @classmethod
    def from_cli_options(cls, options):
        return cls(options.input_files, options.output_dir)
