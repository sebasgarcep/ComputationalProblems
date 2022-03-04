using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^7

    # Algorithm parameters
    bound = limit - 1

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (2 * p):p:bound
                slots[k] = false
            end
            if p != 2 && p != 5
                result += invmod(10, p)
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
