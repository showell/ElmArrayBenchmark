This is a quick exploration of two different algorithms
to convert a list of floats into an isomorphic list
of integers that represent the ordering of the original
list.

Benchmark seems painfully slow for me.  It produces
these results for N=500:

    two sorts: 1719/s
    array: 1301/s

So the sort implementation is slightly faster for n=500.

But I really wanna test bigger N.

Even though Benchmark claims both of these functions
run in less than a millisecond, it takes a couple
minutes to run the benchmark.  So it's being super
thorough, I guess.  It also freezes up the browser
for a while.

Maybe I will try just benchmarking them with time
diffs.
