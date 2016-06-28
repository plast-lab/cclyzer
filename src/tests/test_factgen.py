from cclyzer import runtime as rt
from difflib import unified_diff
import factgen
import os
import zipfile

class TestFactGen(object):
    # Belongs to the `factgen` subset of tests
    factgen = True

    # Input files
    INPUT = 'tests/coreutils-8.24/sort.bc'

    # Older bundled facts archive for given input files
    ARCHIVE = 'facts.zip'

    # Test resources directory
    RESOURCES_DIR = os.path.join(os.path.dirname(__file__), 'resources')

    @classmethod
    def facts_bundle(cls):
        return os.path.join(cls.RESOURCES_DIR, cls.ARCHIVE)

    def __init__(self):
        self.input_files = [self.INPUT]
        self.files = rt.FileManager()

    def setup(self):
        self.outdir = self.files.mkdtemp()
        factgen.run(self.input_files, self.outdir)

    def teardown(self):
        pass

    def extract_facts(self, fileobj):
        # Remove duplicate facts
        return set(line.strip() for line in fileobj)

    def _gendiff(self, oldfacts, newfacts, filename):
        def serialize(facts):
            return list(sorted(facts))

        oldfacts, newfacts = serialize(oldfacts), serialize(newfacts)
        oldname, newname = '<old> ' + filename, '<new> ' + filename

        # Create diff
        return unified_diff(oldfacts, newfacts,
                            fromfile=oldname, tofile=newname, lineterm='')

    def test_allfacts(self):
        # Open facts archive resource
        facts_archive = self.facts_bundle()
        errors = []

        # Read every file in archive
        with zipfile.ZipFile(facts_archive) as zipf:
            for name in zipf.namelist():
                # Path to newest version of facts for given predicate
                path = os.path.join(self.outdir, name)

                # Check pred file existence
                assert os.path.exists(path)

                # Get old and new contents
                old_contents = self.extract_facts(zipf.open(name))
                new_contents = self.extract_facts(open(path))

                # Check if old and new contents differ, and create new diff
                if old_contents != new_contents:
                    diff = self._gendiff(old_contents, new_contents, name)
                    errors.append('\n'.join(diff))

        # Check for any encountered errors
        if errors:
            # Create extended error report that includes diffs for changed files
            reportlines = ['Generated facts have changed!!']
            reportlines.extend(errors)

            raise AssertionError('\n'.join(reportlines))
