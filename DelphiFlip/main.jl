using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    x = 1.9999

    # Algorithm parameters

    # Solution
    t = 1.0
    n = 0
    f_val = 1.0
    while f_val < x
        t *= (2.0 * n + 2.0) / (n + 1.0)
        t *= (2.0 * n + 1.0) / (n + 1.0)
        t *= 1.0 / 4.0
        n += 1
        f_val = 2.0 / (1.0 + t)
    end

    result = n

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()