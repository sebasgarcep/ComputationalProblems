using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    p = 10^9 + 7

    # Algorithm parameters

    # Solution
    # Initialize f(x) = 1
    g = Set{Int128}()
    push!(g, Int128(0))

    e = 3^8
    k = 0
    while e > 0
        if e & 1 == 1
            # f_11(x)^{2^{52 + k}} = 1 + x^{2^{52 + k}} + x^{3 * 2^{52 + k}}

            # Multiply g by 1
            h = copy(g)

            # Multiply g by x^{2^{52 + k}}
            for key in g
                c = (Int128(1) << (52 + k)) + key

                if in(c, h)
                    delete!(h, c)
                else
                    push!(h, c)
                end
            end

            # Multiply g by x^{3 * 2^{52 + k}}
            for key in g
                c = 3 * (Int128(1) << (52 + k)) + key

                if in(c, h)
                    delete!(h, c)
                else
                    push!(h, c)
                end
            end

            # Update g
            g = h
        end
        e = e >> 1
        k += 1
    end

    for key in g
        result += powermod(2, key, p)
        result = mod(result, p)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
