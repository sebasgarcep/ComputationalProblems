using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^9

    # Algorithm parameters

    # Solution
    v = 1
    while 95 * v^2 <= 3 * 3 * 19 * limit
        u = v
        while true
            u += 1

            if 5 * u^2 + 34 * u * v + 56v^2 > 9 * limit
                break
            end

            if mod(u + v, 3) != 0
                continue
            end

            if gcd(u, v) != 1 && gcd(u, v) != 3
                continue
            end

            if mod(u - v, 19) == 0
                continue
            end

            x = fld(u^2 - v^2, 3)
            y = fld(2 * u * v + 17 * v^2, 3)

            if x > y
                continue
            end

            z = fld(5 * u^2 + 34 * u * v + 56 * v^2, 9)
            if gcd(x, y, z) != 1
                continue
            end
            
            result += x + y + z
        end

        u = v
        while true
            u += 19

            if 5 * u^2 + 34 * u * v + 56v^2 > 9 * 19 * limit
                break
            end

            if mod(u + v, 3) != 0
                continue
            end

            if gcd(u, v) != 1 && gcd(u, v) != 3
                continue
            end

            x = fld(u^2 - v^2, 3 * 19)
            y = fld(2 * u * v + 17 * v^2, 3 * 19)

            if x > y
                continue
            end

            z = fld(5 * u^2 + 34 * u * v + 56 * v^2, 9 * 19)
            if gcd(x, y, z) != 1
                continue
            end

            result += x + y + z
        end
        
        v += 1
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
