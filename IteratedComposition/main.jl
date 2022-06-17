using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    mod_size = 1020340567

    # Algorithm parameters
    
    # Solution
    slots = [true for _ in 1:n]
    mu_memo = [1 for _ in 1:n]
    slots[1] = false
    for p in 2:n
        if slots[p]
            for k in p:p:n
                slots[k] = k == p
                mu_memo[k] *= -1
            end

            for k in (p^2):(p^2):n
                mu_memo[k] = 0
            end
        end
    end

    mu_sum_memo = [0 for _ in 1:n]
    mu_sum_memo[1] = mu_memo[1]
    for k in 2:n
        mu_sum_memo[k] = mu_sum_memo[k - 1] + mu_memo[k]
    end

    q_memo = [0 for _ in 1:n]
    q_memo[1] = 2
    q_memo[2] = 2
    for k in 3:n
        q_memo[k] = mod(2 * q_memo[k - 1], mod_size)
    end

    for d in 1:n
        term = mod(q_memo[d] * mu_sum_memo[fld(n, d)], mod_size)
        result = mod(result + term, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
