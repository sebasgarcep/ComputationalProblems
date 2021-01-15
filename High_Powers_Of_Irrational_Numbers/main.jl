using LinearAlgebra
using Printf

function powermod_matrix(x, p, m)
    e = 1
    v = x
    d1, d2 = size(x)
    r = Matrix(I, d1, d2)
    while true
        if (e & p) != 0
            r *= v
            r = mod.(r, m)
        end
        e *= 2
        if e > p
            break
        end
        v *= v
        v = mod.(v, m)
    end
    return r
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = 999999937
    n = 5000000

    # Algorithm parameters
    base = 1
    base_2 = 1

    # Solution
    for a in 1:n
        if a > base_2
            base += 1
            base_2 = base * base
        end
        a_2 = a * a
        x = base
        y = a
        if a == base_2
            e = 0
        else
            e = 1
        end
        t = [x y; 1 x]
        t = powermod_matrix(t, a_2, m)
        t = tr(t)
        result = mod(result + t - e, m)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
