#=
Approach:
Notice that sum(k = 0, n) r^k = (r^n+1 - 1) / (r - 1). Deriving both sides of the
equation with respect to r produces:

sum(k = 0, n) k * r^k-1 = (n * r^n+1 - (n + 1) * r^n + 1) / (r - 1)^2

Or equivalently:

sum(k = 1, n) k * r^k-1 = (n * r^n+1 - (n + 1) * r^n + 1) / (r - 1)^2

Therefore:

s(n) = sum(k = 1, n) (900 - 3k) * r^k-1
     = 900 * sum(k = 1, n) r^k-1 - 3 * sum(k = 1, n) k * r^k-1
     = 900 * sum(k = 0, n - 1) r^k - 3 * sum(k = 1, n) k * r^k-1
     = 900 * (r^n - 1) / (r - 1) - 3 * (n * r^n+1 - (n + 1) * r^n + 1) / (r - 1)^2

Finally we can use bisection search with tolerance to find an appropiate value for
r, using the fact that the function is decreasing in the search interval.
=#

using Printf

function s(n, r)
    return 900.0 * (r^n - 1) / (r - 1) - 3.0 * (n * r^(n + 1) - (n + 1) * r^n + 1) / (r - 1)^2
end

start = time()

n = 5000.0
a = 1.002
b = 1.003
v = -6.0 * 10^11
result = (a + b) / 2

while true
    global result, a, b
    t = s(n, result)
    if t < v
        temp = result
        result = (a + result) / 2
        b = temp
    else
        temp = result
        result = (result + b) / 2
        a = temp
    end
    if abs(temp - result) < 10^(-14)
        break
    end
end

@printf("%.12f\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

