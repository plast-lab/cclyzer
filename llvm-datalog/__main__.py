import argparse
import contextlib
import copper
import logging
import os
from logging.handlers import RotatingFileHandler, SysLogHandler
from utils.timer import Timer
from utils.redirect import stdout_redirected


def main():
    with setup_logging():
        # Create CLI parser
        parser = argparse.ArgumentParser(description='Analyze LLVM bitcode.')
        parser.add_argument('-i', '--input-dir', metavar='DIRECTORY', required = True,
                            help='directory containing LLVM bitcode files to be analyzed')
        parser.add_argument('-o', '--output-dir', metavar='DIRECTORY', required = True,
                            help='output directory')

        # Initialize analysis
        args = parser.parse_args()       # parse arguments
        analysis = copper.Analysis(args) # create analysis

        # Generating CSV facts
        with task_timing('generating facts'):
            analysis.generate_facts()

        # Create database and import facts
        with task_timing('importing facts to database'):
            analysis.create_database()

        # Load additional projects
        with task_timing('installed symbol-lookup project'):
            analysis.load_project(copper.Project.SYMBOL_LOOKUP)
        with task_timing('installed callgraph project'):
            analysis.load_project(copper.Project.CALLGRAPH)


@contextlib.contextmanager
def task_timing(description, to = os.devnull):
    # Define closure that prints elapsed time
    def print_time(elapsed_time):
        print "    %-32s ... %2.2fs" % (description, elapsed_time)

    # Execute task with timer and stdout redirected to /dev/null
    with Timer(print_time):
        with stdout_redirected():
            yield


@contextlib.contextmanager
def setup_logging(lvl = logging.INFO):
    """Configure logging.

    This creates a file handler to the application cache and a syslog
    handler. It also sets up log formatting and level.

    """

    # Get runtime environment and settings
    env = copper.runtime.Environment()
    settings = copper.settings

    # Get root logger and set its logging level
    root_logger = logging.getLogger()
    root_logger.setLevel(lvl)

    # Add rotating file handler
    file_log = os.path.join(env.user_cache_dir, "%s.log" % settings.APP_NAME)
    file_formatter = logging.Formatter("%(asctime)s %(levelname)5.5s - [%(name)s] %(message)s")
    file_handler = RotatingFileHandler(file_log, maxBytes = (2 ** 20), backupCount = 7)
    file_handler.setFormatter(file_formatter)
    root_logger.addHandler(file_handler)

    # Add system log handler
    syslog_formatter = logging.Formatter("[{}] %(message)s".format(settings.APP_NAME))
    syslog_handler = SysLogHandler(address='/dev/log')
    syslog_handler.setFormatter(syslog_formatter)
    root_logger.addHandler(syslog_handler)

    # Start executing task
    try:
        root_logger.info('Started')
        yield
    finally:
        root_logger.info('Finished')


if __name__ == '__main__':
    main()
