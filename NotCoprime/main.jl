using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^6

    # Algorithm parameters

    # Solution
    slots = [true for _ in 1:n]
    factors = [BitSet() for _ in 1:n]
    slots[1] = false
    for k in 2:n
        if slots[k]
            push!(factors[k], k)
            for t in (2 * k):k:n
                slots[t] = false
                push!(factors[t], k)
            end
        end
    end

    # Push the numbers divisible by only one prime
    f_factors = BitSet()
    remaining = BitSet()
    for i in 3:10:n
        if length(factors[i]) == 1
            for p in factors[i]
                push!(f_factors, p)
            end
        else
            push!(remaining, i)
        end
    end

    # Filter out elements that are already not coprime
    removals = BitSet()
    for x in remaining
        if !isdisjoint(f_factors, factors[x])
            push!(removals, x)
        end
    end
    remaining = setdiff(remaining, removals)

    # Heuristic
    while length(remaining) > 0
        score = [0.0 for _ in 1:n]
        # For each prime calculate the sum-log of the remaining
        # elements it divides
        for x in remaining
            for p in factors[x]
                if mod(p, 10) in [3, 7, 9]
                    score[p] += log(x)
                end
            end
        end
        # Get the prime with the largest sum-log
        p = 1
        for t in 2:n
            if score[t] > score[p]
                p = t
            end
        end
        # Add the prime to f_factors
        push!(f_factors, p)
        # Get the elements in remaining divisible by the prime
        removals = BitSet()
        for x in remaining
            if p in factors[x]
                push!(removals, x)
            end
        end
        # Remove those elements from the list of remaining
        remaining = setdiff(remaining, removals)
    end

    result = 0.0
    for f in f_factors
        result += log(f)
    end

    # Show result
    @printf("%.6f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
