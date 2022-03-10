using Printf

function multinomial(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9)
    n = d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9
    value = factorial(Int128(n))
    value = fld(value, factorial(Int128(d0)))
    value = fld(value, factorial(Int128(d1)))
    value = fld(value, factorial(Int128(d2)))
    value = fld(value, factorial(Int128(d3)))
    value = fld(value, factorial(Int128(d4)))
    value = fld(value, factorial(Int128(d5)))
    value = fld(value, factorial(Int128(d6)))
    value = fld(value, factorial(Int128(d7)))
    value = fld(value, factorial(Int128(d8)))
    value = fld(value, factorial(Int128(d9)))
    return value
end

function get_sum(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, mod_size)
    num_digits = d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9
    value = 0
    if d0 > 0
        c = multinomial(d0 - 1, d1, d2, d3, d4, d5, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 0, mod_size)
        value = mod(value, mod_size)
    end
    if d1 > 0
        c = multinomial(d0, d1 - 1, d2, d3, d4, d5, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 1, mod_size)
        value = mod(value, mod_size)
    end
    if d2 > 0
        c = multinomial(d0, d1, d2 - 1, d3, d4, d5, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 2, mod_size)
        value = mod(value, mod_size)
    end
    if d3 > 0
        c = multinomial(d0, d1, d2, d3 - 1, d4, d5, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 3, mod_size)
        value = mod(value, mod_size)
    end
    if d4 > 0
        c = multinomial(d0, d1, d2, d3, d4 - 1, d5, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 4, mod_size)
        value = mod(value, mod_size)
    end
    if d5 > 0
        c = multinomial(d0, d1, d2, d3, d4, d5 - 1, d6, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 5, mod_size)
        value = mod(value, mod_size)
    end
    if d6 > 0
        c = multinomial(d0, d1, d2, d3, d4, d5, d6 - 1, d7, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 6, mod_size)
        value = mod(value, mod_size)
    end
    if d7 > 0
        c = multinomial(d0, d1, d2, d3, d4, d5, d6, d7 - 1, d8, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 7, mod_size)
        value = mod(value, mod_size)
    end
    if d8 > 0
        c = multinomial(d0, d1, d2, d3, d4, d5, d6, d7, d8 - 1, d9)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 8, mod_size)
        value = mod(value, mod_size)
    end
    if d9 > 0
        c = multinomial(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9 - 1)
        c = mod(c, mod_size)
        r = mod(fld(Int128(10)^num_digits - 1, 9), mod_size)
        value += mod(c * r * 9, mod_size)
        value = mod(value, mod_size)
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    num_digits = 20
    mod_size = 10^9

    # Algorithm parameters

    # Solution
    for d0 in 0:num_digits
        for d1 in 0:(num_digits - d0)
            for d2 in 0:(num_digits - d0 - d1)
                for d3 in 0:(num_digits - d0 - d1 - d2)
                    for d4 in 0:(num_digits - d0 - d1 - d2 - d3)
                        for d5 in 0:(num_digits - d0 - d1 - d2 - d3 - d4)
                            for d6 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5)
                                for d7 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6)
                                    for d8 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6 - d7)
                                        d9 = num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6 - d7 - d8
                                        value = d0 * 0^2 +
                                            d1 * 1^2 + 
                                            d2 * 2^2 +
                                            d3 * 3^2 +
                                            d4 * 4^2 +
                                            d5 * 5^2 +
                                            d6 * 6^2 +
                                            d7 * 7^2 +
                                            d8 * 8^2 +
                                            d9 * 9^2
                                        if isqrt(value)^2 == value
                                            result += get_sum(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, mod_size)
                                            result = mod(result, mod_size)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
