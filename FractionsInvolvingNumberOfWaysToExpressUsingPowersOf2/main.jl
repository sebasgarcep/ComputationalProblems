using Printf

function nice_representation(k, m)
    v = BigInt(2)^k + BigInt(m)
    k_next = Int64(floor(log2(v)))
    m_next = v - BigInt(2)^k_next
    return (k_next, m_next)
end

function equal_representations(r1, r2)
    (k1, m1) = r1
    (k2, m2) = r2
    v1 = BigInt(2)^k1 + BigInt(m1)
    v2 = BigInt(2)^k2 + BigInt(m2)
    return v1 == v2
end

function g(k, m)
    if m == 0
        return (0, 0)
    end
    if k == 0
        return g(1, m - 1)
    end
    if m == -1
        return (0, k)
    end
    if m == 1
        return (0, k + 1)
    end
    (g_k1, g_m1) = g(k - 1, fld(m, 2))
    if m & 1 == 1
        (g_k2, g_m2) = g(k - 1, fld(m, 2) + 1)
        g_k1 += g_k2
        g_m1 += g_m2
    end
    return (g_k1, g_m1)
end

function solve(q, p)
    if q == 1
        return (p - 1, 0)
    end
    if p == 1
        return (q, -1)
    end
    if q < p
        q_prime, p_prime = q, p - q
    else
        q_prime, p_prime = q - p, p
    end
    k, m = solve(q_prime, p_prime)
    if equal_representations(g(k, m), (0, q))
        return (k + 1, 2 * m)
    else
        return (k + 1, 2 * m + 1)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    q = 987654321
    p = 123456789

    # Algorithm parameters
    bound = 10^6

    # Solution

    # Make sure they are coprime
    gcd_pq = gcd(p, q)
    p = fld(p, gcd_pq)
    q = fld(q, gcd_pq)

    # Solve the fraction
    (k, m) = solve(q, p)
    (k, m) = nice_representation(k, m)
    expansion = []
    count = 0
    flag = m & 1
    while m > 0
        d = m & 1
        if flag != d
            push!(expansion, count)
            count = 0
            flag = d
        end
        count += 1
        m = m >> 1
        k -= 1
    end
    if k == 0
        count += 1
    end
    push!(expansion, count)
    if k > 0
        push!(expansion, k)
        push!(expansion, 1)
    end
    result = join(reverse(expansion), ",")

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
