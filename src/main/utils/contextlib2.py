"""This module provides some additional context-manager related
functionality.

"""

import functools
import os
import sys


# ---------------------------------------------------------------------------
# The following stuff has been copied from `contextdecorator'
# (see http://pypi.python.org/pypi/contextdecorator
#      http://contextlib2.readthedocs.org/en/latest/)
#
# The `contextdecorator' module is a backport of new features added to
# the `contextlib' module in Python 3.2. `contextdecorator' works with
# Python 2.4+ including Python 3.
#
# TODO Remove and add as dependency when setup.py becomes part of the
# build process.
# ---------------------------------------------------------------------------


class ContextDecorator(object):
    """A base class or mixin that enables context managers to work as
    decorators.

    """

    def __call__(self, f):
        @functools.wraps(f)
        def wrapped(*args, **kwargs):
            with self:
                return f(*args, **kwargs)
        return wrapped


class GeneratorContextManager(ContextDecorator):
    """Helper for @contextmanager decorator."""

    def __init__(self, gen):
        self.gen = gen

    def __enter__(self):
        try:
            return next(self.gen)
        except StopIteration:
            raise RuntimeError("generator didn't yield")

    def __exit__(self, type, value, traceback):
        if type is None:
            try:
                next(self.gen)
            except StopIteration:
                return
            else:
                raise RuntimeError("generator didn't stop")
        else:
            if value is None:
                # Need to force instantiation so we can reliably
                # tell if we get the same exception back
                value = type()
            try:
                self.gen.throw(type, value, traceback)
                raise RuntimeError("generator didn't stop after throw()")
            except StopIteration:
                # Suppress the exception *unless* it's the same exception that
                # was passed to throw().  This prevents a StopIteration
                # raised inside the "with" statement from being suppressed
                exc = sys.exc_info()[1]
                return exc is not value
            except:
                # only re-raise if it's *not* the exception that was
                # passed to throw(), because __exit__() must not raise
                # an exception unless __exit__() itself failed.  But throw()
                # has to raise the exception to signal propagation, so this
                # fixes the impedance mismatch between the throw() protocol
                # and the __exit__() protocol.
                if sys.exc_info()[1] is not value:
                    raise


def contextmanager(func):
    @functools.wraps(func)
    def helper(*args, **kwargs):
        return GeneratorContextManager(func(*args, **kwargs))
    return helper


# ---------------------------------------------------------------------------
# Additional custom context managers.
#
# Most of this stuff can also be found in external modules.
# ---------------------------------------------------------------------------


class cd:
    """Context manager for changing the current working directory."""
    def __init__(self, path):
        self.path = path

    def __enter__(self):
        self.old_path = os.getcwd()
        os.chdir(self.path)

    def __exit__(self, type, value, traceback):
        os.chdir(self.old_path)


@contextmanager
def stdout_redirected(to=os.devnull):
    # Keep stdout at this point in case it is redirected (e.g., via nose)
    old_stdout, sys.stdout = sys.stdout, sys.__stdout__
    stdout_fd = sys.stdout.fileno()

    # Store old stdout
    with os.fdopen(os.dup(stdout_fd), 'wb') as dupped_stdout:
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
            os.dup2(dupped_stdout.fileno(), stdout_fd)
            sys.stdout = old_stdout
