# Sorted Digits

For a positive integer $d$, let $f(d)$ be the number created by sorting the digits of $d$ in ascending order, removing any zeros. For example, $f(3403) = 334$.

Let $S(n)$ be the sum of $f(d)$ for all positive integers $d$ of $n$ digits or less. You are given $S(1) = 45$ and $S(5) = 1543545675$.

Find $S(18)$. Give your answer modulo $1123455689$.

## Solution

Fix the value of $n$. Let $F_n$ be the set of all numbers with $n$ or less digits. Consider all the numbers in $F_n$ as $n$-digit numbers by counting the leading zeros. Then for $d_1, d_2 \in F_n$, $f(d_1) = f(d_2)$ if and only if both $d_1$ and $d_2$ have the same amount of each digit. An equivalence relation $\sim$ falls naturally from this, where $d_1 \sim d_2 \iff f(d_1) = f(d_2)$. Let the represenative element for each class $\langle d \rangle \in F_n / \sim$ be the element such that $f(d) = d$. Then

$$
\begin{align*}
S(n)
&= \sum_{d' \in F_n} f(d') \\
&= \sum_{\langle d \rangle \in F_n / \sim} \sum_{d' \in \langle d \rangle} f(d') \\
&= \sum_{\langle d \rangle \in F_n / \sim} \sum_{d' \in \langle d \rangle} f(d) \\
&= \sum_{\langle d \rangle \in F_n / \sim} |\langle d \rangle| \cdot f(d) \\
&= \sum_{\langle d \rangle \in F_n / \sim} |\langle d \rangle| \cdot d \\
\end{align*}
$$

Let $z_0, z_1, \dots, z_9$ be the amount of each digit in $d$. Then

$$
|\langle d \rangle| = \binom{n}{z_0, z_1, \dots, z_9}
$$
