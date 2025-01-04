using Printf

function multinomial(v::Vector{Int128})::Int128
    total = 0
    denom = 1
    for i in 1:length(v)
        total += v[i]
        denom *= factorial(v[i])
    end
    numer = factorial(total)
    return fld(numer, denom)
end

function build_d(v::Vector{Int128})::Int128
    d = 0
    for i in 1:length(v)
        for _ in 1:v[i]
            d = 10 * d + (i - 1)
        end
    end
    return d
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 18
    m = 1123455689

    # Algorithm parameters

    # Solution
    for z_0::Int128 in 0:n
        for z_1::Int128 in 0:(n - z_0)
            for z_2::Int128 in 0:(n - z_0 - z_1)
                for z_3::Int128 in 0:(n - z_0 - z_1 - z_2)
                    for z_4::Int128 in 0:(n - z_0 - z_1 - z_2 - z_3)
                        for z_5::Int128 in 0:(n - z_0 - z_1 - z_2 - z_3 - z_4)
                            for z_6::Int128 in 0:(n - z_0 - z_1 - z_2 - z_3 - z_4 - z_5)
                                for z_7::Int128 in 0:(n - z_0 - z_1 - z_2 - z_3 - z_4 - z_5 - z_6)
                                    for z_8::Int128 in 0:(n - z_0 - z_1 - z_2 - z_3 - z_4 - z_5 - z_6 - z_7)
                                        z_9::Int128 = n - z_0 - z_1 - z_2 - z_3 - z_4 - z_5 - z_6 - z_7 - z_8
                                        z = [z_0, z_1, z_2, z_3, z_4, z_5, z_6, z_7, z_8, z_9]
                                        s = multinomial(z)
                                        d = build_d(z)
                                        result = mod(result + mod(s * d, m), m)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
