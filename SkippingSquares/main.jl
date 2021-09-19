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

function simplify(f, n, m)
    coeffs = f.coeffs[1:min(length(f.coeffs), n + 1)]
    # return Polynomial(coeffs)
    return Polynomial(mod.(coeffs, m))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1000
    k = 10^9
    mod_size = 10^9

    # Algorithm parameters
    x = Polynomial([Int128(0), Int128(1)])
    y = Polynomial([Int128(1), Int128(-1)])
    p_prev = Polynomial([Int128(0)])
    p_curr = Polynomial([Int128(1)])
    q_curr = Polynomial([Int128(1), Int128(-1)])
    f = Polynomial([Int128(0)])

    for i in 1:k
        # println(i)
        p_prev, p_curr = p_curr, x * p_curr + y * p_prev
        p_curr = simplify(p_curr, n, mod_size)
        p_prev, p_curr = p_curr, x * p_curr + y * p_prev
        p_curr = simplify(p_curr, n, mod_size)
        q_iter, q_curr = q_curr * p_curr, q_curr * (1 - p_curr)
        q_iter = simplify(q_iter, n, mod_size)
        q_curr = simplify(q_curr, n, mod_size)
        f = f + i * q_iter
        f = simplify(f, n, mod_size)
        if q_curr == 0
            break
        end
        # @printf("P(%d) = %s\n", 2 * i - 1, p_prev)
        # @printf("P(%d) = %s\n", 2 * i, p_curr)
        # @printf("Q(%d) = %s\n", (i + 1)^2, q_iter)
        # @printf("Q(%d) = %s\n", (i + 1)^2 + 1, q_curr)
    end
    # @printf("f(x) = %s\n", f)

    for a_i in f.coeffs
        result += a_i
        result = mod(result, mod_size)
    end

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
