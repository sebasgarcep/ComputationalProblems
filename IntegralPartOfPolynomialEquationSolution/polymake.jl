using Printf

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

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 4

    # Algorithm parameters

    # Solution
    count = 0
    open("lattice_points.txt") do io
        while !eof(io)
            count += 1
            line = readline(io)
            coeffs = [parse(Int64, i) for i in split(line, " ")]
            if is_compliant(n, coeffs)
                result += sum([abs(c) for c in coeffs]) - 1
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
