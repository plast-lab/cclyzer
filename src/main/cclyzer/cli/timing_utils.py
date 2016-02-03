from utils import contextlib2
from utils.timer import Timer


@contextlib2.contextmanager
def task_timing(description):
    """This is a context manager that prints the elapsed time of some
    computation. It can also be used as a decorator.

    """
    # Define closure that prints elapsed time
    def print_time(elapsed_time):
        print "    %-32s ... %6.2fs" % (description, elapsed_time)

    # Execute task with timer
    with Timer(print_time):
        yield
