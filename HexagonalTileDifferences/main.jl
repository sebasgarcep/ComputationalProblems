using Printf

function is_prime(n)
    if n == 1
        return false
    end
    if n == 2
        return true
    end
    if mod(n, 2) == 0
        return false
    end
    for k in 3:2:isqrt(n)
        if n % k == 0
            return false
        end
    end
    return true
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 2000

    # Algorithm parameters

    # Solution
    count = 0

    n = 1
    count += 1
    println(@sprintf("n = %d, c = %d", n, count))

    n = 2
    count += 1
    println(@sprintf("n = %d, c = %d", n, count))

    r = 3
    while count < 2000
        # Case n = d_r
        n = 2 + ((6 * (r - 2) * (r - 1)) >> 1)
        if (
            is_prime(6 * (r - 1) + 1) &&
            is_prime(6 * (r - 1) - 1) &&
            is_prime(6 * (2 * r - 1) - 1)
        )
            count += 1
            println(@sprintf("n = %d, c = %d", n, count))

            if count == limit
                result = n
            end
        end

        # Case n = u_r
        n = 1 + ((6 * (r - 1) * r) >> 1)

        if (
            is_prime(6 * (r - 1) - 1) &&
            is_prime(6 * (2 * r - 3) - 1) &&
            is_prime(6 * r - 1)
        )
            count += 1
            println(@sprintf("n = %d, c = %d", n, count))

            if count == limit
                result = n
            end
        end

        r += 1
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
