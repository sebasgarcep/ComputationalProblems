using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^16
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    factor_count = [0 for _ in 1:bound]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false

    for p in 1:bound
        if slots[p]
            factor_count[p] = 1

            for k in (2 * p):p:bound
                slots[k] = false

                if factor_count[k] >= 0
                    factor_count[k] += 1
                end
            end

            p_2 = p * p
            for k in p_2:p_2:bound
                factor_count[k] = -1
            end
        end
    end

    distribution = []
    for k in 1:bound
        if factor_count[k] < 0
            continue
        end
        position = factor_count[k] + 1
        if position > length(distribution)
            push!(distribution, 0)
        end
        term = mod(fld(n, k * k), mod_size)
        distribution[position] = mod(distribution[position] + term, mod_size)
    end

    pascal_triangle = [[1]]
    for i in 1:(length(distribution) - 1)
        push!(pascal_triangle, [0 for _ in 0:i])
        for j in 0:i
            if j == 0
                t1 = 0
            else
                t1 = pascal_triangle[i][j]
            end

            if j == i
                t2 = 0
            else
                t2 = pascal_triangle[i][j + 1]
            end

            pascal_triangle[i + 1][j + 1] = mod(t1 + t2, mod_size)
        end
    end

    solution = [0 for _ in 0:(length(distribution) - 1)]
    for k in 0:(length(distribution) - 1)
        for i in k:(length(distribution) - 1)
            term = (-1)^(i - k) * mod(pascal_triangle[i + 1][k + 1] * distribution[i + 1], mod_size)
            term = mod(term, mod_size)
            solution[k + 1] = mod(solution[k + 1] + term, mod_size)
        end
    end

    result = 1
    for k in 0:(length(solution) - 1)
        result = mod(result * solution[k + 1], mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
