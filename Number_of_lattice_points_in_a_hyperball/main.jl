using Printf

function sum_sigma(n, modval)
    n = Int128(n)
    total = Int128(0)
    # Find the threshold where to divide both sums
    k = Int128(ceil(sqrt(n)))
    while div(n, k)^2 <= n
        k -= 1
    end
    k += 1
    # Solution for d < k
    for d in Int128(1):Int128(k - 1)
        total = mod(total + d * div(n, d), modval)
    end
    # Solution for d >= k
    for m in Int128(1):Int128(div(n, k))
        lower_lim = div(n, m + 1) + 1
        upper_lim = div(n, m)
        lower_sum = div(lower_lim * (lower_lim - 1), 2)
        upper_sum = div(upper_lim * (upper_lim + 1), 2)
        total = mod(total + m * (upper_sum - lower_sum), modval)
    end
    return total
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = (10^8)^2
    modval = 1000000007

    # Algorithm parameters

    # Solution

    # Solution for n = 0
    result += 1
    result += 8 * sum_sigma(limit, modval)
    result = mod(result, modval)
    result -= 32 * sum_sigma(div(limit, 4), modval)
    result = mod(result, modval)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
