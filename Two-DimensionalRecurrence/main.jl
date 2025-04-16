include("../includes.jl")

using Printf

function main()
    # Problem parameters
    k = 50
    s = 1123581313

    # Algorithm parameters

    # Solution
    fib_memo = [0 for _ in 0:k]
    fib_memo[0 + 1] = 0
    fib_memo[1 + 1] = 1
    for i in 2:k
        fib_memo[i + 1] = fib_memo[i - 1 + 1] + fib_memo[i - 2 + 1]
    end

    result = 0
    for i in 2:k
        for j in 2:k
            result = mod(result + calc_a(fib_memo[i + 1], fib_memo[j + 1], s), s)
        end
    end

    return result
end

function calc_a(m, n, s)
    m_matrix = matpowmod(
        [
            1 1;
            3 2;
        ],
        m,
        s
    )
    n_matrix = matpowmod(
        [
            0 1;
            3 1;
        ],
        n,
        s
    )
    mn_matrix = matmulmod(
        m_matrix,
        n_matrix,
        s
    )
    b_vector = matmulmod(
        mn_matrix,
        [
            0;
            1;
        ],
        s
    )
    return b_vector[1]
end

function matmulmod(a, b, s)
    return mod.(a * b, s)
end

function matpowmod(a, k, s)
    b = [
        1 0;
        0 1;
    ]
    c = a
    v = k
    while v > 0
        if v & 1 == 1
            b = matmulmod(b, c, s)
        end
        c = matmulmod(c, c, s)
        v = v >> 1
    end
    return b
end

@time println(main())
