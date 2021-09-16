using Printf

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

function triangular(x)
    return (x * (x + 1)) >> 1
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^8
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = n

    # Solution
    mu_memo = [1 for _ in 1:n]
    totient_memo = [i for i in 1:n]
    factorial_memo = [1 for _ in 1:n]
    factorial_acc_memo = [1 for _ in 1:n]

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p * p):p:bound
                slots[k] = false
            end

            for k in p:p:n
                mu_memo[k] *= -1
                totient_memo[k] = (p - 1) * fld(totient_memo[k], p)
            end

            for k in (p * p):(p * p):n
                mu_memo[k] = 0
            end
        end
    end

    for k in 2:n
        factorial_memo[k] = mod(factorial_memo[k - 1] * k, mod_size)
        factorial_acc_memo[k] = mod(factorial_acc_memo[k - 1] * factorial_memo[k], mod_size)
    end

    result = 1
    for d in 1:n
        if mu_memo[d] == 0
            continue
        end
        result *= powermod(d, triangular(fld(n, d)) * mu_memo[d], mod_size)
        result = mod(result, mod_size)
        result *= powermod(factorial_acc_memo[fld(n, d)], mu_memo[d], mod_size)
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
