using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 100

    # Algorithm parameters
    eps = 1e-14

    # Solution
    n_half = n >> 1

    state = zeros(Float64, n_half + 1)
    state[n_half + 1] = 1.0

    transition = zeros(Float64, n_half + 1, n_half + 1)

    for r in 1:n_half
        if r == 1
            transition[r - 1 + 1, r + 1] = 8.0 / 36.0
            transition[r + 1, r + 1] = 19.0 / 36.0
            transition[r + 1 + 1, r + 1] = 8.0 / 36.0
            transition[r + 2 + 1, r + 1] = 1.0 / 36.0
        elseif r == n_half - 1
            transition[r - 2 + 1, r + 1] = 1.0 / 36.0
            transition[r - 1 + 1, r + 1] = 8.0 / 36.0
            transition[r + 1, r + 1] = 19.0 / 36.0
            transition[r + 1 + 1, r + 1] = 8.0 / 36.0
        elseif r == n_half
            transition[r - 2 + 1, r + 1] = 2.0 / 36.0
            transition[r - 1 + 1, r + 1] = 16.0 / 36.0
            transition[r + 1, r + 1] = 18.0 / 36.0
        else
            transition[r - 2 + 1, r + 1] = 1.0 / 36.0
            transition[r - 1 + 1, r + 1] = 8.0 / 36.0
            transition[r + 1, r + 1] = 18.0 / 36.0
            transition[r + 1 + 1, r + 1] = 8.0 / 36.0
            transition[r + 2 + 1, r + 1] = 1.0 / 36.0
        end
    end

    delta = eps + 1.0
    n = 0
    while n < 100 || delta > eps
        state = transition * state
        n += 1
        delta = n * state[1]
        result += delta
    end

    # Show result
    println(@sprintf("%.6f", result))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
