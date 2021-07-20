# Counting Binary Matrices

A binary matrix is a matrix consisting entirely of 0s and 1s. Consider the following transformations that can be performed on a binary matrix:

<ul>
<li>Swap any two rows</li>
<li>Swap any two columns</li>
<li>Flip all elements in a single row (1s become 0s, 0s become 1s)</li>
<li>Flip all elements in a single column</li>
</ul>

Two binary matrices $A$ and $B$ will be considered <i>equivalent</i> if there is a sequence of such transformations that when applied to $A$ yields $B$. For example, the following two matrices are equivalent:

$$
A=\begin{pmatrix} 
  1 & 0 & 1 \\ 
  0 & 0 & 1 \\
  0 & 0 & 0 \\
\end{pmatrix} \quad B=\begin{pmatrix} 
  0 & 0 & 0 \\ 
  1 & 0 & 0 \\
  0 & 0 & 1 \\
\end{pmatrix}
$$

via the sequence of two transformations "Flip all elements in column 3" followed by "Swap rows 1 and 2".

Define $c(n)$ to be the maximum number of $n\times n$ binary matrices that can be found such that no two are equivalent. For example, $c(3)=3$. You are also given that $c(5)=39$ and $c(8)=656108$.

Find $c(20)$, and give your answer modulo $1\,001\,001\,011$.

## Solution

### Lagrange's Theorem

Let $H$ be a subgroup of a group $G$. Then $|G / H| = |G| / |H|$.

#### Proof

Choose $g \in G$. Notice that $h \in H \rightarrow g \cdot h$ is a bijection, as $g$ is invertible. Therefore $|H| = |g \cdot H|$. Now we need to prove that two left cosets are either equal, or share no common elements. Take two left cosets $g_1 \cdot H, g_2 \cdot H$. If these left cosets are mutually exclusive we are done. Otherwise assume there is an element $g_3 \in g_1 \cdot H \cap g_2 \cdot H$. Then there are $h_1, h_2 \in H$ such that $g_3 = g_1 \cdot h_1 = g_2 \cdot h_2$. Therefore $g_1 = g_2 \cdot h_2 \cdot h_1^{-1}$. Thus

$$
g_1 \cdot H = g_2 \cdot h_2 \cdot h_1^{-1} \cdot H = g_2 \cdot H
$$

which proves the statement. Thus $G$ can be rewritten as $G = H \cup g_1 \cdot H \cup g_2 \cdot H \cup \dots$. Where each left coset in the expression are mutually exclusive. Thus

$$
\begin{align*}
|G| &= |H| + |g_1 \cdot H| + |g_2 \cdot H| + \dots \\
&= |H| + |H| + |H| + \dots \\
&= |H| \cdot (\text{the number of distinct left cosets}) \\
&= |H| \cdot |G / H|
\end{align*}
$$

And rearranging terms concludes our proof.

### Orbit-Stabilizer Theorem

Let $G$ be a finite group acting on a set $X$. For $x \in X$, let $G_x = \{ g \in G : g \cdot x = x \}$ be the stabilizer of $x$. Suppose the orbit of $x$ is $O_x = \{ g \cdot x : g \in G \}$. Then:

$$
|O_x| |G_x| = |G|
$$

#### Proof

Consider a map $f : G / G_x \rightarrow X$ given by $h \cdot G_x \rightarrow h \cdot x$. First, let's prove $f$ is well-defined. Suppose $h' \in h \cdot G_x$. Then there is $g \in G_x$ such that $h' = h \cdot g$. Thus $h' \cdot x = (h \cdot g) \cdot x$. But $g \cdot x = x$. Therefore $h' \cdot x = h \cdot x$. Clearly $\text{Im}(f) \subseteq O_x$ Therefore we need to prove that $O_x \subseteq \text{Im}(f)$ to show that $f$ is a bijection, as $G / G_x$ is finite. Suppose $y \in O_x$. Then there is $g \in G$ such that $g \cdot x = y$. But clearly $f$ maps $g \cdot G_x$ to $g \cdot x = y$. Therefore $y \in \text{Im}(f)$. Thus $O_x \subseteq \text{Im}(f)$. This prove that $\text{Im}(f) = O_x$ and that therefore $f$ is bijective. Thus

$$
|O_x| = |G / G_x|
$$

It is easy to see that $G_x$ is a subgroup of $G$. Then the result follows from Lagrange's Theorem.
 
### Burnside's Lemma

Let $G$ be a group acting on a set $X$. Then:

$$
|X / G| = \frac{1}{|G|} \sum_{g \in G} |X^g|
$$

where

$$
X^g = \{ x \in X : g \cdot x = x \}
$$

#### Proof

$$
\begin{align*}
\sum_{g \in G} |X^g| &= \sum_{g \in G} |\{ x \in X : g \cdot x = x \}|  \\
&= |\{ (g, x) : g \in G, x \in X, g \cdot x = x \}| \\
&= \sum_{x \in X} |\{ g \in G : g \cdot x = x \}| \\
&= \sum_{x \in X} |G_x| \\
&= \sum_{x \in X} \frac{|G|}{|O_x|} \\
&= |G| \sum_{x \in X} \frac{1}{|O_x|} \\
&= |G| \sum_{O \subseteq X} \sum_{x \in O} \frac{1}{|O|} \\
&= |G| \sum_{O \subseteq X} 1 \\
&= |G| \cdot |X / G| \\
\end{align*}
$$

where the sum $\sum_{O \subseteq X}$ is over the distinct orbits in $X$. Notice that each of these orbits is essentially an equivalence class of $X$ under the action of $G$, which proves the last step.

## Analysis of the problem

Now we will proceed to analyze the problem at hand. Notice that swapping columns/rows and flipping their bits forms a group $G$ that acts over the set $X$ of all square binary matrices of size $n$. We are essentially asked to find the number of equivalence classes under this action, which can be done by applying Burnside's Lemma. Let's start by finding the group structure of $G$.

Let:

- $f^r_i$ be a flip on the bits in the $i$-th row.
- $f^c_i$ be a flip on the bits in the $i$-th column.
- $s^r_{i,j}$ be a swap of the $i$-th and $j$-th row.
- $s^c_{i,j}$ be a swap of the $i$-th and $j$-th column.

Then one can easily show the following identities:

- $f^r_i s^r_{i,j} = s^r_{i,j} f^r_j$
- $f^r_j s^r_{i,j} = s^r_{i,j} f^r_i$
- if $i \neq j, i \neq k$ then $f^r_i s^r_{j,k} = s^r_{j,k} f^r_i$
- $f^c_i s^c_{i,j} = s^c_{i,j} f^c_j$
- $f^c_j s^c_{i,j} = s^c_{i,j} f^c_i$
- if $i \neq j, i \neq k$ then $f^c_i s^c_{j,k} = s^c_{j,k} f^c_i$
- $f^r_i s^c_{j,k} = s^c_{j,k} f^r_i$
- $f^c_i s^r_{j,k} = s^r_{j,k} f^c_i$

Which show that we can rewrite any element of $g$ as a string of swaps followed by a string of flips. Moreover, we can trivially show that

$$
s^r_{i,j} s^c_{k,l} = s^c_{k,l} s^r_{i,j}
$$

Therefore the string of swaps can be rearranged into a string of row swaps followed by a string of column swaps. Notice that one can permute the $n$ rows/columns in all possible ways using only swaps. Therefore the subgroup of swaps over either just the rows or just the columns is isomorphic to the symmetric group of size $n$, $S_n$.

Let $F$ be the subgroup of flips over columns and rows. Then it is clear that $G \cong S_n \times S_n \times F$.

Now let's compute the group structure of $F$. Suppose a valid transformation in $F$ maps the zero matrix to itself. Notice that the number of bits equal to $1$ must be $nr + nc - 2rc$, where $r$ is the number of rows we flipped and $c$ is the number of columns we flipped. Then we need to find the integer solutions to $nr + nc - 2rc = 0$. Clearly $(r, c) = (0, 0)$ and $(r, c) = (n, n)$ are solutions. Now we will prove that there are no more solutions.

Consider the function $f(r, c) = 2rc / (r + c)$ on the domain $(0, n] \times (0, n]$. It has partial derivatives $f_r = 2c^2 / (r + c)^2$ and $f_c = 2r^2 / (r + c)^2$. Because these derivatives are positive on the domain, this function is strictly increasing along each axis. Because $f(n, n) = n$ is the upper-right corner of a square-shaped domain, no other point in it can have that value. Therefore in the domain, this is the only point that satisfies $2rc / (r + c) = n$, which is equivalent to $nr + nc - 2rc = 0$. Then the only remaining possible solutions are the ones that have $r = 0$ or $c = 0$. But it is pretty easy to check that if one of them is $0$ the other has to be as well. Therefore these are the only solutions to the equation.

In practicel terms this mean that choosing all rows and columns is equal to choosing none at all. Now we will prove that each transformation has one, and only one, complement that applies the same action, and thus $|F| = 2^{2n - 1}$.

We already know this fact to be true for the transformation that maps the zero matrix unto itself. Now suppose a valid transformation in $F$ maps the zero matrix to a non-zero matrix $M$. Pick a non-zero bit from $M$. Then either the row or column of that bit was flipped, but only one of them can be flipped at the same time. For the sake of argument, say it was the row. Then for each other bit in that same row, if the bit is a $0$, that column was flipped, otherwise it wasn't. Thus, all choice of columns are forced. Now pick any element from any other row. Because the column choice for that element is already forced, then the row choice is also forced, otherwise the bit is free to be $0$ or $1$, but by hypothesis $M$ is fixed. Thus all other row choices are forced too.

Therefore, any given transformation is given by a binary choice. Thus, there are exactly two row-column choices for each possible transformation in $F$. Because there are $2^{2n}$ row-column choices then $|F| = 2^{2n} / 2 = 2^{2n - 1}$. In particular, it is easy to see that for a given row-column choice, its complement applies the same transformation, where the complement is the row-column choice that flips only the rows and columns that were not flipped by the original row-column choice.

Because $F$ is abelian, and every element is of order $2$, then $F \cong Z_2^{2n - 1}$. Thus $G \cong S_n \times S_n \times Z_2^{2n - 1}$.

Before applying Burnside's Lemma let's go through a few illustrative examples.

### Counting Binary Vectors

Suppose we have a binary vector of size $n$ and we want to apply Burnside's Lemma to count the number of equivalence classes under permutations of the values. Clearly this is an action by the group $S_n$. Suppose you have $\alpha \in S_n$ written in cycle notation. Take a single cycle from that permutation. Notice that all position of that cycle need to have the same value in order for the vector to map unto itself. Because there are only two possible values that can be taken, we have that:

$$
|X^\alpha| = 2^{\text{number of cycles in } \alpha}
$$

as we are doing a binary choice of value for each cycle in the permutation. Application of Burnside's Lemma leads to the following formula:

$$
|X / G| = \frac{1}{n!} \sum_{\alpha \in S_n} 2^{c(\alpha)}
$$

where $c(\alpha)$ is the number of cycles in $\alpha$. Notice that the sum would be over $n!$ terms, which is computationally very expensive. To reduce the number of iterations, we can rewrite this expression in terms of partitions. Suppose we have a partition of $n$ as follows:

$$
n = x_1 \cdot 1 + x_2 \cdot 2 + \dots + x_n \cdot n
$$

This partition represents a permutation with $x_1$ cycles of length $1$, $x_2$ cycles of length $2$, and so forth. Then $c(\alpha) = x_1 + x_2 + \dots x_n$. Notice that the particular arrangement of the cycles doesn't matter, only how many of each size we have, i.e. how they partition. Now we need to count the number of permutations that maps to a given partition.

First partition the set of $n$ labels into subsets, where there are $x_k$ subsets of size $k$. There are

$$
\frac{n!}{\prod_{k = 1}^n k!^{x_k}}
$$

ways to do so. Each subset generates $k!/k$ cycles of length $k$. There are therefore

$$
\prod_{k = 1}^n (\frac{k!}{k})^{x_k}
$$

ways this can be done. But we do not distinguish between cycles of the same size when mapping it to a partition, i.e. they are permuted by $S_{x_k}$. This forces us to divide by all of these permutations:

$$
\prod_{k = 1}^n \frac{1}{x_k!}
$$

Multiplying all these possibilies we get:

$$
\frac{n!}{\prod_{k = 1}^n k!^{x_k}} \prod_{k = 1}^n (\frac{k!}{k})^{x_k} \prod_{k = 1}^n \frac{1}{x_k!} = n! \cdot [\prod_{k = 1}^n \frac{1}{x_k! k^{x_k}}]
$$

Therefore the counting equation can be rewritten as:

$$
|X / G| = \frac{1}{n!} \sum_{x_1 \cdot 1 + x_2 \cdot 2 + \dots + x_n \cdot n = n} n! \cdot [\prod_{k = 1}^n \frac{1}{x_k! k^{x_k}}] \cdot 2^{x_1 + x_2 + \dots + x_n}
$$

Setting:

$$
P(n; x_1, x_2, \dots, x_n) = n! \cdot [\prod_{k = 1}^n \frac{1}{x_k! k^{x_k}}] \\
$$

We can rewrite this formula as:

$$
|X / G| = \frac{1}{n!} \sum_{x_1 \cdot 1 + x_2 \cdot 2 + \dots + x_n \cdot n = n} P(n; x_1, x_2, \dots, x_n) \cdot 2^{x_1 + x_2 + \dots + x_n}
$$

### Counting Binary Matrices under row/column swaps

Assume now that we want to count equivalence classes for square binary matrices of size $n$ under row and column swaps. Burnside's Lemma gives:

$$
|X / G| = \frac{1}{n!^2} \sum_{x_1 \cdot 1 + x_2 \cdot 2 + \dots + x_n \cdot n = n} \sum_{y_1 \cdot 1 + y_2 \cdot 2 + \dots + y_n \cdot n = n} P(n; x_1, x_2, \dots, x_n) \cdot P(n; y_1, y_2, \dots, y_n) \cdot 2^{c(n; x_1, x_2, \dots, x_n; y_1, y_2, \dots, y_n)}
$$

where $c(n; x_1, x_2, \dots, x_n; y_1, y_2, \dots, y_n)$ is the number of cycles given by the product of the permutation represented by $x_1, x_2, \dots, x_n$ with the permutation represented by $y_1, y_2, \dots, y_n$. Now we will prove that:

$$
c(n; x_1, x_2, \dots, x_n; y_1, y_2, \dots, y_n) = \sum_{i = 1}^n \sum_{j = 1}^n (i, j) x_i y_j
$$

Take a cycle of length $i$ on the rows and a cycle of length $j$ on the columns. Notice that the product of these two cycles induces at least one new cycle of length $\text{lcm}(i, j)$ given by travelling in parallel along each of these cycles one step at a time. Because there are $i \times j$ slots in the matrix that are affected by the product of these two cycles, there must be $i \times j / \text{lcm}(i, j) = (i, j)$ distinct new cycles induced by the product of these two cycles. Therefore all the row cycles of length $i$ when multiplied by the column cycles of length $j$ induce $(i, j) x_i y_j$ independent cycles in the matrix. The result follows by iterating over all possible $(i, j)$ pairs.

### Counting Binary Matrices (Full Case)

Now with the previous experience under our belt we can build an expression that will solve the original problem. Take $\alpha, \beta \in S_n$. Take an individual cycle from $\alpha \times \beta$. If this cycle passes through an even number of bit flips then there are two possible sequence of values that map unto themselves under the action of this cycle. To see this is true pick either $0$ or $1$ and start at any position of the cycle. Follow the cycle along, respecting bit flips. At the end you should end with the same parity as you started, and because you respected the transformations at each step this sequence of values should map into itself under this action. By the same token, if the cycle has an odd number of bit flips, after one round-trip you end up with opposite parity, and thus no sequence of values can map into itself by this action.

With this in mind, let $\gamma \in F$. Then it is clear that

$$
|X^{\alpha \times \beta \times \gamma}| = 2^{c(\alpha, \beta)} \cdot \mathbb{1}_{\text{(all cycles have even number of bit flips)}}
$$

Thus by Burnside's Lemma we get:

$$
\begin{align*}
|X / G| &= \frac{1}{2|G|} \sum_{\alpha \in S_n} \sum_{\beta \in S_n} \sum_{\gamma \in S_n} 2^{c(\alpha, \beta)} \cdot \mathbb{1}_{\text{(all cycles have even number of bit flips)}} \\
&= \frac{1}{2|G|} \sum_{\alpha \in S_n} \sum_{\beta \in S_n} 2^{c(\alpha, \beta)} \cdot v(\alpha, \beta)
\end{align*}
$$

where $v(\alpha, \beta) = \sum_{\gamma \in S_n} \mathbb{1}_{\text{(all cycles have even number of bit flips)}}$, and the division by $2$ occurs because in calculating $v$ we will double count the transformations, as we will not control for the complement of each action. Now let's calculate $v(\alpha, \beta)$.

Fix $\alpha, \beta \in S_n$. Pick a row cycle of length $a$ from $\alpha$. Notice that flipping a row from this cycle contributes $b$ bit flips to the columns in a column cycle of length $b$ from $\beta$. Because the product of this row cycle with this column cycle induces $(a, b)$ distinct cycles, this row flip contributes $b / (a, b)$ bit flips to each individual cycle. Because this amount depends only on the length of the cycles that are interacting, the same is true for all row flips in the cycle of length $a$. Therefore we can consider these rows as a block.

If all $b / (a, b)$ values are even, then we are free to flip any combination of rows from that block, and there are $2^a$ different ways to do so. If at least one of these values is odd, we have to be careful, as not all possible arrangements will respect the bit flip parity of all cycles. 

If at least one $b / (a, b)$ is odd and for one of these odd values there is even $a / (a, b)$, then we will call this block a "dependent" block. For these blocks, flips in column cycle cannot fix the parity issues introduced by the flips in the row cycle. Therefore we are forced to choose an even number of rows from the row cycle in order to make sure that the bit-flip contribution from this block is even. Let's prove that there are $2^{a-1}$ choices with an even number of rows:

$$
2^a = (1 + 1)^a = {a \choose 0} + {a \choose 1} + {a \choose 2} + \dots \\
0 = (1 - 1)^a = {a \choose 0} - {a \choose 1} + {a \choose 2} + \dots
$$

Adding these we get:

$$
2^a = 2 {a \choose 0} + 2 {a \choose 2} + \dots
$$

and dividing by $2$ we get the desired result. By a similar token, there are $2^{a-1}$ choices with an odd number of rows.

If at least one $b / (a, b)$ is odd and whenever $b / (a, b)$ is odd then $a / (a, b)$ is also odd, then we will call this block "special". Notice that if one "special" block has an odd number of row/column flips, then all the other "special" blocks in the perpendicular direction need to have an odd number of row/column flips. This in turn will force the remaining "special" blocks to have an odd number of row/column flips. Therefore all "special" blocks need to have an odd number of row/column flips at the same time, or all them need to have an even number of row/column flips at the same time.

$$
\prod_{\text{"special" block with length } a} 2^{a - 1} + \prod_{\text{"special" block with length } a} 2^{a - 1} = 2 \prod_{\text{"special" block with length } a} 2^{a - 1}
$$

By multiplying all of these possible arrangements, we get that there are the following number of flip arrangements that respect cycle bit flip parity for all cycles induced by the product of $\alpha$ with $\beta$:

$$
v(\alpha, \beta) = 2^{2n - d(\alpha, \beta) - s(\alpha, \beta)}
$$

where

$$
d(\alpha, \beta) = \text{the number of "dependent" blocks} \\
s(\alpha, \beta) = \text{the number of "special" blocks, minus 1 if there are "special" blocks in both directions (row, columns)} \\
$$

Note that the $2n$ arises from the sum of all $a$ and $b$, as the sum of all cycle lengths along one axis must add up to $n$.

The final expression arises from applying the partition trick we did for the degenerate case with no flips, and using $|G| = n!^2 2^{n-1}$:

$$
|X / G| = \frac{1}{n!^2 \cdot 2^{2n}} \sum_{x_1 \cdot 1 + x_2 \cdot 2 + \dots + x_n \cdot n = n} \sum_{y_1 \cdot 1 + y_2 \cdot 2 + \dots + y_n \cdot n = n} P(n; x_1, x_2, \dots, x_n) \cdot P(n; y_1, y_2, \dots, y_n) \\
\cdot 2^{c(n; x_1, x_2, \dots, x_n; y_1, y_2, \dots, y_n)} \cdot v(n; x_1, x_2, \dots, x_n; y_1, y_2, \dots, y_n)
$$

The implementation can be done trivially using Big Integers.

## References

- https://math.stackexchange.com/questions/22159/how-many-n-times-m-binary-matrices-are-there-up-to-row-and-column-permutation
- https://math.stackexchange.com/questions/2113657/burnsides-lemma-applied-to-grids-with-interchanging-rows-and-columns?rq=1
- Graphical Enumeration (4.1.16)
- Graphical Enumeration (4.3.10)