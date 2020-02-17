using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^6
    m = 1000000007

    # Algorithm parameters

    # Solution
    for k in 1:n
        k2 = k^2
        v = mod(1 - powermod(1 - k2, n + 1, m), m)
        v = mod(v * invmod(k2, m) - 1, m)
        result = mod(result + v, m)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
