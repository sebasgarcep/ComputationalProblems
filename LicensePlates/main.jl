using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters
    eps = 1e-12

    # Solution

    # The state vector is in the order (S_0 S_1 W)
    state = zeros(Float64, 1001)
    state[1] = 1.0 

    # Build the transition matrix
    transition = zeros(Float64, 1001, 1001)
    for r in 0:499
        # S_0(r) -> S_0(r)
        transition[r + 1, r + 1] = (r + 1) / 1000.0
        # S_0(r) -> S_0(r + 1)
        transition[r + 2, r + 1] = (998 - 2 * r) / 1000.0
        # S_0(r) -> S_1(r + 1)
        transition[r + 1 + 500, r + 1] = 1 / 1000.0
        # S_0(r) -> W
        transition[1001, r + 1] = r / 1000.0
    end

    for r in 1:500
        # S_1(r) -> S_1(r)
        transition[r + 500, r + 500] = r / 1000.0
        # S_1(r) -> S_1(r + 1)
        transition[r + 1 + 500, r + 500] = (1000 - 2 * r) / 1000.0
        # S_1(r) -> W
        transition[1001, r + 500] = r / 1000.0
    end

    delta = eps + 1.0
    n = 0
    while n < 2 || delta > eps
        state = transition * state
        n += 1
        delta = n * state[1001]
        result += delta
    end

    # Show result
    println(@sprintf("%.8f", result))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
