#=
Approach:
Suppose there are k red blocks of size at least m. Then they take at least m * k
blocks of space, and the k - 1 separators take at least one block each. In total
they must therefore take (m + 1) * k - 1 blocks of space out of the total n.
Because (m + 1) * k - 1 <= n, then 0 <= k <= floor((n + 1) / (m + 1)). Assume also
that the two ends may also take space. Then let r = n - (m + 1) * k + 1 and
s = 2 * k + 1. The problem now reduces to assigning the remaining r blocks into
the s possible bins (the blocks, the separators and the ends). This is equivalent
to counting the number of solutions to:

x1 + x2 + ... + xs = r

which has (r + s - 1 choose r) solutions.
=#

using Printf

function f(m, n)
    total = 0
    for k in 0:div(n + 1, m + 1)
        r = n - (m + 1) * k + 1
        s = 2 * k + 1
        total += binomial(r + s - 1, r)
    end
    return total
end

start = time()

result = f(3, 50)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)


