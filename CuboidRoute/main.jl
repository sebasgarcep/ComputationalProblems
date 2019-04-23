#=
Approach:
Let the side lengths of the prism be x, y and z. Notice that any path must go
through two faces. Let p be the point where the path intersects the edge e between
the two faces. Let the side length of this edge be x. Let t be the distance from
the vertex, adjacent to e and that shares an edge with S, to p, and let y be the
other side length of the first face traversed by the spider. Finally, let z be the
remaining side length. From the previous construction the distance of the path is:

d = sqrt(t^2 + y^2) + sqrt((x - t)^2 + z^2)

To find the value of t that minimizes d, we need to calculate the derivative of d
with respect to t and find its roots:

d' = (2 * t) / sqrt(t^2 + y^2) - (2 * (x - t)) / sqrt((x - t)^2 + z^2)
   = 2 * (sqrt((x - t)^2 * t^2 + z^2 * t^2) - sqrt((x - t)^2 * t^2 + y^2 * (x - t)^2))
   / (sqrt(t^2 + y^2) * sqrt((x - t)^2 + z^2))
   = 2 * ((x - t)^2 * t^2 + z^2 * t^2 - (x - t)^2 * t^2 - y^2 * (x - t)^2)
   / (sqrt(t^2 + y^2) * sqrt((x - t)^2 + z^2) * (sqrt((x - t)^2 * t^2 + z^2 * t^2) + sqrt((x - t)^2 * t^2 + y^2 * (x - t)^2)))
   = 2 * (z^2 * t^2 - y^2 * (x - t)^2)
   / (sqrt(t^2 + y^2) * sqrt((x - t)^2 + z^2) * (sqrt((x - t)^2 * t^2 + z^2 * t^2) + sqrt((x - t)^2 * t^2 + y^2 * (x - t)^2)))
   = 0

Therefore:

z^2 * t^2 - y^2 * (x - t)^2 = 0
z^2 * t^2 = y^2 * (x - t)^2
z * t = y * (x - t)
t = x * y / (y + z)

Substituting t in d:

d = sqrt((x * y / (y + z))^2 + y^2) + sqrt((x - (x * y / (y + z)))^2 + z^2)
  = sqrt(x^2 * y^2 / (y + z)^2 + y^2) + sqrt(x^2 * (1 - (y / (y + z)))^2 + z^2)
  = sqrt(x^2 * y^2 / (y + z)^2 + y^2) + sqrt(x^2 * ((y + z - y) / (y + z))^2 + z^2)
  = sqrt(x^2 * y^2 / (y + z)^2 + y^2) + sqrt(x^2 * (z / (y + z))^2 + z^2)
  = sqrt(x^2 * y^2 / (y + z)^2 + y^2) + sqrt(x^2 * z^2 / (y + z)^2 + z^2)
  = y * sqrt(x^2 / (y + z)^2 + 1) + z * sqrt(x^2 / (y + z)^2 + 1)
  = (y + z) * sqrt(x^2 / (y + z)^2 + 1)
  = (y + z) * sqrt((x^2 + (y + z)^2) / (y + z)^2)
  = (y + z) * sqrt(x^2 + (y + z)^2) / (y + z)
  = sqrt(x^2 + (y + z)^2)
  = sqrt(x^2 + y^2 + z^2 + 2 * y * z)

Clearly, x must be the largest of the three side lengths in order to minimize d.
Therefore the problem reduces to determining whether x^2 + (y + z)^2 is a square
number, with x >= y >= z.

Let r = y + z. Then we need to find all values of r for which x^2 + r^2 is a perfect
square. Clearly, z <= y which implies z <= r - z or z <= r / 2. Also r - z <= x.
Therefore r - x <= z <= r / s. Therefore z takes floor(r / 2) - max(0, r - x - 1)
different values.

Finally use bisection search to find the appropiate value for m.

=#

using Printf

function cuboid_routes(m)
    result = 0
    squares = Set([i^2 for i in 1:isqrt(5 * m^2)])
    for x in 1:m
        for r in 1:(2 * x)
            d_sq = x^2 + r^2
            if in(d_sq, squares)
                result += fld(r, 2) - max(0, r - x - 1)
            end
        end
    end
    return result
end

start = time()
desired = 10^6 + 1

lower = 1000
upper = 2000
while upper - lower > 1
    global upper, lower
    test = fld(lower + upper, 2)
    val = cuboid_routes(test)
    if val == desired
        lower = test
        upper = test
        break
    elseif val < desired
        lower = test
    else
        upper = test
    end
end

result = upper
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
