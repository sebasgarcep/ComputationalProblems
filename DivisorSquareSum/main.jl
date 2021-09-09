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
    n = 64 * 10^6 - 1

    # Algorithm parameters
    bound = n

    # Solution
    sigma_2_memo = [1 for _ in 1:n]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            acc = p
            factor = 1
            while acc <= n
                factor += acc^2
                for k in acc:acc:bound
                    if mod(k, acc * p) == 0
                        continue
                    end
                    sigma_2_memo[k] *= factor
                end
                acc *= p
            end
        end
    end

    max_val = maximum(sigma_2_memo)
    squares = Set([i^2 for i in 1:isqrt(max_val)])
    result = sum([i for (i, x) in enumerate(sigma_2_memo) if x in squares])

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
