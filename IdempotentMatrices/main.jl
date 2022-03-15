using Printf
using LinearAlgebra

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 200

    # Algorithm parameters

    # Solution
    
    # Rank-0 Matrices
    result += 1

    # Rank-3 Matrices
    result += 1

    # Rank-1 and Rank-2 Matrices
    result_set = Set()

    # Solve a diopantine equation of the form xy = p for (x, y)
    solve_product_memo = [[] for _ in -(n + 1):(n + 1)]
    
    # p = 0
    divisors = []
    push!(divisors, (0, 0))
    for d in 1:(n + 1)
        push!(divisors, (d, 0))
        push!(divisors, (0, d))
        push!(divisors, (-d, 0))
        push!(divisors, (0, -d))
    end
    solve_product_memo[0 + n + 2] = divisors

    # p > 0
    for p in 1:(n + 1)
        divisors = []
        d = 1
        while d <= (n + 1) && d^2 <= p
            if mod(p, d) == 0
                c = fld(p, d)
                if c <= (n + 1)
                    push!(divisors, (d, c))
                    push!(divisors, (-d, -c))
                    if d^2 != p
                        push!(divisors, (c, d))
                        push!(divisors, (-c, -d))
                    end
                end
            end
            d += 1
        end
        solve_product_memo[p + n + 2] = divisors
    end

    # p < 0
    for p in -(n + 1):-1
        solve_product_memo[p + n + 2] = [(-x, y) for (x, y) in solve_product_memo[-p + n + 2]] 
    end

    for xa in -(n + 1):(n + 1)
        for yb in -(n + 1):(n + 1)
            zc = 1 - xa - yb
            if (n + 1) < abs(zc)
                continue
            end
            for (x, a) in solve_product_memo[xa + n + 2]
                for (y, b) in solve_product_memo[yb + n + 2]
                    for (z, c) in solve_product_memo[zc + n + 2]
                        xb = x * b
                        xc = x * c
                        ya = y * a
                        yc = y * c
                        za = z * a
                        zb = z * b

                        if n < abs(xb) ||
                            n < abs(xc) ||
                            n < abs(ya) ||
                            n < abs(yc) ||
                            n < abs(za) ||
                            n < abs(zb)
                            continue
                        end

                        m = [
                            xa xb xc;
                            ya yb yc;
                            za zb zc;
                        ]

                        if abs(xa) <= n &&
                            abs(yb) <= n &&
                            abs(zc) <= n
                            push!(result_set, m)
                        end

                        if abs(1 - xa) <= n &&
                            abs(1 - yb) <= n &&
                            abs(1 - zc) <= n
                            push!(result_set, I - m)
                        end
                    end
                end
            end
        end
    end
    
    result += length(result_set)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()