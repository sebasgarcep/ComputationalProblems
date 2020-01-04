#=
Approach:
Use a sieve to find the divisors of every number and then use the multicativity of the divisor
function over the primes and the fact that d(p^n) = (1 + n), to calculate d(n) for all necessary
n. Then use the following fact:

If M(n, k) = d(i), and i belongs to [n + 1, n + k], then M(n + 1, k) = max(d(i), d(n + k)). Thus
we only have to update the maximum value of each window by comparing it to the incoming value on
the rightmost end. If i does not belong to the next window, then we have to recalculate the maximum
over the window, but hopefully this doesn't happen too often.
=#

using Printf

function factor_multiplicity(n, k)
    r = 0
    nr = n
    while mod(nr, k) == 0
        r += 1
        nr = fld(nr, k)
    end
    return r
end

function main()
    start = time()
    result = 0

    # Define problem parameters
    u = 10^8
    k = 10^5

    # Calculate all the values of d using a sieve
    d = [1 + factor_multiplicity(i, 2) for i in 1:u]
    slots = [true for i in 1:u]
    slots[1] = false
    slots[2] = false
    for r in 3:2:u
        if slots[r]
            d[r] = 2
            for t in (2 * r):r:u
                d[t] *= 1 + factor_multiplicity(t, r)
                slots[t] = false
            end
        end
    end

    # Use the window algorithm
    m = 0
    p = 0
    for i in 1:(u - k + 1)
        if p < i
            m = 0
            p = 0
        end
        if m == 0
            a = i
            b = i + k - 1
        else
            a = i + k - 1
            b = i + k - 1
        end
        for j in a:b
            if d[j] > m
                m = d[j]
                p = j
            end
        end
        result += m
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
