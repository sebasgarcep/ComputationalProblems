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
    m = 10^8
    k = 987654321

    # Algorithm parameters

    # Solution
    for n in 1:30
        v = [
            mod(powermod(8, n, m) - 3 * n, m)
            powermod(4, n, m)
            powermod(2, n, m)
        ]
        t = [powermod(2, n, m) 0 mod(-n, m); 1 0 0; 0 1 0]
        t_k = powermod_matrix(t, k - 3, m)
        r = mod((t_k * v)[1], m)
        result = mod(result + r - 1, m)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
