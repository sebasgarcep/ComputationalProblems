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

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 20000
    mod_size = 10^9 + 7

    # Algorithm parameters
    bound = n

    # Solution
    prime_list = []

    # Sieve
    slots = [true for _ in 1:bound]
    slots[1] = false

    for p in 2:bound
        if slots[p]
            push!(prime_list, p)
            for k in (p * p):p:bound
                slots[k] = false
            end
        end
    end

    factorization = [zeros(Int64, length(prime_list)) for _ in 1:n]
    for k in 1:n
        acc = k
        for i in 1:length(prime_list)
            if acc <= 1
                break
            end
            while mod(acc, prime_list[i]) == 0
                factorization[k][i] += 1
                acc = fld(acc, prime_list[i])
            end
        end
    end

    factorization_factorial = []
    for k in 1:n
        if k == 1
            push!(factorization_factorial, factorization[1])
        else
            next_factorization_factorial = factorization_factorial[k - 1] + factorization[k]
            push!(factorization_factorial, next_factorization_factorial)
        end
    end

    result += 1

    b_factorization = factorization[1]
    for k in 2:n
        b_factorization += k * factorization[k]
        b_factorization -= factorization_factorial[k]
        term = 1
        for i in 1:length(prime_list)
            if b_factorization[i] == 0
                continue
            end
            term *= powermod(prime_list[i], b_factorization[i] + 1, mod_size) - 1
            term = mod(term, mod_size)
            term *= invmod(prime_list[i] - 1, mod_size)
            term = mod(term, mod_size)
        end
        result += term
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
