"""
Approach:
Note that for (a - 1)^n and (a + 1)^n most terms are multiples of a^2. Ignoring
those we get:

(a - 1)^n = +- n * a +- 1 (mod a^2)
(a + 1)^n = n * a + 1 (mod a^2)

when n is even:

(a - 1)^n + (a + 1)^n = 2

but when n is odd:

(a - 1)^n + (a + 1)^n = 2 * n * a

Note that for a >= 3, the case n = 1 produces a remainder of 2 * a <= a^2.
Therefore we only need to maximize the case for an odd n. Note that 2 * n * a
takes all possible values when n is in the range [0, a - 1], therefore we can
search for all values of n in this range instead of searching in the larger
interval [0, a^2 - 1] with step 2.
"""

using Printf

start = time()
result = 0

for a in 3:1000
    global result
    r_max = 2 * a
    mod = a^2
    for n in 2:(a - 1)
        r_cmp = (2 * n * a) % mod
        if r_cmp > r_max
            r_max = r_cmp
        end
    end
    result = result + r_max
end

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

