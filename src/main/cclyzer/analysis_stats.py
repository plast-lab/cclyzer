import blox.connect
import collections

Statistic = collections.namedtuple("Statistic", ["header", "key", "value"])


class AnalysisStatistics(object):
    def __init__(self, builder):
        self._analysis = builder.analysis

        # Calculate column widths
        hdr_width = max(len(stat.header) for stat in builder.stats)
        val_width = len(str(max(stat.value for stat in builder.stats)))

        rows = []

        # Format statistics and store rows
        for stat in builder.stats:
            rows.append(
                '# {0.header:<{h_width}} : {0.value:>{v_width}d}'
                .format(stat, h_width=hdr_width, v_width=val_width)
            )

        self._rows = rows
        self._stats = dict((s.key, s.value) for s in builder.stats)

    def __getstate__(self):
        # Copy object's state
        state = self.__dict__.copy()
        # Remove unpicklable entries
        del state['_analysis']
        return state

    def __setstate__(self, state):
        self.__dict__.update(state)
        self._analysis = None

    def __repr__(self):
        return "{}({})".format(
            self.__class__.__name__,
            ', '.join('{}={!r}'.format(k, v) for k, v in self._stats.iteritems())
        )

    def __getitem__(self, key):
        return self._stats[key]

    def __str__(self):
        return unicode(self).encode('utf-8')

    def __unicode__(self):
        return u'\n'.join(self._rows)


class AnalysisStatisticsBuilder(object):
    def __init__(self, analysis):
        self._analysis = analysis
        self._connector = blox.connect.Connector(analysis.database_directory)
        self._counted_preds = []
        self._headers = {}

    @property
    def stats(self):
        return self._stats

    @property
    def analysis(self):
        return self._analysis

    def count(self, predicate, project=None, title=None):
        """Report size of predicate.

        Predicate can be prefixed with the project it belongs to, in
        the form "project|predicate", if no project argument is given.

        """
        # Loaded projects
        projects = self.analysis.loaded_projects
        project_names = [p.name for p in projects]
        project_names += [p.cname for p in projects]

        # Project can be part of predicate name, delimited by '|'
        if not project and '|' in predicate:
            project, predicate = predicate.split('|')

        # Ensure required project was loaded
        if project:
            # Check project by name
            if isinstance(project, basestring):
                if project not in project_names:
                    return self
            # Check project by identity
            elif project not in projects:
                return self

        # Make generic column header based on predicate name
        if title is None:
            title = predicate.replace(':', ' ').replace('_', ' ') + 's'

        self._headers[predicate] = title
        self._counted_preds.append(predicate)

        return self

    def build(self):
        """Create the analysis report.

        """
        # Run popCount command to workspace for the marked predicates
        counters = self._connector.popCount(*self._counted_preds)

        def make_stat(pred):
            hdr, val = self._headers[pred], counters[pred]
            return Statistic(header=hdr, key=pred, value=val)

        # Store statistics
        self._stats = [make_stat(p) for p in self._counted_preds]

        # Create statistics instance
        return AnalysisStatistics(self)
