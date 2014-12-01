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

    def queryCount(self, queryString, printOpt = ''):
        return len(list(self.query(queryString, printOpt)))

    def query(self, queryString, printOpt = ''):
        """Run a query on this connector.

        This is equivalent to invoking the following command from the
        shell::

            bloxbatch -db `workspace` -query `queryString`


        Args:
          queryString (str): the query to run
          printOpt (str, optional): equivalent to bloxbatch query -print option (default '')

        Yields:
          str: The next (trimmed) line of the query output

        Raises:
          subprocess.CalledProcessError: If the query subprocess returns non-zero.


        """
        command_line = "bloxbatch -db %s -query '%s' " % (self._workspace, queryString)

        # Check if a print option was specified
        if printOpt:
            command_line += "print %s" % (printOpt,)

        # Run the command with separate pipes for stdout/stderr streams
        p = subprocess.Popen(
            command_line, shell = True,
            stdout = subprocess.PIPE,
            stderr = subprocess.PIPE
        )

        # Parse output and lazily return each line
        for line in p.stdout.readlines():
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
