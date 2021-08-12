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
    n = Int64(1e14)

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    mu_memo = [1 for _ in 1:bound]
    factorization_memo = [Dict() for _ in 1:bound]

    function init()
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
                    factorization_memo[k][p] = 1
                end
    
                acc = p * p
                for k in acc:acc:bound
                    mu_memo[k] = 0
                end

                while acc <= bound
                    for k in acc:acc:bound
                        factorization_memo[k][p] += 1
                    end
                    acc *= p
                end
            end
        end
    end

    function numdivisors_sum(x)
        value = 0
        for d in 1:isqrt(x)
            value += fld(x, d)
        end
        max_u = isqrt(x)
        if max_u == fld(x, max_u)
            max_u -= 1
        end
        for u in 1:max_u
            value += u * (fld(x, u) - fld(x, u + 1))
        end
        return value
    end

    function h(a, b)
        value = 1

        keys_a = keys(factorization_memo[a])
        keys_b = keys(factorization_memo[b])
        shared = intersect(keys_a, keys_b)
        just_a = setdiff(keys_a, shared)
        just_b = setdiff(keys_b, shared)

        for p in shared
            value *= 2^(2 * factorization_memo[a][p] + 3 * factorization_memo[b][p] - 2)
        end

        for p in just_a
            value *= 2^(2 * factorization_memo[a][p] - 2)
        end

        for p in just_b
            value *= 2^(3 * factorization_memo[b][p] - 2)
        end

        return value
    end

    function s(x)
        value = 0
        for b in 1:iroot(x, 3)
            if mu_memo[b] == 0
                continue
            end
            for a in 1:isqrt(fld(x, b^3))
                d = a^2 * b^3
                value += h(a, b) * numdivisors_sum(fld(x, d))
            end
        end
        return value
    end

    init()
    result = s(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
