#=
Approach:
Brute force search over the powers of the prime numbers.
=#

using Printf

start = time()
result = 0

function search(primes, k, v)
    global result
    if k > length(primes)
        result += 1
        return
    end
    b = primes[k]
    p = 0
    while v * (b^p) <= 10^9
        search(primes, k + 1, v * (b^p))
        p += 1
    end
end

primes = []
slots = [true for _ in 1:100]
slots[1] = false
for n in 2:100
    if !slots[n]
        continue
    end
    push!(primes, n)
    for k in (2 * n):n:100
        slots[k] = false
    end
end

search(primes, 1, 1)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
