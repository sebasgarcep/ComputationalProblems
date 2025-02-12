include("../includes.jl")

using Printf

using .Common: iroot

function is_palindrome(x)
    d = digits(x)
    return d == reverse(d)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    limit = 10^9

    count = [0 for _ in 1:limit]

    for a in 1:isqrt(limit)
        for b in 1:iroot(limit, 3)
            c = a^2 + b^3
            if c > limit
                break
            end
            count[c] += 1
        end
    end

    num_found = 0
    for c in 1:limit
        if count[c] == 4 && is_palindrome(c)
            num_found += 1
            result += c
            if num_found >= 5
                break
            end
        end
    end

    if num_found < 5
        throw(error("Did not find enough numbers."))
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
