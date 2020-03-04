using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = BigInt(10)^100
    k_max = 100

    # Algorithm parameters

    # Solution
    for k in 1:k_max
        c0 = 1
        while 2 * c0 < 7 * k && c0 <= n
            z0_2 = 12 * c0^2 - 3 * k^2
            if z0_2 < 0
                c0 += 1
                continue
            end
            z0 = isqrt(z0_2)
            if z0^2 != z0_2
                c0 += 1
                continue
            end
            z = BigInt(z0)
            c = BigInt(c0)
            while c <= n
                a_num = -3 * k + z
                if a_num > 0 && mod(a_num, 6) == 0
                    result += 1
                end
                z, c = 7 * z + 24 * c, 2 * z + 7 * c
            end
            c0 += 1
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
