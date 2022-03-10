using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    num_terms = 24
    mod_size = 10^9

    # Algorithm parameters

    # Solution

    # Calculate Fibonacci numbers
    fibonacci = [1]
    a, b = 0, 1
    for _ in 2:num_terms
        a, b = b, a + b
        push!(fibonacci, b)
    end

    # Calculate prime numbers
    limit = last(fibonacci)
    primes = []
    slots = [true for _ in 1:limit]
    slots[1] = false
    for p in 2:limit
        if slots[p]
            for k in (p * p):p:limit
                slots[k] = false
            end
            push!(primes, p)
        end
    end

    # Calculate the values of -R
    r_memo = [0 for _ in 0:limit]
    r_memo[0 + 1] = mod(-1, mod_size)
    for p in primes
        g = copy(r_memo)

        for k in 0:(limit - p)
            g[k + p + 1] -= mod(r_memo[k + 1] * p, mod_size)
        end

        r_memo = mod.(g, mod_size)
    end

    # Calculate the values of S
    s_memo = [0 for _ in 0:limit]
    s_memo[0 + 1] = 1
    for k in 1:limit
        for x in 2:k
            s_memo[k + 1] += mod(r_memo[x + 1] * s_memo[k - x + 1], mod_size)
        end
        s_memo[k + 1] = mod(s_memo[k + 1], mod_size)
    end

    # Use those values to obtain the result
    for i in 2:length(fibonacci)
        result = mod(result + s_memo[fibonacci[i] + 1], mod_size)
    end

    # println(r_memo)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
