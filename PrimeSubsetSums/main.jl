#=
Approach:
Use an array to keep track how many subsets add up to a given number. Iterate over each prime p and
add the same array to itself but shifted p positions. This is equivalent to taking all sets up to
a given iteration and duplicating them and adding the prime p to them. At the end add how many fell
in primes positions using a prime sieve.
=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    l = 5000 # 5000
    m = 10^16

    # Solution
    primes = [2]
    slots = [i % 2 == 1 for i in 1:l]
    slots[1] = false
    slots[2] = true
    for k in 3:2:l
        if slots[k]
            push!(primes, k)
            for t in (2 * k):k:l
                slots[t] = false
            end
        end
    end

    r = sum(primes)
    u = zeros(Int64, r + 1)
    u[0 + 1] = 1
    for p in primes
        for v in (r - p):-1:0
            u[v + p + 1] = mod(u[v + p + 1] + u[v + 1], m)
        end
    end

    primes = [2]
    slots = [i % 2 == 1 for i in 1:r]
    slots[1] = false
    slots[2] = true
    for k in 3:2:r
        if slots[k]
            push!(primes, k)
            for t in (2 * k):k:r
                slots[t] = false
            end
        end
    end

    for v in 0:r
        if v > 0 && slots[v]
            result = mod(result + u[v + 1], m)
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
