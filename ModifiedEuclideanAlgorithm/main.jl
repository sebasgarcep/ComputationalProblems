include("../includes.jl")

using Printf

function f(a, b)
    while a > 1 && b > 1
        if a > b
            a = fld(a, b)
        else
            b = fld(b, a)
        end
    end
    return max(a, b)
end

function e(n)
    return p(n - 1)
end

function p_naive(n)
    val = 0
    for a = 1:n
        for b in 1:n
            val += f(a, b)
        end
    end
    return val
end

function p(n)
    val = 0

    for a in 1:n
        for u in 1:fld(n, a)
            val += 2 * f(a, u) * r(n, a, u)
        end
    end

    val -= (n * (n + 1)) >> 1

    return val
end

function r(n, a, u)
    if u < fld(n, a)
        return a
    end
    return mod(n, a) + 1
end

function main()
    # Problem parameters
    n = 3 * 10^6

    # Algorithm parameters

    # Solution
    return e(n)
end

@time println(main())
