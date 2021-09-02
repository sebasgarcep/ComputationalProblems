using Printf
using Memoize

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit_inferior = 10000000
    limit_superior = 10010000
    mod_size = 1000000007

    # Algorithm parameters
    bound = limit_superior
    factorial_bound = 10010000 + 5000

    # Solution
    factorial_memo = [1]
    for i in 1:factorial_bound
        push!(factorial_memo, mod(factorial_memo[i] * mod(i, mod_size), mod_size))
    end

    function binomial_mod(n, k, p)
        if k < 0 || k > n
            return 0
        end
        if k > n - k
            return binomial_mod(n, n - k, p)
        end
        value = 1
        value *= factorial_memo[n + 1]
        value = mod(value, mod_size)
        value *= invmod(factorial_memo[k + 1], mod_size)
        value = mod(value, mod_size)
        value *= invmod(factorial_memo[n - k + 1], mod_size)
        value = mod(value, mod_size)
        return value
    end
    
    function g(n, p)
        value = 0
    
        limits = []
        b = 0
        while n^2 >= (b + 1)^2 * n
            a_limit = isqrt((b + 1)^2 * n)
            if a_limit^2 == (b + 1)^2 * n
                a_limit -= 1
            end
            push!(limits, a_limit)
            b += 1
        end
        push!(limits, n)
        
        value += 1
        for k in 2:length(limits)
            b = k - 1
            value += binomial_mod(n - limits[k - 1] - 1 + b, b, p)
            value = mod(value, p)
        end
    
        return value
    end

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            if limit_inferior < p && p < limit_superior
                result += g(p, mod_size)
                result = mod(result, mod_size)
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
