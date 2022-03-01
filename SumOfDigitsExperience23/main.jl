using Printf
using LinearAlgebra
using SparseArrays

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function get_elements(p, max_d)
    size_a = max_d * p
    a = spzeros(Int128, size_a, size_a)

    for v in 0:(p - 1)
        for u in 1:max_d
            pos_out = v * max_d + u
            for r in 0:9
                u_prime = u - r
                v_prime = mod((v - r) * invmod(10, p), p)
                pos_inp = v_prime * max_d + u_prime
                if 1 <= u_prime && u_prime <= max_d
                   a[pos_out, pos_inp] += 1 
                end
            end
        end
    end

    f_hat = spzeros(Int128, size_a)
    for r in 1:9
        u = r
        v = mod(r, p)
        pos = v * max_d + u
        f_hat[pos] += 1
    end

    return (a, f_hat)
end

function matrix_powermod(x, n, m)
    acc = I
    mat = x
    flag = 1
    while flag <= n
        if flag & n != 0
            acc = mod.(acc * mat, m)
        end
        flag = flag << 1
        mat = mod.(mat * mat, m)
    end
    return acc
end

function mod_power_sum(x, n, m)
    if n == 0
        return 1
    end
    if n == 1
        return mod.(I + x, m)
    end
    if n & 1 == 0
        return mod.(mod_power_sum(x, n - 1, m) + matrix_powermod(x, n, m), m)
    end
    return mod.((I + x) * mod_power_sum(mod.(x * x, m), n >> 1, m), m)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 11^12
    p = 23
    max_d = 23
    mod_size = 10^9

    # Algorithm parameters

    # Solution
    (a, f_hat) = get_elements(p, max_d)

    f_rst = mod_power_sum(a, n - 1, mod_size) * f_hat

    result = mod.(f_rst[0 * max_d + max_d], mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
