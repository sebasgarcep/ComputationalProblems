using Printf
using SparseArrays

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
    r = 234567
    m = 765432
    mod_size = 10^9 + 9

    # Algorithm parameters
    num_digits = 6

    # Solution
    for digit_pos in 0:(num_digits - 1)
        # Count the number of occurrences of each number for a given digit position
        num_occurrences = [0 for _ in 0:9]
        for x in 0:m
            d = mod(fld(x, 10^digit_pos), 10)
            num_occurrences[d + 1] += 1
        end
        # Calculate each iteration of the Freshman Product
        curr_occurrences = copy(num_occurrences)
        for _ in 2:r
            next_occurrences = [0 for _ in 0:9]
            for a in 0:9
                for b in 0:9
                    c = mod(a * b, 10)
                    delta = mod(curr_occurrences[a + 1] * num_occurrences[b + 1], mod_size)
                    next_occurrences[c + 1] = mod(next_occurrences[c + 1] + delta, mod_size)
                end
            end
            curr_occurrences = next_occurrences
        end
        value = 0
        for d in 0:9
            value += mod(d * curr_occurrences[d + 1], mod_size)
            value = mod(value, mod_size)
        end
        # Add to the final tally taking into account the digit position
        result += mod(value * 10^digit_pos, mod_size)
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
