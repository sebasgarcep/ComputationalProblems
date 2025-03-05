# 2025

For the year $2025$
$$2025 = (20 + 25)^2$$
Given positive integers $a$ and $b$, the concatenation $ab$ we call a $2025$-number if $ab = (a+b)^2$.<br>
Other examples are $3025$ and $81$.<br>
Note $9801$ is not a $2025$-number because the concatenation of $98$ and $1$ is $981$.

Let $T(n)$ be the sum of all $2025$-numbers with $n$ digits or less. You are given $T(4) = 5131$.

Find $T(16)$.

## Solution

Suppose $(a + b)^2 = a \cdot 10^k + b$ with $10^{k-1} \le b \lt 10^k$. Then

$$
\begin{align*}
&\Rightarrow (a + b)^2 \lt 10^n \\
&\Rightarrow b^2 \lt 10^n \\
&\Rightarrow b \lt 10^{n/2} \\
\end{align*}
$$

Also

$$
\begin{align*}
&\Rightarrow a^2 + (2b - 10^k) a + (b^2 - b) = 0 \\
&\Rightarrow a = \frac{10^k - 2b \pm \sqrt{10^{2k} + 4b (1 - 10^k)}}{2} \\
&\Rightarrow 10^{2k} + 4b (1 - 10^k) \ge 0 \\
&\Rightarrow b \le \frac{10^{2k}}{4(10^k - 1)} \\
\end{align*}
$$

This gives us good bounds for the search on $b$ (around $\sqrt{n}$ values of $b$ must be checked), and a way to generate $a$ given $b$ (the quadratic gives two possible values for $a$). Then we only need to test that the generated value of $a$ is a positive integer and that the condition $(a + b)^2 = a \cdot 10^k + b$ holds.