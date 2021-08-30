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
    n = 10^12

    # Algorithm parameters
    bound = 10^8
    factorization_bound = isqrt(n)

    # Solution
    prime_list = []
    prime_memo = [0 for _ in 1:bound]
    prime_k_memo = [
        [0 for _ in 1:bound],
        [],
        [0 for _ in 1:bound],
    ]
    f_two_memo = [1 for _ in 1:factorization_bound]
    special_b = []
    special_b_limit = iroot(n, 3)

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        prime_memo[p] = prime_memo[p - 1]
        prime_k_memo[1][p] = prime_k_memo[1][p - 1]
        prime_k_memo[3][p] = prime_k_memo[3][p - 1]
        if slots[p]
            for k in (2 * p):p:bound
                slots[k] = false
            end

            # Update prime list
            push!(prime_list, p)

            # Update pi
            prime_memo[p] += 1

            # Update pi_k
            if p != 2
                prime_k_memo[p & 3][p] += 1
            end

            if (p & 3) == 1
                # Update special b
                if p <= special_b_limit
                    push!(special_b, p)
                end

                # Calculate prime exponent
                limit = fld(factorization_bound, p)
                p_pow = [1 for _ in 1:limit]

                acc = p
                while acc <= limit
                    for k in acc:acc:limit
                        p_pow[k] += 1
                    end
                    acc *= p
                end

                # Update f_2(c^2)
                for idx in 1:limit
                    f_two_memo[p * idx] *= 2 * p_pow[idx] + 1
                end
            end
        end
    end

    f_two_memo = [(x - 1) >> 1 for x in f_two_memo]

    function phi_k(k, x, a)
        if a <= 1
            return x < k ? 0 : 1 + ((x - k) >> 2)
        end
        if x <= prime_list[a]
            return k == 1 ? 1 : 0
        end
        if x <= prime_list[a]^2
            return prime_k(k, x) - prime_k(k, prime_list[a]) + (k == 1 ? 1 : 0)
        end
        value = phi_k(k, x, 1)
        for i in 2:a
            p_i = prime_list[i]
            value -= phi_k((k * p_i) & 3, fld(x, p_i), i - 1)
        end
        return value
    end

    function prime_k(k, x)
        if x <= 0
            return 0
        end
        if x <= bound
            return prime_k_memo[k][x]
        end
        a = prime_memo[iroot(x, 3)]
        b = prime_memo[isqrt(x)]
        value = phi_k(k, x, a) + prime_k(k, iroot(x, 3)) - (k == 1 ? 1 : 0)
        for i in max(2, a + 1):b
            p_i = prime_list[i]
            k_next = (k * p_i) & 3
            value -= prime_k(k_next, fld(x, p_i)) - prime_k(k_next, p_i - 1)
        end
        return value
    end

    for c in 1:isqrt(n)
        if f_two_memo[c] & 1 == 1
            # c^2
            result += 1
            # 2 * c^2
            if 2 * c^2 <= n
                result += 1
            end
        end
    end

    for b in special_b
        k = 1
        acc = b
        while acc <= n
            if (k + 1) & 3 != 0
                result += isqrt(fld(n, acc)) - isqrt(fld(fld(n, acc), b^2))
                result += isqrt(fld(n, 2 * acc)) - isqrt(fld(fld(n, 2 * acc), b^2))
            end
            k += 2
            acc *= b
            if acc <= n
                acc *= b
            end
        end
    end

    for a in 1:isqrt(n)
        result += max(0, prime_k(1, fld(n, a^2)) - length(special_b))
        result += max(0, prime_k(1, fld(n, 2 * a^2)) - length(special_b))
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
