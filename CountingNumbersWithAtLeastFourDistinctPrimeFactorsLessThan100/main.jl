using Printf
using Memoize

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^16
    m = 100
    k_max = 4

    # Algorithm parameters
    bound = m
    phi_cache_size = 10^5

    # Solution
    prime_list = []
    prime_count_memo = [0 for _ in 1:bound]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        prime_count_memo[p] = prime_count_memo[p - 1]
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            push!(prime_list, p)
            prime_count_memo[p] += 1
        end
    end

    b = prime_count_memo[m]
    phi_cache = [[-1 for _ in 1:phi_cache_size] for _ in 1:b]
    function phi(x, a)
        if x <= 0
            return 0
        end
        if a == 0
            return x
        end
        if x <= prime_list[a]
            return 1
        end
        if x <= phi_cache_size && phi_cache[a][x] != -1
            return phi_cache[a][x]
        end
        value = x - (x >> 1)
        for i in 2:a
            value -= phi(fld(x, prime_list[i]), i - 1)
        end
        if x <= phi_cache_size
            phi_cache[a][x] = value
        end
        return value
    end

    for a in 1:b
        for x in 1:phi_cache_size
            phi(x, a)
        end
    end

    function c_k(k, x, a)
        if k == 0
            return phi(x, a)
        end

        if a >= b
            return 0
        end

        value = c_k(k, x, a + 1)

        acc = fld(x, prime_list[a + 1])
        while acc > 0
            value += c_k(k - 1, acc, a + 1)
            acc = fld(acc, prime_list[a + 1])
        end

        return value
    end

    result = c_k(k_max, n, 0)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
