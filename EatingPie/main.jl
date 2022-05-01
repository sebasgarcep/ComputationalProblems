using Printf

function get_next_coefficients(coeffs)
    if length(coeffs) == 0
        return [(-1 // 1, 1 // 1)]
    end
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

function int_log_k_div_x(k, y)
    return log(y)^(k + 1) / (k + 1)
end

function int_log_k(k, y)
    value = 0.0
    for r in 0:k
        value += (-1.0)^(k - r) * log(y)^r / factorial(r)
    end
    value *= y * factorial(k)
    return value
end

function int_log_k_div_x_sq(k, y)
    value = 0.0
    for r in 0:k
        value += log(y)^r / factorial(r)
    end
    value *= -factorial(k) / y
    return value
end

function calc_s(prev_coeffs, x)
    value = 0.0
    i = length(prev_coeffs) + 1
    for k in 0:(i - 2)
        value += Float64(prev_coeffs[k + 1][1]) * int_log_k(k, x)
        value += Float64(prev_coeffs[k + 1][2]) * int_log_k_div_x(k, x)
    end
    value *= 2.0^(i - 1)
    return value
end

function eval_s(prev_coeffs, lower, upper)
    return calc_s(prev_coeffs, upper) - calc_s(prev_coeffs, lower)
end

function calc_t(prev_coeffs, x)
    value = 0.0
    i = length(prev_coeffs) + 1
    for k in 0:(i - 2)
        value += Float64(prev_coeffs[k + 1][1]) * int_log_k_div_x(k, x)
        value += Float64(prev_coeffs[k + 1][2]) * int_log_k_div_x_sq(k, x)
    end
    value *= 2.0^(i - 1)
    return value
end

function eval_t(prev_coeffs, lower, upper)
    return calc_t(prev_coeffs, upper) - calc_t(prev_coeffs, lower)
end

function joint_probability(prev_coeffs, x)
    z = 1.0 / x
    if length(prev_coeffs) == 0
        return 1.0 - (1.0 - z)^2
    end
    return 2 * z * eval_s(prev_coeffs, z, 1.0) - z^2 * eval_t(prev_coeffs, z, 1.0)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    x = 7.5

    # Algorithm parameters

    # Solution
    prev_coeffs = [] 
    for i in 1:10
        result += i * joint_probability(prev_coeffs, x)
        prev_coeffs = get_next_coefficients(prev_coeffs)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
