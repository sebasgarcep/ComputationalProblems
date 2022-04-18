using Printf

function get_next_coefficients(coeffs)
    i = length(coeffs) + 1
    next_coeffs = []
    for r in 0:(i - 1)
        if r == 0
            a_ir = 0 // 1
            for k in 0:(i - 2)
                a_ir +=  factorial(k) * (coeffs[k + 1][2] - (-1)^k * coeffs[k + 1][1])
            end
            b_ir = -a_ir
        else
            a_ir = coeffs[r][1] // r
            b_ir = -coeffs[r][2] // r
            for k in r:(i - 2)
                a_ir -= (-1)^(k - r) * factorial(k) * coeffs[k + 1][1] // factorial(r)
                b_ir -= factorial(k) * coeffs[k + 1][2] // factorial(r)
            end
        end
        push!(next_coeffs, (a_ir, b_ir))
    end
    return next_coeffs
end

function get_cumulative(coeffs, z)
    value = 0.0
    i = length(coeffs)
    for k in 0:(i - 1)
        int_1 = 0.0
        for r in 0:k
            int_1 += (-1.0)^(k - r) * 2.0^r * (log(z))^r / factorial(r)
        end
        int_1 *= z^2 * factorial(k) / 2.0^(k + 1)
        int_2 = 0.0
        for r in 0:k
            int_2 += (-1.0)^(k - r) * (log(z))^r / factorial(r)
        end
        int_2 *= z * factorial(k)
        value += Float64(coeffs[k + 1][1]) * int_1
        value += Float64(coeffs[k + 1][2]) * int_2
    end
    value *= 2.0^i
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    x = 2.0

    # Algorithm parameters

    # Solution
    z = 1.0 / x
    prev_coeffs, curr_coeffs = [], [(-1 // 1, 1 // 1)]
    for i in 1:10
        if i == 1
            result += i * get_cumulative(curr_coeffs, z)
        else
            result += i * (1.0 - get_cumulative(prev_coeffs, z)) * get_cumulative(curr_coeffs, z)
        end
        prev_coeffs, curr_coeffs = curr_coeffs, get_next_coefficients(curr_coeffs)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
