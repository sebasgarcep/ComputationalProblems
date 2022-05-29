using Printf

function f(primes, i, j)
    p = primes[i]
    q = primes[j]
    return q * log(p) + p * log(q)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 800800
    e = 800800

    # Algorithm parameters

    # Solution
    limit = e * log(n)

    bound = Int64(floor(limit / log(2)))
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            push!(primes, p)
        end
    end

    for i in 1:length(primes)
        lower = 1
        upper = length(primes)
        while upper - lower > 1
            test = (lower + upper) >> 1
            if f(primes, i, test) > limit
                upper = test
            else
                lower = test
            end
        end
        if f(primes, i, upper) <= limit
            j = upper
        else
            j = lower
        end
        if j <= i
            break
        end
        result += j - i
        """
        if 2 * p * log(p) > limit
            break
        end
        for j in (i + 1):length(primes)
            q = primes[j]
            if q * log(p) + p * log(q) > limit
                break
            end
            result += 1
        end
        """
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
