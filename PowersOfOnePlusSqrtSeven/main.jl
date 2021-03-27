using Printf

include("factorize.jl")

function euler_totient(m)
    totient = 1
    next = Factorize.get_next(m)
    while next !== nothing
        divisor_prime, divisor_expo, next_remaining = next
        totient *= divisor_prime^(divisor_expo - 1) * (divisor_prime - 1)
        next = Factorize.get_next(next_remaining)
    end
    return totient
end

function modorder_aux(x, m, t, e, d)
    if t == 1
        return d
    end
    next = Factorize.get_next(t)
    divisor_prime, divisor_expo, next_remaining = next
    result = d
    for i in 0:divisor_expo
        if x == 1
            return e
        else
            result = min(result, modorder_aux(x, m, next_remaining, e, d))
            x = powermod(x, divisor_prime, m)
            e *= divisor_prime
        end
    end
    return result
end

function modorder(x, m)
    t = euler_totient(m)
    e = 1
    return modorder_aux(x, m, t, e, t)
end

function g(x)
    if mod(x, 2) == 0 || mod(x, 3) == 0
        return 0
    end
    a = 1
    b = 1
    m = 0
    while true
        m += 1
        (a, b) = (a + 7 * b, a + b)
        a = mod(a, x)
        b = mod(b, x)
        if (a == 1 && b == 1) || (a == 0 && b == 0)
            return 0
        end
        if b == 0
            m += 1
            z = a
            if gcd(z, x) != 1
                return 0
            end
            k = modorder(z, x)
            return k * m
        end
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^6

    # Algorithm parameters

    # Solution
    for x in 2:limit
        if mod(x, 10000) == 0
            println(x)
        end
        result += g(x)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
