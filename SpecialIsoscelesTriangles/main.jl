#=
Approach:
Notice that h is either b - 1 or b + 1. Therefore:

(b / 2)^2 + (b - 1)^2 = L^2
b^2 / 4 + b^2 - 2 * b + 1 = L^2
b^2 + 4 * b^2 - 8 * b + 4 = 4 * L^2
5 * b^2 - 8 * b + 4 = 4 * L^2
25 * b^2 - 40 * b + 20 = 20 * L^2
25 * b^2 - 40 * b + 16 + 4 = 20 * L^2
(5 * b - 4)^2 + 4 = 20 * L^2
((5 * b - 4) / 2)^2 + 1 = 5 * L^2
((5 * b - 4) / 2)^2 + 5 * L^2 = -1

and with x = (5 * b - 4) / 2, y = L we get:

x^2 - 5 * y^2 = -1

Now for the second case:

(b / 2)^2 + (b + 1)^2 = L^2
b^2 / 4 + b^2 + 2 * b + 1 = L^2
b^2 + 4 * b^2 + 8 * b + 4 = 4 * L^2
5 * b^2 + 8 * b + 4 = 4 * L^2
25 * b^2 + 40 * b + 20 = 20 * L^2
25 * b^2 + 40 * b + 16 + 4 = 20 * L^2
(5 * b + 4)^2 + 4 = 20 * L^2
((5 * b + 4) / 2)^2 + 1 = 5 * L^2
((5 * b + 4) / 2)^2 + 5 * L^2 = -1

and with x = (5 * b + 4) / 2, y = L we get:

x^2 - 5 * y^2 = -1

Therefore we need to solve the negative Pells' equation x^2 - 5 * y^2 = -1, which
can be solved using the same formulas as the usual ones for the positive case:

m0 = 0
d0 = 1
a0 = floor(sqrt(D))
mk = dk-1 * ak-1 - mk-1
dk = (D - mk^2) / dk-1
ak = floor((a0 + mk) / dk)

Finally, for a given x, b is either (2 * x - 4) / 5 or (2 * x + 4) / 5. It cannot
be both as (2 * x + 4) - (2 * x - 4) = 8 != 0 mod 5, therefore at most only one
of those terms is divisible by 5.
=#

using Printf

start = time()
result = 0

count = 0
bound = 12
d = 5
a0 = BigInt(floor(sqrt(d)))
mk = BigInt(0)
dk = BigInt(1)
ak = a0
p_prev = BigInt(1)
q_prev = BigInt(0)
p = ak
q = BigInt(1)
while count < bound
    global mk, dk, ak, p_prev, q_prev, p, q, result, count
    mk = ak * dk - mk
    dk = div(d - mk^2, dk)
    ak = div(a0 + mk, dk)
    p_temp = p
    q_temp = q
    p = ak * p + p_prev
    q = ak * q + q_prev
    p_prev = p_temp
    q_prev = q_temp
    if p^2 - d * q^2 == -1
        if mod(2 * p - 4, 5) == 0 || mod(2 * p + 4, 5) == 0
            result += q
            count += 1
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
