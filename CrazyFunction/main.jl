#=
Approach:
Let G(n) = F(a + n). Assume a + n <= b. Then:

F(n) = F(a + F(a + F(a + F(a + n))))
F(n) = G(G(G(F(a + n))))
F(n) = (G^3 . F)(a + n)
F(n) = (G^3 . G^3 . F)(a + a + n)
F(n) = (G^6 . F)(2 * a + n)

In general, if k * a + n > b, is the smallest k for which this is true, then:

F(n) = (G^(3 * k) . F)(k * a + n)
     = G^(3 * k)(k * a + n - c)
     = (G^(3 * k - 1) . G)(k * a + n - c)

Notice that (k + 1) * a + n - c = k * a + n + (a - c) > k * a + n > b, as in both
the example and the problem a > c. Therefore:

F(n) = (G^(3 * k - 1) . G)(k * a + n - c)
     = (G^(3 * k - 1) . F)(a + k * a + n - c)
     = (G^(3 * k - 1) . F)((k + 1) * a + n - c)
     = G^(3 * k - 1)((k + 1) * a + n - 2 * c)

Therefore on each iteration we will add one a and subtract one c. Because a > c,
then, for any j >= 0, we have that (k + j) * a + n - (j + 1) * c > b. Therefore:

F(n) = 4 * k * a + n - (3 * k + 1) * c

To calculate k notice that the smallest k for which k * a + n > b is equivalent
to the smallest k for which k * a + n >= b + 1. Therefore:

k = ceiling((b + 1 - n) / a)

Therefore:

S(a, b, c) = sum(n = 0, b) F(n)
           = sum(n = 0, b) 4 * k * a + n - (3 * k + 1) * c
           = sum(n = 0, b) 4 * k * a
             + sum(n = 0, b) n
             - sum(n = 0, b) (3 * k + 1) * c
           = 4 * a * sum(n = 0, b) k
             + b * (b + 1) / 2
             - sum(n = 0, b) 3 * k * c
             - sum(n = 0, b) c
           = 4 * a * sum(n = 0, b) k
             + b * (b + 1) / 2
             - 3 * c * sum(n = 0, b) k
             - c * (b + 1)
           = (4 * a - 3 * c) * sum(n = 0, b) k
             + b * (b + 1) / 2
             - c * (b + 1)

Therefore the problem is reduced to calculating sum(n = 0, b) k. Notice that
when n is in [b + 1 - a, b], then k = 1. Similarly, if n is in [b + 1 - j * a, b - (j - 1) * a],
then k = j. Because (b - (j - 1) * a) - (b + 1 - j * a) + 1 = a, then for each j
there are a different values for which k = j. Then the last complete segment of
a values of n for the same value of k can be found by finding the largest j for
which b - (j - 1) * a >= 0. Therefore:

b + 1 - j * a >= 0
- j * a >= - b - 1
j * a <= b + 1

Therefore:

j = floor((b + 1) / a)

Therefore:

sum(n = 0, b) k = sum(n = 0, b - j * a) k
                  + sum(n = b + 1 - j * a, b) k
                = sum(n = 0, b - j * a) k
                  + a * j + a * (j - 1) + ... + a * 2 + a * 1
                = sum(n = 0, b - j * a) k
                  + a * j * (j + 1) / 2
                = (b - j * a + 1) * (j + 1)
                  + a * j * (j + 1) / 2

Because for the incomplete segment, k = j + 1, and it has b - j * a + 1 elements.

=#

using Printf

start = time()
result = 0

m = Int128(10^9)
a = Int128(21^7)
b = Int128(7^21)
c = Int128(12^7)

j = fld(b + 1, a)
result += (b - j * a + 1) * (j + 1)
result += a * fld(j * (j + 1), 2)
result *= 4 * a - 3 * c
result += fld(b * (b + 1), 2)
result -= c * (b + 1)
result = mod(result, m)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
