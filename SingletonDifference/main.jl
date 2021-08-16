using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = Int64(50e6)

    # Algorithm parameters
    num_sols = [0 for _ in 1:limit]

    # Solution
    for a in 1:(limit - 1)
        k = fld(a, 3) + 1
        n = (a + k) * (3 * k - a)
        while n <= (limit - 1)
            num_sols[n] += 1
            k += 1
            n = (a + k) * (3 * k - a)
        end
    end

    for n in 1:(limit - 1)
        if num_sols[n] == 1
            result += 1
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
