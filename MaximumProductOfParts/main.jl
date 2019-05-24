#=
Approach:
Let f_N(k) = (N/k)^k. Then ln(f_N(k)) = k * (N/k). Then:

f_N'(k)/f_N(k) = ln(N/k) + k * (-N/k^2)/ (N/k)
               = ln(N/k) - 1

Therefore f_N'(k) = (N/k)^k * (ln(N/k) - 1). This function attains its maximum
when f_N'(k) = 0. Therefore ln(N/k) - 1 = 0, as (N/k)^k can't be. That is, k = N/e.
Therefore M(k) is in { floor(N/e), ceil(N/e) }. Let floor(N/e) = p. Then either
ceil(N/e) = p, and we are done, or ceil(N/e) = p + 1. Assume that f_N(p) < f_N(p + 1).
Then:

(N/p)^p < (N/(p + 1))^(p + 1)
(1/p)^p < N * (1/(p + 1))^(p + 1)
(p + 1)^(p + 1) < N * p^p
(p + 1) * ln(p + 1) < ln(N) + p * ln(p)

which we can use to check for the value of M(k).

Finally, a fraction in reduced form terminates if and only if the denominator is
of the form 2^s * 5^t.

=#

using Printf

function m(n)
    val = n / MathConstants.e
    lower = floor(Int64, val)
    upper = ceil(Int64, val)
    if upper * log(upper) < log(n) + lower * log(lower)
        return upper
    else
        return lower
    end
end

function d(n)
    den = m(n)
    den = fld(den, gcd(n, den))
    while den % 2 == 0
        den = fld(den, 2)
    end
    while den % 5 == 0
        den = fld(den, 5)
    end
    if den > 1
        return n
    else
        return -n
    end
end

start = time()
result = 0

for n in 5:10000
    global result
    result += d(n)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
