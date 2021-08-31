using Printf

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
    n = 201820182018
    mod_size = 10^9

    # Algorithm parameters
    bound = 5 * 10^8

    # Solution
    prime_list = []
    prime_count_memo = [0 for _ in 1:bound]
    prime_sum_memo = [0 for _ in 1:bound]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        prime_count_memo[p] = prime_count_memo[p - 1]
        prime_sum_memo[p] = prime_sum_memo[p - 1]
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            push!(prime_list, p)
            prime_count_memo[p] += 1
            prime_sum_memo[p] += p
        end
    end

    function triangular(x)
        t1 = x & 1 == 0 ? (x >> 1) : x
        t2 = (x + 1) & 1 == 0 ? ((x + 1) >> 1) : x + 1
        return mod(mod(t1, mod_size) * mod(t2, mod_size), mod_size)
    end

    function phi_sum(x, a)
        if x <= 0
            return 0
        end
        if a <= 0
            return triangular(x)
        end
        if x <= prime_list[a]^2
            return mod(1 + prime_sum(x) - prime_sum(prime_list[a]), mod_size)
        end
        value = phi_sum(x, 0)
        for i in 1:a
            p_i = prime_list[i]
            term = mod(p_i * phi_sum(fld(x, p_i), i - 1), mod_size)
            value = mod(value - term, mod_size)
        end
        return value
    end

    function prime_sum(x)
        if x <= 0
            return 0
        end
        if x <= bound
            return prime_sum_memo[x]
        end
        a = prime_count_memo[iroot(x, 3)]
        b = prime_count_memo[isqrt(x)]
        value = mod(phi_sum(x, a) + prime_sum(iroot(x, 3)) - 1, mod_size)
        for i in (a + 1):b
            p_i = prime_list[i]
            term = mod(p_i * mod(prime_sum(fld(x, p_i)) - prime_sum(p_i - 1), mod_size), mod_size)
            value = mod(value - term, mod_size)
        end
        return value
    end

    function f(x, k)
        if x <= 1
            return 0
        end
        value = prime_sum(x)
        if k >= 1
            term = prime_sum(prime_list[k])
            value = mod(value - term, mod_size) 
        end
        a = prime_count_memo[isqrt(x)]
        for i in (k + 1):a
            term = f(fld(x, prime_list[i]), i - 1)
            value = mod(value + term, mod_size) 
        end
        return value
    end

    result = f(n, 0)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
