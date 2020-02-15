using Printf
using Memoize

@memoize function memo_invmod(n, m)
    return invmod(n, m)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    m = 1000000087

    # Algorithm parameters
    l = 8

    # Solution
    s_value = 1
    s_powers = ones(Int64, n)
    prime_factors = zeros(Int64, n, l)
    prime_powers = zeros(Int64, n, l)
    slots = [true for _ in 1:n]
    slots[1] = false
    for k in 2:n
        if slots[k]
            for t in k:k:n
                if t > k
                    slots[t] = false
                end
                e = 0
                v = t
                while v % k == 0
                    e += 1
                    v = fld(v, k)
                end
                i = 1
                while prime_factors[t, i] != 0
                    i += 1
                end
                prime_factors[t, i] = k
                prime_powers[t, i] = e
            end
        end
        i = 1
        while i <= l && prime_factors[k, i] != 0
            p = prime_factors[k, i]
            prev_power = s_powers[p]
            next_power = prev_power + 2 * prime_powers[k, i]
            s_value = mod(mod(s_value * next_power, m) * memo_invmod(prev_power, m), m)
            s_powers[p] = next_power
            i += 1
        end
        result = mod(result + s_value, m)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
