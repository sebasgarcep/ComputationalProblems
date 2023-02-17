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
    n = 10^4
    m = 10^16
    p = 1234567891

    # Algorithm parameters
    l = isqrt(n) + 1

    # Solution
    data = [i for i in 2:n]

    # Do initial rounds until all elements are within l and l^2
    lower_bound = l
    upper_bound = l^2

    rounds = 0
    while rounds < m && !(lower_bound < minimum(data) && maximum(data) <= upper_bound)
        pos = argmin(data)
        data[pos] = data[pos]^2
        rounds += 1
    end

    data = sort(data)

    # Calculate number of batches
    missing_rounds = m - rounds
    batches = max(0, fld(missing_rounds, n - 1))

    # Calculate exponentiation for each element
    exponent = powermod(2, batches, p - 1)
    values = zeros(Int64, n - 1)
    for pos in 1:(n - 1)
        values[pos] = powermod(data[pos], exponent, p)
    end

    # Brute force the last few rounds
    brute_force_rounds = missing_rounds - batches * (n - 1)
    for pos in 1:brute_force_rounds
        values[pos] = mod(values[pos]^2, p)
    end

    result = mod(sum(values), p)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
