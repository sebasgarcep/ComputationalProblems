using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^8

    # Algorithm parameters

    # Solution
    primes = [2]
    slots = [p & 1 == 1 for p in 1:n]
    slots[1] = false
    for p in 3:2:n
        if slots[p]
            push!(primes, p)
            for t in p^2:p:n
                slots[t] = false
            end
        end
    end

    nbits = 0
    s = n + 1
    while s > 0
        nbits += 1
        s >>= 1
    end

    # Represent tree as an array (just like binary heap)
    tree = zeros(Int64, (1 << (nbits + 1)) - 2)
    for p in primes
        s = p
        i = 0
        while s > 0
            if s & 1 == 0
                # go left
                i = 2 * i + 1
            else
                # go right
                i = 2 * i + 2
            end
            s >>= 1
            tree[i] += 1
        end
    end

    for p in primes
        s = p
        i = 0
        while s > 0
            # Represent 0.5 as 1 and 1 as 2. At the end we divide by 2
            if tree[2 * i + 1] > tree[2 * i + 2] && (s & 1 == 0)
                result += 2
            elseif tree[2 * i + 1] < tree[2 * i + 2] && (s & 1 == 1)
                result += 2
            elseif tree[2 * i + 1] == tree[2 * i + 2]
                result += 1
            end
            if s & 1 == 0
                # go left
                i = 2 * i + 1
            else
                # go right
                i = 2 * i + 2
            end
            s >>= 1
        end
    end

    result /= length(primes) << 1

    # Show result
    @printf("%.8f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
