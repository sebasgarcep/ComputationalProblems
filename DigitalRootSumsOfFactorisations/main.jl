using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^6 - 1

    # Algorithm parameters

    # Solution
    
    # Memoize Digital Root Sum
    drs_memo = [0 for _ in 1:n]
    for k in 1:n
        drs_value = sum(digits(k))
        if k < 10
            drs_memo[k] = drs_value
        else
            drs_memo[k] = drs_memo[drs_value]
        end
    end

    # Calculate Maximal Digital Root Sum
    mdrs_memo = [0 for _ in 1:n]
    for k in 2:n
        mdrs_value = drs_memo[k]
        for d in 2:isqrt(k)
            if mod(k, d) != 0
                continue
            end
            mdrs_value = max(mdrs_value, drs_memo[d] + mdrs_memo[fld(k, d)])
            mdrs_value = max(mdrs_value, drs_memo[fld(k, d)] + mdrs_memo[d])
        end
        mdrs_memo[k] = mdrs_value
    end

    result = sum(mdrs_memo)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
