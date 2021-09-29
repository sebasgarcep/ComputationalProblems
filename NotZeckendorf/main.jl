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

function s(fibonacci, n, l)
    if n < 0
        return 0
    elseif l <= 0
        return 1
    elseif sum(fibonacci[1:l]) <= n
        return 2^l
    else
        return s(fibonacci, n, l - 1) + s(fibonacci, n - fibonacci[l], l - 1)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^13

    # Algorithm parameters

    # Solution
    fibonacci = []
    a, b = 1, 1
    while b <= n
        push!(fibonacci, b)
        a, b = b, a + b
    end

    result = s(fibonacci, n, length(fibonacci))

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
