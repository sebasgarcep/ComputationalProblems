using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    l = 10^6 - 1

    # Algorithm parameters

    # Solution
    generated = Dict()
    for m in 2:isqrt(l)
        for n in 1:(m - 1)
            if (m & 1) == (n & 1)
                continue
            end
            if gcd(m, n) > 1
                continue
            end
            a = m^2 - n^2
            b = 2 * m * n
            c = m^2 + n^2
            for k in 1:fld(l, c)
                s = k * a
                t = k * b
                z = k * c
                if !haskey(generated, s)
                    generated[s] = []
                end
                push!(generated[s], (t, z))
                if !haskey(generated, t)
                    generated[t] = []
                end
                push!(generated[t], (s, z))
            end
        end
    end

    sols = Set()
    for w in keys(generated)
        vals = generated[w]
        k = length(vals)
        if k < 2
            continue
        end
        for i in 1:(k - 1)
            for j in (i + 1):k
                (s, x) = vals[i]
                (t, y) = vals[j]
                if y == x
                    continue
                elseif y < x
                    s, x, t, y = t, y, s, x
                end
                if mod(s * t, s + t) == 0
                    h = fld(s * t, s + t)
                    push!(sols, (x, y, h))
                end
            end
        end
    end

    result = length(sols)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
