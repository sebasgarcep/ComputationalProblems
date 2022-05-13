using Printf

function calc_bounds(n)
    bound_lo = isqrt(n)
    bound_hi = isqrt(n)
    if bound_hi == fld(n, bound_hi)
        bound_hi -= 1
    end
    return bound_lo, bound_hi
end

function t(x, mod_size)
    res = mod(x, mod_size)
    res *= mod(x + 1, mod_size)
    res = mod(res, mod_size)
    res *= invmod(2, mod_size)
    res = mod(res, mod_size)
    return res
end

function p(x, mod_size)
    res = mod(x, mod_size)
    res *= mod(x + 1, mod_size)
    res = mod(res, mod_size)
    res *= mod(2 * x + 1, mod_size)
    res = mod(res, mod_size)
    res *= invmod(6, mod_size)
    res = mod(res, mod_size)
    return res
end

function get_q(n, q_lo, q_hi, x)
    if x <= length(q_lo)
        return q_lo[x]
    end
    return q_hi[fld(n, x)]
end

function calc_q(n, q_lo, q_hi, x, mod_size)
    res = p(x, mod_size)
    bound_lo, bound_hi = calc_bounds(x)
    for k in 2:bound_lo
        res -= mod(mod(k, mod_size) * get_q(n, q_lo, q_hi, fld(x, k)), mod_size)
        res = mod(res, mod_size)
    end
    for u in 1:bound_hi
        res -= mod(get_q(n, q_lo, q_hi, u) * mod(t(fld(x, u), mod_size) - t(fld(x, u + 1), mod_size), mod_size), mod_size)
        res = mod(res, mod_size)
    end
    return res
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 99999999019
    mod_size = 999999017

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    totient_memo = [x for x in 1:bound]
    for p in 1:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                totient_memo[k] = fld(totient_memo[k], p) * (p - 1) 
            end
        end
    end

    # Init Q(n)
    bound_lo, bound_hi = calc_bounds(n)
    q_lo = [0 for _ in 1:bound_lo]
    q_hi = [0 for _ in 1:bound_hi]
    q_lo[1] = 1

    # Calculate Q(n) for n > 1
    for d in 2:bound_lo
        q_lo[d] = calc_q(n, q_lo, q_hi, d, mod_size)
    end

    for d in bound_hi:-1:1
        q_hi[d] = calc_q(n, q_lo, q_hi, fld(n, d), mod_size)
    end

    # Calculate R(n)
    r = 0
    for d in 1:bound_lo
        r += mod(mod(mod(fld(n, d), mod_size) * d, mod_size) * totient_memo[d], mod_size)
        r = mod(r, mod_size)
    end
    for u in 1:bound_hi
        r += mod(u * (get_q(n, q_lo, q_hi, fld(n, u)) - get_q(n, q_lo, q_hi, fld(n, u + 1))), mod_size)
        r = mod(r, mod_size)
    end

    # Calculate S(n)
    result = mod(mod(r + n, mod_size) * invmod(2, mod_size), mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
