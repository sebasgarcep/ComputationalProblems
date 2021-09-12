using Printf
using Random

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

function integral_result(r, h)
    u_min = pi / 2
    u_max = acos(h / r)
    value = sin(2.0 * u_max) / 2.0 - sin(2.0 * u_min) / 2.0
    value -= u_max - u_min
    value *= r^2 / 2.0
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^5

    # Algorithm parameters

    # Solution
    for k in 1:n
        k_iter = Float64(k)
        if k == 1
            r_min = sqrt(2.0)
        else
            r_min = 1.0 - 1.0 / (2.0 * k_iter)
        end
        r_max = 1.0 + 1.0 / (2.0 * k_iter)
        h = 1.0 / k_iter
        area = pi * (r_max^2 - r_min^2) / 4.0
        area -= 2.0 * (integral_result(r_max, h) - integral_result(r_min, h))
        result += k_iter * area
    end

    # Show result
    @printf("%.5f\n",result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
