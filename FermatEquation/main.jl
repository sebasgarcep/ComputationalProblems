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

function get_form(p)
    representations = []
    a = 1
    while 4 * p >= a^2
        if mod(4 * p - a^2, 27) == 0
            b_2 = fld(4 * p - a^2, 27)
            b = isqrt(b_2)
            if b^2 == b_2
                a_repr = a
                if mod(a, 3) != 1
                    a_repr = -a_repr
                end
                push!(representations, (a_repr, b))
            end
        end
        a += 1
    end
    if length(representations) != 1
        return nothing
    else
        return representations[1]
    end
end

function f(p)
    if p == 2
        return 0
    elseif p == 3
        return 2
    elseif mod(p, 3) == 2
        return (p - 1) * (p - 2)
    end
    (a, b) = get_form(p)
    return (p - 1) * (p + a - 8)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 6000000

    # Algorithm parameters
    bound = n

    # Solution
    primes = []
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            result += f(p)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
