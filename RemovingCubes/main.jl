using Printf

function s(memo, n)
    if n == 0
        return 0
    end

    if n <= length(memo) && memo[n] != -1
        return memo[n]
    end

    m = 1
    while (m + 1)^3 <= n
        m += 1
    end

    value = s(memo, n - m^3) + n - m^3 + 1
    for k in 1:(m - 1)
        value += s(memo, 3 * k^2 + 3 * k) + 3 * k^2 + 3 * k + 1
    end

    if n <= length(memo)
        memo[n] = value
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^17

    # Algorithm parameters
    t = 10^9

    # Solution
    memo = [-1 for _ in 1:t]
    memo[1] = 1

    result = s(memo, n - 1)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
