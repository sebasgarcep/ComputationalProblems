using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 25 * 10^6

    # Algorithm parameters

    # Solution
    # a = 1
    result += fld(n - 1, 2)

    # a > 1
    divisors = [a == 1 ? [1] : [1, a] for a in 1:(fld(n, 3) + 1)]
    for d in 2:isqrt(length(divisors))
        for k in d:d:length(divisors)
            if d^2 <= k
                push!(divisors[k], d)
                if d^2 < k
                    push!(divisors[k], fld(k, d))
                end
            end
        end
    end

    for a in 1:length(divisors)
        divisors[a] = sort(divisors[a])
    end

    for a in 2:fld(n, 3)
        f = a^2 - 1
        s = a - 1
        t = a + 1
        v = 0
        while s & 1 == 0
            s = s >> 1
            v += 1
        end
        while t & 1 == 0
            t = t >> 1
            v += 1
        end
        for p1 in divisors[s]
            if p1^2 >= f
                break
            end
            for p2 in divisors[t]
                if (p1 * p2)^2 >= f
                    break
                end
                for v3 in 0:v
                    p = (p1 * p2) << v3
                    if p^2 >= f
                        break
                    end
                    q = fld(f, p)
                    if mod(p - q, 2) != 0
                        continue
                    end
                    c = (p + q) >> 1
                    b = (q - p) >> 1
                    if a <= b && a + b > c && a + b + c <= n
                        result += 1
                    end
                end
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
