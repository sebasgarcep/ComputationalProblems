using Printf

function modpow(x, n, m)
    mask = reverse(string(n, base = 2))
    p = Int128(1)
    s = x
    for k in 1:length(mask)
        if mask[k] == '1'
            p = mod(p * s, m)
        end
        s = mod(s * s, m)
    end
    return p
end

function main()
    # Begin time measurement
    start = time()
    result = Int128(0)

    # Problem parameters
    k = Int128(10^8)
    n = Int128(10^16)
    m = Int128(1000000007)

    # Algorithm parameters
    order_2 = Int128(500000003)

    # Solution
    # Precalculate factorial
    factorialmod = [Int128(1) for _ in Int128(0):k]
    for i in Int128(1):k
        factorialmod[i + Int128(1)] = mod(factorialmod[i] * i, m)
    end

    # Calculate result
    pow_base = modpow(Int128(2), mod(n * invmod(k, order_2), order_2), m)
    permutations_num = factorialmod[k + Int128(1)]
    for b in Int128(0):fld(k, Int128(2))
        a = k - Int128(2) * b
        pow_2 = modpow(pow_base, mod(a, order_2), m)
        permutations_den_a = factorialmod[a + Int128(1)]
        permutations_den_b = factorialmod[b + Int128(1)]
        permutations_den = permutations_den_a * mod(permutations_den_b * permutations_den_b, m)
        permutations_den = mod(permutations_den, m)
        term = mod(pow_2 * invmod(permutations_den, m), m)
        result = mod(result + term, m)
    end
    result = mod(permutations_num * result, m)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
