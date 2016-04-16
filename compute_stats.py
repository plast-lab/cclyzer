#!/usr/bin/python
import csv
import sys

def avg(x, y):
    return (x + y) / 2.0

def compute_stats(path):
    values = []

    # Read CSV file with allocations per points-to set size
    with open(path) as csvfile:
        csvreader = csv.reader(csvfile, delimiter='\t')
        for row in csvreader:
            nallocs, nptrs = map(int, row)
            values.append((nallocs, nptrs))

    # Skip potentially non-pointer objects
    pvalues = filter(lambda (na,np): na > 0, values)

    # Compute mean
    rsum, totalptrs = 0, 0
    for nallocs, nptrs in pvalues:
        rsum += nallocs * nptrs
        totalptrs += nptrs

    mean = rsum / float(totalptrs)

    # Compute median
    vals, arities = zip(*values)
    intervals = [
        (avg(prev, cur), avg(cur, after)) for (prev, cur, after)
        in zip(vals, vals[1:], vals[2:])
    ]

    rsum = 0
    threshold = float(totalptrs) / 2
    for (lower, upper), n in zip(intervals, arities[1:]):
        if rsum + n >= threshold:
            interval = upper - lower
            below = threshold - rsum
            median = upper - (below / n) * interval
            break
        rsum += n

    print 'Mean    : {0:.3f}'.format(round(mean, 3))
    print 'Median  : {0:.3f}'.format(round(median, 3))

if __name__ == '__main__':
    compute_stats(sys.argv[1])
