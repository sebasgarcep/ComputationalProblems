using Printf

function get_coefficients_complex(x)
    a = abs(real(x))
    b = abs(imag(x))
    return min(a, b), max(a, b)
end

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

function get_gaussian_divisors_alt(indexes, representations, factors, divisors, acc, pos)
    push!(divisors, acc)

    if pos > length(factors)
        return
    end

    (p, c) = factors[pos]
    (a, b) = representations[indexes[p]]
    for i in 0:c
        next_acc = acc
        for j in 1:c
            if j <= i
                next_acc *= a+b*im
            else
                next_acc *= a-b*im
            end
        end
        get_gaussian_divisors_alt(indexes, representations, factors, divisors, next_acc, pos + 1)
    end
end

function get_gaussian_divisors(indexes, representations, factors)
    divisors = []
    get_gaussian_divisors_alt(indexes, representations, factors, divisors, 1+0*im, 1)
    unique_divisors = []
    flags = [true for _ in 1:length(divisors)]
    for i in 1:length(divisors)
        if !flags[i]
            continue
        end
        push!(unique_divisors, divisors[i])
        a, b = get_coefficients_complex(divisors[i])
        for j in (i + 1):length(divisors)
            if !flags[j]
                continue
            end
            x, y = get_coefficients_complex(divisors[j])
            if a == x && b == y
                flags[j] = false
            end
        end
    end
    return unique_divisors
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 75 * 10^6

    # Algorithm parameters

    # Solution
    limit = fld(n, 2) + 1
    slots = [true for _ in 1:limit]
    slots[1] = false
    primes = []
    curr_index = 0
    indexes = [0 for _ in 1:limit]
    representations = []
    for p in 2:limit
        if slots[p]
            for k in (p^2):p:limit
                slots[k] = false
            end

            # Add prime to list
            push!(primes, p)

            # Set index
            curr_index += 1
            indexes[p] = curr_index

            # Find representation as a^2 + b^2 = p
            if p & 3 == 3
                push!(representations, (0, 0))
            else
                found = false
                a = 1
                while 2 * a^2 <= p
                    b2 = p - a^2
                    b = isqrt(b2)
                    if b^2 == b2
                        push!(representations, (a, b))
                        break
                    end
                    a += 1
                end
            end
        end
    end

    prev_factorization = []
    next_factorization = get_factorization(2)
    for c in 3:2:fld(n, 2)
        prev_factorization, next_factorization = next_factorization, get_factorization(c + 1)
        skip = false
        base = 1+0*im
        factors = []
        for (p, c) in prev_factorization
            if p & 3 == 3 && c & 1 == 1
                skip = true
                break
            end
            if p == 2
                base *= (1+im)^c
            elseif p & 3 == 3
                base *= p^fld(c, 2)
            else
                push!(factors, (p, c))
            end
        end
        if skip
            continue
        end
        for (p, c) in next_factorization
            if p & 3 == 3 && c & 1 == 1
                skip = true
                break
            end
            if p == 2
                base *= (1+im)^c
            elseif p & 3 == 3
                base *= p^fld(c, 2)
            else
                push!(factors, (p, c))
            end
        end
        if skip
            continue
        end
        for divisor in get_gaussian_divisors(indexes, representations, factors)
            a, b = get_coefficients_complex(base * divisor)
            if a + b > c && a + b + c <= n
                result += 1
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
