# Ascending subsequences

Let $a_i$ be the sequence defined by $a_i=153^i \bmod 10\,000\,019$ for $i \ge 1$.<br />
The first terms of $a_i$ are:
$153, 23409, 3581577, 7980255, 976697, 9434375, \dots$

Consider the subsequences consisting of 4 terms in ascending order. For the part of the sequence shown above, these are:<br />
$153, 23409, 3581577, 7980255$<br />
$153, 23409, 3581577, 9434375$<br />
$153, 23409, 7980255, 9434375$<br />
$153, 23409, 976697, 9434375$<br />
$153, 3581577, 7980255, 9434375$ and<br />
$23409, 3581577, 7980255, 9434375$.

Define $S(n)$ to be the sum of the terms for all such subsequences within the first $n$ terms of $a_i$. Thus $S(6)=94513710$.<br />
You are given that $S(100)=4465488724217$.

Find $S(10^6)$ modulo $1\,000\,000\,007$.

## Solution

We are going to assume that the sequence $(a_i)_{i=1}^n$ has no repeated elements. Let $C(n, k, j)$ be the number of ascending subsequences of length $k$ that end on $a_j$ and let $S(n, k, j)$ be the sum of the elements of the ascending subsequences of length $k$ that end on $a_j$. Then it is clear that

$$
S(n) = \sum_{j=1}^n S(n, 4, j)
$$

Furthermore

$$
C(n, 1, j) = 1 \\
C(n, k, j) = \sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} C(n, k-1, i) \\
S(n, 1, j) = a_j \\
\begin{align*}
S(n, k, j)
&= \sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} \left( a_j \cdot C(n, k-1, i) + S(n, k - 1, i) \right) \\
&= a_j \sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} C(n, k-1, i) + \sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} S(n, k - 1, i) \\
&= a_j \cdot C(n, k, j) + \sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} S(n, k - 1, i) \\
\end{align*}
$$

Both $S$ and $C$ can be calculated using dynamic programming. Finally, the sums of the type

$$
\sum_{\substack{1 \le i \le j-1 \\ a_i \lt a_j}} C(n, k-1, i)
$$

can be computed using a binary tree. To see how, suppose we want to calculate sums of this type for a given $j$. Reindex $(a_i)_{i=1}^{j-1}$ such that $(a_i)_{i=0}^j$ is strictly ascending and $a_0 = -\infty, a_j = \infty$. Let $T_j$ be a binary tree that uses the sequence $(a_i)_{i=1}^{j-1}$ as branching values and that satisfies that for any node in $T_j$, if the range of the node is $(a_s, a_t)$, then the value of the node is

$$
\sum_{i = s + 1}^t C(n, k-1, i)
$$

where the range of a node indicates the range of values that can possibly reach this node during a binary search. Then it is not hard to build an algorithm that calculates the sum in question using $T_j$. Furthermore, $T_{j+1}$ can be built from $T_j$ by updating the nodes such that $a_j$ is in the node's range, and adding a new pair of nodes for the branching at $a_j$.

This is similar to the idea of Fenwick trees.