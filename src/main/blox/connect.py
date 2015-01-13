"""This module provides a Connector class to a LogicBlox workspace.

This class defines a number of methods that closely resemble the
existing bloxbatch commands.

"""

import collections
import subprocess
import sys


_IGNORED_WARNINGS = ('''
*******************************************************************
Warning: BloxBatch is deprecated and will not be supported in LogicBlox 4.0.
Please use 'lb' instead of 'bloxbatch'.
*******************************************************************
''',)


class Connector(object):
    def __init__(self, workspace):
        """A connector to a LogicBlox workspace."""
        self._workspace = workspace

    def _run_command(self, command_line):
        # Run the command with separate pipes for stdout/stderr streams
        p = subprocess.Popen(
            command_line, shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        # Parse output and lazily return each line
        for line in p.stdout:
            yield line.strip()

        # Wait for the process to exit and store the return code
        returncode = p.wait()

        # Create an error string that contains everything in the stderr stream
        errors = ''.join(p.stderr.readlines())

        # Prune some redundant warnings
        for warning in (w.lstrip() for w in _IGNORED_WARNINGS):
            errors = errors.replace(warning, '')

        # Print the remaining warnings
        if errors.strip() is not '':
            print >> sys.stderr, errors

        # Check return code and raise exception at failure indication
        if returncode != 0:
            raise subprocess.CalledProcessError(returncode, command_line)

    def queryCount(self, queryString, printOpt=''):
        return len(list(self.query(queryString, printOpt)))

    def popCount(self, *args):
        """Get the number of populated facts in the listed predicates.

        This is equivalent to invoking the following command from the
        shell::

            bloxbatch -db `workspace` -popCount `args[0],args[1],...`


        Args:
          *args (str): the predicates to be counted

        Returns:
          dict(str,int): A dictionary that maps the predicate names to
            their counters.

        Raises:
          subprocess.CalledProcessError: If the popCount subprocess
          returns non-zero.

        """

        if not args:
            raise ValueError("Empty argument list of predicate names")

        # Construct command line
        command_line = "bloxbatch -db %s -popCount %s " % (self._workspace, ','.join(args))

        # Create empty dictionary to hold counters
        counters = collections.OrderedDict()

        # Parse results and add counters to dictionary
        for (pred, num) in (
                line.rsplit(':', 1) for
                line in self._run_command(command_line)
        ):
            counters[pred] = int(num)

        return counters

    def query(self, queryString, printOpt=''):
        """Run a query on this connector.

        This is equivalent to invoking the following command from the
        shell::

            bloxbatch -db `workspace` -query `queryString`


        Args:
          queryString (str): the query to run
          printOpt (str, optional): equivalent to bloxbatch query
             ``-print`` option (default '')

        Yields:
          str: The next (trimmed) line of the query output

        Raises:
          subprocess.CalledProcessError: If the query subprocess
          returns non-zero.

        """
        command_line = "bloxbatch -db %s -query '%s' " % (self._workspace, queryString)

        # Check if a print option was specified
        if printOpt:
            command_line += "print %s" % (printOpt,)

        return self._run_command(command_line)

    def execute_block(self, blockName):
        command_line = "bloxbatch -db %s -execute -name '%s' " % (self._workspace, blockName)
        return self._run_command(command_line)
