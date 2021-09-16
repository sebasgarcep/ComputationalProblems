using Printf
using Memoize

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
    n = 10^17 - 1

    # Algorithm parameters

    # Solution
    fib_memo = [1, 1]
    a, b = fib_memo[1], fib_memo[2]
    while b <= n
        a, b = b, a + b
        push!(fib_memo, b)
    end

    @memoize function s(x)
        if x == 0
            return 0
        end
        if x == 1
            return 1
        end
        value = x
        for i in 3:(length(fib_memo) - 1)
            if x - fib_memo[i] < 0
                break
            end
            if fib_memo[i + 1] <= x
                value += s(fib_memo[i - 1] - 1)
            else
                value += s(x - fib_memo[i])
            end
        end
        return value
    end

    result = s(n)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
