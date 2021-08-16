using Printf
using Memoize

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = Int64(1e12)
    m = 50
    mod_size = 1000000007

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    mu_memo = [1 for _ in 1:bound]
    factorization_memo = [Dict() for _ in 1:bound]
    poly_sum_coeffs = []
    poly_sum_coeffs_num = []
    poly_sum_coeffs_den = []

    function init()
        # Sieve
        slots = [true for _ in 1:bound]
        slots[1] = false
        for p in 2:bound
            if slots[p]
                for k in (2 * p):p:bound
                    slots[k] = false
                end
    
                for k in p:p:bound
                    mu_memo[k] *= -1
                    factorization_memo[k][p] = 1
                end
    
                acc = p * p
                for k in acc:acc:bound
                    mu_memo[k] = 0
                end

                while acc <= bound
                    for k in acc:acc:bound
                        factorization_memo[k][p] += 1
                    end
                    acc *= p
                end
            end
        end

        # Construct Polynomial Sum coefficients
        poly_sum_coeffs = [
            [Int128(1) // Int128(2), Int128(1) // Int128(2)],
        ]

        for k in 2:m
            next_poly_sum_coeffs = []
            for i in 1:(k + 1)
                c_i = 1 / (poly_sum_coeffs[k - 1][k] + 1)
                if i == k + 1
                    c_i *= poly_sum_coeffs[k - 1][k]
                else
                    if i == 1
                        term = poly_sum_coeffs[k - 1][i]
                    else
                        term = poly_sum_coeffs[k - 1][i - 1] + poly_sum_coeffs[k - 1][i]
                    end
                    for j in max(1, i - 1):(k - 1)
                        term -= poly_sum_coeffs[k - 1][j] * poly_sum_coeffs[j][i]
                    end
                    c_i *= term
                end
                push!(next_poly_sum_coeffs, c_i)
            end
            push!(poly_sum_coeffs, next_poly_sum_coeffs)
        end
        
        poly_sum_coeffs_den = [lcm([denominator(x) for x in coeffs]) for coeffs in poly_sum_coeffs]
        poly_sum_coeffs_num = [
            [numerator(x) * fld(poly_sum_coeffs_den[index], denominator(x)) for x in coeffs] for (index, coeffs) in enumerate(poly_sum_coeffs)
        ]        
        
        # Reduce the coefficients using the mod
        poly_sum_coeffs_num = [[Int64(mod(x, mod_size)) for x in coeffs] for coeffs in poly_sum_coeffs_num]
        # Invert the denominator coefficient using invmod just once
        poly_sum_coeffs_den = [Int64(invmod(x, mod_size)) for x in poly_sum_coeffs_den]
    end

    @memoize function poly_sum(k, x)
        value = 0
        x_i = 1
        for i in 1:(k + 1)
            c_i = poly_sum_coeffs_num[k][i]
            x_i = mod(x_i * x, mod_size)
            term = mod(c_i * x_i, mod_size)
            value = mod(value + term, mod_size)
        end
        value = mod(value * poly_sum_coeffs_den[k], mod_size)
        return value
    end

    @memoize function h_k(k, p)
        p_k = powermod(p, k, mod_size)
        return mod(-p_k * (p_k - 1), mod_size)
    end

    function s()
        value = 0
        for b in 1:iroot(n, 3)
            if mu_memo[b] == 0
                continue
            end
            for a in 1:isqrt(fld(n, b^3))
                d = a^2 * b^3
                n_d = mod(fld(n, d), mod_size)

                keys_a = keys(factorization_memo[a])
                keys_b = keys(factorization_memo[b])
                keys_ab = union(keys_a, keys_b)

                for k in 1:m
                    h_k_val = 1
                    for p in keys_ab
                        h_k_val = mod(h_k_val * h_k(k, p), mod_size)
                    end

                    t_k_val = poly_sum(k, n_d)
                    term = mod(h_k_val * t_k_val, mod_size)
                    value = mod(value + term, mod_size)
                end
            end
        end
        return value
    end

    init()
    result = s()

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
