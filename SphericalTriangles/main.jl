#=
Approach:
First exhaustively generate all possible solutions to x^2 + y^2 + z^2 = r^2, for
r = 1, 2, ... , 50. Next use Girard's theorem to calculate the area of each triplet
of solutions for a same radius.

Definition (Angle Excess)
Let u, v, w be the angles of a triangle on a spherical surface. Then the angle
excess E is:

E = u + v + w - pi

Definition (Great Circle)
A great cicle is a circle over the sphere such that the center of such circle
is the center of the sphere.

Definition (Lune)
A lune is the section of the surface of a sphere formed by the intersection of two
great circles.

Corollary
Notice that two great circles intersect at only two points. Therefore
a lune ends on two vertices.

Corollary
Both vertex of a lune have the same angle.

Theorem (Area of Lune)
Let A be the area of a lune with angle a. Then:

A = 2 * r^2 * a

Proof:
Rotate the sphere containing the lune so that one side of the lune is straight up.
Then notice that the area of the lune is a portion of the area of the sphere
proportional to the angle between both sides of a given lune. Therefore

A = 4 * pi * r^2 * a / (2 * pi)
  = 2 * r^2 * a

Theorem (Girard's Theorem)
Let A be the area of a triangle, r its radius and E its angle excess. Then:

A = r^2 * E

Proof:
Consider a triangle T on a sphere S of radius r. Let u, v, w be the angles of
triangle T. Let U, V, and W be their corresponding vertices. Because not all
three of the vertices lie on the same great circle, T lies on three different lunes,
each corresponding to each vertex of T. Let these lunes be LU, LV, and LW. Notice
that the three great circles that form T also form another triangle T', which
must have the same area as T and which is not adjacent to T. Let LU', LV', and LT'
be the lunes containing T'. Finally notice that the lunes of T and the lunes of T'
don't overlap, otherwise T and T' would be adjacent, or a same lune would have to
be divided more than once by the great circles we are considering, implying that
there is more than one great circle. Finally notice that the three great circles
split the surface of S into 8 parts. These are exactly the 6 lunes (without T and T')
and the two triangles T and T'. Therefore the 6 lunes cover the whole are of the
sphere. Therefore:

area(LU) + area(LV) + area(LW) + area(LU') + area(LV') + area(LW')
= area(S) + 2 * area(T) + 2 * area(T')

as the only area that appears more than once among the lunes are the area of the
triangles, which appear three times each (and therefore appear in excess of two
times). Notice that there must also exist symmetry among the lunes, and therefore
area(LU) = area(LU'), area(LV) = area(LV'), and area(LW) = area(LW'), because
triangle T' is congruent to T by a rotation of S. Because area(T) = area(T'), then:

2 * area(LU) + 2 * area(LV) + 2 * area(LW) = area(S) + 4 * area(T)
area(T) = 1/2 * area(LU) + 1/2 * area(LV) + 1/2 * area(LW) - area(S) / 4
area(T) = r^2 * u + r^2 * v + r^2 * w - pi * r^2
area(T) = r^2 * (u + v + w - pi)
area(T) = r^2 * E

First we need to determine whether three points lie on the same great circle. By
definition this is equivalent to determining whether the plane formed by two points
and the center of the circle contains the remaining point. Suppose the points are
U and V. Then U x V gives us a normal to the plane. Therefore, point W is in the
same great circle if (U x V) . W = 0.

Now notice that the distance between two points on the sphere is propertional to
the perimeter of the great circle, with respect to the angle between the two points.
If NU = U / || U ||, and NV = V / || V ||, then the angle between them is acos(NU . NV)
and therefore the distance between them is angle * r.

Assume, for now that r = 1. Therefore the distance between any two points is exactly
the angle they make with respect to the origin of the sphere. Consider the triangle
T. We already know the angle of each side. We want to know the angle of each vertex.
It can be calculated using the cosine rule.

Identity (Quadruple Product)
(a x b) . (c x d) = (a . c) * (b . d) - (a . d) * (b . c)
Proof:
We are going to use the following identities:
    1. a . (b x c) = c . (a x b)
    2. (a x (b x c)) = (a . c) * b - (a . b) * c

Let u = c x d. Then:

(a x b) . (c x d) = (a x b) . u
                  = u . (a x b)
                  = u . (a x b)
                  = b . (u x a)
                  = b . ((c x d) x a)
                  = - b . (a x (c x d))
                  = -b . ((a . d) * c - (a . c) * d)
                  = -((a . d) * (b . c) - (a . c) * (b . d))
                  = (a . c) * (b . d) - (a . d) * (b . c)

Theorem (Cosine Rule for Spherical Triangles)
Assume a, b, c are the angles of the sides of triangle T, and A, B, C the angles
of its vertex, where A is opposite to a, B is opposite to b and C is opposite to c.
Then:

cos(a) = cos(b) * cos(c) + sin(b) * sin(c) * cos(A)
cos(b) = cos(c) * cos(a) + sin(c) * sin(a) * cos(B)
cos(c) = cos(a) * cos(b) + sin(a) * sin(b) * cos(C)

Proof:
Notice that equations 2 and 3 arise from equation 1 and a relabeling of the vertex
and the sides. Therefore let's prove equation 1. Let u, v and w be the unit vectors
from the origin to vertex A, B, and C. Therefore u . u = 1, v . w = cos(a),
u . v = cos(c), u . w = cos(b). Also |u x v| = sin(c), |u x w| = sin(b). Then:

(u x v) . (u x w) = sin(c) * sin(b) * cos(A)

But by the previous identity:

(u x v) . (u x w) = (u . u) * (v . w) - (u . v) * (u . w)
                  = 1 * cos(a) - cos(c) * cos(b)
                  = cos(a) - cos(c) * cos(b)

Thus:

sin(c) * sin(b) * cos(A) = cos(a) - cos(c) * cos(b)
cos(a) = cos(b) * cos(c) + sin(b) * sin(c) * cos(A)

From the previous theorem, for a triangle T with side angles u, v, w and vertex
angles U, V, W. The angle of vertex U is:

cos(u) = cos(v) * cos(w) + sin(v) * sin(w) * cos(U)
cos(U) = (cos(u) - cos(v) * cos(w)) / (sin(v) * sin(w))

Notice that cos(u) = NV . NW, cos(v) = NU . NW, cos(w) = NU . NV. Finally,
sin(v) = sin(acos(cos(v))) = sin(acos(NU . NW)) = sqrt(1 - (NU . NW)^2).
Similarly, sin(w) = sqrt(1 - (NU . NV)^2). Therefore:

U = acos( (NV . NW - (NU . NW) * (NU . NV)) / (sqrt(1 - (NU . NW)^2) * sqrt(1 - (NU . NV)^2)) )

Relabeling of the vertex and sides give us the equations for V and W.

Final optimization: as a triangle must lie in only one of the faces of the
sphere, we can always rotate the points around so that their first coordinate
takes only positive values.

=#

using LinearAlgebra
using Printf

start = time()
result = 0

r_vals = collect(1:50).^2
max_r = maximum(r_vals)
vertex = [[] for _ in 1:50]
min_area = [4 * pi * r^2 for r in 1:50]

for x in 0:50
    curr_x = x^2
    for y in 0:50
        curr_y = curr_x + y^2
        if curr_y > max_r
            continue
        end
        for z in 0:50
            curr_z = curr_y + z^2
            if curr_z > max_r
                continue
            end
            r = findfirst(item -> item === curr_z, r_vals)
            if isnothing(r)
                continue
            end
            push!(vertex[r], [ x, -y, -z])
            push!(vertex[r], [ x, -y,  z])
            push!(vertex[r], [ x,  y, -z])
            push!(vertex[r], [ x,  y,  z])
        end
    end
end

products = Dict()
for r in 1:50
    for ux in 1:(length(vertex[r]) - 1)
        for vx in (ux + 1):length(vertex[r])
            u = vertex[r][ux]
            v = vertex[r][vx]
            p = dot(u, v) / (norm(u) * norm(v))
            products[r, ux, vx] = p
        end
    end
end

for r in 1:50
    println(r)
    for ux in 1:(length(vertex[r]) - 2)
        for vx in (ux + 1):(length(vertex[r]) - 1)
            for wx in (vx + 1):length(vertex[r])
                u = vertex[r][ux]
                v = vertex[r][vx]
                w = vertex[r][wx]
                if iszero(dot(cross(u, v), w))
                    continue
                end
                nuv = products[r, ux, vx]
                nuw = products[r, ux, wx]
                nvw = products[r, vx, wx]
                au = (nvw - nuw * nuv) / sqrt((1 - nuw^2) * (1 - nuv^2))
                au = acos(max(-1, min(1, au)))
                av = (nuw - nuv * nvw) / sqrt((1 - nuv^2) * (1 - nvw^2))
                av = acos(max(-1, min(1, av)))
                aw = (nuv - nuw * nvw) / sqrt((1 - nuw^2) * (1 - nvw^2))
                aw = acos(max(-1, min(1, aw)))
                area = r^2 * (au + av + aw - pi)
                if min_area[r] > area
                    min_area[r] = area
                end
            end
        end
    end
end


result = sum(min_area)

@printf("%.6f\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
