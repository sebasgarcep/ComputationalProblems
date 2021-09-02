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
    n = 10^13
    m = 10^12
    d = 10^4
    mod_size = 999999937

    # Algorithm parameters

    # Solution
    function get_digits(t, p)
        digits = []
        while t > 0
            s = mod(t, p)
            push!(digits, s)
            t = fld(t, p)
        end
        return digits
    end

    function binomial_mod_prime(x, y, p)
        digits_x = get_digits(x, p)
        digits_y = get_digits(y, p)
        for i in 1:min(length(digits_x), length(digits_y))
            x_i = digits_x[i]
            y_i = digits_y[i]
            if y_i > x_i
                return 0
            end
        end
        value = 1
        for i in 1:min(length(digits_x), length(digits_y))
            x_i = digits_x[i]
            y_i = digits_y[i]
            for j in 1:y_i
                value *= mod((x_i - j + 1) * invmod(j, p), p)
                value = mod(value, p)
            end
        end
        return value
    end

    result = mod(binomial_mod_prime(n, d, mod_size), mod_size) * mod(binomial_mod_prime(n - d - 1, m - d - 1, mod_size), mod_size)
    result = mod(result, mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
