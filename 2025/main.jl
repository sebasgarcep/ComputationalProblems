include("../includes.jl")

using Printf

function main()
    # Problem parameters
    n = 16

    # Algorithm parameters

    # Solution
    found = Set()
    for k in 1:fld(n + 1, 2)
        lower_limit = 10^(k - 1)
        upper_limit = min(10^k, fld(10^(2 * k), 4 * (10^k - 1)))
        for b in lower_limit:upper_limit
            d2 = 10^(2 * k) + 4 * b * (1 - 10^k)
            d = isqrt(d2)
            if d2 < 0 || d & 1 == 1 || d2 != d^2
                continue
            end
            a1 = fld(10^k - 2 * b + d, 2)
            if a1 > 0
                v_a = Int128(a1 + b)^2
                v_c = Int128(a1) * Int128(10)^k + Int128(b)
                if v_a == v_c && length(digits(v_a)) <= n
                    push!(found, v_a)
                end
            end
            a2 = fld(10^k - 2 * b - d, 2)
            if a2 > 0
                v_a = Int128(a2 + b)^2
                v_c = Int128(a2) * Int128(10)^k + Int128(b)
                if v_a == v_c && length(digits(v_a)) <= n
                    push!(found, v_a)
                end
            end
        end
    end

    result = sum(found)
    return result
end

@time println(main())
