using Printf

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

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^6 - 1

    # Algorithm parameters

    # Solution
    slots = [true for _ in 1:limit]
    slots[1] = false
    for p in 2:limit
        if slots[p]
            for k in (p^2):p:limit
                slots[k] = false
            end

            d2 = 12 * p - 3
            d = isqrt(d2)
            if d^2 == d2 && mod(d - 3, 6) == 0
                a = fld(d - 3, 6)
                b = a + 1
                n = a^3
                m = b * a^2
                # println((p, n, m, n^3 + n^2 * p - m^3))
                result += 1
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
