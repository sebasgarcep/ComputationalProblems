using Printf
using LinearAlgebra
using AbstractAlgebra

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

function get_factorization(n)
    if n == 1
        return []
    end
    factorization = []
    remaining = n
    if remaining & 1 == 0
        count = 0
        while remaining & 1 == 0
            remaining = remaining >> 1
            count += 1
        end
        push!(factorization, (2, count))
    end
    d = 3
    while d * d <= remaining
        count = 0
        while mod(remaining, d) == 0
            remaining = fld(remaining, d)
            count += 1
        end
        if count > 0
            push!(factorization, (d, count))
        end
        d += 2
    end
    if remaining > 1
        push!(factorization, (remaining, 1))
    end
    return factorization
end

function get_divisors_alt(factorization, divisors, k, a)
    if k > length(factorization)
        push!(divisors, a)
        return
    end
    (p, e) = factorization[k]
    factor = 1
    for _ in 0:e
        get_divisors_alt(factorization, divisors, k + 1, a * factor)
        factor *= p
    end
end

function get_divisors(n)
    factorization = get_factorization(n)
    divisors = []
    get_divisors_alt(factorization, divisors, 1, 1)
    return sort(divisors)
end

function polynomial_multiply(f, g, k, m)
    r = [0 for _ in 0:(k - 1)]
    for i in 0:(k - 1)
        for j in 0:(k - 1)
            c = mod(f[i + 1] * g[j + 1], m)
            p = mod(i + j, k)
            r[p + 1] = mod(r[p + 1] + c, m)
        end
    end
    return r
end

function polynomial_powermod(f, k, n, m)
    r = [0 for _ in 0:(k - 1)]
    r[0 + 1] = 1
    flag = 1
    g = f
    while flag <= n
        if n & flag != 0
            r = polynomial_multiply(r, g, k, m)
        end
        g = polynomial_multiply(g, g, k, m)
        flag = flag << 1
    end
    return r
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1234567898765
    k = 4321
    mod_size = 10^9

    # Algorithm parameters

    # Solution
    divisors = get_divisors(n)

    # Calculate A matrix
    a = zeros(Int64, k, k)
    for j in 0:(k - 1)
        for d in divisors
            a[mod(j + d, k) + 1, j + 1] += 1
        end
    end

    # Calculate initial value of g
    g = zeros(Int64, k)
    g[mod(n, k) + 1] = 1

    f = a[:, 1]
    r = polynomial_powermod(f, k, n, mod_size)

    b = zeros(Int64, k, k)
    for i in 1:k
        for j in 0:(k - 1)
            b[mod(j + i - 1, k) + 1, j + 1] = r[i]
        end
    end

    result = mod((b * g)[1], mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
