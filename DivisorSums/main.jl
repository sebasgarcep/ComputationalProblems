using Printf

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

function get_primes(n)
    bound = isqrt(n)
    slots = [true for _ in 1:bound]
    slots[1] = false
    primes = []
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end
            push!(primes, p)
        end
    end
    return primes, slots
end

# DP implementation of the Meissel-Lehmer algorithm
function get_phi(n, phi_val_lo, phi_val_hi, x)
    if x <= 0
        return 0
    end
    if x <= length(phi_val_lo)
        return phi_val_lo[x]
    end
    return phi_val_hi[fld(n, x)]
end

function bump_phi(n, bound_lo, bound_hi, phi_val_lo, phi_val_hi, primes, a)
    next_phi_val_lo = [0 for _ in 1:bound_lo]
    next_phi_val_hi = [0 for _ in 1:bound_hi]
    for d in 1:bound_lo
        next_phi_val_lo[d] = get_phi(n, phi_val_lo, phi_val_hi, d) - get_phi(n, phi_val_lo, phi_val_hi, fld(d, primes[a]))
    end
    for d in 1:bound_hi
        next_phi_val_hi[d] = get_phi(n, phi_val_lo, phi_val_hi, fld(n, d)) - get_phi(n, phi_val_lo, phi_val_hi, fld(n, d * primes[a]))
    end
    return next_phi_val_lo, next_phi_val_hi
end

function get_pi_vals(n, bound_lo, bound_hi, primes, slots)
    pi_val_lo = [0 for _ in 1:bound_lo]
    pi_val_hi = [0 for _ in 1:bound_hi]

    # Get pi for small values
    acc = 0
    for d in 1:bound_lo
        if slots[d]
            acc += 1
        end
        pi_val_lo[d] = acc
    end

    a_init = get_pi(n, pi_val_lo, pi_val_hi, iroot(fld(n, bound_hi), 4))
    a_curr = 0
    phi_val_lo = [d for d in 1:bound_lo]
    phi_val_hi = [fld(n, d) for d in 1:bound_hi]
    for _ in 1:a_init
        a_curr += 1
        phi_val_lo, phi_val_hi = bump_phi(n, bound_lo, bound_hi, phi_val_lo, phi_val_hi, primes, a_curr)
    end

    # Get pi for large values
    for d in bound_hi:-1:1
        x = fld(n, d)

        # Enumeration constants
        a = get_pi(n, pi_val_lo, pi_val_hi, iroot(x, 4))
        while a_curr < a
            a_curr += 1
            phi_val_lo, phi_val_hi = bump_phi(n, bound_lo, bound_hi, phi_val_lo, phi_val_hi, primes, a_curr)
        end
        b = get_pi(n, pi_val_lo, pi_val_hi, iroot(x, 2))
        c = get_pi(n, pi_val_lo, pi_val_hi, iroot(x, 3))
    
        # Base answer
        res = a - 1 + get_phi(n, phi_val_lo, phi_val_hi, x)
    
        # Calculate P2(x, a)
        res -= binomial(a, 2) - binomial(b, 2)
        for i in (a + 1):b
            x_div_p = fld(x, primes[i])
            res -= get_pi(n, pi_val_lo, pi_val_hi, x_div_p)
            # Calculate P3(x, a)
            if i <= c
                bi = get_pi(n, pi_val_lo, pi_val_hi, isqrt(x_div_p))
                for j in i:bi
                    res -= get_pi(n, pi_val_lo, pi_val_hi, fld(x_div_p, primes[j])) - (j - 1)
                end
            end
        end

        pi_val_hi[d] = res
    end

    return pi_val_lo, pi_val_hi
end

function get_pi(n, pi_val_lo, pi_val_hi, x)
    if x <= length(pi_val_lo)
        return pi_val_lo[x]
    end
    return pi_val_hi[fld(n, x)]
end
# Finish implementation

function factorize_m_fact(m_fact, primes)
    m_fact_factorization = []
    for p in primes
        if p > m_fact
            break
        end
        valuation = 0
        base = p
        while base <= m_fact
            valuation += fld(m_fact, base)
            base *= p
        end
        push!(m_fact_factorization, (p, valuation))
    end
    return m_fact_factorization
end

function get_d1_bounds(n)
    bound = isqrt(n)
    bound_lo = bound
    bound_hi = bound
    if bound_hi^2 == n
        bound_hi -= 1
    end
    return bound_lo, bound_hi
end

function propagate(n, bound_lo, bound_hi, mod_size, d1_cnt_lo, d1_cnt_hi, p, t)
    next_d1_cnt_lo = [0 for _ in 1:bound_lo]
    next_d1_cnt_hi = [0 for _ in 1:bound_hi]

    for d in 1:bound_lo
        r = 0
        while true
            n_next = fld(d, p^r)
            term = mod((((t * (t + 1)) >> 1) + (r + 1) * (t + 1)) * d1_cnt_lo[d], mod_size)
            if n_next <= 0
                break
            end
            next_d1_cnt_lo[n_next] += term
            next_d1_cnt_lo[n_next] = mod(next_d1_cnt_lo[n_next], mod_size)
            r += 1
        end
    end

    for d in 1:bound_hi
        r = 0
        while true
            n_next = d * p^r
            term = (((t * (t + 1)) >> 1) + (r + 1) * (t + 1)) * d1_cnt_hi[d]
            if n_next <= bound_hi
                next_d1_cnt_hi[n_next] += term
                next_d1_cnt_hi[n_next] = mod(next_d1_cnt_hi[n_next], mod_size)
            else
                n_next = fld(n, n_next)
                if n_next <= 0
                    break
                end
                next_d1_cnt_lo[n_next] += term
                next_d1_cnt_lo[n_next] = mod(next_d1_cnt_lo[n_next], mod_size)
            end
            r += 1
        end
    end

    return next_d1_cnt_lo, next_d1_cnt_hi
end

function get_d1_cnts(n, bound_lo, bound_hi, m_fact_factorization, primes, pi_val_lo, pi_val_hi, mod_size)
    # Counts the number of D(*, d, a) in the expression
    d1_cnt_lo = [0 for _ in 1:bound_lo]
    # Counts the number of D(*, n/d, a) in the expression
    d1_cnt_hi = [0 for _ in 1:bound_hi]

    # Start with a single D(*, n, 0)
    d1_cnt_hi[1] = 1

    # Propagate the D(*, *, a - 1) into D(*, *, a)
    for a in 1:get_pi(n, pi_val_lo, pi_val_hi, iroot(n, 3))
        if a <= length(m_fact_factorization)
            (p, t) = m_fact_factorization[a]
        else
            p = primes[a]
            t = 0
        end
        d1_cnt_lo, d1_cnt_hi = propagate(n, bound_lo, bound_hi, mod_size, d1_cnt_lo, d1_cnt_hi, p, t)
    end

    return d1_cnt_lo, d1_cnt_hi
end

function get_d1_val(n, pi_val_lo, pi_val_hi, primes, mod_size, d)
    a = get_pi(n, pi_val_lo, pi_val_hi, iroot(n, 3))
    b = get_pi(n, pi_val_lo, pi_val_hi, iroot(d, 2))
    c = get_pi(n, pi_val_lo, pi_val_hi, d)

    res = 1
    res += 2 * max(0, c - a)
    res = mod(res, mod_size)
    res += 3 * max(0, b - a)
    res = mod(res, mod_size)
    for x in (a + 1):b
        res += 4 * max(0, get_pi(n, pi_val_lo, pi_val_hi, fld(d, primes[x])) - x)
        res = mod(res, mod_size)
    end

    return res
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m_fact = 200
    n = 10^12
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    primes, slots = get_primes(n)
    bound_lo, bound_hi = get_d1_bounds(n)
    # Calculate values of the prime counting function
    pi_val_lo, pi_val_hi = get_pi_vals(n, bound_lo, bound_hi, primes, slots)
    # Factorize m_fact
    m_fact_factorization = factorize_m_fact(m_fact, primes)
    # Propapagate D(m, n, 0) to D(1, *, a_max) and count the number of times each term appears
    d1_cnt_lo, d1_cnt_hi = get_d1_cnts(n, bound_lo, bound_hi, m_fact_factorization, primes, pi_val_lo, pi_val_hi, mod_size)

    # Calculate each of the D(1, *, a_max) and multiply it by the number of appearances
    for d in 1:bound_lo
        result += mod(d1_cnt_lo[d] * get_d1_val(n, pi_val_lo, pi_val_hi, primes, mod_size, d), mod_size)
        result = mod(result, mod_size)
    end

    for d in 1:bound_hi
        result += mod(d1_cnt_hi[d] * get_d1_val(n, pi_val_lo, pi_val_hi, primes, mod_size, fld(n, d)), mod_size)
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
