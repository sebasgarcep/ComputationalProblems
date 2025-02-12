using Printf

# Prime sieve
struct PrimeSieve
    limit::Int64
    is_prime::Vector{Bool}
    primes::Vector{Int64}

    function PrimeSieve(limit::Int64)
        is_prime = [true for _ in 1:limit]
        primes = []
        is_prime[1] = false
        for p in 1:limit
            if is_prime[p]
                push!(primes, p)
                for k in (p^2):p:limit
                    is_prime[k] = false
                end
            end
        end
        return new(limit, is_prime, primes)
    end
end

# Cache functions
struct TwoSidedCache
    bound::Int64
    limit::Int64
    lo::Vector{Union{Nothing, Int64}}
    hi::Vector{Union{Nothing, Int64}}

    function TwoSidedCache(bound, limit)
        cache_lo = [nothing for _ in 1:limit]
        cache_hi = [nothing for _ in 1:limit]
        return new(
            bound,
            limit,
            cache_lo,
            cache_hi
        )
    end
end

function get_from_cache(cache::TwoSidedCache, x::Int64)::Union{Nothing, Int64}
    if x <= 0 || cache.bound < x
        return nothing
    elseif x <= cache.limit
        return cache.lo[x]
    else # limit < x <= bound
        # Estimate k
        k = fld(cache.bound, x)
        # is cacheable if [N/k] = x
        is_cacheable = fld(cache.bound, k) == x
        if is_cacheable
            return cache.hi[k]
        end
        return nothing
    end
end

function update_cache(cache::TwoSidedCache, x::Int64, v::Int64)
    if x <= 0 || cache.bound < x
        return
    elseif x <= cache.limit
        cache.lo[x] = v
    else # limit < x <= bound
        # Estimate k
        k = fld(cache.bound, x)
        # is cacheable if [N/k] = x
        is_cacheable = fld(cache.bound, k) == x
        if is_cacheable
            cache.hi[k] = v
        end
    end
end

# Prime counter
struct PrimeCounter
    cache::TwoSidedCache
    sieve::PrimeSieve

    function PrimeCounter(bound::Int64, sieve::PrimeSieve)
        cache = TwoSidedCache(bound, sieve.limit)
        cache.lo[1] = 0
        for x in 2:sieve.limit
            cache.lo[x] = cache.lo[x - 1]
            if sieve.is_prime[x]
                cache.lo[x] += 1
            end
        end
        return new(cache, sieve)
    end
end

function calc_pi(this::PrimeCounter, x::Int64)::Int64
    cached = get_from_cache(this.cache, x)
    if cached !== nothing
        return cached
    end
    a = calc_pi(this, isqrt(x))
    value = calc_legendre_pi(this, x, a) + a - 1
    update_cache(this.cache, x, value)
    return value
end

function calc_legendre_pi(this::PrimeCounter, x::Int64, a::Int64)::Int64
    if x == 0 || a == 0
        return x
    end
    if x <= this.sieve.limit && a >= calc_pi(this, isqrt(x))
        return max(0, calc_pi(this, x) - a) + 1
    end
    value = x
    for i in 1:a
        p = this.sieve.primes[i]
        value -= calc_legendre_pi(this, fld(x, p), i - 1)
    end
    return value
end

# Prime adder
struct PrimeAdder
    modulo::Int64
    cache::TwoSidedCache
    sieve::PrimeSieve
    counter::PrimeCounter

    function PrimeAdder(
        modulo::Int64,
        bound::Int64,
        sieve::PrimeSieve,
        counter::PrimeCounter
    )
        cache = TwoSidedCache(bound, sieve.limit)
        cache.lo[1] = 0
        for x in 2:sieve.limit
            cache.lo[x] = cache.lo[x - 1]
            if sieve.is_prime[x]
                cache.lo[x] = mod(cache.lo[x] + x, modulo)
            end
        end

        return new(
            modulo,
            cache,
            sieve,
            counter,
        )
    end
end

function calc_sigma(this::PrimeAdder, x::Int64)::Int64
    cached = get_from_cache(this.cache, x)
    if cached !== nothing
        return cached
    end
    a = calc_pi(this.counter, isqrt(x))
    b = calc_sigma(this, isqrt(x))
    value = calc_legendre_sigma(this, x, a) + b - 1
    update_cache(this.cache, x, value)
    return value
end

function calc_legendre_sigma(this::PrimeAdder, x::Int64, a::Int64)::Int64
    if x == 0 || a == 0
        return summation_formula(this.modulo, x)
    end
    if x <= this.sieve.limit && a >= calc_pi(this.counter, isqrt(x))
        value = 1
        if x >= this.sieve.primes[a]
            b = calc_sigma(this, this.sieve.primes[a])
            c = calc_sigma(this, x)
            value += c - b
        end
        return mod(value, this.modulo)
    end
    value = summation_formula(this.modulo, x)
    for i in 1:a
        p = this.sieve.primes[i]
        value -= mod(
            mod(p, this.modulo) * mod(
                calc_legendre_sigma(this, fld(x, p), i - 1),
                this.modulo
            ),
            this.modulo
        )
        value = mod(value, this.modulo)
    end
    return value
end

function summation_formula(modulo::Int64, x::Int64)::Int64
    value = 1
    if x & 1 == 0
        value = mod(x >> 1, modulo);
        value *= mod(x + 1, modulo)
    else
        value = mod(x, modulo);
        value *= mod((x + 1) >> 1, modulo)
    end
    value = mod(value, modulo)
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    bound = 10^8 # 454_582_882 + 1
    modulo = 715827883

    # Algorithm parameters
    limit = 10^7

    # Solution
    sieve = PrimeSieve(limit)
    prime_counter = PrimeCounter(bound, sieve)
    prime_adder = PrimeAdder(modulo, bound, sieve, prime_counter)

    function t_func(x, a)
        if x == 0
            return 0
        end

        a_limit = calc_pi(prime_counter, isqrt(x))
        if a >= a_limit
            value = calc_legendre_sigma(prime_adder, x, a) - 1
            value -= 2 * (calc_legendre_pi(prime_counter, x, a) - 1)
            return mod(value, modulo)
        end

        value = t_func(x, a_limit)
        for i in a:(a_limit - 1)
            p = sieve.primes[i + 1]
            value += mod(p * t_func(fld(x, p), i), modulo)
            value = mod(value, modulo)
            value -= calc_legendre_sigma(prime_adder, fld(x, p), i + 1)
            value = mod(value, modulo)
            k = 1
            while p^k <= x
                value += mod(
                    (p - 1) *
                    calc_legendre_sigma(prime_adder, fld(x, p^k), i + 1),
                    modulo
                )
                value = mod(value, modulo)
                k += 1
            end
        end
        return value
    end

    result = t_func(bound, 0)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
