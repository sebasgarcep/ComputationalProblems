#=
Approach:

Suppose n = p1^r1 * p2^r2 * ... * pm^rm. Then:

f(n) = sum(i = 1, n) phi(n^i) mod (n + 1)
     = sum(i = 1, n) n^i prod(j = 1, m) (1 - 1 / pk) mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * sum(i = 1, n) n^i mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * (n + n^2 + n^3 + ... + n^n) mod (n + 1)

If n is even:

f(n) = prod(j = 1, m) (1 - 1 / pk) * (n + n^2 + n^3 + ... + n^n) mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * (n * (1 + n) + n^3 * (1 + n) + ... + n^(n-1) * (1 + n)) mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * 0 mod (n + 1)
     = 0

If n is odd:

f(n) = prod(j = 1, m) (1 - 1 / pk) * (n + n^2 + n^3 + ... + n^n) mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * (n + n^2 * (1 + n) + n^4 * (1 + n) + ... + n^(n-1) * (1 + n)) mod (n + 1)
     = prod(j = 1, m) (1 - 1 / pk) * n mod (n + 1)
     = phi(n) mod (n + 1)
     = phi(n)

Because 0 <= phi(n) <= n < n + 1.

To solve this problem we keep an array initialized with the values from 1 to n.
Using a sieve every time we find a prime divisor p of a number we multiply the value
in the array by (1 - 1 / p). When we reach that number in the sieve we will not
find any more prime factors, thus we can safely add it to the global result.

To improve the running time of the algorithm we abuse the fact that even values
of n do not contribute to the final result. Therefore when sieving we can skip
even numbers both in the outer loop and in the inner loop where we are marking
the numbers using the prime factor we found (If we start from 3 * k instead of
2 * k and jump using steps of size 2 * k we will never iterate over an even number).
=#

using Printf

start = time()
result = 0

n = 5 * 10^8

# Case: k = 1
result += 1
# Case: k = 2
result += 0

# Sieve
slots = [mod(k, 2) != 0 for k in 1:n]
slots[1] = false
slotvals = [k for k in 1:n]
for k = 3:2:n
    global result
    if slots[k]
        for t in k:(2 * k):n
            slots[t] = false
            slotvals[t] = round(slotvals[t] * (1 - 1 / k))
        end
    end
    result += slotvals[k]
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
