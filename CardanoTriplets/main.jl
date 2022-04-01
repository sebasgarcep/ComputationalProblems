using Printf

function get_factorization(n)
    if n == 1
        return []
    end
    factorization = []
    remaining = n
    if remaining & 1 == 0
        count = 0
        while remaining & 1 == 0
            remaining = remaining >> 1
            count += 1
        end
        push!(factorization, (2, count))
    end
    d = 3
    while d * d <= remaining
        count = 0
        while mod(remaining, d) == 0
            remaining = fld(remaining, d)
            count += 1
        end
        if count > 0
            push!(factorization, (d, count))
        end
        d += 2
    end
    if remaining > 1
        push!(factorization, (remaining, 1))
    end
    return factorization
end

function get_divisors_alt(factorization, divisors, k, a)
    if k > length(factorization)
        push!(divisors, a)
        return
    end
    (p, e) = factorization[k]
    factor = 1
    for _ in 0:e
        get_divisors_alt(factorization, divisors, k + 1, a * factor)
        factor *= p
    end
end

function get_divisors(n)
    factorization = get_factorization(n)
    divisors = []
    get_divisors_alt(factorization, divisors, 1, 1)
    return sort(divisors)
end

function get_square_divisors_alt(factorization, divisors, k, a)
    if k > length(factorization)
        push!(divisors, a)
        return
    end
    (p, e) = factorization[k]
    factor = 1
    for _ in 0:2:e
        get_square_divisors_alt(factorization, divisors, k + 1, a * factor)
        factor *= p
    end
end

function get_square_divisors(n)
    factorization = get_factorization(n)
    divisors = []
    get_square_divisors_alt(factorization, divisors, 1, 1)
    return sort(divisors)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 110000000

    # Algorithm parameters

    # Solution
    for a in 2:3:fld(n, 2)
        v = 0
        s = a + 1
        while mod(s, 3) == 0
            s = fld(s, 3)
            v += 2
        end
        t = 8 * a - 1
        while mod(t, 3) == 0
            t = fld(t, 3)
            v += 1
        end
        divisors = get_divisors(s)
        square_divisors = get_square_divisors(t)
        for d1 in divisors
            b1 = Int128(d1)
            c1 = Int128(fld(s, d1))^2
            if a + b1 > n
                break
            end
            if a + b1 + c1 > n
                continue
            end
            for d2 in square_divisors
                b2 = b1 * Int128(d2)
                c2 = c1 * Int128(fld(t, d2^2))
                if a + b2 > n
                    break
                end
                if a + b2 + c2 > n
                    continue
                end
                for v3 in 0:fld(v-3, 2)
                    b = b2 * Int128(3)^v3
                    c = c2 * Int128(3)^(v-3-2*v3)
                    if a + b > n
                        break
                    end
                    if a + b + c <= n
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
