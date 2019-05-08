#=
Approach:
Calculate the Sieve of Eratosthenes up to 10^8. Then for each prime number multiply
it by all other primes larger than or equal to itself until you reach a number larger
than 10^8. Count each number you've obtained (it must be unique from the condition
that the second prime number is larger than or equal to the first one). Notice
that for p1, p2, both primes, to satisfy p1 * p2 < 10^8, then p2 < 10^8 / p1, and
because the smallest value p1 can take is 2 then p2 < 10^8 / 2.
=#

using Printf

start = time()
result = 0

bound = 10^8 - 1

limit = fld(bound, 2)
slots = [true for _ in 1:limit]
primes = []

for n in 2:limit
    global primes
    if slots[n]
        push!(primes, n)
        for k in (2 * n):n:limit
            slots[k] = false
        end
    end
end

for pos in 1:(length(primes) - 1)
    for idx in pos:length(primes)
        global result
        if primes[pos] * primes[idx] > bound
            break
        end
        result += 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
