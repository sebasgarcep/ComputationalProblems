using Printf
using LinearAlgebra

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

function angle(p)
    (x, y) = p
    if x == 0 && y == 0
        return nothing
    end
    if x == 0
        return y > 0 ? pi / 2.0 : -pi / 2.0
    end
    theta = atan(Float64(y) / Float64(x))
    if x < 0
        return theta + pi
    end
    return theta
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 105

    # Algorithm parameters

    # Solution
    points = []

    for x in 1:min(n - 1)
        for y in 1:isqrt(n^2 - 1 - x^2)
            push!(points, (x, y))
            push!(points, (-x, y))
            push!(points, (x, -y))
            push!(points, (-x, -y))
        end
    end

    for x in 1:min(n - 1)
        push!(points, (x, 0))
        push!(points, (0, x))
        push!(points, (-x, 0))
        push!(points, (0, -x))
    end

    group_counts = Dict()
    for p in points
        (x, y) = p
        g = gcd(x, y)
        pg = (fld(x, g), fld(y, g))
        if !haskey(group_counts, pg)
            group_counts[pg] = 0
        end
        group_counts[pg] += 1
    end

    group_representatives = [k for k in keys(group_counts)]
    sort!(group_representatives, by = angle)

    group_index = Dict()
    for i in 1:length(group_representatives)
        p = group_representatives[i]
        group_index[p] = i
    end

    group_count_memo = [group_counts[p] for p in group_representatives]
    group_count_sum = zeros(Int64, length(group_representatives), length(group_representatives))
    total_count = length(points)
    for i in 1:(length(group_representatives) - 1)
        total = 0
        for j in i:length(group_representatives)
            total += group_count_memo[j]
            group_count_sum[i, j] = total
        end
    end

    for i in 1:(length(group_representatives) - 1)
        for j in (i + 1):length(group_representatives)
            p_i = group_representatives[i]
            p_j = group_representatives[j]
            (xi, yi) = p_i
            (xj, yj) = p_j
            if xj * yi == xi * yj
                continue
            end
            complement_i = (-xi, -yi)
            complement_j = (-xj, -yj)
            pos_complement_i = group_index[complement_i]
            pos_complement_j = group_index[complement_j]
            if abs(angle(complement_i) - angle(complement_j)) < pi
                min_pos = min(pos_complement_i, pos_complement_j) + 1
                max_pos = max(pos_complement_i, pos_complement_j) - 1
                result += group_counts[p_i] * group_counts[p_j] * sum(group_count_sum[min_pos, max_pos])
            else
                min_pos = min(pos_complement_i, pos_complement_j)
                max_pos = max(pos_complement_i, pos_complement_j)
                result += group_counts[p_i] * group_counts[p_j] * (total_count - sum(group_count_sum[min_pos, max_pos]))
            end
        end
    end

    result = fld(result, 3)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
