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
    n = 10^12

    # Algorithm parameters

    # Solution
    square_set = Set([i^2 for i in 1:isqrt(n)])

    result_set = Set()
    for a in 2:iroot(n, 3)
        for b in 1:(a - 1)
            if a^3 * b + b^2 > n
                break
            end
            if gcd(a, b) != 1
                continue
            end
            k = 1
            while a^3 * b * k^2 + b^2 * k <= n
                if a^3 * b * k^2 + b^2 * k in square_set
                    push!(result_set, a^3 * b * k^2 + b^2 * k)
                end
                k += 1
            end
        end
    end

    result = sum(result_set)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
