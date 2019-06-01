#=
Approach:
Let l be any positive real number. Then there always exists a real value of t such
that l = 2^t. Therefore k = 4^t - 2^t = (2^t)^2 - 2^t = l^2 - l. Notice that if
l = 1, then k = 0, and if l = infty then k = infty. Because l^2 - l is continuous
then l^2 - l takes all real positive values, and therefore all integer values. Let
D(m) be the number of values of t such that l^2 - l <= m. Because l can take all
possible integer values, we only need to find the number of values of l for which
this inequality still holds. Therefore l <= (1 + sqrt(4 * m + 1)) / 2. Notice that
for l = 1, t = 0, but t must be positive. Therefore D(m) = floor((1 + sqrt(4 * m + 1)) / 2) - 1

Therefore P(m) = N(m) / D(m), where N(m) is the number of integer values of t such that
l^2 - l <= m. Therefore t <= log2((1 + sqrt(4 * m + 1)) / 2) = log2(1 + sqrt(4 * m + 1)) - 1,
from the inequality on l.

Finally, if P(m) = n / d < 1 / 12345, then n * 12345 < d.
=#

using Printf

start = time()
result = 0

m = 44043900000 # Use bisection search to find this value
n = 0
d = 0
while n * 12345 >= d
    global m, n, d
    m += 1
    n = floor(Int128, log2(1 + sqrt(4 * m + 1))) - 1
    d = floor(Int128, (1 + sqrt(4 * m + 1)) / 2) - 1
end

result = m
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
