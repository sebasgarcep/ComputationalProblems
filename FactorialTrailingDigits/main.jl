using Printf
using Memoize

function factorial_prime_power(n, p)
    total = 0
    d = 1
    while true
        d *= p
        v = fld(n, d)
        if v <= 0
            break
        end
        total += v
    end
    return total
end

@memoize function u(n, s)
    l = mod(n, s)
    total = 1
    acc = 1
    for k in 1:s
        if k & 1 != 0 && k % 5 != 0
            acc = mod(acc * k, s)
            if k <= l
                total = mod(total * k, s)
            end
        end
    end
    total = mod(total * powermod(acc, fld(n, s), s), s)
    return total
end

@memoize function h(n, s)
    if n <= 1
        return 1
    end
    total = u(n, s)
    total = mod(total * h(fld(n, 2), s), s)
    total = mod(total * h(fld(n, 5), s), s)
    total = mod(total * invmod(h(fld(n, 10), s), s), s)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12
    s = 10^5

    # Algorithm parameters

    # Solution
    result = powermod(2, factorial_prime_power(n, 2) - factorial_prime_power(n, 5), s)
    result = mod(result * h(n, s), s)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
