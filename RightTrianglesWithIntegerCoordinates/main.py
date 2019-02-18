"""
Consider any line segment between two points in the grid. To generate a right
triangle from this line segment one has to rotate the line segment 90 degrees in
any direction. Notice that if both points in the line segment were integer coordinates
then the rotated line segment will fall in a point with integer coordinated too.
To see this notice that if the end of the line segment that is rotated has
coordinates (x, y) with respect to the pivot, then after the rotation that point
will have coordinates either (-y, x) or (y, -x) (or (-x, -y) for 180 degrees rotation).

To find the number of solutions we divide the search space in two cases:
1. The right angle is at an axis

Pick a value on the x-axis and another on the y-axis. There are 50^2 possible
choices. The point where these values intersect allows us to define a rectangle.
There are 3 ways to pick points from this rectangle such that the origin is picked.
There are therefore 3 * 50^2 possible right triangles for this case.

1. The right angle is not at an axis

We use the previous fact and calculate how long can a rotation of a reduced line
segment (i.e. with coprime coordinates) from the origin to a given point can be.


"""

import math

result = 50 * 50 * 3
for xd in range(1, 50 + 1):
    for yd in range(1, 50 + 1):
        d = math.gcd(xd, yd)
        xf = xd // d
        yf = yd // d
        result += min([xd // yf, (50 - yd) // xf])
        result += min([(50 - xd) // yf, yd // xf])

print(result)
