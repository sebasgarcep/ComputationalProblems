#=
Alternative Approach:
Use the fact that (a/b) mod m = (a mod (m * b)) / b, when a = 0 mod b.
=#

using Printf

function modfib(n, m)
    if n == 0
        return (BigInt(0), mod(BigInt(1), m))
    end
    (a, b) = modfib(div(n, 2), m)
    c = a * mod(2 * b - a, m)
    c = mod(c, m)
    d = mod(a^2, m) + mod(b^2, m)
    d = mod(d, m)
    return n % 2 == 0 ? (c, d) : (d, (c + d) % m)
end

function modpow(x, n, m)
    mask = reverse(string(n, base = 2))
    p = BigInt(1)
    s = x
    for k in 1:length(mask)
        if mask[k] == '1'
            p = mod(p * s, m)
        end
        s = mod(s * s, m)
    end
    return p
end

start = time()

n = BigInt(10^15)
m = BigInt(factorial(15))
k = 100
result = BigInt(0)

for x in 1:k
    global result
    x = BigInt(x)
    a = x^2 + x - 1
    t = a * m
    (fn_curr, fn_next) = modfib(n, t)
    p = modpow(x, n + 1, t)
    d = mod(p * (fn_curr * x + fn_next) - x, t)
    d = div(d, a)
    result = mod(result + d, m)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

