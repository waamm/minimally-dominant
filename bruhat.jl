#= Most of the code in this file is based on code by Professor Jean Michel (reused here with his
permission). See the following paper for his context, which includes an explanation for some of the
functions below and contains similar code for the C version of GAP3:

Jean Michel. The development version of the CHEVIE package of GAP3. J. Algebra, 435:308–336, 2015.
=#

#=
The aim of the code below is to test the main conjecture of the author's paper on minimally
dominant elements (see arXiv:2110.09266).

The input is as follows:
. A Weyl group W
. A list L of pairs of reduced words (in GAP notation) representing two elements in a conjugacy
    class of W, one is of minimal length and the other one is minimally dominant.
. A prime number p

Such a list L can be computed with the other file in this repository.
Running the function test_main_conjecture(W, L, p) below then verifies whether the corresponding
Bruhat cells intersect the same conjugacy classes in the associated (simply connected) reductive
group, over an algebraically closed field of characteristic p.

Input example:
> W = coxgroup(:B,3)
> L = [([1, 2, 1, 2], [2, 1, 3, 2, 1, 3, 2, 3]),
        ([1, 3], [1, 2, 1, 3, 2, 1, 3, 2]),
        ([2, 1], [3, 2, 1, 2]),
        ([3, 2], [1, 3, 2, 1, 3, 2]),
        ([3], [2, 1, 3, 2, 1, 3, 2]),
        ([1], [3, 2, 1, 2, 3])]
> p = 7
> test_main_conjecture(W, L, p)
=#


using Gapjm     # https://github.com/jmichel7/Gapjm.jl
using LinearAlgebra


function f_per_wrd(W, wrd, q)
    permutedims(
        toM(
            DLLefschetz(Tbasis(hecke(W, q))(W(wrd...))).v[
                UnipotentCharacters(W).harishChandra[1][:charNumbers]]))
end


function g(W, q, p)
    uc = UnipotentClasses(W, p)
    t = ICCTable(uc, 1; q)
    triv = map(1:length(uc)) do i
        findfirst(==([i, charinfo(uc.classes[i].Au)[:positionId]]),
            uc.springerseries[1][:locsys])
    end
    permutedims(t.L[triv, triv] * t.scalar[triv, :] * diagm(q .^ t.dimBu))
end


function vdash_per_wrd(W, wrd, p)
    q = Pol()^2
    m = f_per_wrd(W, wrd, q) * g(W, q, p)
    map(j -> axes(m, 2)[(!iszero).(m[j, :])], axes(m, 1))
end


function test_main_conjecture(W, L, p)
    indices_of_conjugacy_classes = []
    count_cc = 0
    for pair in L
        count_cc += 1
        indices_of_conjugacy_classes = []
        for wrd in pair
            append!(indices_of_conjugacy_classes, vdash_per_wrd(W, wrd, p))
        end
        if length(Set(indices_of_conjugacy_classes)) != 1
            print("Counterexample at conjugacy class ", count_cc, " in L\n")
        end
    end
end