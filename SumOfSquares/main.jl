using Printf

function search(primes, a_list, b_list, acc, a, b, start)
    total = a
    for current in start:length(primes)
        next_acc = acc * primes[current]
        c = a_list[current]
        d = b_list[current]
        # First version of the Brahmagupta-Fibonacci identity
        next_a, next_b = minmax(abs(a * c - b * d), abs(a * d + b * c))
        total += search(primes, a_list, b_list, next_acc, next_a, next_b, current + 1)
        # Second version of the Brahmagupta-Fibonacci identity
        next_a, next_b = minmax(abs(a * c + b * d), abs(a * d - b * c))
        total += search(primes, a_list, b_list, next_acc, next_a, next_b, current + 1)
    end
    return total
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    l = 150 - 1

    # Algorithm parameters

    # Solution
    primes = []
    slots = [p & 1 == 1 for p in 1:l]
    slots[1] = false
    if l >= 2
        slots[2] = true
    end
    for p in 3:2:l
        if slots[p]
            if p & 3 == 1
                push!(primes, p)
            end
            for t in p^2:p:l
                slots[t] = false
            end
        end
    end

    a_list = []
    b_list = []
    for p in primes
        found = false
        for a in 1:isqrt(p)
            for b in a:isqrt(p)
                if a^2 + b^2 == p
                    found = false
                    push!(a_list, a)
                    push!(b_list, b)
                    break
                end
            end
            if found
                break
            end
        end
    end

    for (start, p, a, b) in zip(1:length(primes), primes, a_list, b_list)
        result += search(primes, a_list, b_list, p, a, b, start + 1)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
