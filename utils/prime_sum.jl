module PrimeSum

import ..Common: iroot, summation_formula
import ..PrimeSieve
import ..TwoSidedCache
import ..PrimeCount

struct Calculator
    modulo::Int64
    cache::TwoSidedCache.Cache
    sieve::PrimeSieve.Calculator
    counter::PrimeCount.Calculator

    function Calculator(
        modulo::Int64,
        bound::Int64,
        sieve::PrimeSieve.Calculator,
        counter::PrimeCount.Calculator
    )
        cache = TwoSidedCache.Cache(bound, sieve.limit)
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

function get(this::PrimeSum.Calculator, x::Int64)::Int64
    cached = TwoSidedCache.get(this.cache, x)
    if cached !== nothing
        return cached
    end

    if x <= 0
        return 0
    end

    # Enumeration constants
    a = PrimeCount.get(this.counter, iroot(x, 4))
    b = PrimeCount.get(this.counter, iroot(x, 2))
    c = PrimeCount.get(this.counter, iroot(x, 3))

    value = 0

    if a > 0
        value += PrimeSum.get(this, this.sieve.primes[a])
        value = mod(value, this.modulo)
    end

    # Base answer
    value += mod(
        - 1 + PrimeSum.phi(this, x, a),
        this.modulo
    )

    # Calculate P2(x, a)
    for i in (a + 1):b
        p_i = this.sieve.primes[i]
        x_div_pi = fld(x, p_i);
        diff_i = mod(
            PrimeSum.get(this, x_div_pi) - PrimeSum.get(this, p_i - 1),
            this.modulo
        )
        value = mod(value - mod(p_i * diff_i, this.modulo), this.modulo)
        # Calculate P3(x, a)
        if i <= c
            ci = PrimeCount.get(this.counter, isqrt(x_div_pi))
            for j in i:ci
                p_j = this.sieve.primes[j]
                x_div_pi_pj = fld(x_div_pi, p_j)
                diff_ij = mod(
                    PrimeSum.get(this, x_div_pi_pj) - PrimeSum.get(this, p_j - 1),
                    this.modulo
                );
                coeff_ij = mod(p_i * p_j, this.modulo)
                value = mod(value - mod(coeff_ij * diff_ij, this.modulo), this.modulo)
            end
        end
    end

    TwoSidedCache.set(this.cache, x, value)
    return value
end

function phi(this::PrimeSum.Calculator, x::Int64, a::Int64)::Int64
    if x == 0 || a == 0
        return summation_formula(this.modulo, x)
    end
    if x <= this.sieve.limit && a >= PrimeCount.get(this.counter, isqrt(x))
        value = 1
        if x >= this.sieve.primes[a]
            b = PrimeSum.get(this, this.sieve.primes[a])
            c = PrimeSum.get(this, x)
            value += c - b
        end
        return mod(value, this.modulo)
    end
    value = summation_formula(this.modulo, x)
    for i in 1:a
        p = this.sieve.primes[i]
        value -= mod(
            mod(p, this.modulo) * mod(
                PrimeSum.phi(this, fld(x, p), i - 1),
                this.modulo
            ),
            this.modulo
        )
        value = mod(value, this.modulo)
    end
    return value
end

end