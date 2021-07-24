# Hexagonal Tile Differences

<p>A hexagonal tile with number 1 is surrounded by a ring of six hexagonal tiles, starting at "12 o'clock" and numbering the tiles 2 to 7 in an anti-clockwise direction.</p>
<p>New rings are added in the same fashion, with the next rings being numbered 8 to 19, 20 to 37, 38 to 61, and so on. The diagram below shows the first three rings.</p>

<p>By finding the difference between tile <i>n</i> and each of its six neighbours we shall define PD(<i>n</i>) to be the number of those differences which are prime.</p>
<p>For example, working clockwise around tile 8 the differences are 12, 29, 11, 6, 1, and 13. So PD(8) = 3.</p>
<p>In the same way, the differences around tile 17 are 1, 17, 16, 1, 11, and 10, hence PD(17) = 2.</p>
<p>It can be shown that the maximum value of PD(<i>n</i>) is 3.</p>
<p>If all of the tiles for which PD(<i>n</i>) = 3 are listed in ascending order to form a sequence, the 10th tile would be 271.</p>
<p>Find the 2000th tile in this sequence.</p>

## Solution

Let $l_r$ be the number of hexagons in the $r$-th ring. Then it is clear that $l_1 = 1, l_2 = 6$. From there on each new ring is constructed by slotting a hexagon between each pair of hexagons in the underlaying ring, and adding an extra hexagon for each of the corner hexagons. Therefore $l_r = 6 + l_{r-1}, r \geq 3$. From this we can trivially conclude that $l_r = 6(r-1), r \geq 2$.

Similarly, we can define functions $d_r, u_r$, where $d_r$ is the lowest number in a ring, and $u_r$ is the largest one. Then:

$$
d_r = l_{r-1} + d_{r-1} \\
u_r = l_r + u_{r-1}
$$

And using the fact that $d_2 = 2, u_2 = 7$ we get:

$$
d_r = 2 + 6 T_{r-2}, r \geq 2 \\
u_r = 1 + 6 T_{r-1}, r \geq 2
$$

where $T_r$ is the $r$-th triangular number and with $T_0 = 0$.

Now let's explore the following cases:

### Special case: $r = 1, 2$

Manual calculation shows that:

$$
PD(1) = 3 \\
PD(2) = 3 \\
PD(3) = 2 \\
PD(4) = 2 \\
PD(5) = 0 \\
PD(6) = 2 \\
PD(7) = 2 \\
$$

From this point forward we will only consider $r \geq 3$.

### Special case: $n = d_r$

The differences for this case are:

$$
\begin{align*}
|d_{r+1} - d_r| &= 6 (r - 1) \\
|d_{r+1} + 1 - d_r| &= 6 (r - 1) + 1 \\
|d_r + 1 - d_r| &= 1 \\
|d_{r-1} - d_r| &= 6 (r - 2) \\
|u_r - d_r| &= 6 (r - 1) - 1 \\
|u_{r+1} - d_r| &= 6 (2r - 1) - 1 \\
\end{align*}
$$

So we have to test that the following are all prime for $PD(n) = 3$:

$$
6 (r - 1) + 1, 6 (r - 1) - 1, 6 (2r - 1) - 1
$$

### Special case: $n = u_r$

The differences for this case are:

$$
\begin{align*}
|u_{r+1} - u_r| &= 6r \\
|d_r - u_r| &= 6 (r - 1) - 1 \\
|d_{r-1} - u_r| &= 6 (2r - 3) - 1 \\
|u_{r-1} - u_r| &= 6(r - 1) \\
|u_r - 1 - u_r| &= 1 \\
|u_{r+1} - 1 - u_r| &= 6r - 1 \\
\end{align*}
$$

So we have to test that the following are all prime for $PD(n) = 3$:

$$
6 (r - 1) - 1, 6 (2r - 3) - 1, 6r - 1
$$

### Corner Hexagon

It is clear that a corner hexagon must satisfy that $n - d_r \equiv 0 \: (\text{mod } r - 1)$. The $k$-th corner hexagon in a ring is a neighbour to the $k$-th corner hexagon of the previous and following rings. It is easy to see that we can generate the $k$-th corner hexagon of the $r$-th ring using the formula $n = d_r + k (r - 1)$. Then the differences for this case are:

$$
\begin{align*}
|n + 1 - n| &= 1 \\
|n - 1 - n| &= 1 \\
|d_{r-1} + k (r - 2) - n| &= n - d_{r-1} - k (r - 2) \\
|d_{r+1} + k r - n| &= d_{r+1} + k r - n \\
|d_{r+1} + k r + 1 - n| &= d_{r+1} + k r + 1 - n \\
|d_{r+1} + k r - 1 - n| &= d_{r+1} + k r - 1 - n \\
\end{align*}
$$

where $k = (n - d_r) / (r - 1)$. Notice that if $d_{r+1} + k r - n$ is prime, then it is odd, and $d_{r+1} + k r + 1 - n$, $d_{r+1} + k r - 1 - n$ are even, which will force $PD(n) < 3$. So we have to test that the following are all prime for $PD(n) = 3$:

$$
n - d_{r-1} - k (r - 2), d_{r+1} + k r + 1 - n, d_{r+1} + k r - 1 - n
$$

Let's express these differences in terms of $k = 1, 2, 3, 4, 5$ and $r$:

$$
n - d_{r-1} - k (r - 2) = d_r + k (r - 1) - d_{r-1} - k (r - 2) = 6 (r - 2) + k \\
d_{r+1} + k r + 1 - n = d_{r+1} + k r + 1 - d_r - k (r - 1) = 6 (r - 1) + k + 1 \\
d_{r+1} + k r - 1 - n = d_{r+1} + k r - 1 - d_r - k (r - 1) = 6 (r - 1) + k - 1 \\
$$

Notice that if $k = 2, 3, 4$ then the first difference is not a prime. If $k = 1, 5$ then the other two differences are even, and thus not prime. Therefore there are no corner hexagons outside of the special case $n = d_r$ for which $PD(n) = 3$.

### Edge Hexagon

The 6 neighbours of an edge hexagon $n$ are:

- $n - 1$, $n + 1$
- Two sequential hexagons in the previous ring
- Two sequential hexagons in the following ring

Notice that the difference with either of $n - 1$ and $n + 1$ is $1$, which is not prime. Notice also that the difference between neighbouring hexagons in different, consecutive rings will be more than $2$, and therefore the difference has to be odd for it to be prime. But of the two differences with the sequential hexagons in an adjacent ring, only one of those can be odd. Because we have differences with two pairs of sequential hexagons, only one difference can be odd for each pair, and thus $PD(n) \leq 2$.

### Algorithm

Manually set $n = 1$ as the first tile in the sequence and $n = 2$ as the second tile in the sequence. Then we only need to check the $n = d_r, u_r$ for each ring $r \geq 3$ until we find the $2000$-th element of the sequence. Primality is tested using a naive primality testing algorithm.