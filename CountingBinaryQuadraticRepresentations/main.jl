using Printf

function f(m)
    if m & 1 == 1
        return f(m - 1) + 1
    end
    return m >> 1
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^16

    # Algorithm parameters

    # Solution
    result += 2 * Int64(floor(sqrt(n / 163.0)))
    result += 2 * isqrt(n)
    y = 1
    while 163 * y^2 < n
        result += 4 * isqrt(n - 163 * y^2)
        y += 1
    end
    y = 1
    while 163 * y^2 < 4 * n
        if y & 1 == 1
            result += 4 * f(isqrt(4 * n - 163 * y^2))
        end
        y += 1
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
