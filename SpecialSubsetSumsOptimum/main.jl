#=
Approach:
We will prove that the rule works.

Notice that a singleton set {a} satisfies the properties trivially. If the set we
want to build is of size 2 then clearly the set {a, a + a} satisfies the conditions.
Notice that for the set {a, b}, where a < b, the rule generates the set {b, a + b, b + b}.
The possible picks for disjoint sets are:

B = {b, b + b}, C = {a + b}
B = {b, a + b}, C = {b + b}
B = {a + b, b + b}, C = {b}

All of which clearly satisfy the conditions. For the rest of the proof assume that
n >= 3.

Assume A = {a1, a2, ... , an} is the given special sum set for n. If a1 < a2 < ... < an,
let k = ceil((n + 1) / 2) and d = ak. Let D = {d, a1 + d, a2 + d, ... , an + d}. Then
d < a1 + d < a2 + d < ... < an + d. Pick disjoint subsets B and C of D \ {d}.
Notice that these sets are equivalent (plus the d constant) to some subsets of A
and therefore the special sum set properties must hold. Let B' and C' be the members
of B and C minus d, i.e. the equivalent sets to B and C in A. Notice that if |C| > |B|,
then by swapping the labels of both sets we have |B| > |C| and it must hold that
S(B) > S(C), and therefore swapping the labels back S(C) > S(B). Therefore assume,
without loss of generality that |B| >= |C|.

If |B| > |C|, then:

S(B') > S(C')
S(B') + |C| * d > S(C') + |C| * d
S(B') + |B| * d > S(B') + |C| * d > S(C') + |C| * d
S(B) > S(C)

Then clearly S(B U {d}) > S(C). If |B| - |C| > 1 then:

|B| - |C| > 1
|B| * d - |C| * d > d
|B| * d > |C| * d + d
S(B') + |B| * d > S(C') + |C| * d + d
S(B') + |B| * d > S(C') + |C| * d + d
S(B) > S(C U {d})

Now let |B| - |C| = 1. Then |B| = |C U {d}|. Now, for sake of contradiction, assume:

S(B) = S(C U {d})
S(B') + |B| * d = S(C') + (|C| + 1) * d
S(B') - S(C') + (|B| - |C| - 1) * d = 0
S(B') - S(C') = 0
S(B') = S(C')

which contradicts that A is a special sum set. Therefore S(B) != S(C U {d}) and
because |B| = |C U {d}| we don't need to prove property ii.

Now let |B| = |C|. Therefore S(B') != S(C') and S(B) != S(C). Assume without
loss of generality that S(B) > S(C). Then clearly S(B U {d}) > S(C). Now, for the
sake of contradiction assume that S(B) >= S(C U {d}), i.e.  S(B) - S(C) >= d and
S(B') - S(C') >= d. If d is in B' then S(B' \ {d}) - S(C') >= 0. But because A is
a special sum set then S(C') >= S(B' \ {d}), and therefore S(B' \ {d}) = S(C'),
a contradiction. If d is in neither B' nor C' notice that d > S(B') - S(C') so that
S(C' U {d}) may be larger than S(B'). Therefore d > S(B) - S(C). But if
S(B) >= S(C U {d}) = S(C) + d then S(B) - S(C) >= d, which is a contradiction.

Finally let d be in C'. Then S(B') - S(C') < min(A \ B' \ C'). Therefore
S(B) - S(C) < min(A \ B' \ C'). If d > min(A \ B' \ C') then S(B) - S(C) < d, but
S(B) >= S(C U {d}) = S(C) + d then S(B) - S(C) >= d, which is a contradiction.
Therefore either d <= min(A \ B' \ C') or min(A \ B' \ C') does not exist. Notice
that when |B| = |C| = 1 we get that for every elements ap, aq, ar of A, ap < aq + ar
and aq < ap + ar, therefore aq - ar < ap < aq + ar. Therefore min(A \ B' \ C') < d + ai,
for some i and therefore d <= min(A \ B' \ C') < d + ai or d < d + ai which is a
contradiction (this requires that n >= 3, which we already have).

For min(A \ B' \ C') not to exist it means that B' U C' = A. Because S(B') > S(C'),
if all the elements smaller than d belong to B', then the remaining elements belong
to C' and S(C') > S(B'), a contradiction. Therefore there is at least one element
in B' larger than d. Because n >= 3 then C' has another element besides d. Let that
element be aj. By the single element inequalities described in the previous paragraph,
ai < d + aj. Therefore, because A is a special sum set:

S(B' \ {ai}) < S(C' \ {d} \ {aj})
S(B') - ai < S(C') - d - aj

And adding ai < d + aj to the previous inequality we get:

S(B') < S(C')
S(B) < S(C)

which is false by hypothesis. Therefore our original hypothesis of S(B) >= S(C U {d})
is false and therefore S(B) < S(C U {d}), proving the rule.

Therefore D is a special sum set. Because the optimum special sum set of n = 6 is
{11, 18, 19, 20, 22, 25}, then D for n = 7 is:

{20, 11 + 20, 18 + 20, 19 + 20, 20 + 20, 22 + 20, 25 + 20}
{20, 31, 38, 39, 40, 42, 45}

with S(D) = 255.

With the previous in mind we only need to test the properties for all sets of size
n + 1 that add up to less than or equal to S(D) to find the optimum special sum set.
=#

using Printf

start = time()
result = 0

function test_recursive(test_set, idx, b, c)
    if idx > length(test_set)
        lb = length(b)
        lc = length(c)
        if lb == 0 || lc == 0
            return true
        end
        sb = sum(b)
        sc = sum(c)
        if lb == lc
            return sb != sc
        elseif lb > lc
            return sb > sc
        else # lb < lc
            return sb < sc
        end
    end

    if !test_recursive(test_set, idx + 1, b, c)
        return false
    end

    new_b = copy(b)
    push!(new_b, test_set[idx])
    if !test_recursive(test_set, idx + 1, new_b, c)
        return false
    end

    new_c = copy(c)
    push!(new_c, test_set[idx])
    if !test_recursive(test_set, idx + 1, b, new_c)
        return false
    end

    return true
end

function test(test_set)
    return test_recursive(test_set, 1, [], [])
end

function search(n, bound, min_set, test_set)
    if length(test_set) >= n
        if test(test_set)
            return test_set
        else
            return min_set
        end
    end

    lastidx = lastindex(test_set)

    # If the smallest element of the optimal sum set for n + 1
    # is smaller than what the previous optimum set tells us it must be,
    # then we could generate a special sum set of size n which has a lower
    # sum by subtracting the smallest element from all others and removing
    # the zero from the set. This is by definition impossible.
    lower =
        if lastidx == 0
            min_set[1]
        else
            test_set[lastidx] + 1
        end

    # Because ai < ai-1 + ai-2
    upper =
        if lastidx == 0
            min_set[1]
        elseif lastidx < 3
            bound
        else
            min(bound, test_set[lastidx] + test_set[lastidx - 1])
        end

    for elem in lower:upper
        new_test_set = copy(test_set)
        push!(new_test_set, elem)
        if sum(new_test_set) < sum(min_set)
            min_set = search(n, bound, min_set, new_test_set)
        end
    end

    return min_set
end


n = 7
min_set = [20, 31, 38, 39, 40, 42, 45]
# x + (x - 1) + (x - 2) + ... + (x - n + 1) <= sum(min_set)
bound = fld(2 * sum(min_set) + n * (n - 1), 2 * n)

result_set = search(n, bound, min_set, [])
println(result_set)

result = join(string.(result_set))
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
