"""
If we calculate the angle that the line that joins the origin with a vertex makes,
with respect to one of the sides of that vertex of the triangle it should be less
than the angle the other side of that vertex has.

To calculate the angle we use cos x = u . v / (norm(u) * norm(v)). This excludes
all points outside the triangle and the complementary triangle formed by extending
both sides along the vertex. Notice that a point cannot be outside the triangle
and inside all three of the complementary triangles, therefore we can use this
to test for the number of triangles that contain the origin.
"""

import math

triangles = open('triangles.txt', 'r').readlines()

def norm (vector):
    return math.sqrt(math.pow(vector[0], 2) + math.pow(vector[1], 2))

def dot (v1, v2):
    return v1[0] * v2[0] + v1[1] * v2[1]

def diff (v1, v2):
    return (v1[0] - v2[0], v1[1] - v2[1])

def angle (v1, v2):
    return math.acos( dot(v1, v2) / (norm(v1) * norm(v2)))

def contains_origin (coords):
    for idx in range(0, 3):
        vertex = (coords[2 * idx], coords[2 * idx + 1])
        first_idx = (idx + 1) % 3
        first = (coords[2 * first_idx], coords[2 * first_idx + 1])
        second_idx = (idx + 2) % 3
        second = (coords[2 * second_idx], coords[2 * second_idx + 1])
        first_side = diff(first, vertex)
        second_side = diff(second, vertex)
        origin_side = diff((0, 0), vertex)
        reference_angle = angle(first_side, second_side)
        comparison_angle = angle(first_side, origin_side)
        if comparison_angle > reference_angle:
            return False
    return True

result = 0
for line in triangles:
    coords = [float(n) for n in line.strip().split(',')]
    if contains_origin(coords):
        result += 1
print(result)
