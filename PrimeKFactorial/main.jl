#=
Approach:
Assume that p is prime.

Now, let's prove Lagrange's theorem, i.e. that a = a^-1 (mod p)
only has two solutions: a = +- 1 (mod p). To see this notice that the previous
equation can be reduced to a^2 = 1 (mod p) <-> (a - 1) * (a + 1) = 0 (mod p).
This implies that p | a - 1 or p | a + 1 <-> a - 1 = k * p or a + 1 = k * p, for
some integer k. Therefore a = +- 1 (mod p).

Now we will use this result to prove Wilson's theorem, i.e. that (p - 1)! = -1 (mod p).
Notice that for p = 2 the result is trivial. Let p >= 3. Because only 1 and p - 1
are their own inverses, we can pair all the numbers in the range [2, p - 2] so that
the product of each pair equals 1. Notice that the product of all pairs equals 1.
Therefore if we multiply by 1 and p - 1, we complete (p - 1)!, and we obtain -1
as a result. Notice that from the previous proof it can also be inferred that
(p - 2)! = 1 (mod p).

Therefore:
S(p) = (p - 1)! + (p - 2)! + (p - 3)! + (p - 4)! + (p - 5)! (mod p)
     = -1 + 1 + (p - 3)! + (p - 4)! + (p - 5)! (mod p)
     = (p - 3)! + (p - 4)! + (p - 5)! (mod p)

Now, to solve the problem use the sieve to find all primes. Then use the previous
results to calculate (p - 1)! and (p - 2)!. Notice that:
(p - 3)! * (p - 2) = (p - 2)! = 1(mod p) -> (p - 3)! = (p - 2)^-1 (mod p)
Similarly:
(p - 4)! = (p - 3)! * (p - 3)^-1 (mod p)
(p - 5)! = (p - 4)! * (p - 4)^-1 (mod p)
=#

using Printf

start = time()
result = 0

limit = 10^8 - 1
slots = [true for _ in 1:limit]
slots[1] = false
for n in 2:limit
    global result
    if !slots[n]
        continue
    end
    for k in (2 * n):n:limit
        slots[k] = false
    end
    if n < 5
        continue
    end
    p3 = invmod(n - 2, n)
    p4 = (p3 * invmod(n - 3, n)) % n
    p5 = (p4 * invmod(n - 4, n)) % n
    result += (p3 + p4 + p5) % n
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
