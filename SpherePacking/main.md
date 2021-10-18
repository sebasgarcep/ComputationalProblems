# Sphere Packing

<p>What is the length of the shortest pipe, of internal radius 50mm, that can fully contain 21 balls of radii 30mm, 31mm, ..., 50mm?</p>

<p>Give your answer in micrometres (10<sup>-6</sup> m) rounded to the nearest integer.</p>

## Solution

Notice that no two balls can be placed on top of each other inside the pipe. Therefore the balls will go in particular sequential order inside the pipe. The most efficient way to pack the balls is to rest consecutive balls on opposite sides of the pipe. This way the horizontal distance between ball centers is minimized. If two consecutive balls have radius $r_i, r_j$ then, because the balls will be tangent to each other, the distance between the centers is $r_i + r_j$. The vertical distance is $100 - r_i - r_j$. Therefore the horizontal distance is $\sqrt{(r_i + r_j)^2 - (100 - r_i - r_j)^2}$. Thus if the balls (in order) have radius $r_1, \dots, r_n$. Then the minimal length of the pipe must be

$$
r_1 + r_n + \sum_{i = 1}^{n - 1} \sqrt{(r_i + r_{i + 1})^2 - (100 - r_i - r_{i + 1})^2}
$$

Thus we just need to find the order that minimizes this quantity. Notice that the square root term can be shown to  equal

$$
10 \sqrt{2 (r_i + r_{i + 1}) - 100}
$$

Because this function is clearly concave with respect to $r_i + r_{i + 1}$ a greedy approach is very likely to produce an optimal solution. The greedy approach will try to minimize $r_i + r_{i + 1}$, thus it will first pair $30$ with $31$, then $30$ with $32$. Then $33$ with the smallest element on either side, in this case $31$, and so forth. The greedy approach will therefore return the order

$$
50,48,46,44,42,40,38,36,34,32,30,31,33,35,37,39,41,43,45,47,49
$$