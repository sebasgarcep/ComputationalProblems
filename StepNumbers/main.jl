using Printf

function bit_set(n::Int64, d::Int64, v::Int64)::Int64
    pos = 1 << d
    if v == 1
        return n | pos
    else
        return n - (n & pos)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 40

    # Algorithm parameters

    # Solution
    h = zeros(Int64, n, 10, 1 << 10)

    # Base case
    for d in 1:9
        f = 1 << d
        h[1, d + 1, f + 1] = 1
    end

    for k in 2:n
        for d in 0:9
            for f in 0:((1 << 10) - 1)
                if (f & (1 << d)) == 0
                    h[k, d + 1, f + 1] = 0
                else
                    if d < 9
                        for g in 0:1
                            h[k, d + 1, f + 1] += h[k - 1, d + 2, bit_set(f, d, g) + 1]
                        end
                    end
                    if d > 0
                        for g in 0:1
                            h[k, d + 1, f + 1] += h[k - 1, d, bit_set(f, d, g) + 1]
                        end
                    end
                end
            end
        end
    end

    for k in 1:n
        for d in 0:9
            result += h[k, d + 1, 1 << 10]
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
