using Printf
using Memoize

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

function f(p, r, n)
    return Int64(fld(n, Int128(p)^r) - fld(n, Int128(p)^(r + 1)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = 10^8

    # Solution

    # Prime sieve
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

    @memoize function meissel_lehmer_prime_counting(x)
        # Binary search
        if x <= bound
            return binary_prime_counting(x)
        end

        # Enumeration constants
        a = binary_prime_counting(iroot(x, 4))
        b = binary_prime_counting(iroot(x, 2))
        c = binary_prime_counting(iroot(x, 3))

        # Base answer
        res = a - 1 + phi(x, a)

        # Calculate P2(x, a)
        res -= binomial(a, 2) - binomial(b, 2)
        for i in (a + 1):b
            x_div_p = fld(x, primes[i])
            res -= meissel_lehmer_prime_counting(x_div_p)
            # Calculate P3(x, a)
            if i <= c
                bi = binary_prime_counting(isqrt(x_div_p))
                for j in i:bi
                    res -= meissel_lehmer_prime_counting(fld(x_div_p, primes[j])) - (j - 1)
                end
            end
        end

        return res
    end

    # Calculate the sum for p <= sqrt(N)
    result = BigInt(0)

    limit = isqrt(n)
    for p in primes
        if p > limit
            break
        end
        x = 1
        while true
            f_x = f(p, x, n)
            if f_x <= 0
                break
            end
            for y in 0:(x - 1)
                f_y = f(p, y, n)
                result += 2 * (x - y) * mod(mod(f_x, mod_size) * mod(f_y, mod_size), mod_size)
                result = mod(result, mod_size)
            end
            x += 1
        end
    end

    # Calculate the sum for p > sqrt(N)
    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in 1:max_u
        result += 2 * mod(mod(mod(u, mod_size) * mod(n - u, mod_size), mod_size) * mod(meissel_lehmer_prime_counting(fld(n, u)) - meissel_lehmer_prime_counting(fld(n, u + 1)), mod_size), mod_size)
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
