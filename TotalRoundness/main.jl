using Printf

function naive(n, m, primes, gamma)
    r = length(primes)
    result = 0
    for i in 1:r
        for s in 1:gamma[i]
            u = fld(gamma[i], s)
            a = 1
            for j in 1:(i - 1)
                t = fld(gamma[j], u + 1)
                if t == 0
                    break
                end
                a *= 1 + t
            end
            b = 1
            for j in (i + 1):r
                t = fld(gamma[j], u)
                if t == 0
                    break
                end
                b *= 1 + t
            end
            k = a * b
            result += k * u
        end
    end
    return mod(result, m)
end

function optimal(n, m, primes, gamma)
    r = length(primes)
    result = 0
    for u in 1:gamma[1]
        t = 1
        for i in 1:r
            # gamma is decreasing
            if u > gamma[i]
                break
            end
            # Calculate q
            q = mod(fld(gamma[i], u) - fld(gamma[i], u + 1), m)
            # Calculate t
            if i == 1
                for j in 2:r
                    if u > gamma[j]
                        break
                    end
                    t *= mod(1 + fld(gamma[j], u), m)
                    t = mod(t, m)
                end
            else
                t *= mod(1 + fld(gamma[i - 1], u + 1), m)
                t = mod(t, m)
                t *= invmod(mod(1 + fld(gamma[i], u), m), m)
                t = mod(t, m)
            end
            # Calculate the term and add it to the result
            result += mod(mod(q * t, m) * u, m)
            result = mod(result, m)
        end
    end
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    m = 10^9 + 7

    # Algorithm parameters

    # Solution
    slots = [true for _ in 1:n]
    slots[1] = false
    primes = []
    for p in 2:n
        if slots[p]
            push!(primes, p)
            for k in (p^2):p:n
                slots[k] = false
            end
        end
    end

    r = length(primes)
    gamma = zeros(Int64, r)
    for i in 1:length(primes)
        p = primes[i]
        a = p
        while a <= n
            gamma[i] += fld(n, a)
            a *= p
        end
    end

    # Approach 1
    # println(naive(n, m, primes, gamma))
    result = optimal(n, m, primes, gamma)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
