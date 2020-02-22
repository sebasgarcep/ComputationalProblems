using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k = 2011

    # Algorithm parameters

    # Solution
    for q in 2.0:k
        for p in 1.0:min(q - 1.0, k - q)
            c = p + q - 2.0 * sqrt(p * q)
            if c < 1
                result += ceil(Int64, -k * log(10.0) / log(c))
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
