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

    # Algorithm parameters

    # Solution
    for k in 1:9
        for d in 1:9
            for r in 2:100
                eqn_size = BigInt(10)^r
                n = mod(-BigInt(d) * invmod(BigInt(10 * k - 1), eqn_size), eqn_size)
                if n >= fld(eqn_size, BigInt(10)) && 10 * k * n == (n - d) + d * eqn_size
                    result += mod(n, 10^5)
                    result = mod(result, 10^5)
                end
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
