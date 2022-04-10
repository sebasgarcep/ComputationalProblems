using Printf
using Combinatorics
using Base.Iterators

function evaluate(p, x)
    value = 0
    for (c, n) in zip(p, (length(p) - 1):-1:0)
        value += c * x^n
    end
    return value
end

function derivative(p)
    return [n * c for (c, n) in zip(p[1:(length(p) - 1)], (length(p) - 1):-1:1)]
end

function factor(p, r)
    q = [0 for _ in 1:(length(p) - 1)]
    q[length(q)] = -fld(p[length(p)], r)
    for i in (length(q) - 1):-1:2
        q[i] = -fld(p[i + 1] - q[i + 1], r)
    end
    q[1] = p[1]
    return q
end

function is_compliant(n, p)
    # Check p has no root on n+1 from the inequality g(n+1)>=0
    if evaluate(p, n + 1) == 0
        return false
    end

    p_x = derivative(p)
    range_roots = [0 for _ in 1:n]
    for k in 1:n
        if evaluate(p, k) == 0
            # Check if p is squarefree by checking if k is a root of the derivative of p
            if evaluate(p_x, k) == 0
                return false
            end
            range_roots[k] += 1
            # Factor out integer root
            p = factor(p, k)
        end
    end

    # Check out sign changes in ranges
    for k in 1:n
        if sign(evaluate(p, k)) != sign(evaluate(p, k + 1))
            range_roots[k] += 1
            if range_roots[k] > 1
                return false
            end
        end
    end

    return true
end

function remove_redundant_constraints_linear_integer_inequalities(a, b)
    return a, b
end

function reduce_linear_integer_inequalities(a, b)
    (m, n) = size(a)
    
    a_l = a[a[:, n] .< 0, :]
    a_u = a[a[:, n] .> 0, :]
    a_z = a[a[:, n] .== 0, :]

    b_l = b[a[:, n] .< 0]
    b_u = b[a[:, n] .> 0]
    b_z = b[a[:, n] .== 0]

    max_s = length(b_l)
    max_t = length(b_u)
    max_z = length(b_z)

    a_r = zeros(Int64, max_s * max_t + max_z, n - 1)
    for s in 1:max_s
        for t in 1:max_t
            a_i_s = abs(a_l[s, n])
            a_i_t = abs(a_u[t, n])
            a_i_r = lcm(a_i_s, a_i_t)
            a_r[(s - 1) * max_t + t, :] = a_l[s, 1:(n - 1)] * fld(a_i_r, a_i_s) + a_u[t, 1:(n - 1)] * fld(a_i_r, a_i_t)
        end
    end
    a_r[(max_s * max_t + 1):(max_s * max_t + max_z), :] = a_z[:, 1:(n - 1)]

    b_r = zeros(Int64, max_s * max_t + max_z)
    for s in 1:max_s
        for t in 1:max_t
            a_i_s = abs(a_l[s, n])
            a_i_t = abs(a_u[t, n])
            a_i_r = lcm(a_i_s, a_i_t)
            b_r[(s - 1) * max_t + t] = b_l[s] * fld(a_i_r, a_i_s) + b_u[t] * fld(a_i_r, a_i_t)
        end
    end
    b_r[(max_s * max_t + 1):(max_s * max_t + max_z)] = b_z

    return remove_redundant_constraints_linear_integer_inequalities(a_r, b_r)
end

function solve_linear_integer_inequalities_1d(a, b)
    lower = nothing
    upper = nothing
    for i in 1:length(a)
        if a[i] == 0
            if b[i] < 0
                return nothing, nothing
            end
        elseif a[i] < 0
            next_lower = cld(b[i], a[i])
            if lower == nothing || next_lower > lower
                lower = next_lower
            end
        else
            next_upper = fld(b[i], a[i])
            if upper == nothing || next_upper < upper
                upper = next_upper
            end
        end
        if lower != nothing && upper != nothing && lower > upper
            return nothing, nothing
        end
    end
    return lower, upper
end

function solve_linear_integer_inequalities_naive(a, b, bounds)
    (m, n) = size(a)
    solutions = []
    iterator = product([lower:upper for (lower, upper) in bounds[1:n]]...)

    for t in iterator
        x = collect(t)
        skip = false
        for k in 1:m
            if a[k, :]'x > b[k] # a[k, :] * x > b[k] in Julia's weird notation
                skip = true
                break
            end
        end
        if !skip
            push!(solutions, x)
        end
    end

    return solutions
end

function solve_linear_integer_inequalities(a, b, bounds = nothing, manual_checks_limit = 10^7)
    (m, n) = size(a)
    if bounds != nothing
        log_manual_checks = sum([log(upper - lower + 1) for (lower, upper) in bounds[1:n]])
        if log_manual_checks <= log(manual_checks_limit)
            return solve_linear_integer_inequalities_naive(a, b, bounds)
        end
    end
    if n == 1
        lower, upper = solve_linear_integer_inequalities_1d(a, b)
        return [[x] for x in lower:upper]
    end
    a_r, b_r = reduce_linear_integer_inequalities(a, b)
    lattice_points = solve_linear_integer_inequalities(a_r, b_r, bounds)
    solutions = []
    a_curr = a[:, n]
    a_prev = a[:, 1:(n - 1)]
    for p in lattice_points
        b_curr = b - a_prev * p
        lower, upper = solve_linear_integer_inequalities_1d(a_curr, b_curr)
        for x in lower:upper
            push!(solutions, vcat(p, x))
        end
    end
    return solutions
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 7

    # Algorithm parameters

    # Solution
    
    # Create the restriction matrix and vector
    a = zeros(Int64, n + 1, n)
    b = zeros(Int64, n + 1)

    # Use bounds on g(x)
    s = -1
    for k in (n + 1):-1:1
        for r in (n - 1):-1:0
            a[n + 2 - k, n - r] = s * k^r
        end
        b[n + 2 - k] = -s * k^n
        s *= -1
    end

    # Calculate individual bounds using Vieta's formulas
    bounds = []
    for k in 1:n
        lower = sum([prod(item) for item in combinations(1:n, k)])
        upper = sum([prod(item) for item in combinations(2:(n + 1), k)]) - 1
        if mod(k, 2) == 0
            push!(bounds, (lower, upper))
        else
            push!(bounds, (-upper, -lower))
        end
    end

    # Solve Ax <= b
    for p in solve_linear_integer_inequalities(a, b, bounds)
        coeffs = vcat(1, p)
        if is_compliant(n, coeffs)
            result += sum([abs(c) for c in coeffs]) - 1
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
