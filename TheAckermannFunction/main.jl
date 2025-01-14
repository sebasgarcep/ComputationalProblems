using Printf

# Calculate 2 ^^ n modulo s
function tetrationmod(phi_memo, n, s)
    # If n is small enough, calculate it directly
    if n <= 4
        r = 2
        t = n - 1
        while t > 0
            r = 2^r
            t -= 1
        end
        return mod(r, s)
    end

    if s == 1
        return 1
    end

    # Otherwise we will use recursion.
    # Factor s = 2^f * g
    f = 0
    g = s
    while g & 1 == 0
        f += 1
        g = g >> 1
    end

    # Because n >= 5, then it will equal 0 modulo 2^f since s is small enough
    # Because gcd(2, g) = 1, then the exponent can be calculated
    # modulo phi(g).
    e = tetrationmod(phi_memo, n - 1, phi_memo[g])
    p = powermod(2, e, g)

    # Applying the chinese remainder theorem we get
    return mod(2^f * mod(invmod(2^f, g) * p, s), s)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    s = 14^8

    # Algorithm parameters
    memo_size = 7^8
    mock = 10^8

    # Solution
    slots = [true for _ in 1:memo_size]
    slots[1] = false
    phi_memo = [x for x in 1:memo_size]
    for p in 1:memo_size
        if slots[p]
            for k in p:p:memo_size
                phi_memo[k] = fld(phi_memo[k], p) * (p - 1)
                if k != p
                    slots[k] = false
                end
            end
        end
    end

    # A(0, 0)
    n = 0
    result += mod(n + 1, s)
    result = mod(result, s)

    # A(1, 1)
    n = 1
    result += mod(n + 2, s)
    result = mod(result, s)

    # A(2, 2)
    n = 2
    result += mod(2 * n + 3, s)
    result = mod(result, s)

    # A(3, 3)
    n = 3
    result += mod(powermod(2, n + 3, s) - 3, s)
    result = mod(result, s)

    # A(4, 4)
    n = 4
    a = tetrationmod(phi_memo, n + 3, 7^8)
    # Use the chinese remainder theorem to get the desired result
    result += mod(2^8 * mod(invmod(2^8, 7^8) * a, s), s) - 3
    result = mod(result, s)

    # A(5, 5)
    n = 5
    # tetrationmod will reach the case s = 1 before it ever
    # reaches the end of the tetration
    a = tetrationmod(phi_memo, mock, 7^8)
    # Use the chinese remainder theorem to get the desired result
    result += mod(2^8 * mod(invmod(2^8, 7^8) * a, s), s) - 3
    result = mod(result, s)

    # A(6, 6)
    n = 5
    # tetrationmod will reach the case s = 1 before it ever
    # reaches the end of the tetration
    a = tetrationmod(phi_memo, mock, 7^8)
    # Use the chinese remainder theorem to get the desired result
    result += mod(2^8 * mod(invmod(2^8, 7^8) * a, s), s) - 3
    result = mod(result, s)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
