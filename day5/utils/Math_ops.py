import statistics

def mean(data):
    """Calculate the arithmetic mean of a list of numbers."""
    return statistics.mean(data)

def median(data):
    """Calculate the median of a list of numbers."""
    return statistics.median(data)

def standard_deviation(data):
    """Calculate the standard deviation of a list of numbers."""
    return statistics.stdev(data) if len(data) > 1 else 0.0
