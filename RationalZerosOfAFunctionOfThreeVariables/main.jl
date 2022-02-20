using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    order = 35

    # Algorithm parameters
    fractions = Set()
    for b in 2:order
        for a in 1:(b - 1)
            push!(fractions, Int128(a) // Int128(b))
        end
    end

    solutions = Set()
    for x in fractions
        for y in fractions
            if x > y
                continue
            end
            for z in fractions
                for n in [-2, -1, 1, 2]
                    if x^n + y^n == z^n
                        push!(solutions, x + y + z)
                        break
                    end
                end
            end
        end
    end

    solutions_sum = sum(solutions)
    result = numerator(solutions_sum) + denominator(solutions_sum)

    # Solution

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
