using Printf
using Combinatorics

function is_prime(bound, slots, primes, n)
    if n > bound^2
        throw(DomainError("Invalid bounds"))
    end

    if n <= bound
        return slots[n]
    end

    for p in primes
        if p^2 > n
            break
        end
        if mod(n, p) == 0
            return false
        end
    end

    return true
end

function test(bound, slots, primes, perm, f)
    prev = nothing
    a = 0
    for i in 1:9
        a = 10 * a + perm[i]
        g = 1 << (i - 1)
        if i == 9 || (f & g) == g
            if prev != nothing && prev >= a
                return false
            end
            if !is_prime(bound, slots, primes, a)
                return false
            end
            prev = a
            a = 0
        end
    end
    return true
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters
    bound = 10^6

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            push!(primes, p)
            for k in (p^2):p:bound
                slots[k] = false
            end
        end
    end

    for perm in Combinatorics.permutations([i for i in 1:9])
        for f in 0:((1 << 8) - 1)
            if test(bound, slots, primes, perm, f)
                result += 1
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
