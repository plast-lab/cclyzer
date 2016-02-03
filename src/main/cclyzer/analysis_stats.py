import blox.connect
import collections

Statistic = collections.namedtuple("Statistic", ["header", "value"])


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

    def __str__(self):
        return '\n'.join(self._rows)


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

    def count(self, predicate, columnHeader=None):
        # Make generic column header based on predicate name
        if columnHeader is None:
            columnHeader = predicate.replace(':', ' ').replace('_', ' ') + 's'

        self._headers[predicate] = columnHeader
        self._counted_preds.append(predicate)

        return self

    def build(self):
        # Run popCount command to workspace for the marked predicates
        counters = self._connector.popCount(*self._counted_preds)

        def make_stat(pred):
            hdr, val = self._headers[pred], counters[pred]
            return Statistic(header=hdr, value=val)

        # Store statistics
        self._stats = [make_stat(p) for p in self._counted_preds]

        # Create statistics instance
        return AnalysisStatistics(self)
