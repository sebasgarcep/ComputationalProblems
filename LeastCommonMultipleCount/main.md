# Least Common Multiple Count

Let <var>f</var>(<var>n</var>) be the number of couples (<var>x</var>,<var>y</var>) with <var>x</var> and <var>y</var> positive integers, <var>x</var> ≤ <var>y</var> and the least common multiple of <var>x</var> and <var>y</var> equal to <var>n</var>.

Let <var>g</var> be the <b>summatory function</b> of <var>f</var>, i.e.: 
<var>g</var>(<var>n</var>) = ∑ <var>f</var>(<var>i</var>)  for 1 ≤ <var>i</var> ≤ <var>n</var>.

You are given that <var>g</var>(10<sup>6</sup>) = 37429395.

Find <var>g</var>(10<sup>12</sup>).

## Solution

$$
\begin{align*}
g(N)
&= \sum_{\substack{1 \leq x \leq y \\ \text{lcm}(x, y) \leq N}} 1 \\
&= \sum_{\substack{1 \leq x \leq y \\ \frac{xy}{\text{gcd}(x, y)} \leq N}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq x \leq y \\ \text{gcd}(x, y) = k \\ \frac{xy}{k} \leq N}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq kx \leq ky \\ \text{gcd}(kx, ky) = k \\ \frac{kx \cdot ky}{k} \leq N}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq x \leq y \\ \text{gcd}(x, y) = 1 \\ xy \leq N / k}} 1 \\
&= \sum_{k \geq 1} S(N / k) \\
\end{align*}
$$

where

$$
S(N) = \sum_{\substack{1 \leq x \leq y \\ \text{gcd}(x, y) = 1 \\ xy \leq N}} 1
$$

Let

$$
\begin{align*}
T(N)
&:= \sum_{\substack{1 \leq x \leq y \\ xy \leq N}} 1 \\
&= \sum_{\substack{1 \leq x \leq \text{min}(y, N / y)}} 1 \\
&= \sum_{y = 1}^{\sqrt{N}} \sum_{x = 1}^y 1 + \sum_{y = \sqrt{N} + 1}^N \sum_{x = 1}^{N / y} 1 \\
&= \sum_{y = 1}^{\sqrt{N}} y + \sum_{y = \sqrt{N} + 1}^N \lfloor N / y \rfloor \\
&= \lfloor \sqrt{N} \rfloor ( \lfloor \sqrt{N} \rfloor + 1) / 2 + \sum_{\substack{1 \leq u \leq \sqrt{N} \\ u \not= \lfloor N / u \rfloor}} u \cdot (\lfloor N / u \rfloor - \lfloor N / (u + 1) \rfloor) \\
\end{align*}
$$

where the last sum is obtained using the same trick as the one used to split the sum over $\sqrt{N}$. On the other hand

$$
\begin{align*}
T(N)
&= \sum_{\substack{1 \leq x \leq y \\ xy \leq N}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq x \leq y \\ xy \leq N \\ \text{gcd}(x, y) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq kx \leq ky \\ kx \cdot ky \leq N \\ \text{gcd}(kx, ky) = k}} 1 \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq x \leq y \\ xy \leq N / k^2 \\ \text{gcd}(x, y) = 1}} 1 \\
&= \sum_{k \geq 1} S(N / k^2) \\
\end{align*}
$$

Thus $S(N) = T(N) - \sum_{k \geq 2} S(N / k^2)$. Finally, we can optimize the calculation of $g(N)$ by splitting the sum over $\sqrt{N}$.