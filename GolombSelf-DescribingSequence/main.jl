using Printf
using Memoize

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    s = 10^6

    # Algorithm parameters
    l = 10^12

    # Solution
    # Calculate G^{-1}
    b_list = [1, 3]
    n = 2
    g = 2
    b = 3
    while b <= l
        n += 1
        if n > b_list[g]
            g += 1
        end
        b = g + b
        push!(b_list, b)
    end

    # Calculate G(1^3)
    result += 1
    x = 2
    # Calculate G(n^3)
    a = 1
    b = 1
    p = 1
    q = 1
    g = 1
    for k in 2:last(b_list)
        if k > b_list[g]
            g += 1
        end
        a = b + 1
        b = a + k * g - 1
        p = q + 1
        q = p + g - 1
        while x < s && x^3 <= b
            result += p + fld(x^3 - a, k)
            x += 1
        end
        if x >= s
            break
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
