using Printf

function get_next(exponents)
    # Find next
    min_n = nothing
    min_b = nothing
    min_e = nothing
    for e in 2:length(exponents)
        b = exponents[e] + Int128(1)
        n = b^e
        if min_n == nothing || min_n > n
            min_n = n
            min_b = b
            min_e = e
        end
    end
    e = length(exponents) + 1
    b = Int128(2)
    n = b^e
    if min_n === nothing || min_n > n
        min_n = n
        min_b = b
        min_e = e
    end
    # Update exponents
    if min_e <= length(exponents)
        exponents[min_e] = min_b
    else
        push!(exponents, min_b)
    end
    # Return
    return min_b, min_e
end

function test(n, b)
    ds = 0
    while n > 0
        ds += mod(n, 10)
        n = fld(n, 10)
    end
    return ds == b
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 30

    # Algorithm parameters

    # Solution
    count = 0
    exponents = [Int128(0)]
    steps = 0
    while count < limit
        steps += 1
        b, e = get_next(exponents)
        n = b^e
        if n <= 10
            continue
        end
        if test(n, b)
            count += 1
            result = n
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
