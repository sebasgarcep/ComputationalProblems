using Printf

# Factorization
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

# Chinese Remainder Theorem
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

function chinese_remainder_theorem(vals)
    if length(vals) == 0
        return nothing
    end
    a_curr, n_curr = vals[1]
    for (a_term, n_term) in vals
        if mod(a_curr - a_term, gcd(n_curr, n_term)) != 0
            return nothing
        end
        g_next = gcd(n_curr, n_term)
        n_next = lcm(n_curr, n_term)
        q_curr, q_term = extended_euclidean(fld(n_curr, g_next), fld(n_term, g_next))
        a_next = mod(
            mod(a_curr * fld(n_term, g_next) * q_term, n_next) +
            mod(a_term * fld(n_curr, g_next) * q_curr, n_next),
            n_next
        )
        # Update accumulators
        a_curr = a_next
        n_curr = n_next
    end
    return a_curr, n_curr
end

# Discrete logarithm
function baby_step_giant_step(g, h, n, m)
    # Sanity checks
    if h == 1
        return 0
    end

    # Implementations
    k = Int64(ceil(sqrt(n)))
    power_memo = Dict()
    for j in 0:(k - 1)
        power_memo[powermod(g, j, m)] = j
    end
    z = powermod(g, -k, m)
    y = mod(h, m)
    for i in 0:(k - 1)
        if haskey(power_memo, y)
            j = power_memo[y]
            return i * k + j
        end
        y = mod(y * z, m)
    end
    return nothing
end

function pohlig_hellman_prime_power(g, h, p, e, m)
    x = 0
    y = powermod(g, p^(e - 1), m)
    for k in 0:(e - 1)
        r = powermod(mod(powermod(g, -x, m) * h, m), p^(e - 1 - k), m)
        d = baby_step_giant_step(y, r, p, m)
        x += p^k * d
    end
    return x
end

function calculate_order(b, m)
    max_order = m
    for (p, _) in get_factorization(m)
        max_order = fld(max_order, p)
        max_order *= p - 1
    end
    for d in get_divisors(max_order)
        if powermod(b, d, m) == 1
            return d
        end
    end
    return nothing
end

function pohlig_hellman(g, h, m)
    # Sanity checks
    if gcd(g, m) != 1 || gcd(h, m) != 1
        error("Can't handle the case when one of the arguments is not-coprime with the modulus")
    end
    if g >= m || h >= m
        return pohlig_hellman(mod(g, m), mod(h, m), m)
    end
    if g == h
        return g == 1 ? 0 : 1
    end
    if g == 0 || g == 1 || h == 0
        return nothing
    end

    # Implementation
    n = calculate_order(g, m)
    vals = []
    for (p_i, ei) in get_factorization(n)
        ki = fld(n, p_i^ei)
        gi = powermod(g, ki, m)
        hi = powermod(h, ki, m)
        xi = pohlig_hellman_prime_power(gi, hi, p_i, ei, m)
        push!(vals, (xi, p_i^ei))
    end

    result = chinese_remainder_theorem(vals)
    if result == nothing
        return nothing
    end

    return result[1]
end

function solve(p, q, mod_size)
    if p == 1 && q == 1
        return 1
    end

    if gcd(p, q) != 1
        return 0
    end

    min_a = nothing
    min_t = nothing
    h = 10 * q - p

    if h < 0
        return 0
    end

    for a in 1:9
        if a * p > h
            continue
        end

        g = fld(h, gcd(a, h))
        if gcd(g, 10) != 1
            continue
        end

        c = mod(invmod(p, g) * mod(q, g), g)
        t = pohlig_hellman(10, c, g)
        if t == nothing
            continue
        end

        if min_t == nothing || t < min_t
            min_a = a
            min_t = t
        end
    end

    if min_a == nothing || min_t == nothing
        return 0
    end
    
    min_b = invmod(h, mod_size)
    min_b *= min_a
    min_b = mod(min_b, mod_size)
    min_b *= mod(powermod(10, min_t, mod_size) * p - q, mod_size)
    # Build n from min_a, min_t and min_b
    return mod(powermod(10, min_t, mod_size) * min_a + min_b, mod_size)
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = 200
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    for u in 1:m
        for v in 1:m
            n = solve(u^3, v^3, mod_size)
            result = mod(result + n, mod_size)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
