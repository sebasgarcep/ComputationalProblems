using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    s0 = 290797
    m = 50515093
    n = 2 * 10^9

    # Algorithm parameters

    # Solution
    s = mod(s0 * s0, m)
    p = 0
    r = m
    s_vals = []
    found = [0 for _ in 1:(m - 1)]
    while found[s] == 0
        p += 1
        r = min(r, s)
        push!(s_vals, s)
        found[s] = p
        s = mod(s * s, m)
    end

    k = cld(n, p)

    cases = 0
    for i in 1:min(p, n)
        e = i + 1
        while s_vals[e > p ? e - p : e] > s_vals[i]
            e += 1
        end
        f = i - 1
        while s_vals[f <= 0 ? f + p : f] > s_vals[i]
            f -= 1
        end
        s_i = s_vals[i]
        # Segments 2, 3, ... , k - 2
        cases += max(k - 3, 0) * (i - f) * (e - i)
        result += max(k - 3, 0) * (i - f) * (e - i) * s_i
        # Segment 1
        cases += (i - max(f, 0)) * (min(e, n + 1) - i)
        result += (i - max(f, 0)) * (min(e, n + 1) - i) * s_i
        # Segment k - 1
        if k >= 3 && i + (k - 2) * p <= n
            cases += (i - f) * (min(e, n + 1 - (k - 2) * p) - i)
            result += (i - f) * (min(e, n + 1 - (k - 2) * p) - i) * s_i
        end
        # Segment k
        if k >= 2 && i + (k - 1) * p <= n
            cases += (i - f) * (min(e, n + 1 - (k - 1) * p) - i)
            result += (i - f) * (min(e, n + 1 - (k - 1) * p) - i) * s_i
        end
    end

    if mod(n, 2) == 0
        result += max(fld(n, 2) * (n + 1) - cases, 0) * r
    else
        result += max(fld(n + 1, 2) * n - cases, 0) * r
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
