# minimally-dominant
Computes minimally dominant elements and the intersections of their Bruhat cells
with conjugacy classes

--

This repository contains two files:

## minimally-dominant.spyx

Computes dominant and minimally dominant elements in a Weyl group W. In
particular, it provides a function which computes for each (nontrivial and
nonelliptic) conjugacy class in such a group a pair of elements - one of minimal
length and one which is minimally dominant. These are returned as words
following GAP notation.

Written for [SageMath] version 8.9 and tested with 9.4, using Python 3.9.5.

## bruhat.jl

It can use such pairs of elements to test whether the corresponding Bruhat cells
intersect the same conjugacy classes in the associated simply connected
reductive group.

Written for (Jean Michel's Julia port of) [Gapjm]. Tested with commit
[5728d89][gapcommit], using Julia 1.7.0-rc1.

--

More details and sample inputs are provided in both files.

[SageMath]: https://www.sagemath.org
[Gapjm]: https://jmichel7.github.io/Gapjm.jl
[gapcommit]: https://github.com/jmichel7/Gapjm.jl/commit/5728d89532ab4e23fb2cf2b5759587d8d4185b5d