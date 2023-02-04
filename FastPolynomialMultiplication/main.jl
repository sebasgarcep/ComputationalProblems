using LinearAlgebra
using Printf

function slowpolymul(pa::Vector{Int64}, pb::Vector{Int64})::Vector{Int64}
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

function fft(p; sgn=1.0)
    n = length(p)

    if n == 1
        return p
    end

    w = exp(sgn * 2.0 * pi * im / n)
    w_j = w .^ (0:((n >> 1) - 1))

    y_e = fft(p[1:2:end]; sgn=sgn)
    y_o = fft(p[2:2:end]; sgn=sgn)

    return [y_e .+ w_j .* y_o; y_e .- w_j .* y_o]
end

function fastpolymul(pa::Vector{Int64}, pb::Vector{Int64})::Vector{Int64}
    na = length(pa)
    nb = length(pb)
    nc = na + nb - 1

    # Coefficient to value representation
    pa_copy = complex(zeros(nc))
    pa_copy[1:na] = pa

    pb_copy = complex(zeros(nc))
    pb_copy[1:nb] = pb

    fa = fft(pa_copy)
    fb = fft(pb_copy)

    # Multiply values
    fc = fa .* fb

    # Value to coefficient representation
    res = (1.0 / nc) * fft(fc; sgn=-1.0)

    # Round to account for numerical error
    return round.(res)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    pa = [3, 4, 1]
    pb = [-1, 0, 0, 0, 1, 1]

    slowres = slowpolymul(pa, pb)
    println(slowres)

    fastres = fastpolymul(pa, pb)
    println(fastres)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
