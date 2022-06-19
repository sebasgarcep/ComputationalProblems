using Printf

function factorize(primes, n)
    factors = []
    for p in primes
        if p^2 > n
            break
        end
        e = 0
        while mod(n, p) == 0
            n = fld(n, p)
            e += 1
        end
        if e > 0
            push!(factors, (p, e))
        end
    end
    if n > 1
        push!(factors, (n, 1))
    end
    return factors
end

function search(
    divisors,
    totient_memo,
    mu_memo,
    factors,
    pos,
    div_acc,
    totient_acc,
    mu_acc,
)
    if pos > length(factors)
        push!(divisors, div_acc)
        totient_memo[div_acc] = totient_acc
        mu_memo[div_acc] = mu_acc
        return
    end
    (p, e) = factors[pos]
    next_pos = pos + 1
    next_div_acc = div_acc
    next_totient_acc = totient_acc
    next_mu_acc = mu_acc
    for v in 0:e
        search(
            divisors,
            totient_memo,
            mu_memo,
            factors,
            next_pos,
            next_div_acc,
            next_totient_acc,
            next_mu_acc,
        )
        next_div_acc *= p
        if v == 0
            next_totient_acc *= p - 1
        else
            next_totient_acc *= p
        end
        if v == 0
            next_mu_acc *= -1
        else
            next_mu_acc = 0
        end
    end
end

function f(mod_size, primes, p)
    r_memo = Dict()
    mu_memo = Dict()
    totient_memo = Dict()
    factors = factorize(primes, p - 1)
    divisors = []
    search(divisors, totient_memo, mu_memo, factors, 1, 1, 1, 1)
    divisors = sort(divisors)
    # Memoize r_p
    for m in divisors
        r_memo[m] = 0
        for t in divisors
            q = gcd(m, t)
            term = mod(fld(p - 1, t), mod_size)
            term *= mod(q, mod_size)
            term = mod(term, mod_size)
            term *= mod(totient_memo[t], mod_size)
            term = mod(term, mod_size)
            r_memo[m] = mod(r_memo[m] + term, mod_size)
        end
    end
    acc = powermod(p - 1, 2, mod_size)
    for m in divisors
        # Calculate h_p
        h = 0
        for d in divisors
            if d > m
                break
            end
            if mod(m, d) != 0
                continue
            end
            h += r_memo[d] * mu_memo[fld(m, d)]
            h = mod(h, mod_size)
        end
        # Calculate term in the sum of f(p)
        term = powermod(h, 2, mod_size)
        term *= invmod(totient_memo[m], mod_size)
        term = mod(term, mod_size)
        acc = mod(acc + term, mod_size)
    end
    return acc
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    m = 10^16
    n = 10^16 + 10^6
    mod_size = 993353399

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    # Find primes not exceeding sqrt(N)
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

    # Find primes in range [M, N]
    slots = [true for _ in m:n]
    for p in primes
        r = mod(m, p)
        if r == 0
            init = 1
        else
            init = p - r + 1
        end
        for k in init:p:(n - m + 1)
            slots[k] = false
        end
        # Primes in the list of primes are getting erased
        # by the sieve. Correct this afterwards
        if p == init - 1 + m
            slots[init] = true
        end
    end

    # Calculate f(p) for such primes
    for p in m:n
        if slots[p - m + 1]
            result += f(mod_size, primes, p)
            result = mod(result, mod_size)
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
