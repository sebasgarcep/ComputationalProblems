#=
Approach:
If n rounds are played, the player must win in at least floor(n/2) + 1 rounds. The
odds of taking the blue disc in round k, where 1 <= k <= n, is 1 / (k + 1). This
problem can be modelled by the following generating polynomial:

(1 / 2 + x / 2) * (2 / 3 + x / 3) * ... * (k / (k + 1) + x / (k + 1)) * ... * (n / (n + 1) + x / (n + 1))
= prod(k = 1, n) (k / (k + 1) + x / (k + 1))
= prod(k = 1, n) (k + x) / prod(k = 1, n) (k + 1)

Let's consider only the numerator. After expanding the polynomial we are interested
in the sum of the coefficients where the power of x is larger than or equal to
floor(n/2) + 1 rounds.

Suppose the result of the previous procedure produces a probability p. Then the
maximum prize fund is the largest integer w such that p * w <= 1. Therefore,
w <= 1 / p and therefore w = floor(1 / p).
=#

using Printf

function search(p, n, k, s, c)
    if k > n
        if s >= fld(n, 2) + 1
            p += c
        end
        return p
    end

    # Pick constant
    p = search(p, n, k + 1, s, c * k)

    # Pick x
    p = search(p, n, k + 1, s + 1, c)

    return p
end

start = time()
result = 0

p = 0
n = 15
k = 1
s = 0
c = 1
p = search(p, n, k, s, c)
q = prod(2:(n + 1))

result = fld(q, p)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
