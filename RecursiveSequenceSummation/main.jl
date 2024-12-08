using Printf

function calc_s(memo_limit, memo_a, memo_s, memo_s_o, n)
    if n <= memo_limit
        return memo_s[n]
    end
    result = 0
    acc = 1
    while n > 0
        result += acc * calc_s_o(memo_limit, memo_a, memo_s, memo_s_o, n)
        n = n >> 1
        acc = acc << 1
    end
    return result
end

function calc_s_o(memo_limit, memo_a, memo_s, memo_s_o, n)
    if n <= memo_limit
        return memo_s_o[n]
    end
    return (
        4
        - 3 * calc_a(memo_limit, memo_a, calc_q(n) + 1)
        - 2 * calc_s(memo_limit, memo_a, memo_s, memo_s_o, calc_q(n))
    )
end

function calc_a(memo_limit, memo_a, n)
    if n <= memo_limit
        return memo_a[n]
    end
    if n & 1 == 0
        return 2 * calc_a(memo_limit, memo_a, n >> 1)
    else
        return (
            calc_a(memo_limit, memo_a, n >> 1)
            - 3 * calc_a(memo_limit, memo_a, (n >> 1) + 1)
        )
    end
end

function calc_q(n)
    return (n - 1) >> 1
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12

    # Algorithm parameters
    memo_limit = 10^7

    # Solution
    memo_a = Vector{Int64}(undef, memo_limit)
    memo_s = Vector{Int64}(undef, memo_limit)
    memo_s_o = Vector{Int64}(undef, memo_limit)

    # Memoize
    memo_a[1] = 1
    memo_s[1] = memo_a[1]
    memo_s_o[1] = memo_a[1]
    for i in 2:memo_limit
        if i & 1 == 0
            memo_a[i] = 2 * memo_a[i >> 1]
            memo_s_o[i] = memo_s_o[i - 1]
        else
            memo_a[i] = memo_a[i >> 1] - 3 * memo_a[(i >> 1) + 1]
            memo_s_o[i] = memo_s_o[i - 1] + memo_a[i]
        end
        memo_s[i] = memo_s[i - 1] + memo_a[i]
    end

    result = calc_s(memo_limit, memo_a, memo_s, memo_s_o, n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
