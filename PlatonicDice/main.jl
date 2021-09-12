using Printf
using Polynomials

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

function g_t(t, x)
    value = 0
    for n in 1:t
        value += x^n
    end
    return value
end

function g_t_dx(t, x)
    value = 0
    for n in 1:t
        value += n * x^(n - 1)
    end
    return value
end

function g_t_dx_dx(t, x)
    value = 0
    for n in 2:t
        value += n * (n - 1) * x^(n - 2)
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    g = Polynomial([0, 1])
    for t in [4, 6, 8, 12, 20]
        f = Polynomial([i == 0 ? 0 : 1.0 / Float64(t) for i in 0:t])
        g = f(g)
    end

    g_dx = derivative(g)
    g_dx_dx = derivative(g_dx)
    result = g_dx_dx(1) + g_dx(1) - g_dx(1)^2

    # Show result
    @printf("%.4f\n",result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
