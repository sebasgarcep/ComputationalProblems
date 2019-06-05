#=
Approach:
Notice that for an n-sided triangle, the largest hexagon that can fit into it
is n/3 levels deep. Therefore for each level of depth k we want to count how many
hexagons can fit into a given triangle. Notice that this is equivalent to counting
the number of lattice points in the triangle that are at least k levels removed
from the outer layer of the triangle. Notice also that any given hexagon can be
rotated up to k times. This is because we can draw lines that instead of going
through the lines connecting the adjacent lattice points we can draw lines that
go through the open space to another point that is k triangles removed. The
following algorithm follows from properly implementing this approach.
=#

using Printf

function h(n)
    total = 0
    outer = 0
    for k in 1:fld(n, 3)
        outer += 3 * (n - 3 * (k - 1))
        total += k * (fld((n + 1) * (n + 2), 2) - outer)
    end
    return total
end

start = time()
result = 0

for n in 3:12345
    global result
    result += h(n)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
