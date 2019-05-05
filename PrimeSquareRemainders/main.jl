#=
Approach:
Notice that s = (pn - 1)^n + (pn + 1) = ((-1)^n + n * pn * (-1)^n-1) + (1 + n * pn) mod pn^2,
as the remaining terms are multiple of pn^2 and therefore cancel out. If n is even
then s = 2. Therefore we need to consider odd n. In particular, for n odd, s = 2 * n * pn.
As a result of the prime number theorem pn ~ n * ln(n) and therefore for large enough
n, pn > 2 * n and therefore pn^2 > 2 * n * pn. Therefore we need to find the least value
of n for which 2 * n * pn > 10^10. Also, because of the prime number theorem we have
that pn ~ n * ln(n) and therefore 2 * n^2 * ln(n) ~ 10^10. Therefore n ~ 22'344.7.
We will therefore use an upper bound of pn ~ n * ln(n) ~ 300'000 for the Sieve of
Eratosthenes.
=#

using Printf

start = time()
result = 0

bound = 300000
primes = []
slots = [true for _ in 1:bound]
for n in 2:bound
    global slots, primes
    if slots[n]
        push!(primes, n)
        for k in (2 * n):n:bound
            slots[k] = false
        end
    end
end

limit = 10^10
for n in 1:2:length(primes)
    global result
    if 2 * n * primes[n] > limit
        result = n
        break
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
