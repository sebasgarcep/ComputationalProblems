using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = BigInt(10)^36

    # Algorithm parameters
    bound = iroot(n, 4)

    # Solution
    mu_memo = [1 for _ in 1:bound]
    mu_one_list = []

    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 1:bound
        if slots[p]
            mu_memo[p] = -1

            for k in (2 * p):p:bound
                slots[k] = false
                mu_memo[k] *= -1
            end

            p_2 = p * p
            for k in p_2:p_2:bound
                mu_memo[k] = 0
            end
        end

        if mu_memo[p] == 1
            push!(mu_one_list, p)
        end
    end

    function binary_search(limit)
        lower = 1
        upper = length(mu_one_list)
        
        while upper - lower > 1
            middle = (lower + upper) >> 1
            if mu_one_list[middle] == limit
                return middle
            elseif mu_one_list[middle] < limit
                lower = middle
            else
                upper = middle
            end
        end

        if mu_one_list[upper] <= limit
            return upper
        end
        
        return lower
    end

    n_4 = iroot(n, 4)
    for a in 1:iroot(n, 6)
        limit = Int64(floor(n_4 / sqrt(a^3)))
        value = binary_search(limit)
        result += value
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
