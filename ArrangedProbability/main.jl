#=
Approach:
Notice that:

b / (b + r) * (b - 1) / (b + r - 1) = 1 / 2
2 * b^2 - 2b = (b + r)^2 - (b + r)
2 * b^2 - 2b = b^2 + 2 * b * r + r^2 - b - r
b^2 - b = 2 * b * r + r^2 - r
b^2 - b - 2 * b * r = r^2 - r
b^2 - 2 * b * (1 / 2 + r) = r^2 - r
b^2 - 2 * b * (1 / 2 + r) + (1 / 2 + r)^2 - (1 / 2 + r)^2 = r^2 - r
(b - 1/2 - r)^2 = (1 / 2 + r)^2 + r^2 - r
(b - 1/2 - r)^2 = 1 / 4 + r + r^2 + r^2 - r
(b - 1/2 - r)^2 = 1 / 4 + 2 * r^2
(2 * b - 1 - 2 * r)^2 = 1 + 8 * r^2
(2 * b - 2 * r - 1)^2 - 8 * r^2 = 1

And substituting x = 2 * b - 2 * r - 1, y = r we obtain:

x^2 - 8 * y^2 = 1

which is Pell's equation and can be solved using the convergents of the continued
fraction representations of sqrt(8). In particular, the equations we will use are:

m0 = 0
d0 = 1
a0 = floor(sqrt(D))
mk = dk-1 * ak-1 - mk-1
dk = (D - mk^2) / dk-1
ak = floor((a0 + mk) / dk)

Finally, for a given x and y:

b = (x + 2 * r + 1) / 2
b = (x + 2 * y + 1) / 2
b + r = (x + 2 * y + 1) / 2 + y
b + r = (x + 4 * y + 1) / 2

And therefore b + r = (x + 4 * y + 1) / 2 > 10^12, i.e. x + 4 * y + 1 > 2 * 10^12.
=#

using Printf

start = time()
result = 0

bound = BigInt(2 * 10^12)

d = 8
a0 = BigInt(floor(sqrt(d)))
mk = BigInt(0)
dk = BigInt(1)
ak = a0
p_prev = BigInt(1)
q_prev = BigInt(0)
p = ak
q = BigInt(1)
while p + 4 * q + 1 <= bound || p^2 - d * q^2 != 1
    global mk, dk, ak, p_prev, q_prev, p, q, result
    mk = ak * dk - mk
    dk = div(d - mk^2, dk)
    ak = div(a0 + mk, dk)
    p_temp = p
    q_temp = q
    p = ak * p + p_prev
    q = ak * q + q_prev
    p_prev = p_temp
    q_prev = q_temp
end

result = fld(p + 2 * q + 1, 2)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
