using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^14
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    mu_memo = [1 for _ in 1:bound]
    q_memo = [0 for _ in 1:bound]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (2 * p):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                mu_memo[k] *= -1
            end

            p_2 = p * p
            for k in p_2:p_2:bound
                mu_memo[k] = 0
            end
        end
    end

    q_memo[1] = 1
    for i in 2:bound
        q_memo[i] = q_memo[i - 1]
        if mu_memo[i] != 0
            q_memo[i] += 1
        end
    end

    function q(x)
        if x <= bound
            return q_memo[x]
        end
        value = 0
        for d in 1:isqrt(x)
            value += mu_memo[d] * fld(x, d * d)
        end
        return value
    end

    for a in 1:isqrt(n)
        term = mod(a^2, mod_size) * mod(q(fld(n, a^2)), mod_size)
        term = mod(term, mod_size)
        result = mod(result + term, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
