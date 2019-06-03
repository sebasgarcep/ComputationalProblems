#=
Approach:
Let x = d * a, y = d * b, where d = gcd(x, y). Therefore gcd(a, b) = 1. Then:

1/n = 1/x + 1/y = (x + y) / (x * y) = d * (a + b) / (d^2 * a * b) = (a + b) / (d * a * b).

Notice that if any prime p divides a * b, then because gcd(a, b) = 1, it must
divide either a or b exclusively. But then p cannot divide a + b, otherwise both
would be divisible by p, which is a contradiction. Therefore gcd(a * b, a + b) = 1.
Because n = d * a * b / (a + b) is an integer then a + b divides d, and Therefore
d = k * (a + b). Thus:

x = k * a * (a + b)
y = k * b * (a + b)
n = k * a * b

Therefore, to count all solutions to this equation for a given n we can find all
divisors of n, and let that divisor be k. Then, assuming a <= b, we can check up
to sqrt(n/k) for a divisor of n/k, which we will label a. Then b = n / (k * a).
If gcd(a, b) = 1, then we can count this as a solution.

A fast calculation shows that 2 * 3 * 5 * 7 * 11 * 13 * 17 = 510510 has 1094 solutions.
Therefore we only need to check up to this number.
=#

using Printf

function search()
    n = 1
    while true
        count = 0
        for k in 1:n
            if n % k != 0
                continue
            end
            v = fld(n, k)
            for a in 1:isqrt(v)
                if v % a != 0
                    continue
                end
                global result
                b = fld(v, a)
                if gcd(a, b) != 1
                    continue
                end
                count += 1
                if count > 1000
                    return n
                end
            end
        end
        n += 1
    end
end

start = time()
result = 0

result = search()
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
