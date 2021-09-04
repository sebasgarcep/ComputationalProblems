using Printf

function iroot(a, b)
    if b == 1
        return Int128(a)
    end

    if b == 2
        return Int128(isqrt(a))
    end

    test_value = Int128(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + Int128(1)
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int128(10)^18

    # Algorithm parameters
    bound = iroot(n, 3)

    # Solution
    prime_list = []

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in Int128(2):bound
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            push!(prime_list, p)
        end
    end

    function explore(acc, start)
        value = fld(n, acc)
        for pos in start:length(prime_list)
            next_acc = acc * prime_list[pos]^3
            if next_acc > n
                break
            end
            while next_acc <= n
                value += explore(next_acc, pos + 1)
                next_acc *= prime_list[pos]
            end
        end
        return value
    end

    result = explore(Int128(1), 1)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
