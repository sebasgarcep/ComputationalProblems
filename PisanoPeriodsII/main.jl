using Printf

function pisano_period(m)
    a, b = 0, 1
    p = 0
    while true
        p += 1
        a, b = b, mod(a + b, m)
        if a == 0 && b == 1
            return p
        end
    end
end

function sigma2(a)
    k = 0
    while a & 1 == 0
        k += 1
        a = a >> 1
    end
    return k
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^6
    m = 1234567891

    # Algorithm parameters

    # Solution
    found = Dict()
    result = 2
    a, b = 0, 1
    c, d, e = 0, 1, 1
    for p in 1:n
        if p & 1 == 0
            a, b = b, mod(a + b, m)
            if p & 3 == 0
                g = a
            else
                g = mod(c + e, m)
            end
            result = mod(result * g, m)
            c, d, e = d, e, mod(d + e, m)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
