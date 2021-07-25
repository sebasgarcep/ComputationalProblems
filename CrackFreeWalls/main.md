# Crack Free Walls

<p>Consider the problem of building a wall out of 2×1 and 3×1 bricks (horizontal×vertical dimensions) such that, for extra strength, the gaps between horizontally-adjacent bricks never line up in consecutive layers, i.e. never form a "running crack".</p>

<p>For example, the following 9×3 wall is not acceptable due to the running crack shown in red:</p>

<p>There are eight ways of forming a crack-free 9×3 wall, written W(9,3) = 8.</p>

<p>Calculate W(32,10).</p>

## Solution

If the wall has height $1$, then the number of solutions is the number of ways to arrange the bricks so that they add up to the width $h$. To obtain these arrangements partition $h$ into $s$ $2
\times 1$ and $t$ $3 \times 1$ bricks. Then of the $s + t$ positions that these bricks can go, choose $s$ for the $2 \times 1$ bricks.

If the wall has arbitrary height $v$, then not all arrangements can go next to each other. Build a graph $G$ where each node is a brick arrangement and each edge tells us if two arrangements can go in consecutive layers. Then we want to find how many paths of length $v$ exist starting at any node and ending at any node. Suppose $A$ is the adjacency matrix of $G$. Then:

$$
W(h, v) = A^{v-1} \mathbb{1}
$$

where $\mathbb{1}$ is a vector of ones.

We can speed up the computation by exploiting the fact that $A$ is a sparse matrix.