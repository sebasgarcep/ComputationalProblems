using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 40000000 - 1
    max_chain_length = 25

    # Algorithm parameters

    # Solution
    slots = repeat([true], limit)
    slots[1] = false
    phi = repeat([1], limit)
    idx = 2
    while idx <= limit
        if slots[idx]
            # Mark non-primes
            for ptr in (2 * idx):idx:limit
                slots[ptr] = false
            end
            # Calculate Euler Totient Function
            factor = idx
            while factor <= limit
                if factor == idx
                    for ptr in factor:factor:limit
                        phi[ptr] *= idx - 1
                    end
                else
                    for ptr in factor:factor:limit
                        phi[ptr] *= idx
                    end
                end
                factor *= idx
            end
            # Calculate chain length
            ptr = idx
            curr_chain_length = 1
            while ptr != 1
                ptr = phi[ptr]
                curr_chain_length += 1
                if curr_chain_length > max_chain_length
                    break
                end
            end
            if curr_chain_length == max_chain_length
                result += idx
            end
        end
        idx += 1
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()

