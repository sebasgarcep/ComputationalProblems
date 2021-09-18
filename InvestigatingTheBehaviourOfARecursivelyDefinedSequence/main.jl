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

function f(x)
    return floor(2.0^(30.403243784 - x^2)) * 1e-9
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters
    delta = 1e-10

    # Solution

    u_sum_curr = -1
    u_curr = -1.0
    while true
        u_prev = u_curr
        u_curr = f(u_curr)
        u_sum_prev = u_sum_curr
        u_sum_curr = u_prev + u_curr
        if abs(u_sum_prev - u_sum_curr) < delta
            result = u_sum_curr
            break
        end
    end

    # Show result
    @printf("%.9f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
