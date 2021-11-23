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

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    c = Int128(1504170715041707)
    m = Int128(4503599627370517)

    indexes = []
    eulercoins = []
    for n in 1:10^8
        x = mod(c * n, m)
        if length(eulercoins) == 0 || x < last(eulercoins)
            push!(indexes, n)
            push!(eulercoins, x)
        end
    end

    c_inv = invmod(c, m)
    indexes_inv = [mod(c_inv * x, m) for x in 1:(last(eulercoins) - 1)]
    while last(eulercoins) > 1
        min_index = nothing
        min_eulercoin = nothing
        for x in 1:(last(eulercoins) - 1)
            curr_index = indexes_inv[x]
            if curr_index <= last(indexes)
                continue
            end
            if min_index == nothing || min_index > curr_index
                min_index = curr_index
                min_eulercoin = x
            end
        end
        push!(indexes, min_index)
        push!(eulercoins, min_eulercoin)
    end

    result = sum(eulercoins)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
