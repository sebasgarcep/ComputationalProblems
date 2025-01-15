using Printf
using Memoize

function euler_totient(n::Int128)::Int128
    t = n
    p = Int128(2)
    r = Int128(1)
    while t > 1
        e = Int128(0)
        while mod(t, p) == 0
            e += Int128(1)
            t = fld(t, p)
        end
        if e > 0
            r *= (p - 1) * p^(e - 1)
        end
        p += Int128(1)
    end
    return r
end

# Compute 2 ^^ n for very large n compared to m
function tetrationmod(m::Int128)::Int128
    if m == 1
        return 1
    end

    # Factorize m = 2^f * g
    f = Int128(0)
    g = m
    while g & Int128(1) == 0
        f += Int128(1)
        g = g >> 1
    end

    # 2 ^^ n = 0 mod 2^f, since f is not large enough
    # To compute 2 ^^ n = 2^e mod g we can reduce the exponent
    # modulo phi(g)
    e = tetrationmod(euler_totient(g))
    p = powermod(Int128(2), e, g)

    # Use the chinese remainder theorem to find result
    return mod(Int128(2)^f * mod(invmod(Int128(2)^f, g) * p, m), m)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = Int128(10^15)

    # Algorithm parameters

    # Solution
    result = mod(tetrationmod(m) - 3, m)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
