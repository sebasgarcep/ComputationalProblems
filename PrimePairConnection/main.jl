#=
Approach:
Use the Sieve of Eratosthenes to find all primes <= 10^6. Suppose k is the smallest
value for which 10^k > p1. Therefore S >= 10^k + p1. For S == 0 (mod p2), we have to
find the smallest value of m for which 10^k * m + p1 == 0 (mod p2). Notice that
p2 > 5, and therefore gcd(10^k, p2) == 1. Thus, 10^k is invertible. Therefore
m = -p1 * (10^k)-1 (mod p2).
=#

using Printf

start = time()
result = 0

primes = []
bound = 10^6 + 3 # The first prime after 10^6 is 10^6 + 3.
slots = [true for _ in 1:bound]
for n in 2:bound
    if slots[n]
        push!(primes, n)
        for k in (2 * n):n:bound
            slots[k] = false
        end
    end
end

primes = primes[3:length(primes)]

for i in 1:(length(primes) - 1)
    global result
    p1 = primes[i]
    p2 = primes[i + 1]
    k = 1
    while 10^k <= p1
        k += 1
    end
    m = mod(- p1 * invmod(10^k, p2), p2)
    s = 10^k * m + p1
    if s % p2 != 0 || (s % 10^k) != p1 || m <= 0
        println((p1, p2, k, m, s))
        exit()
    end
    result += s
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
