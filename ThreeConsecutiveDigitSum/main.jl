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

function digit_sum(x)
    value = 0
    while x > 0
        value += mod(x, 10)
        x = fld(x, 10)
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 20
    m = 3
    k = 9

    # Algorithm parameters

    # Solution
    segments = []
    for x in 0:(10^m - 1)
        if digit_sum(x) <= k
            push!(segments, x)
        end
    end

    adjacency = zeros(Int64, length(segments), length(segments))
    for i in 1:length(segments)
        u = segments[i]
        for j in 1:length(segments)
            v = segments[j]
            if mod(u, 10^(m - 1)) == fld(v, 10)
                adjacency[j, i] = 1
            end
        end
    end

    state = zeros(Int64, length(segments))
    for i in 1:length(segments)
        u = segments[i]
        if u >= 10^(m - 1)
            state[i] = 1
        end
    end

    for _ in 1:(n - m)
        state = adjacency * state
    end

    result = sum(state)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
