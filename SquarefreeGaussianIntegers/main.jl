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

function gauss_circle_sum(n, k)
    value = 0
    for i in 0:((isqrt(n) - k) >> 2)
        value += fld(n, 4 * i + k)
    end
    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in 1:max_u
        value += u * (fld(n - k * u, 4 * u) - fld(n - k * (u + 1), 4 * (u + 1)))
    end
    return value
end

function gauss_circle_proper(n)
    return gauss_circle_sum(n, 1) - gauss_circle_sum(n, 3)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^14

    # Algorithm parameters

    # Solution
    bound = isqrt(n)
    slots = [true for _ in 1:bound]
    slots[1] = false
    factorization = [[] for _ in 1:bound]
    remainder = [i for i in 1:bound]
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                acc = fld(k, p)
                exponent = 1
                while mod(acc, p) == 0
                    acc = fld(acc, p)
                    exponent += 1
                end
                push!(factorization[k], (p, exponent))
            end
        end
    end

    for k in 1:bound
        mu = 1
        amount = 1
        for (p, exponent) in factorization[k]
            if p == 2
                if exponent == 1
                    mu *= -1
                else
                    mu = 0
                    amount = 0
                    break
                end
            elseif mod(p, 4) == 3
                if exponent == 2
                    mu *= -1
                else
                    mu = 0
                    amount = 0
                    break
                end
            else
                if exponent == 1
                    mu *= -1
                    amount *= 2
                elseif exponent == 2
                    # pass
                else
                    mu = 0
                    amount = 0
                    break
                end
            end
        end
        if mu != 0
            result += amount * mu * gauss_circle_proper(fld(n, k^2))
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
