using Printf

function f(n)
    if mod(n, 10) == 0
        return 0
    end
    curr = n
    prev = 1
    while curr != prev
        prev, curr = curr, powermod(n, curr, 10^9)
    end
    return curr
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^6

    # Algorithm parameters

    # Solution
    for n in 2:limit
        result += f(n)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
