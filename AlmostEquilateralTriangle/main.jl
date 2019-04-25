#=
Approach:
Let's prove that the area of a triangle with side lengths a, b, and c equals
sqrt(p * (p - a) * (p - b) * (p - c)), where p = (a + b + c) / 2. Let h be the
altitude of the triangle and d the length of one of the segments of the side it
divides. Without loss of generality, assume h, d and b form a triangle and that h
divides c into two. Therefore d^2 + h^2 = b^2 and (c - d)^2 + h^2 = a^2. So:

d^2 - (c - d)^2 = b^2 - a^2
-c^2 + 2 * c * d = b^2 - a^2
d = (-a^2 + b^2 + c^2) / (2 * c)

Substituting into d^2 + h^2 = b^2:

(-a^2 + b^2 + c^2)^2 / (2 * c)^2 + h^2 = b^2
h^2 = b^2 - (-a^2 + b^2 + c^2)^2 / (2 * c)^2
h^2 = (b - (-a^2 + b^2 + c^2) / (2 * c)) * (b + (-a^2 + b^2 + c^2) / (2 * c))
h^2 = (2 * b * c + a^2 - b^2 - c^2) * (2 * b * c - a^2 + b^2 + c^2) / (4 * c^2)
h^2 = (a^2 - (b - c)^2) * ((b + c)^2 - a^2) / (4 * c^2)
h^2 = (a - b + c) * (a + b - c) * (- a + b + c) * (a + b + c) / (4 * c^2)
h^2 = 2 * (p - b) * 2 * (p - c) * 2 * (p - a) * 2 * p / (4 * c^2)
h^2 = 4 * (p - b)  * (p - c) * (p - a) * p / c^2
h^2 = 4 * p * (p - a) * (p - b)  * (p - c) / c^2
c^2 * h^2 / 4 = p * (p - a) * (p - b)  * (p - c)

Finally, if S is the area of triangle:

S = c * h / 2
S^2 = c^2 * h^2 / 4 = p * (p - a) * (p - b)  * (p - c)
S = sqrt(p * (p - a) * (p - b)  * (p - c))

Therefore the problem reduces to determining when p * (p - a) * (p - b) * (p - c)
is a square number. Notice that:

p * (p - a) * (p - b) * (p - c) = (a + b + c) / 2 *
                                    ((a + b + c) / 2 - a) *
                                    ((a + b + c) / 2 - b) *
                                    ((a + b + c) / 2 - c)
                                = (a + b + c) * (- a + b + c) * (a - b + c) * (a + b - c) / 16

Therefore (a + b + c) * (- a + b + c) * (a - b + c) * (a + b - c) must be divisible
by 16, and must be a square number. There are two types of almost equilateral triangles:
either the remaining side is smaller or larger by 1 than the other two sides.

Let the triangle be of the smaller by 1 type. Then:

= (a + b + c) * (- a + b + c) * (a - b + c) * (a + b - c)
= (3 * i - 1) * (i - 1)^2 * (i + 1)

If i is odd then, then both i - 1 and i + 1 are multiples of 2 and one of them is
a multiple of 4. Therefore the whole expression is divisible by 16. Otherwise
3 * i - 1 would have to be a multiple of 16, i.e. 3 * i - 1 = 0 mod 16. Because
i is not odd, it can be expressed in terms of another integer k as i = 2 * k.
Therefore 3 * (2 * k) - 1 = 0 mod 16. Because 3 is invertible mod 16, 2 * k = 11 mod 16,
Which is clearly not possible. Finally we would need to test whether (3 * i - 1) / d
and (i + 1) / d are both squares, where d = gcd(3 * i - 1, i + 1).

Let the triangle be of the larger by 1 type. Then:

= (a + b + c) * (- a + b + c) * (a - b + c) * (a + b - c)
= (3 * i + 1) * (i + 1)^2 * (i - 1)

If i is odd then, then both i - 1 and i + 1 are multiples of 2 and one of them is
a multiple of 4. Therefore the whole expression is divisible by 16. Otherwise
3 * i + 1 would have to be a multiple of 16, i.e. 3 * i + 1 = 0 mod 16. Because
i is not odd, it can be expressed in terms of another integer k as i = 2 * k.
Therefore 3 * (2 * k) + 1 = 0 mod 16. Because 3 is invertible mod 16, 2 * k = 5 mod 16,
Which is clearly not possible. Finally we would need to test whether (3 * i + 1) / d
and (i - 1) / d are both squares, where d = gcd(3 * i + 1, i - 1).

Finally, we only need to know the squares up to 3 * i + 1.
=#

using Printf

start = time()
result = 0

bound = fld(10^9, 3)
squares = Set([i^2 for i in 1:isqrt((3 * bound + 1))])

for i in 3:2:fld(10^9, 3)
    global result
    d = gcd(3 * i - 1, i + 1)
    if in(fld(3 * i - 1, d), squares) && in(fld(i + 1, d), squares)
        result += 3 * i - 1
    end
end

for i in 1:2:fld(10^9, 3)
    global result
    d = gcd(3 * i + 1, i - 1)
    if in(fld(3 * i + 1, d), squares) && in(fld(i - 1, d), squares)
        result += 3 * i + 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
