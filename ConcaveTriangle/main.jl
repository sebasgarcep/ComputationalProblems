#=
Approach:
Assume, WLOG, that the circles have radius 1. Therefore, for n circles, the
rectangle has dimensions 2 x 2n. If we place this rectangle in a cartesian coordinate
system, with the lower left edge on the origin, we can represent the diagonal
with the function d(x) = x / n. Similarly, the lower left arc of the first circle
can be represented with the function a(x) = 1 - sqrt(1 - (1 - x)^2). To see this
notice that for any point x in the range [0, 1], the point (x, a(x)) is on the
arc, and because the center of the circle is located at (1, 1), it must satisfy
(1 - x)^2 + (1 - a(x))^2 = 1. Solving for a(x) leads to the previous equation.

Notice that the diagonal and the arc intersect on a point x, such that d(x) = a(x).
Therefore, we need to solve for x:

x / n = 1 - sqrt(1 - (1 - x)^2)
sqrt(1 - (1 - x)^2) = 1 - x / n
1 - (1 - x)^2 = (1 - x / n)^2
1 - 1 + 2 * x - x^2 = 1 - 2 * x / n + x^2 / n^2
0 = 1 - 2 * x / n + x^2 / n^2 - 2 * x + x^2
0 = (1 / n^2 + 1) * x^2 + (- 2 - 2 / n) * x + 1

Therefore:

x = (2 + 2 / n - sqrt((2 + 2 / n)^2 - 4 * (1 / n^2 + 1) * (1)))) / (2 * (1 / n^2 + 1))
  = (1 + 1 / n - sqrt((1 + 1 / n)^2 - (1 / n^2 + 1))) / (1 / n^2 + 1)
  = (1 + 1 / n - sqrt(2 / n)) / (1 / n^2 + 1)

The area under the diagonal can be split into A1 and A2, where A1 is the area from
t = 0 to t = x, and A2 goes from t = x to t = 1. A1 can be easily calculated as:

A1 = x * d(x) / 2

A2 can be calculated by noticing that a vertical line going through x creates a
rectangle to its right with area 1 - x. The portion of the circle inside this
rectangle can be split into two by drawing a line from the upper right corner
to the point (x, d(x)). The area above this line forms a right triangle with area
(1 - x) * (1 - d(x)) / 2. The area below the line forms a circle slice with angle
alpha, where alpha = arcsin(1 - x). The area of this slice is therefore:

(alpha / (2 * pi)) * pi = alpha / 2

Therefore, substracting the right triangle and the slice from the total area we get:

A2 = (1 - x) - (1 - x) * (1 - d(x)) / 2 - alpha / 2

The area of the concave triangle A3 can be calculated by noticing that the one
quarter of the circle, which measures pi/4 in area, is contained in a 1x1 square.
Therefore A3 = 1 - pi/4.

Therefore the proportion can be calculated as (A1 + A2) / A3.
=#

using Printf

function p(n)
    x = (1.0 + 1.0 / n - sqrt(2.0 / n)) / (1.0 / n^2 + 1.0)
    dx = x / n
    a1 = x * dx / 2.0
    a2 = (1.0 - x) - (1.0 - x) * (1.0 - dx) / 2.0 - asin(1.0 - x) / 2.0
    a3 = 1 - pi / 4.0
    return (a1 + a2) / a3
end

start = time()
result = 1

while p(result) >= 0.001
    global result
    result += 1
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

