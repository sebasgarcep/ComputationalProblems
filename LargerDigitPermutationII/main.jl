using Printf

function are_digits_decreasing(a)
    d = digits(a)
    for k in 1:(length(d) - 1)
        if d[k] > d[k + 1]
            return false
        end
    end
    return true
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters
    m = 10^9 + 7
    t = 9
    s = 10^t

    # Solution
    """
    found = Set()
    iters = 0
    a = 0
    while !(a in found)
        push!(found, a)
        if are_digits_decreasing(a)
            println((a, iters))
        end
        iters += 1
        a = mod(mod(a * a, s) + 2, s)
    end
    println((a, iters))
    """

    """
    t = 14
    s = 10^t
    a = Int128(0)
    for _ in 1:429120
        a = mod(mod(a * a, s) + Int128(2), s)
    end

    for k in 1:40
        println((lpad(a, t, "0"), k))
        for _ in 1:625000
            a = mod(mod(a * a, s) + Int128(2), s)
        end
    end
    """

    for f in [9998886, 99998886, 999998886, 9999998886, 99999998886]
        t = length(digits(f))
        s = BigInt(10)^BigInt(t)
        iters = 0
        a = BigInt(0)
        while a != f
            iters += 1
            a = mod(mod(a * a, s) + BigInt(2), s)
        end
        println((iters, a))
    end

    # Show result
    # println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
