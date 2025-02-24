include("../includes.jl")

using Printf

using .PrimeSieve

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^8
    m = 10^16

    # Algorithm parameters

    # Solution
    bound = Int64(ceil(n * 1.5))
    sieve = PrimeSieve.Calculator(bound)

    slots = [true for _ in 1:bound]
    for p in sieve.primes
        pp = period(p, Int64(ceil(bound / p)))
        if pp === nothing
            continue
        end
        step = p * pp
        for k in step:step:bound
            slots[k] = false
        end
    end

    c = 0
    a_d, b_d = 0, 1
    a_f, b_f = 0.0, 1.0
    e_f = 0
    for k in 1:bound
        a_d, b_d = b_d, mod(a_d + b_d, m)
        a_f, b_f = b_f, a_f + b_f
        while a_f > 10.0
            a_f = a_f / 10.0
            b_f = b_f / 10.0
            e_f += 1
        end
        if slots[k]
            c += 1
        end
        if c == n
            result = @sprintf("%d,%.1fe%d", a_d, a_f, e_f)
            break
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

function period(n, bound)
    k = 1
    a, b = 1, 1
    while a != 0
        a, b = b, mod(a + b, n)
        k += 1
        if k > bound
            return nothing
        end
    end
    return k
end

main()
