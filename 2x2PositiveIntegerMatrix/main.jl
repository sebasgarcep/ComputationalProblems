using Printf

function extended_euclidean(a, b)
    (curr_s, prev_s) = (0, 1)
    (curr_t, prev_t) = (1, 0)
    (curr_r, prev_r) = (b, a)
    while curr_r != 0
        quotient = fld(prev_r, curr_r)
        (prev_r, curr_r) = (curr_r, prev_r - quotient * curr_r)
        (prev_s, curr_s) = (curr_s, prev_s - quotient * curr_s)
        (prev_t, curr_t) = (curr_t, prev_t - quotient * curr_t)
    end
    return prev_s, prev_t # Bezout Coefficients
    # return prev_r # Greeatest Common Divisor
    # return curr_t, curr_s # Quotients by the GCD
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7 - 1

    # Algorithm parameters

    # Solution
    for z1 in 1:isqrt(2 * n)
        for z2 in 1:min(isqrt(2 * n - z1^2), z1 - 1)
            if mod(z1^2 + z2^2, 2) != 0 || mod(z1^2 - z2^2, 4) != 0
                continue
            end
            tau = fld(z1^2 + z2^2, 2)
            s = fld(z1^2 - z2^2, 4)
            if s + 1 > tau - s - 1
                continue
            end
            delta = s^2
            t1 = isqrt(tau + 2 * s)
            t2 = isqrt(tau - 2 * s)
            t_gcd = gcd(t1, t2)
            if mod(2 * s, t_gcd) != 0
                continue
            end
            alpha_mult, beta_mult = extended_euclidean(t1, t2)
            alpha = fld(alpha_mult * 2 * s, t_gcd)
            beta = fld(-beta_mult * 2 * s, t_gcd)
            t_lcm = fld(t1 * t2, t_gcd)
            k_min = cld(alpha * t1 + beta * t2 - 2 * (tau - s - 1), 2 * t_lcm)
            k_max = fld(alpha * t1 + beta * t2 - 2 * (s + 1), 2 * t_lcm)
            for k in k_min:k_max
                kd1 = alpha - k * fld(t2, t_gcd)
                kd2 = beta - k * fld(t1, t_gcd)
                d_num = kd1 * t1 + kd2 * t2
                if mod(d_num, 2) != 0
                    continue
                end
                d = fld(d_num, 2)
                a = tau - d
                # Calculate b, c
                b_max = a * d - delta
                t_lcm_2 = t_lcm^2
                if mod(b_max, t_lcm_2) != 0
                    continue
                end
                remainder = fld(b_max, t_lcm_2)
                for b_pr in 1:isqrt(remainder)
                    if mod(remainder, b_pr) != 0
                        continue
                    end
                    c_pr = fld(remainder, b_pr)
                    if b_pr == c_pr
                        result += 1
                    else
                        result += 2
                    end
                end
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
