#=
Approach:
If a number n has prime factorization p1^k1 * p2^k2 * ... * pm^km, then it has
(k1 + 1) * (k2 + 1) * ... * (km + 1) positive divisors. Using the Sieve of Erathostenes
we can find the prime divisorsof each number and therefore calculate the different
values of ki, for all i. Therefore each time we find a value of ki, we multiply it
times the current value of the counter for a given number. Finally, we compare
the pairwise results of the number of divisors.
=#

using Printf

start = time()
result = 0

bound = 10^7
divisors = [1 for _ in 1:bound]
slots = [true for _ in 1:bound]
slots[1] = false
for n in 2:bound
    global slots, divisors, result
    if slots[n]
        for k in n:n:bound
            slots[k] = false
            c = 1
            d = n
            while true
                d *= n
                k % d != 0 && break
                c += 1
            end
            divisors[k] *= c + 1
        end
    end
end

for n in 2:(bound - 1)
    global result
    if divisors[n] == divisors[n + 1]
        result += 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
