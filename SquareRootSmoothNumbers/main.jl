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
    n = 10^10

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            push!(primes, p)
        end
    end

    # These functions require list of primes and must be memoized
    function binary_prime_counting(x)
        if x < primes[1]
            return 0
        end
        lower = 1
        upper = length(primes)
        while upper - lower > 1
            middle = fld(lower + upper, 2)
            if primes[middle] == x
                lower = middle
                upper = middle
            elseif primes[middle] < x
                lower = middle
            else
                upper = middle
            end
        end
        if primes[upper] <= x
            return upper
        else
            return lower
        end
    end

    function phi(x, a)
        # Base cases
        if a == 0
            return x
        elseif x <= primes[a]
            return 1
        elseif a == 1
            return x - fld(x, 2)
        elseif a == 2
            return x - fld(x, 2) - fld(x, 3) + fld(x, 6)
        end
        res = x - fld(x, 2) - fld(x, 3) - fld(x, 5) + fld(x, 6) + fld(x, 10) + fld(x, 15) - fld(x, 30)
        for ai in 3:(a - 1)
            res -= phi(fld(x, primes[ai + 1]), ai)
        end
        return res
    end

    function meissel_lehmer_prime_counting(x)
        # Binary search
        if x <= bound
            return binary_prime_counting(x)
        end

        # Enumeration constants
        a = meissel_lehmer_prime_counting(iroot(x, 4))
        b = meissel_lehmer_prime_counting(iroot(x, 2))
        c = meissel_lehmer_prime_counting(iroot(x, 3))

        # Base answer
        res = a - 1 + phi(x, a)

        # Calculate P2(x, a)
        res -= binomial(a, 2) - binomial(b, 2)
        for i in (a + 1):b
            x_div_p = fld(x, primes[i])
            res -= meissel_lehmer_prime_counting(x_div_p)
            # Calculate P3(x, a)
            if i <= c
                bi = meissel_lehmer_prime_counting(isqrt(x_div_p))
                for j in i:bi
                    res -= meissel_lehmer_prime_counting(fld(x_div_p, primes[j])) - (j - 1)
                end
            end
        end

        return res
    end

    for p in primes
        result += p
    end

    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    result += meissel_lehmer_prime_counting(n)
    result -= max_u * meissel_lehmer_prime_counting(fld(n, max_u + 1))
    for u in 2:max_u
        result += meissel_lehmer_prime_counting(fld(n, u))
    end

    result = n - result

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
