using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    limit = 10^15

    # Algorithm parameters
    bound = 10^3

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    totient_memo = [k for k in 1:bound]
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                totient_memo[k] = fld(totient_memo[k], p) * (p - 1)
            end
        end
    end

    m = BigInt(2)
    while factorial(m - 1) <= limit
        n = BigInt(1)
        while factorial(m)^n <= limit * m * n
            f = BigInt(0)
            for d in BigInt(1):n
                if mod(n, d) == 0
                    f += fld(totient_memo[fld(n, d)] * factorial(m * d), factorial(d)^m)
                end
            end
            f = fld(f, m * n)
            if f <= limit
                result += f
            end
            n += BigInt(1)
        end
        m += BigInt(1)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
