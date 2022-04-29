using Printf

function f(n, k)
    return exp(Float64(k) / Float64(n)) - 1.0
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10000

    # Algorithm parameters

    # Solution
    max_k = Int64(ceil(n * log(1 + pi)))
    f_memo = [f(n, k) for k in 1:max_k]

    # Generate the list of a, b
    values = []
    values_a = []
    values_b = []
    sizehint!(values, max_k^2)
    sizehint!(values_a, max_k^2)
    sizehint!(values_b, max_k^2)
    for a in 1:max_k
        for b in a:max_k
            half_v = f_memo[a] + f_memo[b]
            push!(values, half_v)
            push!(values_a, a)
            push!(values_b, b)
        end
    end

    sort_indexes = zeros(Int64, length(values))
    sortperm!(sort_indexes, values)

    values = values[sort_indexes]
    values_a = values_a[sort_indexes]
    values_b = values_b[sort_indexes]

    # For each c, d find optimal a, b
    min_e = nothing
    for c in 1:max_k
        for d in c:max_k
            half_v = f_memo[c] + f_memo[d]
            # The error from this half_v will end up being larger than min_e
            if min_e != nothing && half_v > pi + min_e
                continue
            end
            test = pi - half_v
            lower = 1
            upper = length(values)
            while upper - lower > 1
                midpoint = (lower + upper) >> 1
                if values[midpoint] < test
                    lower = midpoint
                else
                    upper = midpoint
                end
            end
            v_lower = half_v + values[lower]
            v_upper = half_v + values[upper]
            if abs(v_lower - pi) < abs(v_upper - pi)
                if min_e === nothing || min_e > abs(v_lower - pi)
                    min_e = abs(v_lower - pi)
                    a = values_a[lower]
                    b = values_b[lower]
                    result = a^2 + b^2 + c^2 + d^2
                end
            else
                if min_e === nothing || min_e > abs(v_upper - pi)
                    min_e = abs(v_upper - pi)
                    a = values_a[upper]
                    b = values_b[upper]
                    result = a^2 + b^2 + c^2 + d^2
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
