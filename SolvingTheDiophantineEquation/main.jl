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
    max_n = 9

    # Algorithm parameters
    bound = isqrt(2 * 10^max_n)

    # Solution
    prime_list = []
    
    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            push!(prime_list, p)
        end
    end

    function num_divisors(x)
        value = 1
        for p in prime_list
            if p^2 > x
                break
            end
            if mod(x, p) != 0
                continue
            end
            exponent = 0
            while mod(x, p) == 0
                x = fld(x, p)
                exponent += 1
            end
            value *= exponent + 1
            if x == 1
                break
            end
        end
        if x > 1
            value *= 2
        end
        return value
    end

    for n in 1:max_n
        acc_u = 1
        for u in 0:(2 * n)
            for v in 0:(2 * n)
                if 2^u * 5^v > 10^n
                    break
                end
                a = 2^u * 5^v + 10^n
                b = fld(10^n * a, a - 10^n)
                g = gcd(a, b)
                result += num_divisors(g)
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
