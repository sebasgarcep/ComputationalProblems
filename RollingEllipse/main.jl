using Printf
using Plots

function numerical_integration(f, a, b, n = 10^4)
    res = f(a) / 2.0 + f(b) / 2.0
    for k in 1:(n - 1)
        res += f(a + (b - a) * Float64(k) / Float64(n))
    end
    res *= (b - a) / Float64(n)
    return res
end

function eccentricity(a, b)
    return sqrt(1.0 - Float64(a)^2 / Float64(b)^2)
end

function c(a, b)
    if a > b
        return c(b, a)
    end
    ecc = eccentricity(a, b)

    function f(x)
        t = a^2 * cos(x)^2 + b^2 * sin(x)^2
        x_prime = b * sqrt(1.0 - ecc^2 * cos(x)^2) + (b^2 - a^2) * (a^2 * cos(x)^4 - b^2 * sin(x)^4) / sqrt(t^3)
        y_prime = a * b * (a^2 - b^2) * sin(x) * cos(x) / sqrt(t^3)
        return sqrt(x_prime^2 + y_prime^2)
    end

    lower = 0.0
    upper = pi / 2.0
    return 4.0 * numerical_integration(f, lower, upper)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    result = c(1, 4) + c(3, 4)

    # Show result
    @printf("%.8f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
