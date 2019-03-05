"""
Approach:
Use the Sieve of Eratosthenes to find the factors of each number. Note that
because a + b = c, then gdc(a, b) = 1 iff gdc(a, c) = gcd(b, c) = 1. Also,
whenever gdc(a, b, c) = 1 then rad(abc) = rad(a) rad(b) rad(c).
"""

using Printf

start = time()
result = 0

function has_abc_hit(factors, radical, c)
    counter = 0
    for a in 1:Int64(ceil(c / 2.0) - 1)
        b = c - a
        if radical[a] * radical[b] * radical[c] < c &&
            isempty(intersect(factors[a], factors[b]))
            counter = counter + 1
        end
    end
    return counter
end

limit = 120000 - 1
factors = [Set() for i in 1:limit]
radical = [1 for i in 1:limit]
for n in 2:limit
    if length(factors[n]) == 0
        for k in n:n:limit
            radical[k] = radical[k] * n
            push!(factors[k], n)
        end
    end
end

for c in 3:limit
    global result
    result = result + c * has_abc_hit(factors, radical, c)
end

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
