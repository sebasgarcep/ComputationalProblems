#=
Approach:
Notice that the polygon can be split into four square triangles. We can therefore
calculate the number of internal lattice points by adding up the number of internal
lattice points of each square triangle, and subtracting the four side lengths (as
they appear twice, once for each of the triangles it belongs to). Finally, because
we are subtracing all of the sides, we are completely subtracting the center point.
We therefore have to add the center point again. An algorithm to solve this problem
uses the previous facts to memoize some of the work. Finally the algorithm is:

1. Precalculate the number of internal lattice points for every possible triangle.
2. Precalculate all possible squares values we may obtain. Because m = 100, all
polygons can be enclosed in a 200x200 square. Therefore we will never have more
than 200^2 lattice points.
3. Use the equation described above to calculate the number of internal lattice
points for each of the possible 100^4 arrangements. Use the set of squared numbers
to determine whether the result is a square number.

=#

using Printf

function internal(s, t)
    total = 0
    for k in 0:(s - 1)
        total += cld(t * (s - k), s)
    end
    return total
end

start = time()
result = 0

m = 100

triangles = zeros(m, m)
for s in 1:m
    for t in 1:m
        triangles[s, t] = internal(s, t)
    end
end

squares = Set([i^2 for i in 0:200])

for a in 1:m
    for b in 1:m
        for c in 1:m
            for d in 1:m
                global result
                total = triangles[a, b] +
                    triangles[b, c] +
                    triangles[c, d] +
                    triangles[d, a] +
                    - (a + b + c + d) + 1
                if in(total, squares)
                    result += 1
                end
            end
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
