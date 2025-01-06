using Printf

function pisano_period(m)
    a = 0
    b = 1
    p = 0
    while true
        p += 1
        if p > 120
            return -1
        end
        a, b = b, mod(a + b, m)
        if a == 0 && b == 1
            return p
        end
    end
end

function search(n, pp_memo, candidate_primes, i, a, b)
    if b > 120
        return 0
    end

    if i > length(candidate_primes)
        if b == 120
            return a
        else
            return 0
        end
    end

    p = candidate_primes[i]
    limit = 0
    e = p
    while a * e <= n
        limit += 1
        if p != 2 && p != 3 && p != 5
            break
        end
        e *= p
    end

    result = 0
    for k in 0:limit
        next_a = a * p^k
        if k == 0
            next_b = b
        else
            next_b = lcm(b, p^(k - 1) * pp_memo[p])
        end
        result += search(n, pp_memo, candidate_primes, i + 1, next_a, next_b)
    end
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^9

    # Algorithm parameters

    # Solution
    candidate_primes = []
    pp_memo = zeros(Int64, n)

    slots = [true for _ in 1:n]
    slots[1] = false
    for p in 2:n
        if slots[p]
            pp_memo[p] = pisano_period(p)
            if pp_memo[p] > 0 && mod(120, pp_memo[p]) == 0
                push!(candidate_primes, p)
            end
            for k in (p^2):p:n
                slots[k] = false
            end
        end
    end

    result = search(n, pp_memo, candidate_primes, 1, 1, 1)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
