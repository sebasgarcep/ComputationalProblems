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

function fastmulmod(pa::Vector{Int64}, pb::Vector{Int64}, n::Int64)::Vector{Int64}
    test_cases = [
        (998244353, 15311432, 23),
        (167772161, 243, 25),
        (469762049, 2187, 26),
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

    # Garner's algorithm
    pc = zeros(Int128, lc)
    pr = [p for (p, w, k) in test_cases]
    x = zeros(Int128, length(test_cases))
    for i in 1:lc
        for j in 1:length(test_cases)
            x[j] = res_list[j][i]
            # Calculate the minus terms of x_i
            for k in 1:(j - 1)
                t = mod(x[k], pr[j])
                for r in 1:(k - 1)
                    t = mod(t * pr[r], pr[j])
                end
                x[j] = mod(x[j] - t, pr[j])
            end
            # Calculate the prime inverses of x_i
            for k in 1:(j - 1)
                x[j] = mod(x[j] * invmod(pr[k], pr[j]), pr[j])
            end
            # Calculate p_i
            ti = mod(x[j], n)
            for k in 1:(j - 1)
                ti = mod(ti * pr[k], n)
            end
            pc[i] = mod(pc[i] + ti, n)
        end
    end

    return Int64.(pc[1:lc])
end

end