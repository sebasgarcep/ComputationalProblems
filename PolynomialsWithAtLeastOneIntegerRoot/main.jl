using Printf

function evaluate(p, x)
    value = 0
    y = 1
    for c in p
        value += c * y
        y *= x
    end
    return value
end

function recursive_count_roots_mitm_lhs(k, dss, rss, counter, pos, acc)
    if pos > k - 1
        next_acc = rss .+ dss .* acc
        if !haskey(counter, next_acc)
            counter[next_acc] = 0
        end
        counter[next_acc] += 1
        return
    end
    for a_i in 0:9
        next_pos = pos + 2
        next_acc = (dss .^ 2) .* acc .+ a_i
        recursive_count_roots_mitm_lhs(k, dss, rss, counter, next_pos, next_acc)
    end
end

function recursive_count_roots_mitm_rhs(k, dss, counter, pos, acc)
    if pos > k - 1
        if haskey(counter, acc)
            return counter[acc]
        end
        return 0
    end
    count = 0
    for a_i in 0:9
        next_pos = pos + 2
        next_acc = (dss .^2) .* acc .+ a_i
        count += recursive_count_roots_mitm_rhs(k, dss, counter, next_pos, next_acc)
    end
    return count
end

function count_roots_mitm(k, a_0, dss)
    rss = fld.(a_0, dss)
    counter = Dict()
    sizehint!(counter, 10^fld(k, 2))
    recursive_count_roots_mitm_lhs(k, dss, rss, counter, 2, dss .* 0)
    return recursive_count_roots_mitm_rhs(k, dss, counter, 1, dss .* 0)
end

function build_p_n(a_0, lhs_coeffs, rhs_coeffs)
    p_n = [a_0]
    i = 1
    j = 1
    while i <= length(lhs_coeffs) || j <= length(rhs_coeffs)
        if j <= length(rhs_coeffs)
            push!(p_n, rhs_coeffs[j])
        end
        j += 1
        if i <= length(lhs_coeffs)
            push!(p_n, lhs_coeffs[i])
        end
        i += 1
    end
    return p_n
end

function recursive_count_roots_base(k, a_0, dss, d, r, pos, acc, lhs_coeffs)
    if pos > k - 1
        next_acc = r + d * acc
        rhs_coeffs = digits(next_acc, base = d^2)
        if length(rhs_coeffs) > fld(k, 2)
            return 0
        end
        for a_i in rhs_coeffs
            if a_i >= 10
                return 0
            end
        end
        p_n = build_p_n(a_0, lhs_coeffs, rhs_coeffs)
        for d in dss
            if evaluate(p_n, -d) != 0
                return 0
            end
        end
        return 1
    end
    count = 0
    for a_i in 0:9
        next_pos = pos + 2
        next_acc = d^2 * acc + a_i
        next_lhs_coeffs = [a_i, lhs_coeffs...]
        count += recursive_count_roots_base(k, a_0, dss, d, r, next_pos, next_acc, next_lhs_coeffs)
    end
    return count
end

function count_roots_base(k, a_0, dss)
    d = max(dss...)
    r = fld(a_0, d)
    return recursive_count_roots_base(k, a_0, dss, d, r, 2, 0, [])
end

function count_roots(k, a_0, dss...)
    println("counting n with parameters ", (k, a_0, dss...))
    if max(dss...)^2 >= 10
        return count_roots_base(k, a_0, dss)
    else
        return count_roots_mitm(k, a_0, dss)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k = 16

    # Algorithm parameters

    # Solution

    # a_0 = 0
    result += 10^(k - 1)

    # a_0 = 1
    result += count_roots(k, 1, 1)

    # a_0 = p = 2, 3, 5, 7
    for p in [2, 3, 5, 7]
        result += count_roots(k, p, 1)
        result += count_roots(k, p, p)
        result -= count_roots(k, p, 1, p)
    end

    # a_0 = 4
    result += count_roots(k, 4, 1)
    result += count_roots(k, 4, 2)
    result += count_roots(k, 4, 4)
    result -= count_roots(k, 4, 1, 2)
    result -= count_roots(k, 4, 1, 4)

    # a_0 = 6
    result += count_roots(k, 6, 1)
    result += count_roots(k, 6, 2)
    result += count_roots(k, 6, 3)
    result += count_roots(k, 6, 6)
    result -= count_roots(k, 6, 1, 2)
    result -= count_roots(k, 6, 1, 3)
    result -= count_roots(k, 6, 1, 6)
    result -= count_roots(k, 6, 2, 3)
    result += count_roots(k, 6, 1, 2, 3)

    # a_0 = 8
    result += count_roots(k, 8, 1)
    result += count_roots(k, 8, 2)
    result += count_roots(k, 8, 4)
    result += count_roots(k, 8, 8)
    result -= count_roots(k, 8, 1, 2)
    result -= count_roots(k, 8, 1, 4)
    result -= count_roots(k, 8, 1, 8)
    result -= count_roots(k, 8, 2, 4)
    result += count_roots(k, 8, 1, 2, 4)

    # a_0 = 9
    result += count_roots(k, 9, 1)
    result += count_roots(k, 9, 3)
    result += count_roots(k, 9, 9)
    result -= count_roots(k, 9, 1, 3)
    result -= count_roots(k, 9, 1, 9)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
