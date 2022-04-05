using Printf

function all_products(primes)
    products = []
    for flag in 0:(2^length(primes) - 1)
        acc = 1
        pos = 1
        while flag > 0
            if flag & 1 == 1
                acc *= BigInt(primes[pos])
            end
            flag = flag >> 1
            pos += 1
        end
        push!(products, acc)
    end
    return sort(products)
end

function pseudo_square_root(primes)
    midpoint = length(primes) >> 1

    # Calculate all products of first half of primes
    primes_l = primes[1:midpoint]
    products_l = all_products(primes_l)

    # Calculate all products of second half of primes
    primes_r = primes[(midpoint+1):length(primes)]
    products_r = all_products(primes_r)

    # For each left product binary search the right product
    value = 0
    limit = isqrt(prod([BigInt(p) for p in primes]))
    for p_l in products_l
        lower = 1
        upper = length(products_r)
        while upper - lower > 1
            pos = (lower + upper) >> 1
            p_r = products_r[pos]
            if p_l * p_r <= limit
                lower = pos
            else
                upper = pos
            end
        end
        if p_l * products_r[upper] <= limit
            value = max(value, p_l * products_r[upper])
        else
            value = max(value, p_l * products_r[lower])
        end
    end

    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    bound = 190

    # Algorithm parameters

    # Solution

    # Find all primes
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

    result = mod(pseudo_square_root(primes), BigInt(10)^16)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
