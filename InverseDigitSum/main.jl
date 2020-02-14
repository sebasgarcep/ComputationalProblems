using Printf

function s_upr(n, m)
    t = fld(n, 9)
    total = mod(5 * (powermod(10, t, m) - 1) - 9 * t, m)
    for k in (9 * t):n
        d = fld(k, 9)
        total = mod(total + (mod(k, 9) + 1) * powermod(10, d, m) - 1, m)
    end
    return total
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = 1000000007

    # Algorithm parameters

    # Solution
    a, b = 0, 1
    for _ in 2:90
        a, b = b, a + b
        result = mod(result + s_upr(b, m), m)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
