#!python
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
            value, cardinality = map(int, row)
            values.append((value, cardinality))

    # Skip potentially non-pointer objects
    pvalues = filter(lambda (val,n): val > 0, values)

    # Compute mean
    wsum, total = 0, 0
    for value, n in pvalues:
        wsum  += value * n
        total += n

    mean = wsum / float(total)

    # Compute median
    vals, cardinalities = zip(*values)
    bounds = []
    for (prev, cur, after) in zip(vals, vals[1:], vals[2:]):
        lower, upper = avg(prev, cur), avg(cur, after)
        bounds.append((lower, upper))

    rsum = 0
    threshold = float(total) / 2
    for (lower, upper), n in zip(bounds, cardinalities[1:]):
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
