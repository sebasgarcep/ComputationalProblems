using Printf
using Memoize

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^11
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = 10^8

    # Solution

    # Sieve
    totient_memo = [i for i in 1:bound]
    totient_sum_memo = [0 for _ in 1:bound]

    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            totient_memo[p] = p - 1
            for k in (2 * p):p:bound
                slots[k] = false
                totient_memo[k] = (p - 1) * fld(totient_memo[k], p)
            end
        end
    end

    totient_sum_memo[1] = totient_memo[1]
    for i in 2:bound
        totient_sum_memo[i] = mod(totient_sum_memo[i - 1] + totient_memo[i], mod_size)
    end

    # Program
    function triangular(x)
        t1 = x
        if (t1 & 1) == 0
            t1 = t1 >> 1
        end
        t1 = mod(t1, mod_size)
        t2 = x + 1
        if (t2 & 1) == 0
            t2 = t2 >> 1
        end
        t2 = mod(t2, mod_size)
        return mod(t1 * t2, mod_size)
    end

    @memoize function totient_sum(x)
        if x == 1
            return 1
        end
        if x <= bound
            return totient_sum_memo[x]
        end
        s = triangular(x)
        sqrtn = isqrt(x)
        for m in 2:sqrtn
            term = totient_sum(fld(x, m))
            s = mod(s - term, mod_size)
        end
        max_d = sqrtn
        if max_d == fld(x, max_d)
            max_d -= 1
        end
        for d in 1:max_d
            term = mod(mod(fld(x, d) - fld(x, d + 1), mod_size) * totient_sum(d), mod_size)
            s = mod(s - term, mod_size)
        end
        return s
    end

    acc = n
    while (acc = acc >> 1) > 0
        result = mod(result + totient_sum(acc) - 1, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
