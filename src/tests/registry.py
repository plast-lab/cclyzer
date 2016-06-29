from cclyzer import Analysis, AnalysisConfig
import cclyzer.runtime as rt
from computil import compile_bitcode
import os
from utils.contextlib2 import stdout_redirected

class AnalysisRegistry(object):
    # Cached analysis dictionary from resource filenames
    _CACHED_ANALYSES = {}

    # C/C++ sources directory
    SOURCES_DIR = os.path.join(os.path.dirname(__file__), 'resources')

    @classmethod
    def _analyze(cls, filename):
        # Get paths to source and bitcode file
        srcfile = os.path.join(cls.SOURCES_DIR, filename)
        bcfile = rt.FileManager().mktemp(suffix='.bc')

        # Compile bitcode
        compile_bitcode(srcfile, bcfile)

        # Create temporary directory for analysis
        tmpdir = rt.FileManager().mkdtemp()

        try:
            # Run analysis
            config = AnalysisConfig(bcfile, output_dir=tmpdir)
            analysis = Analysis(config)

            with stdout_redirected():
                analysis.enable_exports()
                analysis.run()
        finally:
            os.remove(bcfile)

        return analysis

    def __getitem__(self, key):
        # Check for cached analysis
        if key not in self._CACHED_ANALYSES:
            self._CACHED_ANALYSES[key] = self._analyze(key)

        return self._CACHED_ANALYSES[key]
