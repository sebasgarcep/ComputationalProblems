#=
Approach:
(https://forthright48.com/chinese-remainder-theorem-part-2-non-coprime-moduli/)

Suppose x = a (mod n) and x = b (mod m). Then x = a + s * n and x = b + t * m.
Therefore a + s * n = b + t * m or a - b = 0 + (t * m - s * n). Therefore
a = b (mod gcd(m, n)).

Now, from Bezout's identity we know that there must be a solution to:

n * s + m * t = gcd(m, n)

The extended euclidean algorithms allows us to find the values for s and t. Then,
if n' = n / gcd(m, n), m' = m / gcd(m, n):

n' * s + m' * t = 1

Let x = b * n' * s + a * m' * t. Notice that:

x = b * n' * s + a * m' * t + a * n' * s - a * n' * s
  = b * n' * s + a - a * n' * s
  = (b - a) * n' * s + a

But gcd(m, n) | b - a. Therefore b - a = r * gcd(m, n). Thus:

x = (b - a) * n' * s + a = r * gcd(m, n) * n' * s + a = r * n * s + a

Therefore x = a (mod n). By a similar argument it can be shown that x = b (mod m).
Therefore x is a solution. Finally to find the smallest possible solution to the
system (as x may not be it), suppose x' is a solution too. Then x - x' = 0 (mod n)
and x - x' = 0 (mod m). Therefore x - x' = 0 (mod lcm(m, n)). Since any two adjacent
solutions are divisible by lcm(m, n), there cannot be more than one solution in
the range [0, lcm(m, n) - 1]. Thus x = b * n' * s + a * m' * t (mod lcm(m, n))
is the smallest solution.

=#

using Printf

function totient(x)
    total = 1
    current = x
    while current > 1
        if current % 2 == 0
            k = 0
            while current % 2 == 0
                current = fld(current, 2)
                k += 1
            end
            total *= 2^k - 2^(k - 1)
        else
            found = false
            for p in 3:2:isqrt(current)
                if current % p == 0
                    k = 0
                    while current % p == 0
                        current = fld(current, p)
                        k += 1
                    end
                    total *= p^k - p^(k - 1)
                    found = true
                    break
                end
            end
            if !found # current is prime number
                p = current
                total *= p - 1
                current  = 1
            end
        end
    end
    return total
end

function extended_euclidean(a, b)
    (curr_s, prev_s) = (0, 1)
    (curr_t, prev_t) = (1, 0)
    (curr_r, prev_r) = (b, a)
    while curr_r != 0
        quotient = fld(prev_r, curr_r)
        (prev_r, curr_r) = (curr_r, prev_r - quotient * curr_r)
        (prev_s, curr_s) = (curr_s, prev_s - quotient * curr_s)
        (prev_t, curr_t) = (curr_t, prev_t - quotient * curr_t)
    end
    return prev_s, prev_t # Bezout Coefficients
    # return prev_r # Greeatest Common Divisor
    # return curr_t, curr_s # Quotients by the GCD
end

start = time()
result = 0

lower = 1000000
upper = 1005000

totient_vals = [totient(i) for i in lower:(upper - 1)]
for n in lower:(upper - 2)
    for m in (n + 1):(upper - 1)
        a = totient_vals[n - lower + 1]
        b = totient_vals[m - lower + 1]
        d = gcd(n, m)
        if mod(a - b, d) != 0
            continue
        end
        n_p = fld(n, d)
        m_p = fld(m, d)
        (s, t) = extended_euclidean(n_p, m_p)
        l = lcm(m, n)
        x = mod(b * n_p * s + a * m_p * t, l)
        global result
        result += x
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
