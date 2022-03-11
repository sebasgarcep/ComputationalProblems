using Printf

function count_digits(num_digits, n)
    digits_n = digits(n)
    c = [0 for _ in 0:9]
    for d in digits_n
        c[d + 1] += 1
    end
    c[0 + 1] += num_digits - sum(c)
    return c
end

function get_sum(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9)
    num_digits = d0 + d1 + d2 + d3 + d4 + d5 + d6 + d7 + d8 + d9
    test_digits = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9]
    value = 0
    k = 1
    while true
        digit_power_sum = d0 * Int128(0)^k +
            d1 * Int128(1)^k +
            d2 * Int128(2)^k +
            d3 * Int128(3)^k +
            d4 * Int128(4)^k +
            d5 * Int128(5)^k +
            d6 * Int128(6)^k +
            d7 * Int128(7)^k +
            d8 * Int128(8)^k +
            d9 * Int128(9)^k
        if digit_power_sum - 1 >= Int128(10)^num_digits
            break
        end
        # Check n = v_k + 1
        n = digit_power_sum + 1
        if n < Int128(10)^num_digits
            n = Int64(n)
            if count_digits(num_digits, n) == test_digits
                value += n
            end
        end
        # Check n = v_k - 1
        n = digit_power_sum - 1
        if n < Int128(10)^num_digits
            n = Int64(n)
            if count_digits(num_digits, n) == test_digits
                value += n
            end
        end
        # v_k is constant
        if num_digits == d0 + d1
            break
        end
        k += 1
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    num_digits = 16

    # Algorithm parameters

    # Solution
    for d0 in 0:(num_digits - 1)
        for d1 in 0:(num_digits - d0)
            for d2 in 0:(num_digits - d0 - d1)
                for d3 in 0:(num_digits - d0 - d1 - d2)
                    for d4 in 0:(num_digits - d0 - d1 - d2 - d3)
                        for d5 in 0:(num_digits - d0 - d1 - d2 - d3 - d4)
                            for d6 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5)
                                for d7 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6)
                                    for d8 in 0:(num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6 - d7)
                                        d9 = num_digits - d0 - d1 - d2 - d3 - d4 - d5 - d6 - d7 - d8
                                        result += get_sum(d0, d1, d2, d3, d4, d5, d6, d7, d8, d9)
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
