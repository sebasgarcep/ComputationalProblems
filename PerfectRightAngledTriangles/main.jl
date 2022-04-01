using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^16

    # Algorithm parameters
    u = 2
    while (u^2 + 1)^2 <= limit
        v = 1
        while v < u && (u^2 + v^2)^2 <= limit
            if mod(u - v, 2) != 0 && gcd(u, v) == 1
                m = u^2 - v^2
                n = 2 * u * v
                d = u^2 + v^2
                m, n = max(m, n), min(m, n)
                a = m^2 - n^2
                b = 2 * m * n
                c = m^2 + n^2
                if mod(Int128(a) * Int128(b), 168) != 0
                    result += 1
                end
            end
            v += 1
        end
        u += 1
    end

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
