# Larger Digit Permutation

For a positive integer $n$ define $T(n)$ to be the number of strictly larger integers which can be formed by permuting the digits of $n$.

Leading zeros are not allowed and so for $n = 2302$ the total list of permutations would be:

$2023,2032,2203,2230,\mathbf{2302},2320,3022,32 02,3220$

giving $T(2302)=4$.

Further define $S(k)$ to be the sum of $T(n)$ for all $k$-digit numbers $n$. You are given $S(3) = 1701$.

Find $S(12)$.

## Solution

Let $F_k$ be the set of all $k$-digit numbers and let $G_k := F_k / \sim_1$ where $a \sim_1 b$ if $a$ and $b$ have the same number of digits and their digits are permutations of one another.

Pick any equivalence class in $E \in G_k$, and let $x_1 < x_2 < \dots < x_m$ be members of $E$. Note that

$$
T(x_1) = m - 1 \\
T(x_2) = m - 2 \\
\dots \\
T(x_k) = 1 \\
$$

Therefore

$$
\sum_{x \in E} T(x) = \frac{m(m-1)}{2}
$$

where $m = |E|$. Thus

$$
\begin{align*}
S(k)
&= \sum_{x \in F_k} T(x) \\
&= \sum_{E \in G_k} \sum_{x \in E} T(x) \\
&= \sum_{E \in G_k} \frac{|E| \cdot (|E| - 1)}{2} \\
\end{align*}
$$

Let $y_0, y_1, \dots, y_9$ be the amount of each digit for a set $E \in G_k$. Also let $y_0', y_1', \dots, y_9'$ be the amount of each digit for another set $E \in G_k$. Let $\sim_2$ be the equivalence relation on $G_k$ where $E \sim_2 E'$ if and only if $y_0 = y_0'$ and there exists a permutation $\tau$ such that $\tau((y_1, y_2, \dots, y_9)) = (y_1', y_2', \dots, y_9')$. It is clear that if $E \sim_2 E'$ then $|E| = |E'|$. Let $H_k := G_k / \sim_2$. Then:

$$
\begin{align*}
S(k)
&= \sum_{E \in G_k} \frac{|E| \cdot (|E| - 1)}{2} \\
&= \sum_{\langle E \rangle \in H_k} \sum_{E' \in \langle E \rangle} \frac{|E'| \cdot (|E'| - 1)}{2} \\
&= \sum_{\langle E \rangle \in H_k} \frac{|E| \cdot (|E| - 1)}{2} \sum_{E' \in \langle E \rangle} 1 \\
\end{align*}
$$

A representative member for each class in $H_k$ can be generated by iterating $y_0$ from $0$ to $k-1$, and choosing $y_1, y_2, \dots, y_9$ such that $y_1 \ge y_2 \ge \dots \ge y_9 \ge 0$ and $y_0 + y_1 + \dots + y_9 = k$. Once we know $y_0, y_1, \dots, y_9$ then $|E|$ can be calculated using the formula:

$$
\begin{align*}
|E|
&= \binom{k - y_0}{y_1, y_2, \dots, y_9} \cdot \binom{y_0 + (k - y_0) - 1}{(k - y_0) - 1} \\
&= \binom{k - y_0}{y_1, y_2, \dots, y_9} \cdot \binom{k - 1}{k - y_0 - 1} \\
\end{align*}
$$

Where the first term in the product represents the ways of laying out each of the non-zero digits and the second term represents the possible ways of packing the remaining zero digits into the spaces in between the already chosen digits (using the stars and bars formula).

Finally $\sum_{E' \in \langle E \rangle} 1$ can be calculated using the formula:

$$
\sum_{E' \in \langle E \rangle} 1 = \binom{9}{z_0, z_1, \dots, z_k} \\
$$

where $z_i$ is how many of $y_1, y_2, \dots, y_9$ equal $i$.