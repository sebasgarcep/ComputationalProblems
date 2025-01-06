using Printf

function test(d, x, l)
    return search(d, x, l, 0, 1)
end

function search(d, x, l, a, i)
    if a > x
        return false
    end

    if i > length(d)
        return x == a
    end

    for j in 1:min(l, length(d) - i + 1)
        t = foldr((a, b) -> muladd(10, b, a), d[i:(i + j - 1)], init=0)
        if search(d, x, l, a + t, i + j)
            return true
        end
    end

    return false
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^12

    # Algorithm parameters

    # Solution
    for x in 2:isqrt(n)
        y = x^2
        if mod(y - x, 9) != 0 && mod(y - x, 9) != 1
            continue
        end
        l = length(digits(x))
        d = digits(y)
        if test(d, x, l)
            result += y
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
