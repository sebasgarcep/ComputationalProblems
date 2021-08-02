using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n_input = [2, 3, 5, 7, 11, 13, 17]
    m_input = Int64(1e11)
    mod_input = Int64(1e9)

    # Algorithm parameters
    memo_bound = Int64(1e9)

    # Solution
    totient_memo = [1 for _ in 1:memo_bound]
    totient_sum_memo = [0 for _ in 1:memo_bound]
    n_last_factor = Dict()

    function init()
        # Sieve
        slots = [true for _ in 1:memo_bound]
        slots[1] = false
        for p in 2:memo_bound
            if slots[p]
                totient_memo[p] = p - 1
                for k in (2 * p):p:memo_bound
                    slots[k] = false
                    totient_memo[k] *= p - 1
                    acc = p * p
                    while mod(k, acc) == 0
                        totient_memo[k] *= p
                        acc *= p
                    end
                end
            end
        end

        # Summations
        totient_sum_memo[1] = mod(totient_memo[1], mod_input)
        for k in 2:memo_bound
            totient_sum_memo[k] = mod(totient_sum_memo[k - 1] + totient_memo[k], mod_input)
        end

        # Maps
        acc = 1
        for k in 1:length(n_input)
            acc *= n_input[k]
            n_last_factor[acc] = n_input[k]
        end
    end

    function totient_sum(n)
        if n <= memo_bound
            return totient_sum_memo[n]
        end
        s = (Int128(n) * Int128(n + 1)) >> 1
        s = Int64(mod(s, mod_input))
        sqrtn = isqrt(n)
        for m in 2:sqrtn
            s = mod(s - totient_sum(fld(n, m)), mod_input)
        end
        for d in 1:sqrtn
            r = fld(n, d)
            if d == r
                continue
            end
            s = mod(s - (r - fld(n, d + 1)) * totient_sum(d), mod_input)
        end
        return s
    end
    
    function totient_product_sum(n, m)
        if m <= 0
            return 0
        end
        if n == 1
            return totient_sum(m)
        end
        p = n_last_factor[n]
        return mod(
            (p - 1) * mod(
                totient_product_sum(fld(n, p), m),
                mod_input,
            ) + mod(
                totient_product_sum(n, fld(m, p)),
                mod_input,
            ),
            mod_input,
        )
    end

    init()
    result = totient_product_sum(prod(n_input), m_input)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
