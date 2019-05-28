#=
Approach:
In general, the number of times p appears in Nfac(p, q) = N(p, q)! is equal to
the number of times the powers of p appear in the numbers from 1 to N(p, q).
Therefore, NF(p, q) = floor(N(p, q) / p) + floor(N(p, q) / p^2) + ...

Notice also that because 0 <= Tn < p, then:

N(p, q) / p^k = (sum(n = 0, q) Tn * p^n) / p^k
              = (sum(n = 0, k - 1) Tn * p^n) / p^k + sum(n = k, q) Tn * p^(n - k)

But:

sum(n = 0, k - 1) Tn * p^n <= sum(n = 0, k - 1) (p - 1) * p^n
                            = (p - 1) * sum(n = 0, k - 1) p^n
                            = (p - 1) * (p^k - 1) / (p - 1)
                            = p^k - 1
                            < p^k

Therefore:

floor(N(p, q) / p^k) = sum(n = k, q) Tn * p^(n - k)

Therefore:

NF(p, q) = floor(N(p, q) / p) + floor(N(p, q) / p^2) + ...
         = sum(k = 1, q) sum(n = k, q) Tn * p^(n - k)
         = (T1 * p^0 + T2 * p^1 + ... + Tq * p^(q - 1)) +
           (T2 * p^0 + T3 * p^1 + ... + Tq * p^(q - 2)) +
           ... +
           Tq * p^0
         = (T1 + T2 + ... + Tq) * p^0 + (T2 + T3 + ... + Tq) * p^1 + ... + Tq * p^(q - 1)

=#

using Printf

start = time()
result = 0

p = Int128(61) # 3
q = Int128(10^7) # 10^4
m = Int128(61^10) # 3^20

memo = []
total = 0
s = 290797
for k in 1:q
    global total, s
    s = powermod(s, 2, 50515093)
    t = s % p
    total += t
    push!(memo, t)
end

expo = Int128(1)
for k in 0:(q - 1)
    global p, q, m, expo, result, total
    modtot = total % m
    step = (modtot * expo) % m
    result = (result + step) % m
    expo = (expo * p) % m
    total -= memo[k + 1]
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
