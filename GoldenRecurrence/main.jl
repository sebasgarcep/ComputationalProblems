using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    p0 = 1
    q0 = 2
    r = 398874989
    m = 1618034

    # Algorithm parameters
    memo_size = 10^8

    # Solution
    p = p0
    q = q0
    p_memo = Vector{Int64}(undef, memo_size)
    q_memo = Vector{Int64}(undef, memo_size)

    k = 1
    while true
        pn = mod(p * mod(400 * powermod(p, 4, r) - 100 * powermod(p, 2, r) + 5, r), r)
        qn = mod(q * mod(400 * powermod(p, 4, r) - 60 * powermod(p, 2, r) + 1, r), r)
        p, q = pn, qn
        p_memo[k] = p
        q_memo[k] = q
        if p == p0 && q == q0
            break
        end
        k += 1
    end

    a = 1
    b = 1
    for _ in 2:m
        # p_0, q_0 are in the final position
        if b == 0
            j = k
        else
            j = b
        end
        s = mod(powermod(p_memo[j], 5, r) + powermod(q_memo[j], 5, r), r)
        result = mod(result + s, r)
        a, b = b, mod(a + b, k)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
