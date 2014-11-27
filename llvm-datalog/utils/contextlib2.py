import contextlib
import os
import sys

class cd:
    """Context manager for changing the current working directory."""
    def __init__(self, path):
        self.path = path

    def __enter__(self):
        self.old_path = os.getcwd()
        os.chdir(self.path)

    def __exit__(self, type, value, traceback):
        os.chdir(self.old_path)


@contextlib.contextmanager
def stdout_redirected(to = os.devnull):
    stdout_fd = sys.stdout.fileno()
    # Store old stdout
    with os.fdopen(os.dup(stdout_fd), 'wb') as old_stdout:
        sys.stdout.flush()
        # Temporarily redirect stdout to /dev/null (or some file)
        with open(to, 'wb') as to_file:
            os.dup2(to_file.fileno(), stdout_fd)
        # Execute statements with redirected stdout
        try:
            yield sys.stdout
        finally:
            # restore stdout to its previous value
            sys.stdout.flush()
            os.dup2(old_stdout.fileno(), stdout_fd)
