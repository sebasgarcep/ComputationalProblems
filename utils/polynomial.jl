module Polynomial

function fft(p; sgn=1.0)
    n = length(p)

    if n == 1
        return p
    end

    w = exp(sgn * 2.0 * pi * im / n)
    w_j = w .^ (0:((n >> 1) - 1))

    y_e = fft(p[1:2:end]; sgn=sgn)
    y_o = fft(p[2:2:end]; sgn=sgn)

    rhs = w_j .* y_o

    return [y_e .+ rhs; y_e .- rhs]
end

function slowmul(pa::Vector{Int64}, pb::Vector{Int64})::Vector{Int64}
    da = length(pa) - 1
    db = length(pb) - 1
    dc = da + db
    pc = zeros(dc + 1)

    for i in 0:da
        for j in 0:db
            pc[i + j + 1] += pa[i + 1] * pb[j + 1]
        end
    end

    return pc
end

function slowmulmod(pa::Vector{Int64}, pb::Vector{Int64}, m::Int64)::Vector{Int64}
    da = length(pa) - 1
    db = length(pb) - 1
    dc = da + db
    pc = zeros(dc + 1)

    for i in 0:da
        for j in 0:db
            pc[i + j + 1] = mod(pc[i + j + 1] + mod(pa[i + 1] * pb[j + 1], m), m)
        end
    end

    return pc
end

function fastmul(pa::Vector{Int64}, pb::Vector{Int64})::Vector{Int64}
    na = length(pa)
    nb = length(pb)
    nc = na + nb - 1

    np = 1
    while np < nc
        np = np << 1
    end

    # Coefficient to value representation
    pa_copy = complex(zeros(np))
    pa_copy[1:na] = pa

    pb_copy = complex(zeros(np))
    pb_copy[1:nb] = pb

    fa = fft(pa_copy)
    fb = fft(pb_copy)

    # Multiply values
    fc = fa .* fb

    # Value to coefficient representation
    res = (1.0 / np) * fft(fc; sgn=-1.0)
    res = res[1:nc]

    # Round to account for numerical error
    return round.(res)
end

function ntt(p::Vector{Int64}, n::Int64, w::Int64, k::Int64)
    if k == 0
        return p
    end

    w_j = ones(Int64, 1 << (k - 1))
    for i in 2:(1 << (k - 1))
        w_j[i] = mod(w_j[i - 1] * w, n)
    end

    y_e = ntt(p[1:2:end], n, mod(w * w, n), k - 1)
    y_o = ntt(p[2:2:end], n, mod(w * w, n), k - 1)

    rhs = mod.(w_j .* y_o, n)

    result = [mod.(y_e .+ rhs, n); mod.(y_e .- rhs, n)]

    return result
end

# FIXME: STILL HAS A BUG
function fastmulmod(pa::Vector{Int64}, pb::Vector{Int64}, n::Int64)::Vector{Int64}
    test_cases = [
        (998244353, 15311432, 23),
        (167772161, 243, 25),
        # We don't need the third prime for now
        # (469762049, 2187, 26),
    ]

    # Calculate sizes
    la = length(pa)
    lb = length(pb)
    lc = la + lb - 1

    # Round lc up to the next power of two
    lp = 1
    kp = 0
    while lp < lc
        lp = lp << 1
        kp += 1
    end

    # Zero pad polynomials so their sizes match
    pa_copy = zeros(Int64, lp)
    pa_copy[1:la] = pa
    pb_copy = zeros(Int64, lp)
    pb_copy[1:lb] = pb
    pa = pa_copy
    pb = pb_copy

    # Case-wise fast polynomial multiplication
    res_list = []
    for (p, w, k) in test_cases
        wp = powermod(w, 1 << (k - kp), p)

        fa = ntt(pa, p, wp, kp)
        fb = ntt(pb, p, wp, kp)

        fc = mod.(fa .* fb, p)

        wp_inv = powermod(wp, (1 << kp) - 1, p)
        res = mod.(invmod(1 << kp, p) * ntt(fc, p, wp_inv, kp), p)

        push!(res_list, res)
    end

    # Garner's algorithm with two primes
    pc = zeros(lc)
    p_1 = test_cases[1][1]
    p_2 = test_cases[2][1]
    for i in 1:lc
        x_1 = res_list[1][i]
        x_2 = mod(mod(res_list[2][i] - x_1, p_2) * invmod(p_1, p_2), p_2)
        pc[i] = mod(x_1 + mod(x_2 * p_1, n), n)
    end

    return pc[1:lc]
end

end