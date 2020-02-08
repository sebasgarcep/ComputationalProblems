using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 300000

    # Algorithm parameters

    # Solution
    primes = []
    slots = [p & 1 == 1 for p in 1:n]
    slots[1] = false
    if n >= 2
        push!(primes, 2)
        slots[2] = true
    end
    for p in 3:2:n
        if slots[p]
            push!(primes, p)
            for t in p^2:p:n
                slots[t] = false
            end
        end
    end

    mark = [false for _ in 1:length(primes)]
    m_vals = []

    for k in 1:length(primes)
        p = primes[k]
        a_prev = 0
        prime_prod = 1
        for i in 1:(k - 1)
            q = primes[i]
            a_prev = mod(a_prev + m_vals[i] * prime_prod, p)
            if a_prev == 0
                mark[k] = true
            end
            prime_prod = mod(prime_prod * q, p)
        end
        m = mod((k - a_prev) * invmod(prime_prod, p), p)
        push!(m_vals, m)
    end

    for i in 1:length(primes)
        if mark[i]
            result += primes[i]
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
