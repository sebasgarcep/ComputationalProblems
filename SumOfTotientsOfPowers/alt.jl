#=
Approach:

Lemma 1:
-------------------------------------------------------------------------------

sum(k = 1, n, k odd) k = floor((n + 1) / 2)^2

Proof:
------

n * (n + 1) / 2 = sum(k = 1, n) k
                = sum(k = 1, n, k odd) k + = sum(k = 1, n, k even) k

If n is even:

n * (n + 1) / 2 = sum(k = 1, n, k odd) k + sum(k = 1, n, k even) k
                = sum(k = 1, n, k odd) k + sum(k = 1, n, k odd) (k + 1)
                = 2 * sum(k = 1, n, k odd) + n / 2

Then:

2 * sum(k = 1, n, k odd) = n * (n + 1) / 2 - n / 2
2 * sum(k = 1, n, k odd) = n^2 / 2
sum(k = 1, n, k odd) = n^2 / 4
sum(k = 1, n, k odd) = (n / 2)^2 = floor(n / 2)^2 = floor((n + 1) / 2)^2

If n is odd:

n * (n + 1) / 2 = sum(k = 1, n, k odd) k + sum(k = 1, n, k even) k
                = sum(k = 1, n, k odd) k + sum(k = 1, n, k odd) (k + 1) - (n + 1)
                = 2 * sum(k = 1, n, k odd) + (n + 1) / 2 - (n + 1)
                = 2 * sum(k = 1, n, k odd) - (n + 1) / 2

Then:

2 * sum(k = 1, n, k odd) = n * (n + 1) / 2 + (n + 1) / 2
2 * sum(k = 1, n, k odd) = (n + 1) / 2 * (n + 1)
2 * sum(k = 1, n, k odd) = (n + 1)^2 / 2
sum(k = 1, n, k odd) = (n + 1)^2 / 4 = ((n + 1) / 2)^2 = floor((n + 1) / 2)^2

Lemma 2:
-------------------------------------------------------------------------------

sum(d | n) phi(d) = n

Proof:
------

Clearly |Zn| = n. Note that every divisor d of n, there is an unique subgroup of
Zn with cardinality d. Notice that this subgroup must be Zd. Clearly, Zd has
phi(d) different possible generators. Also, any generator of Zd cannot be the
generator of Zd' unless Zd = Zd'. Thus:

sum(d | n) phi(d) <= n

Because any number generates a subgroup of Zn, then each member of Zn must count
at least once in one of the phi(d). Thus:

sum(d | n) phi(d) >= n

Therefore:

sum(d | n) phi(d) = n

Lemma 3:
-------------------------------------------------------------------------------

sum(d = 1, n, d odd) floor((n + d) / (2 * d)) * phi(d) = floor((n + 1) / 2)^2

Proof:
------

Combining Lemmas 1 and 2 we get:

sum(k = 1, n, k odd) sum(d | k) phi(d) = sum(k = 1, n, k odd) k = floor((n + 1) / 2)^2

Also, the number of odd multiples of d, less than or equal to n, are floor((n + d) / (2 * d)).
Therefore by swapping the sums we obtain the desired result.

Theorem:
-------------------------------------------------------------------------------

g(n) = floor((n + 1) / 2)^2 - sum(k = 2, (n + 1) / 2) g(floor(n / (2 * k - 1)))

Proof:
------

Notice that we want to remove the extra appearances of phi(d) from floor((n + 1) / 2)^2.
Notice also that when floor((n + d) / (2 * d)) = k, then:

n / (2 * k + 1) < d <= n / (2 * k - 1)

Thus for k = 1, n / 3 < d <= n, we don't have to subtract any phi(d). For k = 2,
n / 5 < d <= n / 3, we have to subtract one phi(d), thus we can subtract g(floor(n / (2 * k - 1)))
for that. When k = 3, n / 7 < d <= n / 5 and we have two subtract two phi(d)'s. But we
have already subtracted one from the case k = 2. Thus we only have to subtract g(floor(n / (2 * k - 1)))
again. We have to keep doing this until n / (2 * k - 1) < 1, i.e. until k > (n + 1) / 2.
This proves our recursion formula.

[Source: https://projecteuler.net/thread=512]

=#

using Memoize
using Printf

@memoize function g(n)
    if n == 1
        return 1
    end
    total = 0
    for k in 2:fld(n + 1, 2)
        total += g(fld(n, 2 * k - 1))
    end
    return fld(n + 1, 2)^2 - total
end

start = time()
result = 0

n = 5 * 10^8

result = g(n)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
