using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k_max = 124

    # Algorithm parameters

    # Solution
    k = 0
    m = 27
    while k < k_max
        s = Set()
        a, b, c = 1, 1, 1
        while true
            a, b, c = b, c, mod(a + b + c, m)
            if c == 0
                break
            end
            v = (a, b, c)
            if in(v, s)
                k += 1
                result = m
                break
            else
                push!(s, (a, b, c))
            end
        end
        m += 2
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
