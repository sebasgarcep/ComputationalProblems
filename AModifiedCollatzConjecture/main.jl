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
    prefix = "UDDDUdddDDUDDddDdDddDDUDDdUUDd"
    bound = Int128(10^15)

    # Algorithm parameters

    # Solution
    r = Int128(0)
    m = Int128(1)
    for c in reverse(prefix)
        m *= Int128(3)
        if c == 'D'
            r = mod(Int128(3) * r, m)
        elseif c == 'U'
            r = mod(invmod(Int128(4), m) * mod(Int128(3) * r - Int128(2), m), m)
        else
            r = mod(invmod(Int128(2), m) * mod(Int128(3) * r + Int128(1), m), m)
        end
    end

    offset = mod(r - (bound + 1), m)
    result = bound + 1 + offset

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
