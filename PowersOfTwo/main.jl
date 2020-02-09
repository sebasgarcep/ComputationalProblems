using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    l = 123
    n = 678910

    # Algorithm parameters
    d = 1000.0

    # Solution
    k = 0
    j = 0
    head = 1.0
    while k < n
        j += 1
        head *= 2.0
        while head >= d
            head /= 10.0
        end
        if head >= l && head < l + 1
            k += 1
        end
        if k >= n
            break
        end
    end
    result = j

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
