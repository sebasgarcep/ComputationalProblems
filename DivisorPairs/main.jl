#=
Approach:
Notice that for n = p1^k1 * p2^k2 * ... * pm^km, b can take the values of all
possible divisors of n, except for 1 (as there is no number distinct from 1 that
divides it). Suppose that b = p1^k1' * p2^k2' * ... * pm^km'. As a can take all
possible values of divisors of b, but b, then there are
(k1' + 1) * (k2' + 1) * ... * (km' + 1) - 1 possible values that a can take.
Therefore:

S(n) = S(p1^k1 * p2^k2 * ... * pm^km)
     = sum(k1' = 0, k1) sum(k2' = 0, k2) ... sum(km' = 0, km) [
        (k1' + 1) * (k2' + 1) * ... * (km' + 1) - 1
     ]
     = prod(j = 1, m) sum(kj' = 0, kj) (kj' + 1)
        + sum(k1' = 0, k1) sum(k2' = 0, k2) ... sum(km' = 0, km) -1
     = prod(j = 1, m) (kj + 1 + kj * (kj + 1) / 2)
        + sum(k1' = 0, k1) sum(k2' = 0, k2) ... sum(km' = 0, km) -1
     = prod(j = 1, m) (kj + 1 + kj * (kj + 1) / 2)
        - prod(j = 1, m) (kj + 1)
     = prod(j = 1, m) (kj + 1) * (1 + kj / 2)
        - prod(j = 1, m) (kj + 1)
     = prod(j = 1, m) (kj + 1) * prod(j = 1, m) (1 + kj / 2)
        - prod(j = 1, m) (kj + 1)
     = prod(j = 1, m) (kj + 1) * ( prod(j = 1, m) (1 + kj / 2) - 1 )

When m = 904961, 1 <= s <= 10^12, then:

S(n) = (s + 1)^m * ( (1 + s / 2)^m - 1 )
     = (s + 1)^m * ( (2 + s)^m - 2^m ) / 2^m

To find the largest 2^k that divides S(n), let's divide the problem into two cases:

1. If s is odd then (2 + s)^m is odd and (2 + s)^m - 2^m is odd too. Therefore
we need to find the largest power of two of (s + 1)^m and divide it by 2^m. If
s + 1 = r * 2^k, then (s + 1)^m / 2^m = r^m * 2^(k * m - m). Therefore the value
of E for this s is m * (k - 1). Because m is constant, and we want to find the
sum over all odd s, we only need to find, for all even s + 1, how many fall in
k = 1, k = 2, k = 3, ... and multiply by m * (k - 1).

2. If s is even then (s + 1)^m is odd. Therefore we need to find the largest
power of two of (2 + s)^m - 2^m and divide it by 2^m. If 2 + s = r * 2^k, then
s + 2 is either 4 * t or 4 * t + 2. If s + 2 = 4 * t, then:

((s + 2)^m - 2^m) / 2^m = (4^m * t^m - 2^m) / 2^m
                        = (2^(2 * m) * t^m - 2^m) / 2^m
                        = 2^m * t^m - 1

which is odd. Therefore the largest power of two that can divide this number is
2^0 and thus E = 0. Now, if s + 2 = 4 * t + 2, then:

((s + 2)^m - 2^m) / 2^m = ((4 * t + 2)^m - 2^m) / 2^m
                        = (2 * t + 1)^m - 1
                        = (2 * t + 1)^m - 1^m
                        = (2 * t + 1 - 1) * ((2 * t)^(m - 1) + (2 * t)^(m - 2) + ... + (2 * t) + 1)
                        = 2 * t * ((2 * t)^(m - 1) + (2 * t)^(m - 2) + ... + (2 * t) + 1)

Clearly, the rightmost term is odd. Therefore the largest power of two that can
divide this number is determined by 2 * t. Suppose t = r * 2^k. Then E = k + 1.
Because 1 <= s <= 10^12 implies 1 <= 4 * t <= 10^12, then:

1/4 <= t <= 10^12 / 4
1 <= t <= 10^12 / 4

and for each of these possible values of t count how many times they fall into
a certain k. Multiply this number by k + 1, and add the result to the accumulator.

=#

using Printf

start = time()
result = 0

n = 10^12
m = 904961

k = 1
upper = n + 1
while true
    global k, result
    r = fld(upper, 2^k) - fld(upper, 2^(k + 1))
    if r <= 0
        break
    end
    result += r * m * (k - 1)
    k += 1
end

k = 0
upper = fld(n, 4)
while true
    global k, result
    r = fld(upper, 2^k) - fld(upper, 2^(k + 1))
    if r <= 0
        break
    end
    result += r * (k + 1)
    k += 1
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
