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
    k = 97
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = 10^6

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            if mod(p, 10) == 7 && length(primes) < k
                push!(primes, p)
            end
        end
    end

    if length(primes) != k
        println("ERROR: DID NOT FIND ENOUGH PRIMES.")
        return
    end

    n = 10
    phi = [gcd(d, 10) == 1 ? 1 : 0 for d in 0:9]
    gamma = [gcd(d, 10) == 1 ? d : 0 for d in 0:9]
    for p in primes
        n_next = mod(n * p, mod_size)
        phi_next = [0 for _ in 0:9]
        gamma_next = [0 for _ in 0:9]
        for d in 0:9
            phi_next[d + 1] = mod(p * phi[d + 1], mod_size)
            phi_next[d + 1] -= phi[mod(3 * d, 10) + 1]
            phi_next[d + 1] = mod(phi_next[d + 1], mod_size)
            gamma_next[d + 1] = mod(n * mod((((p - 1) * p) >> 1) * phi[d + 1], mod_size), mod_size)
            gamma_next[d + 1] += mod(p * gamma[d + 1], mod_size)
            gamma_next[d + 1] = mod(gamma_next[d + 1], mod_size)
            gamma_next[d + 1] -= mod(p * gamma[mod(3 * d, 10) + 1], mod_size)
            gamma_next[d + 1] = mod(gamma_next[d + 1], mod_size)
        end
        n = n_next
        phi = phi_next
        gamma = gamma_next
    end

    result = gamma[7 + 1]

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
