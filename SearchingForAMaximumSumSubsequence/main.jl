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
    n = 2000

    # Algorithm parameters

    # Solution
    """
    m = [
        -2 5 3 2;
        9 -6 5 1;
        3 2 7 3;
        -1 8 -4 8;
    ]
    """

    # Lagged Fibonacci Generator
    s = zeros(Int64, n^2)
    for k in 1:n^2
        if k <= 55
            s[k] = mod(100003 - 200003 * k + 300007 * k^3, 1000000) - 500000
        else
            s[k] = mod(s[k - 24] + s[k - 55] + 1000000, 1000000) - 500000
        end
    end
    m =  transpose(reshape(s, (n, n)))

    (height, width) = size(m)

    # Horizontal
    for i in 1:height
        best_sum = 0
        current_sum = 0
        for j in 1:width
            current_sum = max(0, current_sum + m[i, j])
            best_sum = max(best_sum, current_sum)
        end
        if best_sum > result
            result = best_sum
        end
    end

    # Vertical
    for j in 1:width
        best_sum = 0
        current_sum = 0
        for i in 1:height
            current_sum = max(0, current_sum + m[i, j])
            best_sum = max(best_sum, current_sum)
        end
        if best_sum > result
            result = best_sum
        end
    end

    # Diagonal
    for d in 2:(height + width)
        best_sum = 0
        current_sum = 0
        for i in max(1, d - width):min(height, d - 1)
            current_sum = max(0, current_sum + m[i, d - i])
            best_sum = max(best_sum, current_sum)
        end
        if best_sum > result
            result = best_sum
        end
    end

    # Anti-diagonal
    for d in (1 - width):(height - 1)
        best_sum = 0
        current_sum = 0
        for i in max(1, d + 1):min(height, d + width)
            current_sum = max(0, current_sum + m[i, i - d])
            best_sum = max(best_sum, current_sum)
        end
        if best_sum > result
            result = best_sum
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
