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
    n = 10^11

    # Algorithm parameters
    k_max = 5
    bound = 10^8

    # Solution
    prime_list = []
    prime_count_memo = [0 for _ in 1:bound]
    prime_sum_k_memo = [
        [0 for _ in 1:bound],
        [0 for _ in 1:bound],
    ]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        prime_count_memo[p] = prime_count_memo[p - 1]
        prime_sum_k_memo[1][p] = prime_sum_k_memo[1][p - 1]
        prime_sum_k_memo[2][p] = prime_sum_k_memo[2][p - 1]
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            push!(prime_list, p)
            prime_count_memo[p] += 1

            if p != 3
                prime_sum_k_memo[mod(p, 3)][p] += p
            end
        end
    end

    function triangular(x)
        return (x * (x + 1)) >> 1
    end

    function phi_k(k, x, a)
        if x < k
            return 0
        end
        limit = fld(x - k, 3)
        value = 3 * triangular(limit) + k * (limit + 1)
        if a == 0
            return value
        end
        if x <= prime_list[a]
            return k == 1 ? 1 : 0
        end
        if x <= prime_list[a]^2
            return prime_sum_k(k, x) - prime_sum_k(k, prime_list[a]) + (k == 1 ? 1 : 0)
        end
        for i in 1:a
            if i == 2
                continue
            end
            p_i = prime_list[i]
            value -= p_i * phi_k(mod(k * p_i, 3), fld(x, p_i), i - 1)
        end
        return value
    end

    function prime_sum_k(k, x)
        if x <= 0
            return 0
        end
        if x <= bound
            return prime_sum_k_memo[k][x]
        end
        a = prime_count_memo[iroot(x, 3)]
        b = prime_count_memo[isqrt(x)]
        value = phi_k(k, x, a) + prime_sum_k_memo[k][prime_list[a]] - (k == 1 ? 1 : 0)
        for i in (a + 1):b
            p_i = prime_list[i]
            k_next = mod(k * p_i, 3)
            value -= p_i * (prime_sum_k(k_next, fld(x, p_i)) - prime_sum_k(k_next, p_i - 1))
        end
        return value 
    end

    function s_k(k, x, a)
        if x <= 0 || k < 0
            return 0
        end

        if a >= 1 && x <= prime_list[a]
            return k == 0 ? 1 : 0
        end

        if a >= 1 && x <= prime_list[a]^2
            if k >= 2
                return 0
            elseif k == 1
                return prime_sum_k(1, x) - prime_sum_k(1, prime_list[a])
            elseif a >= 2
                return 1 + prime_sum_k(2, x) - prime_sum_k(2, prime_list[a])
            else
                return 1 + 3 + prime_sum_k(2, x) - prime_sum_k(2, prime_list[a])
            end
        end

        value = s_k(k, x, a + 1)

        p = prime_list[a + 1]

        if p == 3
            value += p * s_k(k, fld(x, 3), a + 1)
            acc = p * p
            while acc <= x
                value += acc * s_k(k - 1, fld(x, acc), a + 1)
                acc *= p
            end
        elseif mod(p, 3) == 1
            if k > 0
                acc = p
                while acc <= x
                    value += acc * s_k(k - 1, fld(x, acc), a + 1)
                    acc *= p
                end
            end
        else
            acc = p
            while acc <= x
                value += acc * s_k(k, fld(x, acc), a + 1)
                acc *= p
            end
        end

        return value
    end

    result = s_k(k_max, n, 0)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
