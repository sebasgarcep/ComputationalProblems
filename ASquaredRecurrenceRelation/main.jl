using Printf
using Memoize

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
    n = 10^16
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    function f(i, j, x)
        acc = x
        gamma = 0
        while acc > 0
            if acc & 1 == 1
                gamma += 1
            end
            acc = acc >> 1
        end
        return mod(mod(x, mod_size)^i, mod_size) * mod(mod(gamma, mod_size)^j, mod_size)
    end

    function r(i, j, x)
        if x & 1 == 1
            return 0
        end
        return mod(-f(i, j, x + 1), mod_size)
    end

    @memoize function s(i, j, x)
        if x <= 0
            return 0
        end
        if x == 1
            return 1
        end
        value = 0
        if i == 0 && j == 0
            value += mod(x, mod_size) 
        elseif i == 1 && j == 0
            term = mod(x, mod_size)
            term *= mod(x + 1, mod_size)
            term = mod(term, mod_size)
            term *= invmod(2, mod_size)
            term = mod(term, mod_size)
            value += term
        elseif i == 2 && j == 0
            term = mod(x, mod_size)
            term *= mod(x + 1, mod_size)
            term = mod(term, mod_size)
            term *= mod(2 * x + 1, mod_size)
            term = mod(term, mod_size)
            term *= invmod(6, mod_size)
            term = mod(term, mod_size)
            value += term
        elseif i == 0 && j == 1
            value += 1 + r(i, j, x)
            value += 2 * s(i - 0, j - 0, x >> 1)
            value += 1 * s(i - 0, j - 1, x >> 1)
        elseif i == 1 && j == 1
            value += 1 + r(i, j, x)
            value += 4 * s(i - 0, j - 0, x >> 1)
            value += 2 * s(i - 0, j - 1, x >> 1)
            value += 1 * s(i - 1, j - 0, x >> 1)
            value += 1 * s(i - 1, j - 1, x >> 1)
        elseif i == 2 && j == 1
            value += 1 + r(i, j, x)
            value += 8 * s(i - 0, j - 0, x >> 1)
            value += 4 * s(i - 1, j - 0, x >> 1)
            value += 1 * s(i - 2, j - 0, x >> 1)
            value += 4 * s(i - 0, j - 0 - 1, x >> 1)
            value += 4 * s(i - 1, j - 0 - 1, x >> 1)
            value += 1 * s(i - 2, j - 0 - 1, x >> 1)
        elseif i == 0 && j == 2
            value += 1 + r(i, j, x)
            value += 2 * s(i - 0, j - 0, x >> 1)
            value += 2 * s(i - 0, j - 1, x >> 1)
            value += 1 * s(i - 0, j - 2, x >> 1)
        elseif i == 1 && j == 2
            value += 1 + r(i, j, x)
            value += 4 * s(i - 0, j - 0, x >> 1)
            value += 4 * s(i - 0, j - 1, x >> 1)
            value += 2 * s(i - 0, j - 2, x >> 1)
            value += 1 * s(i - 1, j - 0, x >> 1)
            value += 2 * s(i - 1, j - 1, x >> 1)
            value += 1 * s(i - 1, j - 2, x >> 1)
        elseif i == 2 && j == 2
            value += 1 + r(i, j, x)
            value += 8 * s(i - 0, j - 0, x >> 1)
            value += 8 * s(i - 0, j - 1, x >> 1)
            value += 4 * s(i - 0, j - 2, x >> 1)
            value += 4 * s(i - 1, j - 0, x >> 1)
            value += 8 * s(i - 1, j - 1, x >> 1)
            value += 4 * s(i - 1, j - 2, x >> 1)
            value += 1 * s(i - 2, j - 0, x >> 1)
            value += 2 * s(i - 2, j - 1, x >> 1)
            value += 1 * s(i - 2, j - 2, x >> 1)
        end
        value = mod(value, mod_size)
        return value
    end

    result = s(2, 2, n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
