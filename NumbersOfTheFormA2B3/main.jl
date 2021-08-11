using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int64(9e18)

    # Algorithm parameters
    bound = iroot(n, 3)

    # Solution
    mu_memo = [1 for _ in 1:bound]
    
    # Sieve
    primes = []
    divisors = [[1] for _ in 1:bound]

    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            push!(primes, p)
            for k in (2 * p):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                mu_memo[k] *= -1
                divisors[k] = vcat(divisors[k], p * divisors[k])
            end

            p_2 = p * p
            for k in p_2:p_2:bound
                mu_memo[k] = 0
                divisors[k] = []
            end
        end
    end

    function primecount(x)
        min_idx = 1
        max_idx = length(primes)

        while max_idx - min_idx > 1
            test_idx = fld(min_idx + max_idx, 2)
            if primes[test_idx] == x
                return test_idx
            elseif primes[test_idx] < x
                min_idx = test_idx
            else
                max_idx = test_idx
            end
        end

        if primes[max_idx] > x
            return min_idx
        end

        return max_idx
    end

    function q(x)
        value = 0
        for d in 1:isqrt(x)
            value += mu_memo[d] * fld(x, d * d)
        end
        return value
    end

    function p(x)
        value = 0
        for i in 1:iroot(x, 3)
            if mu_memo[i] == 0
                continue
            end
            value += isqrt(fld(x, i^3))
        end
        return value
    end

    function q_coprime(u, l)
        if l <= 0
            return 0
        end
        if u == 1
            return q(l)
        end
        value = 0
        for d in divisors[u]
            value += mu_memo[d] * q_coprime(d, fld(l, d))
        end
        return value
    end

    function f(x)
        f_prime = primecount(iroot(x, 6)) + q(iroot(x, 3)) - 1
        
        for u in 1:iroot(x, 4)
            if mu_memo[u] == 0
                continue
            end
            l = fld(isqrt(x), u^2)
            f_prime += q_coprime(u, l)
        end

        return p(x) - f_prime
    end

    result = f(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
