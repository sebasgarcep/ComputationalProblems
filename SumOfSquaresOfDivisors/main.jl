using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int64(1e15)
    mod_size = Int64(1e9)

    # Algorithm parameters

    # Solution
    function t_2(x)
        items = [x, x + 1, 2 * x + 1]

        for (index, element) in enumerate(items)
            if mod(element, 2) == 0
                items[index] = fld(element, 2)
                break
            end
        end

        for (index, element) in enumerate(items)
            if mod(element, 3) == 0
                items[index] = fld(element, 3)
                break
            end
        end

        value = Int128(1)
        for element in items
            value = mod(value * element, mod_size)
        end

        return Int64(value)
    end

    for d in 1:isqrt(n)
        term = mod(d^2, mod_size) * mod(fld(n, d), mod_size)
        term = mod(term, mod_size)
        result = mod(result + term, mod_size)
    end

    max_u = isqrt(n)
    if max_u == fld(n, max_u)
        max_u -= 1
    end
    for u in 1:max_u
        term = u * mod(t_2(fld(n, u)) - t_2(fld(n, u + 1)), mod_size)
        term = mod(term, mod_size)
        result = mod(result + term, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
