#=
Approach:
Clearly, for n = 1, 1 + 1 / 1 = 2 which is prime. If n > 1 is odd then
1 + n / 1 = n + 1 which is an even number larger than 2 and clearly not prime.
Also notice that if n = p1^k1 * p2^k2 * ... * pm^km, then ki = 1,
for i = 1, 2, ... , m. To see this notice that if, without loss of generality,
k1 > 1 and d = p1, then n/d = p1^k1-1 * p2^k2 * ... * pm^km and gcd(d, n/d) = p1 > 1.
Therefore n = 1 or n = 2 * p1 * p2 * ... * pm.

Finally, implement a recursive search over the different factors of n, which are
found using a sieving method, and test for the required condition.
=#

using Printf

start = time()
result = 1
bound = 10^8

limit = bound + 1
slots = [true for _ in 1:limit]
slots[1] = false
primes = []
for n in 2:limit
    global primes, slots, result
    if !slots[n]
        continue
    end
    if 2 * n < limit
        push!(primes, n)
    end
    for k in (2 * n):n:limit
        slots[k] = false
    end
end

function test_r(v, p, k, n)
    if k > length(v)
        return slots[n + fld(p, n)]
    end
    if !test_r(v, p, k + 1, n * v[k])
        return false
    end
    if !test_r(v, p, k + 1, n)
        return false
    end
    return true
end

function test(v, p)
    return test_r(v, p, 1, 1)
end

function search(k, l, v, p)
    global result
    if test(v, p)
        result += p
    end
    if l >= 8
        return
    end
    for i in (k + 1):length(primes)
        next_p = p * primes[i]
        if next_p > bound
            break
        end
        next_v = copy(v)
        push!(next_v, primes[i])
        search(i, l + 1, next_v, next_p)
    end
end

search(1, 1, [2], 2)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
