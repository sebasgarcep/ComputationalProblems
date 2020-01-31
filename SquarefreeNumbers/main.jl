#=
Approach:
Let Q(x) be the amount of squarefree numbers less than or equal to x. Then by the inclusion-exclusion
principle:

Q(x) = x - sum(pi prime) floor(x / pi^2)
    + sum(pi < pj; pi, pj prime) floor(x / (pi * pj)^2)
    - sum(pi < pj < pk; pi, pj, pk prime) floor(x / (pi * pj * pk)^2)
    + ...

Therefore:

Q(x) = sum(1 <= d^2 <= x) C(d) * floor(x / d^2)

where C(d) is clearly 0 if d is a multiple of the square of a prime. If d has an odd number of prime
factors, then C(d) = -1, otherwise C(d) = 1. Therefore C(d) = mu(d), where mu is the Mobius function.
Thus:

Q(x) = sum(1 <= d^2 <= x) mu(d) * floor(x / d^2)

Source:
https://en.wikipedia.org/wiki/Square-free_integer

Notes:
Finally I understand what Moebius function really means.  It is the sign in the inclusion-exclusion principle

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    x = 2^50 - 1

    # Solution
    k = isqrt(x)

    # Calculate mu
    slots = [n & 1 == 1 for n in 1:k]
    slots[1] = false
    mu = [n & 1 == 1 ? 1 : -1 for n in 1:k]
    if k >= 2
        slots[2] = true
        mu[2] = -1
        for t in 4:4:k
            mu[t] = 0
        end
    end
    for p in 3:2:k
        if slots[p]
            mu[p] = -1
            for t in (2 * p):p:k
                slots[t] = false
                mu[t] *= -1
            end
            for t in p^2:p^2:k
                mu[t] = 0
            end
        end
    end

    # Calculate Q(x)
    for n in 1:k
        result += mu[n] * fld(x, n^2)
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
