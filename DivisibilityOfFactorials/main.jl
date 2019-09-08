#=
Approach:
Notice that if n = p1^k1 * p2^k2 * ... * pm^km, then s(n) = max(s(p1^k1), s(p2^k2), ... , s(pm^km)).
Also, if L is the parameter of S, then if p > sqrt(L) the multiplicity of p in n is 1.
Therefore we only need to calculate the values of s for prime numbers below or equal to
sqrt(L). This can be computed easily by iterating over the multiples of p and adding up
the multiplicities. Finally, we use a sieve to find the prime factors of all numbers from 1 to L.
=#

using Printf

function is_prime(n)
    if n == 1
        return false
    end
    if n == 2
        return true
    end
    if mod(n, 2) == 0
        return false
    end
    for k in 3:2:isqrt(n)
        if n % k == 0
            return false
        end
    end
    return true
end

function factor_multiplicity(n, k)
    r = 0
    nr = n
    while mod(nr, k) == 0
        r += 1
        nr = fld(nr, k)
    end
    return r
end

start = time()
result = 0

n = 10^8
un = isqrt(n)
powervals = Dict()
for k in 2:un
    if is_prime(k)
        vals = []
        l = floor(log(k, n))
        for i in 1:l
            v = 0
            r = 0
            while r < i
                v += k
                r += factor_multiplicity(v, k)
            end
            push!(vals, v)
        end
        powervals[k] = vals
    end
end

slots = [true for _ in 1:n]
slots[1] = false
data = [0 for _ in 1:n]
for k in 2:n
    if slots[k]
        if k <= un
            data[k] = max(data[k], k)
            for t in (2*k):k:n
                slots[t] = false
                r = factor_multiplicity(t, k)
                data[t] = max(data[t], powervals[k][r])
            end
        else
            data[k] = max(data[k], k)
            for t in (2*k):k:n
                slots[t] = false
                data[t] = max(data[t], k)
            end
        end

    end
end

result = sum(data[2:n])
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
