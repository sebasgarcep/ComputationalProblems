using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 5 * 10^4
    s = 999676999

    # Algorithm parameters

    # Solution
    
    # Calculate values of d
    d = zeros(Int64, n + 1)

    d[0 + 1] = 1
    d[1 + 1] = 1
    for i in 2:n
        found = false
        for k in 2:isqrt(i)
            if mod(i, k) == 0
                d[i + 1] = d[k + 1] * fld(i, k) + d[fld(i, k) + 1] * k
                found = true
            end
        end
        if !found
            d[i + 1] = 1
        end
    end

    # Compute g polynomial
    g = zeros(Int64, n + 1)
    g[0 + 1] = 1

    for k in 1:n
        g_rst = copy(g)
        for i in 1:fld(n, k)
            t = powermod(d[k + 1], i, s)
            for j in 0:(n - i * k)
                e = i * k + j
                g_rst[e + 1] += mod(g[j + 1] * t, s)
                g_rst[e + 1] = mod(g_rst[e + 1], s)
            end
        end
        g = g_rst
    end

    result = sum(g[(1 + 1):(n + 1)])
    result = mod(result, s)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
