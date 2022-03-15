using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    theta = BigInt(2223561019313554106173177) // BigInt(10)^24

    b = theta
    tau = ""

    a = Int64(floor(b))
    tau *= string(a)
    tau *= "."

    for _ in 1:15
        b = floor(b) * (b - floor(b) + 1)
        a = Int64(floor(b))
        tau *= string(a)
    end

    result = tau[1:26]

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
