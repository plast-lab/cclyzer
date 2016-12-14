import contextlib
import logging
import sys
from logging import StreamHandler
from logging.handlers import RotatingFileHandler, SysLogHandler
from .. import runtime
from .. import settings


class CachelessFormatter(logging.Formatter):
    def format(self, record):
        # Disable the caching of the exception text.
        backup = record.exc_text
        try:
            record.exc_text = None
            return logging.Formatter.format(self, record)
        finally:
            record.exc_test = backup


class ConsoleFormatter(CachelessFormatter):
    def format(self, record):
        msg = CachelessFormatter.format(self, record)
        return msg

    def formatException(self, exc_info):
        if not exc_info:
            return ''
        type, value, traceback = exc_info
        return str(value)


@contextlib.contextmanager
def setup_logging(lvl=logging.INFO):
    """Configure logging.

    This creates a file handler to the application cache and a syslog
    handler. It also sets up log formatting and level.

    """

    # Get runtime environment and settings
    env = runtime.Environment()
    app_name = settings.APP_NAME

    # Get root logger and set its logging level
    root_logger = logging.getLogger()
    root_logger.setLevel(lvl)

    # Add rotating file handler
    file_log = env.user_log_file
    file_formatter = logging.Formatter("[PID %(process)d - %(asctime)s %(levelname)5.5s] "
                                       "%(pathname)s: Line %(lineno)d: %(message)s")
    file_handler = RotatingFileHandler(file_log, maxBytes=(2 ** 20), backupCount=7)
    file_handler.setFormatter(file_formatter)
    root_logger.addHandler(file_handler)

    # Add system log handler
    try:
        syslog_formatter = logging.Formatter("[{}] %(message)s".format(app_name))
        syslog_handler = SysLogHandler(address='/dev/log')
        syslog_handler.setFormatter(syslog_formatter)
        root_logger.addHandler(syslog_handler)
    except:
        root_logger.warning('Cannot add system logger')

    # Add stderr handler
    stderr_formatter = ConsoleFormatter("%(levelname)s (%(name)s): %(message)s")
    stderr_handler = StreamHandler(stream=sys.stderr)
    stderr_handler.setFormatter(stderr_formatter)
    stderr_handler.setLevel(logging.WARNING)
    root_logger.addHandler(stderr_handler)

    # Start executing task
    yield root_logger
