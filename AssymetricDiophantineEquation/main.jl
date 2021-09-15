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
    z_max = 10^16
    mod_size = 10^9

    # Algorithm parameters
    # y is odd
    limit = isqrt(z_max)
    for u in 2:iroot(z_max, 4)
        for v in 1:(u - 1)
            if u^2 + v^2 > limit
                break
            end
            if (u & 1 == 1 && v & 1 == 1) || (u & 1 == 0 && v & 1 == 0) || gcd(u, v) != 1
                continue
            end
            y = u^2 - v^2
            n = 2 * u * v
            m = u^2 + v^2
            x = (m * n) >> 1
            z = m^2 + n^2
            if z <= z_max
                result += mod(x, mod_size) + mod(y, mod_size) + mod(z, mod_size)
                result = mod(result, mod_size)
            end
        end
    end

    # y is even and u = v = 1
    x = 3
    y = 4
    z = 20
    if z <= z_max
        result += mod(x, mod_size) + mod(y, mod_size) + mod(z, mod_size)
        result = mod(result, mod_size)
    end

    # y is even and u > v and u > 1
    for u in 2:iroot(z_max, 4)
        for v in 1:(u - 1)
            if u^2 + v^2 > limit
                break
            end
            if (u & 1 == 0 && v & 1 == 0) || gcd(u, v) != 1
                continue
            end
            if u & 1 == 1 && u^2 > 2 * v^2
                m = u^2
                n = 2 * v^2
                x = m^2 - n^2
                y = 4 * u * v
                z = 4 * (m^2 + n^2)
                if z <= z_max
                    result += mod(x, mod_size) + mod(y, mod_size) + mod(z, mod_size)
                    result = mod(result, mod_size)
                end
            end
            if u & 1 == 1 && 2 * v^2 > u^2
                m = 2 * v^2
                n = u^2
                x = m^2 - n^2
                y = 4 * u * v
                z = 4 * (m^2 + n^2)
                if z <= z_max
                    result += mod(x, mod_size) + mod(y, mod_size) + mod(z, mod_size)
                    result = mod(result, mod_size)
                end
            end
            if v & 1 == 1 && 2 * u^2 > v^2
                m = 2 * u^2
                n = v^2
                x = m^2 - n^2
                y = 4 * u * v
                z = 4 * (m^2 + n^2)
                if z <= z_max
                    result += mod(x, mod_size) + mod(y, mod_size) + mod(z, mod_size)
                    result = mod(result, mod_size)
                end
            end
        end
    end

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
