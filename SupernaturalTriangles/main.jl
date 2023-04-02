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

function calc_prod(a, b, c, d, p)
    """
    Compute (a + b * sqrt(2)) * (c + d * sqrt(2)) in Z_p[2].
    """
    return mod(mod(a * c, p) + mod(2 * mod(b * d, p), p), p), mod(mod(a * d, p) + mod(b * c, p), p)
end

function calc_exp(a, b, c, p)
    """
    Compute u + v * sqrt(2) = (a + b * sqrt(2))^c in Z_p[2].
    """
    u, v = 1, 0
    while c > 0
        if c & 1 == 1
            u, v = calc_prod(a, b, u, v, p)
        end
        c = c >> 1
        a, b = calc_prod(a, b, a, b, p)
    end
    return u, v
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = 10^10
    p = 1234567891

    # Algorithm parameters

    # Solution

    # Case 1
    k = Int64(floor((m - log10((4.0 + 3.0 * sqrt(2.0)) * 0.25)) / log10(3.0 + 2.0 * sqrt(2.0))))
    q, r = calc_exp(3, -2, k + 1, p)
    q, r = calc_prod(q, r, 4, -2, p)
    s, t = calc_exp(3, 2, k + 1, p)
    s, t = calc_prod(s, t, 4, 2, p)
    term = mod(mod(q + s - 8, p) * invmod(16, p), p)
    result += term - 2
    result = mod(result, p)

    # Case 2
    inv_2 = invmod(2, p)
    inv_3 = invmod(3, p)
    inv_6 = invmod(6, p)
    b = mod(powermod(10, m >> 1, p) - 1, p)
    c = mod((b - 1) * inv_2, p)
    term_b = mod(b * (b + 1), p)
    result += mod(mod(term_b * (2 * b + 1), p) * inv_6, p) + mod(term_b * inv_2, p)
    result = mod(result, p)
    term_c = mod(c * (c + 1), p)
    result -= mod(mod(mod(2 * term_c, p) * (2 * c + 1), p) * inv_3, p) + term_c
    result = mod(result, p)
    result -= 2
    result = mod(result, p)

    # Case 3
    result -= 12
    result = mod(result, p)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
