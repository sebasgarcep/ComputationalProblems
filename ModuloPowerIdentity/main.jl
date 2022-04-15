using Printf

function search(n, bound, primes, slots, k, start, m, l, last_factor)
    value = 0
    # Once we have at least 2 primes
    if 2 <= k
        g = gcd(m, l)
        if g == 1 || g == 3
            m_alt = fld(m, g)
            l_alt = fld(l, g)
            t_min = mod(invmod(l_alt, m_alt) * fld(3, g), m_alt)
            # Generate all the x's from the t's and perform all checks on them
            for t in t_min:m_alt:fld(m * bound + 3, l)
                x = fld(l * t - 3, m)
                if slots[x] &&
                    mod(m * x + 3, x - 1) == 0 &&
                    x > last_factor &&
                    m * x <= n
                    value += m * x
                end
            end
        end
    end
    # Go deeper in the DFS
    for pos in start:length(primes)
        next_m = m * primes[pos]
        if next_m * primes[pos] > n
            break
        end
        next_k = k + 1
        next_start = pos + 1
        next_l = lcm(l, primes[pos] - 1)
        next_last_factor = primes[pos]
        value += search(n, bound, primes, slots, next_k, next_start, next_m, next_l, next_last_factor)
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1000000000000

    # Algorithm parameters
    bound = isqrt(n + 4) + 2

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            if p > 2
                push!(primes, p)
            end
        end
    end

    # m = 1
    if 1 <= n
        result += 1
    end

    # m prime
    if 2 <= n
        result += 2
    end
    if 3 <= n
        result += 3
    end
    if 5 <= n
        result += 5
    end

    # m product of two primes
    if 21 <= n
        result += 21
    end

    # m product of three or more primes
    result += search(n, bound, primes, slots, 0, 1, 1, 1, 1)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
