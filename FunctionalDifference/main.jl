include("../includes.jl")

using Printf

function main()
    # Problem parameters
    n = 10^7
    m = 10^9 + 7
    w = 10

    # Algorithm parameters

    # Solution
    result = 0

    # Compute some common inverses
    inv_memo = [0 for _ in 1:(2 * n)]
    inv_memo[1] = 1
    for k in 1:(2 * n)
        if inv_memo[k] == 0
            inv_memo[k] = invmod(k, m)
        end
    end

    # Compute the inverse factorials
    inv_fact_memo = [1 for _ in (0 + 1):(2 * n + 1)]
    for k in 2:(2 * n)
        inv_fact_memo[k + 1] = mod(inv_memo[k] * inv_fact_memo[k - 1 + 1], m)
    end

    # Compute left polynomial
    left_poly = [0 for _ in (0 + 1):(w + 1)]
    left_poly[0 + 1] = 1
    for i in 0:n
        term = [mod(-i * i, m), 1]
        left_poly = Polynomial.slowmulmod(left_poly, term, m)[(0 + 1):(w + 1)]
    end

    # Compute right polynomial
    right_poly = [0 for _ in (0 + 1):(w + 1)]
    for j in 1:n
        u_j = mod(j - powermod(j, 2 * (n + 1), m), m)
        v_j = mod((2 * (-1)^(n - j)) * mod(inv_fact_memo[n - j + 1] * inv_fact_memo[n + j + 1], m), m)
        u_j_v_j = mod(u_j * v_j, m)
        for k in 0:w
            term = powermod(inv_memo[j], 2 * (k + 1), m)
            term = mod(u_j_v_j * term, m)
            right_poly[k + 1] = mod(right_poly[k + 1] + term, m)
        end
    end

    result_poly = Polynomial.slowmulmod(left_poly, right_poly, m)
    result_poly = mod.(-result_poly, m)

    result = mod(result_poly[w + 1], m)
    return result
end

@time println(main())
