using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    order = [Float64(x) for x in [50,48,46,44,42,40,38,36,34,32,30,31,33,35,37,39,41,43,45,47,49]]
    acc = order[1]
    for k in 1:(length(order) - 1)
        r1 = order[k]
        r2 = order[k + 1]
        acc += sqrt((r1 + r2)^2 - (100 - r1 - r2)^2)
    end
    acc += order[length(order)]

    result = Int64(round(acc * 1000.0))

    # Algorithm parameters

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
