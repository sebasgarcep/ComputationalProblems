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
    bound = 10^6

    # Solution
    pi_memo = [0 for _ in 1:bound]
    primes = []
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        pi_memo[p] = pi_memo[p - 1]
        if slots[p]
            pi_memo[p] += 1
            push!(primes, p)
            for k in (p^2):p:bound
                slots[k] = false
            end
        end
    end

    # These functions require list of primes and must be memoized
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
        if x <= 0
            return 0
        end

        # Binary search
        if x <= bound
            return pi_memo[x]
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

    function calc_s(n)
        val = 0
        if n >= 1
            val += meissel_lehmer_prime_counting(n)
        end
        if n >= 2
            val += (n >> 1) - 1 + meissel_lehmer_prime_counting(n - 2) - (n >= 4 ? 1 : 0)
        end
        if n >= 3
            val += (n + 1) * ((n >> 1) - 2) - (n >> 1) * ((n >> 1) + 1) + 6
        end
        return val
    end

    fa, fb = 0, 1
    for idx in 1:44
        fa, fb = fb, fa + fb
        if idx >= 3
            result += calc_s(fa)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
