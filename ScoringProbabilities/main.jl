using Printf
using Polynomials

function probability(q)
    p = Polynomial([1]) 
    for x in 1:50
        m = Polynomial([x / q, 1.0 - x / q])
        p = p * m
    end
    return p.coeffs[20 + 1]
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    r = 0.02

    # Algorithm parameters
    eps = 1e-14

    # Solution
    q_min = 50.0
    
    q_max = q_min
    while probability(q_max) > r
        q_max *= 2
    end

    q_mid = (q_min + q_max) / 2.0
    current = probability(q_mid)
    while abs(current - r) > eps
        if current > r
            q_min = q_mid
        else
            q_max = q_mid
        end
        q_mid = (q_min + q_max) / 2.0
        current = probability(q_mid)
    end

    result = q_mid

    # Show result
    println(@sprintf("%.10f", result))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
