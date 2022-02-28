using Printf
using LinearAlgebra
using AbstractAlgebra

function berlekamp_massey(K, x, s)
    l = 0
    m = 0
    v = K(1)
    c = K(1)
    b = K(1)

    for i in 0:degree(s)
        m += 1

        d = coeff(s, i)
        for j in 1:l
            d += coeff(c, j) * coeff(s, i - j)
        end

        if d == 0
            continue
        end

        t = c
        c = c - d * inv(v) * x^m * b

        if 2 * l > i
            continue
        end

        l = i + 1 - l
        b = t
        v = d
        m = 0
    end

    return c
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 5000
    m = 10^12
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    a = zeros(Int64, n - 1, n - 1)
    for i in 1:(n - 1)
        for j in 1:i
            a[n - i, j] = 1
        end
    end

    f_vecs = []
    vals = [1]
    f = ones(Int64, n - 1)
    for _ in 1:(2 * (n - 1))
        push!(f_vecs, f)
        push!(vals, sum(f))
        f = mod.(a * f, mod_size)
    end

    K = GF(mod_size)
    P, x = PolynomialRing(K, "x")
    s = polynomial(K, reverse(vals), "x")
    c = berlekamp_massey(K, x, s)

    r = powermod(x, m - 1, c)
    coeffs = [data(r_i) for r_i in collect(coefficients(r))]

    result_vec = zeros(Int64, n - 1)
    for i in 1:length(coeffs)
        result_vec += mod.(coeffs[i] * f_vecs[i], mod_size)
        result_vec = mod.(result_vec, mod_size)
    end

    result = mod(sum(result_vec), mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
