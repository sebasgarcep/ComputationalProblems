#=
Approach:
Suppose p divides n and N(p) <= sqrt(n). Then n/p is a divisor of n and N(p) >= sqrt(n). Therefore
the divisors of n can be found by looking up to sqrt(n) in terms of the norm. Notice that:

n / (a + i * b) = n * (a - i * b) / (a^2 + b^2)
                = n * a / (a^2 + b^2) + i * n * b / (a^2 + b^2)

Therefore n is divisible ny a + i * b if and only if a^2 + b^2 | n * a, n * b, or equivalently, if
(a^2 + b^2) / gcd(a, b) | n. Therefore the solution to the problem is the following:

1. Generate all Gaussian integers with a >= b and a > 0 and b >= 0 and (a^2 + b^2 <= n or b = 0).
2. If b = 0, then the amount of numbers in the range [1, n] divisible by a is floor(n, a). Therefore
this integer contributes a * floor(n, a) to the total sum.
3. Let b > 0 and step_size = (a^2 + b^2) / gcd(a, b).
4. The amount of numbers in the range [1, n] divisible by a + i * b is floor(n / step_size). Now we
make use of the symmetry of the divisibility property: if a + i * b | x, then a - i * b | x. Thus,
these terms contribute 2 * a to the total sum. By symmetry b + i * a, b - i * a, are also divisors
of x. Thus, because we limited a >= b, we can safely add their contribution to the sum, i.e. we can
add 2 * b, but only if a > b. Because this contribution is repeated floor(n / step_size) times, the
total contribution becomes 2 * floor(n / step_size) * (a + b), or 2 * floor(n / step_size) * a if
b = 0.
5. For each number that a + i * b divides, find the complement, i.e. if a + i * b | x, then find
x / (a + i * b). Clearly the norm of this element must be larger than sqrt(n) and less than or equal
to n. If x = k * step_size, then:

N(x / (a + i * b)) > sqrt(n)
N(x) / N(a + i * b) > sqrt(n)
N(x)^2 / N(a + i * b)^2 > n
(k^2 * step_size^2) / (a^2 + b^2) > n
(k^2 * step_size^2) > n * (a^2 + b^2)
k^2 > n * (a^2 + b^2) / step_size^2
k > sqrt(n * (a^2 + b^2) / step_size^2)
k => floor(sqrt(n * (a^2 + b^2) / step_size^2)) + 1 := lim_inf

And clearly, k <= floor(n / step_size) := lim_sup

Finally:

x / (a + i * b) = x * a / (a^2 + b^2) + i * x * b / (a^2 + b^2)
                = k * step_size * a / (a^2 + b^2) + i * k * step_size * b / (a^2 + b^2)
                = k * a / gcd(a, b) + i * k * b / gcd(a, b)

Therefore all divisors are of the form k * (a / gcd(a, b) + i * b / gcd(a, b)). Because we are adding
over them for k in [lim_inf, lim_sup], the final contribution of all these terms is:

2 * (a / gcd(a, b) + b / gcd(a, b)) * (lim_sup * (lim_sup + 1) / 2 - lim_inf * (lim_inf - 1) / 2)

or if a = b:

2 * a / gcd(a, b) * (lim_sup * (lim_sup + 1) / 2 - lim_inf * (lim_inf - 1) / 2)

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    n = 10^8

    # Solution
    # Assume |b| <= |a|
    for a in 1:n
        # Case 1: b = 0, i.e. divisor is in Z
        result += a * fld(n, a)
        # Case 2: b > 0, i.e. divisor is not in Z
        for b in 1:min(a, isqrt(max(0, n - a^2)))
            norm2 = a^2 + b^2
            step = fld(norm2, gcd(a, b))
            num_steps = fld(n, step)
            if a != b
                result += 2 * (a + b) * num_steps
            else
                result += 2 * a * num_steps
            end
            min_step = convert(Int64, floor(sqrt(n * norm2 / step^2))) + 1
            mult = fld(num_steps * (num_steps + 1), 2) - fld(min_step * (min_step - 1), 2)
            e = fld(a, gcd(a, b))
            f = fld(b, gcd(a, b))
            if a != b
                result += 2 * (e + f) * mult
            else
                result += 2 * e * mult
            end
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
