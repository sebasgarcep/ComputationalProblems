# Divisor Square Sum

<p>For a positive integer <var>n</var>, let σ<sub>2</sub>(<var>n</var>) be the sum of the squares of its divisors. For example,</p>
<div class="center">σ<sub>2</sub>(10) = 1 + 4 + 25 + 100 = 130.</div>
<p>Find the sum of all <var>n</var>, 0 &lt; <var>n</var> &lt; 64,000,000 such that σ<sub>2</sub>(<var>n</var>) is a perfect square.</p>

## Solution

Using a prime sieve we can efficiently factorize all $n$. Then using the formula $\sigma_2(n) = \prod_i (1 + p_i^2 + p_i^4 + \dots + p_i^{2v_i})$ we can construct $\sigma_2(n)$ for all $n$. Finally we determine the largest value $L$ of $\sigma_2(n)$ and calculate a set with all $i^2$ for $i^2 \leq L$. If a $\sigma_2(n)$ is in the set, then it is a perfect square.