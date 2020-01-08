#=
Approach:

Label the centers of each circle a, b, and c. Notice that the line from a to b has length ra + rb.
If we draw a line parallel L to that goes through a, and a line perpendicular to L that goes through
b we create a right triangle. Clearly the vertical side of this triangle has length rb - ra. Therefore
the lower side has length 2 * sqrt(ra * rb) from Pythagora's theorem. This same construction can be made
between circle a and circle c, respectively, and the resulting lower side has length equal to 2 * sqrt(ra * rc).
Repeating the same procedure for circle b and circle c, respectively, we obtain a lower side of length
2 * sqrt(rb * rc). Notice that the lower side of the two latter triangles we contructed equals the distance
from the line perpendicular to L that goes through a and the line perpendicular to L that goes through b.
From the first construction we made it is clear that the length of such line is 2 * sqrt(ra * rb). Thus:

2 * sqrt(ra * rb) = 2 * sqrt(ra * rc) + 2 * sqrt(rb * rc)
sqrt(ra * rb) = sqrt(ra * rc) + sqrt(rb * rc)
1 / sqrt(rc) = 1 / sqrt(rb) + 1 / sqrt(ra)
1 / sqrt(rc) = 1 / sqrt(ra) + 1 / sqrt(rb)

Clearly, if x = sqrt(ra), y = sqrt(rb), z = sqrt(rc) are integers then the problem reduces to the problem
of the Diophantine Reciprocals where ra, rb, and rc are multiples of square numbers.

Assume gcd(ra, rb, rc) = 1. Therefore gcd(x, y, z) = 1. Assume x is rational and y is irrational. Then for
some non-square integer p, we have that:

1 / z = 1 / x + 1 / y = c1 + c2 * sqrt(p)

where c1 and c2 are rational. Therefore 1 / z belongs to Q[sqrt(p)]. Thus, for some rational c3, 1 / z = c3 * sqrt(p).
Therefore:

c3 * sqrt(p) = c1 + c2 * sqrt(p)
(c3 - c2) * sqrt(p) = c1

Therefore c1 = 0, impossible as 1 / x != 0, or c3 - c2 is a multiple of sqrt(p). This is impossible as both
c3 and c2 are rational. Therefore x is irrational. Let:

1 / x = c1 + c2 * sqrt(p1)
1 / y = c3 + c4 * sqrt(p2)

where c1, c2, c3, c4 are rational and p1, p2 are non-square integers. Then:

1 / z = (c1 + c3) + c2 * sqrt(p1) + c4 * sqrt(p2)

1 / sqrt(rc) = (c1 + c3) + c2 * sqrt(p1) + c4 * sqrt(p2)
1 / rc = (c1 + c3)^2 + c2^2 * p1 + c4^2 * p2
    + 2 * (c1 + c3) * c2 * sqrt(p1) + 2 * (c1 + c3) * c4 * sqrt(p2) + 2 * c2 * c4 * sqrt(p1 * p2)

Clearly 1 / rc is rational, but the right hand side is not unless:

- (c1 + c3) * c2 is a multiple of sqrt(p2)
- (c1 + c3) * c4 is a multiple of sqrt(p1)
- c2 = 0
- c4 = 0
- c1 + c3 = 0

all of which imply some sort of contradiction. Therefore both x and y must be rational.

Therefore, for a given n, the bounds for the problem are:

1 <= sqrt(ra) <= sqrt(rb) <= sqrt(n)

Notice that we assumed that gcd(ra, rb, rc) = 1. This is clearly not always the case. for example
(ra, rb, rc) = (8, 8, 2) is a solution. This solution is actually the multiple of the solution
(4, 4, 1). In general, integer multiples of solutions with gcd(ra, rb, rc) = 1 are also solutions.
These can be easily counted using basic summation formulas.

=#

using Printf

function main()
    start = time()
    result = 0

    n = 10^9

    for sqrt_rb in 1:isqrt(n)
        for sqrt_ra in 1:sqrt_rb
            if (sqrt_ra * sqrt_rb) % (sqrt_ra + sqrt_rb) == 0
                ra = sqrt_ra^2
                rb = sqrt_rb^2
                rc = fld(sqrt_ra * sqrt_rb, sqrt_ra + sqrt_rb)^2
                if gcd(ra, gcd(rb, rc)) == 1
                    k = fld(n, rb)
                    result += fld(k * (k + 1), 2) * (ra + rb + rc)
                end
            end
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
