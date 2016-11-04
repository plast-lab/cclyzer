from utils import contextlib2
from utils.timer import Timer


@contextlib2.contextmanager
def task_timing(description, length=32):
    """This is a context manager that prints the elapsed time of some
    computation. It can also be used as a decorator.

    """
    # Define closure that prints elapsed time
    def print_time(elapsed_time):
        print "    {0:<{len}} ... {1:6.2f}s".format(description, elapsed_time, len=length)

    # Execute task with timer
    with Timer(print_time):
        yield
