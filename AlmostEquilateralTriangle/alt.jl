#=
Approach:
Let h be the altitude of the triangle with side lengths a, b, c, and let S be its
area. If h divides c into two segments:

S = c * h / 2

If c is the off-by-one side, then:

(c / 2)^2 + h^2 = a^2
((a +- 1) / 2)^2 + h^2 = a^2
(a +- 1)^2 + 4 * h^2 = 4 * a^2
a^2 +- 2 * a + 1 + 4 * h^2 = 4 * a^2
1 + 4 * h^2 = 3 * a^2 +- 2 * a
3 + 12 * h^2 = 9 * a^2 +- 6 * a + 1 - 1
3 + 12 * h^2 = (3 * a +- 1)^2 - 1
4 = (3 * a +- 1)^2 - 12 * h^2
1 = ((3 * a +- 1) / 2)^2 - 3 * h^2

Set x = (3 * a +- 1) / 2, y = h and we have Pell's equation:

1 = x^2 - 3 * y^2

Therefore we need to find the solutions to Pell's equation, using continued fractions:

m0 = 0
d0 = 1
a0 = floor(sqrt(D))
mk = dk-1 * ak-1 - mk-1
dk = (D - mk^2) / dk-1
ak = floor((a0 + mk) / dk)

Finally:

a <= 10^9 / 3
3 * a <= 10^9
3 * a +- 1 <= 10^9 +- 1
(3 * a +- 1) / 2 <= (10^9 +- 1) / 2
p <= (10^9 +- 1) / 2

Now, clearly for one case the perimeter equals (3 * a - 1) and for the other case
the perimeter equals (3 * a + 1), and in both cases this value would equal 2 * p.
Notice that 2 * p can only equal either of 3 * a + 1 and 3 * a - 1, but not both at once,
otherwise it would equal two different values mod 3, which is impossible. Also notice
that p must equal at least one of those, otherwise p = 0 mod 3, but when we consider
Pell's equation mod 3, p^2 = 1 mod 3 and therefore p = 1 mod 3 or p = -1 mod 3, a
contradiction. Therefore every time we find a solution we must add 2 * p to the total
perimeter.

Notice that when 2 * p = 2 mod 3, then the off-by-one side is larger than a by 1.
If 2 * p = 1 mod 3, then the off-by-one side is smaller than a by 1, and therefore
a is at least 2 and 2 * p is at least 5.
=#

using Printf

start = time()
result = 0
d = 3

negative_bound = fld(10^9 - 1, 2)
positive_bound = fld(10^9 + 1, 2)

a0 = BigInt(floor(sqrt(d)))
mk = BigInt(0)
dk = BigInt(1)
ak = a0
p_prev = BigInt(1)
q_prev = BigInt(0)
p = ak
q = BigInt(1)
while p <= positive_bound
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
    if p^2 - d * q^2 == 1
        val = 2 * p
        if (mod(val, 3) == 1 && p < positive_bound && val >= 5) ||
            (mod(val, 3) == 2 && p < negative_bound)
            result += val
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
