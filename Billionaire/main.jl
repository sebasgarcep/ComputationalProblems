using Printf
using Polynomials

function m_p(c, l, n, p)
    for w in 0:n
        r = c * (1 + 2 * p)^w * (1 - p)^(n - w)
        if r >= l
            return w
        end
    end
    return 2 * n # Larger than any real output of the function
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    c = 1.0
    l = 1.0e9
    n = 1000

    # Algorithm parameters
    eps = 1e-16

    # Solution
    k = 1.0 / n * log(l / c)

    p_min = 0.0 + eps
    p_max = 1.0 - eps

    while abs(p_max - p_min) > eps
        p_mid = (p_min + p_max) / 2.0
        f_p_mid = log(1 + p_mid) * (1 + 2 * p_mid) + log(1 - p_mid) * (1 - p_mid) - (2.0 + p_mid) * k
        if f_p_mid < 0.0
            p_min = p_mid
        else
            p_max = p_mid
        end
    end
    
    p = (p_min + p_max) / 2.0
    m = m_p(c, l, n, p)

    poly = Polynomial([0.5, 0.5])^n

    result = sum(poly.coeffs[(m + 1):(n + 1)])

    # Show result
    println(@sprintf("%.12f", result))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
