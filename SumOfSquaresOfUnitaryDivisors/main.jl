#=
Approach:
Notice that if n = p1^k1 * p2^k2 * ... * pm^km, then gdc(d, n/d) = 1 if and only
if pi^ki | d or pi^ki | n/d. That means that d is a product of a subset of the prime
powers of n. Therefore S(n) = (1 + p1^(2 * k1)) * (1 + p2^(2 * k2)) * ... * (1 + pm^(2 * km)).
Finally, we can find the values of k1, k2, ... , km for n! using:

ki = floor(n / pi) + floor(n / pi^2) + ...
=#

using Printf

function modpow(x, n, m)
    mask = reverse(string(n, base = 2))
    p = BigInt(1)
    s = x
    for k in 1:length(mask)
        if mask[k] == '1'
            p = mod(p * s, m)
        end
        s = mod(s * s, m)
    end
    return p
end

start = time()
result = BigInt(1)

m = 10^9 + 9
limit = 10^8
slots = [true for _ in 1:limit]
slots[1] = false
for n in 2:limit
    global primes, slots, result
    if !slots[n]
        continue
    end
    for k in (2 * n):n:limit
        slots[k] = false
    end
    t = n
    p = 0
    while true
        d = fld(limit, t)
        if d <= 0
            break
        end
        p += d
        t *= n
    end
    term = 1 + modpow(n, 2 * p, m)
    result = mod(result * term, m)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
