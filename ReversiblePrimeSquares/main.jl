using Printf

function test(slots, pa)
    sa = pa^2

    da = digits(sa)
    db = reverse(da)

    sb = foldr((a, b) -> muladd(10, b, a), db, init=0)

    if sa == sb
        return false
    end

    pb = isqrt(sb)
    if pb^2 != sb
        return false
    end

    return slots[pb]
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters
    n = 10^8

    # Solution
    slots = [true for _ in 1:n]
    slots[1] = false
    primes = []
    for p in 2:n
        if slots[p]
            push!(primes, p)
            for k in (p^2):p:n
                slots[k] = false
            end
        end
    end

    found = 0
    for p in primes
        if found >= 50
            break
        end

        if test(slots, p)
            result += p^2
            found += 1
        end
    end

    println(found)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
