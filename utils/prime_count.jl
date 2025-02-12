module PrimeCount

import ..Common: iroot
import ..PrimeSieve
import ..TwoSidedCache

struct Calculator
    cache::TwoSidedCache.Cache
    sieve::PrimeSieve.Calculator

    function Calculator(bound::Int64, sieve::PrimeSieve.Calculator)
        cache = TwoSidedCache.Cache(bound, sieve.limit)
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

function get(this::Calculator, x::Int64)::Int64
    cached = TwoSidedCache.get(this.cache, x)
    if cached !== nothing
        return cached
    end

    if x <= 0
        return 0
    end

    # Enumeration constants
    a = get(this, iroot(x, 4))
    b = get(this, iroot(x, 2))
    c = get(this, iroot(x, 3))

    # Base answer
    value = a - 1 + phi(this, x, a)

    # Calculate P2(x, a)
    value -= binomial(a, 2) - binomial(b, 2)
    for i in (a + 1):b
        x_div_p = fld(x, this.sieve.primes[i])
        value -= get(this, x_div_p)
        # Calculate P3(x, a)
        if i <= c
            bi = get(this, isqrt(x_div_p))
            for j in i:bi
                value -= get(this, fld(x_div_p, this.sieve.primes[j])) - (j - 1)
            end
        end
    end

    TwoSidedCache.set(this.cache, x, value)
    return value
end

# Calculate auxiliary function
# source: https://rosettacode.org/wiki/Legendre_prime_counting_function
function phi(this::Calculator, x::Int64, a::Int64)::Int64
    if x == 0 || a == 0
        return x
    end
    if x <= this.sieve.limit && a >= get(this, isqrt(x))
        return max(0, get(this, x) - a) + 1
    end
    value = x
    for i in 1:a
        p = this.sieve.primes[i]
        value -= phi(this, fld(x, p), i - 1)
    end
    return value
end

end