from functools import wraps
from timeit import default_timer

class Timer(object):
    def __init__(self, callback):
        """A timing context manager."""
        self.callback = callback

    def __enter__(self):
        self.start = default_timer()
        return self

    def __exit__(self, type, value, traceback):
        self.end = default_timer()
        self.callback(self.end - self.start)

    def elapsed_time(self):
        return default_timer() - self.start
