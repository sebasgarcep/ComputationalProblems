using Printf

function factorize(n)
    factors = []
    e = 0
    while n & 1 == 0
        e += 1
        n = n >> 1
    end
    if e > 0
        push!(factors, (2, e))
    end
    p = 3
    while p <= n
        e = 0
        while mod(n, p) == 0
            e += 1
            n = fld(n, p)
        end
        if e > 0
            push!(factors, (p, e))
        end
        p += 2
    end
    return factors
end

function search(t, p_v, i, a)
    if i > length(p_v)
        if a == 1
            return 0
        end

        for j in 1:(t - 1)
            w = (1 << j)
            if mod(w, a) == 1
                return 0
            end
        end

        return a + 1
    end

    result = 0
    (p, e) = p_v[i]
    for k in 0:e
        result += search(t, p_v, i + 1, a * p^k)
    end
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    t = 60

    # Algorithm parameters

    # Solution
    v = (1 << t) - 1

    p_v = factorize(v)

    result = search(t, p_v, 1, 1)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
