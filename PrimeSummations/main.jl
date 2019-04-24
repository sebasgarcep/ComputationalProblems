#=
Approach:
Let f(m) be the number of distinct prime sums for an integer m. Notice that f(m) <= f(m + 2),
as m + 2 can be formed by taking all the previous prime sums and adding 2 to each.
Therefore f is increasing in the evens and the odds. Notice that f(70) < 5000 and
f(80) > 5000, therefore we only need to search in this region.
=#

using Printf

function f(primes, m, min_idx)
    if m == 0
        return 1
    end

    total = 0
    for idx in min_idx:length(primes)
        val = primes[idx]
        if val > m
            break
        end
        total += f(primes, m - val, idx)
    end

    return total
end

start = time()
result = 0

limit = 30000
primes = []
slots = [true for _ in 1:limit]
slots[1] = false
for n in 2:limit
    global primes, slots
    if slots[n]
        push!(primes, n)
        for k in (2 * n):n:limit
            slots[k] = false
        end
    end
end

for m in 70:80
    global result
    if f(primes, m, 1) >= 5000
        result = m
        break
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
