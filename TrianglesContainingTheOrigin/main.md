# Triangles containing the origin

Consider the set <var>I<sub>r</sub></var> of points (<var>x</var>,<var>y</var>) with integer co-ordinates in the interior of the circle with radius <var>r</var>, centered at the origin, i.e. <var>x</var><sup>2</sup> + <var>y</var><sup>2</sup> &lt; <var>r</var><sup>2</sup>.
For a radius of 2, <var>I</var><sub>2</sub> contains the nine points (0,0), (1,0), (1,1), (0,1), (-1,1), (-1,0), (-1,-1), (0,-1) and (1,-1). There are eight triangles having all three vertices in <var>I</var><sub>2</sub> which contain the origin in the interior. Two of them are shown below, the others are obtained from these by rotation.
<p class="center"><img src="https://projecteuler.net/project/images/p184.gif" class="dark_img" alt="" />

For a radius of 3, there are 360 triangles containing the origin in the interior and having all vertices in <var>I</var><sub>3</sub> and for <var>I</var><sub>5</sub> the number is 10600.

How many triangles are there containing the origin in the interior and having all three vertices in <var>I</var><sub>105</sub>?

## Solution

Suppose the origin is the point $O$. Take any two pair of points inside the circle $P_1, P_2$. Then the lines defined by the line segments $P_1 O, P_2 O$ splits the circle into four. Take the circle slice whose border does not contain either of $P_1, P_2$ (i.e. the one opposite to both points). Clearly any point $P_3$ inside this slice will define a triangle $P_1 P_2 P_3$ which contains the origin. Also notice that all points collinear with $P_1 O$ or $P_2 O$ will produce the same lines and all points with an angle inside the circle slice defined by these two lines will form a triangle containing the origin. Thus we can identify all points $(x, y)$ with $(x/g, y/g)$ where $g = gcd(x, y)$. We can operate over each pair of these points and calculate how many of these representative lie inside the circle slice. Then we can multiply the number of points represented by $P_1$ times the number of points represented by $P_2$ times the total number of points represented by the representatives that fall inside the circle slice. Finally notice that each triangle will be counted thrice, once for each pair of points in the triangle. Thus we need to divide the final result by $3$.

A few notes for the implementation of the algorithm:

- $(x_i, yi), (x_j, y_j)$ are colinear with $O$ if and only if $\frac{y_i - 0}{x_i - 0} = \frac{y_j - 0}{x_j - 0} \iff x_j y_i = x_i y_j$.
- If $P_1 = (x_1, y_1), P_2 = (x_2, y_2)$ then the circle slice is defined by the angles of the points $(-x_1, -y_1), (-x_2, -y_2)$.
- Suppose the angles defined the lines projected from $P_1, P_2$ are $\alpha, \beta$ with $\alpha < \beta$. If $|\beta - \alpha| < \pi$ then the angles we need to count are the ones in the interval $(\alpha, \beta)$. Otherwise the angles we need to count are the ones outside the interval $[\alpha, \beta]$. The latter case can be done by subtracting from the count of all points the number of point in this interval.
- Finally, we can memoize the count of all points between each pair of representatives to reduce the number of operations we need to do when iterating over all pair of representatives.