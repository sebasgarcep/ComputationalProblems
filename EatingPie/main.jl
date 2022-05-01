using Printf
using AbstractAlgebra

function get_next_coefficients(coeffs)
    if length(coeffs) == 0
        return [(-BigInt(1) // BigInt(1), BigInt(1) // BigInt(1))]
    end
    i = length(coeffs) + 1
    next_coeffs = []
    for r in 0:(i - 1)
        if r == 0
            a_ir = BigInt(0) // BigInt(1)
            for k in 0:(i - 2)
                a_ir +=  factorial(BigInt(k)) * (coeffs[k + 1][2] - (-1)^k * coeffs[k + 1][1])
            end
            b_ir = -a_ir
        else
            a_ir = coeffs[r][1] // r
            b_ir = -coeffs[r][2] // r
            for k in r:(i - 2)
                a_ir -= (-1)^(k - r) * factorial(BigInt(k)) * coeffs[k + 1][1] // factorial(BigInt(r))
                b_ir -= factorial(BigInt(k)) * coeffs[k + 1][2] // factorial(BigInt(r))
            end
        end
        push!(next_coeffs, (a_ir, b_ir))
    end
    return next_coeffs
end

"""
All integrals are evaluated at upper bound = 1 and lower bound = y.
Notice that the evaluation at cancels most of the terms of each
integral, which is why most of the work involves evaluation at y.
"""
function int_log_k_div_x(k, y, u)
    return -(1 // (k + 1)) * u^(k + 1)
end

function int_log_k(k, y, u)
    value = BigInt(0) // BigInt(1)
    for r in 0:k
        value -= ((-1)^(k - r) // factorial(BigInt(r))) * u^r
    end
    value *= y * factorial(BigInt(k))
    value += factorial(BigInt(k)) * (-1)^k
    return value
end

function int_log_k_div_x_sq(k, y, u)
    value = BigInt(0) // BigInt(1)
    for r in 0:k
        value -= (1 // factorial(BigInt(r))) * u^r
    end
    value *= -factorial(BigInt(k)) // y
    value += -factorial(BigInt(k))
    return value
end

function int_s(prev_coeffs, z, u)
    value = BigInt(0) // BigInt(1)
    i = length(prev_coeffs) + 1
    for k in 0:(i - 2)
        value += prev_coeffs[k + 1][1] * int_log_k(k, z, u)
        value += prev_coeffs[k + 1][2] * int_log_k_div_x(k, z, u)
    end
    value *= BigInt(2)^(i - 1)
    return value
end

function int_t(prev_coeffs, z, u)
    value = BigInt(0) // BigInt(1)
    i = length(prev_coeffs) + 1
    for k in 0:(i - 2)
        value += prev_coeffs[k + 1][1] * int_log_k_div_x(k, z, u)
        value += prev_coeffs[k + 1][2] * int_log_k_div_x_sq(k, z, u)
    end
    value *= BigInt(2)^(i - 1)
    return value
end

function joint_probability(prev_coeffs, z, u)
    if length(prev_coeffs) == 0
        return 2 * z - z^2
    end
    return 2 * z * int_s(prev_coeffs, z, u) - z^2 * int_t(prev_coeffs, z, u)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    x = BigInt(40) // BigInt(1)

    # Algorithm parameters

    # Solution

    """
    Instead of directly computing the answer, we get a polynomial
    expression in terms of u = log(z). Then we evaluate the
    expression using BigFloats to avoid rounding issues.
    """
    _, u = PolynomialRing(QQ, "u")

    expression = BigInt(0) // BigInt(1)

    z = BigInt(1) / x
    prev_coeffs = [] 
    for i in 1:30
        expression += i * joint_probability(prev_coeffs, z, u)
        prev_coeffs = get_next_coefficients(prev_coeffs)
    end
    
    u_val = log(BigFloat(z))
    for k in 0:degree(expression)
        result += BigFloat(coeff(expression, k)) * u_val^k
    end

    result = Float64(result)

    # Show result
    @printf("%.10f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
