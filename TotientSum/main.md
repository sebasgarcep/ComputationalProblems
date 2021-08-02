# Totient Sum

<p>
Let S(<var>n,m</var>) = ∑φ(<var>n × i</var>) for 1 ≤ <var>i ≤ m</var>. (φ is Euler's totient function)<br />
You are given that S(510510,10<sup>6</sup> )= 45480596821125120. 
</p>
<p>
Find S(510510,10<sup>11</sup>).<br />
Give the last 9 digits of your answer.
</p>

## Solution

Let $n$ be a square-free number and $p$ be a prime that does not divide $n$. Then we can see that:

$$
\begin{align*}
S(n \times p, m)
&= \sum_{i = 1}^m \varphi(n \times p \times i) \\
&= \sum_{\substack{i = 1 \\ p \nmid i}}^m \varphi(n \times i) \cdot \varphi(p) + \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) \cdot p \\
&= \varphi(p) \cdot \sum_{\substack{i = 1 \\ p \nmid i}}^m \varphi(n \times i) + p \cdot \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) \\
&= \varphi(p) \cdot \sum_{i = 1}^m \varphi(n \times i) - \varphi(p) \cdot \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) + p \cdot \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) \\
&= \varphi(p) \cdot \sum_{i = 1}^m \varphi(n \times i) + (p - \varphi(p)) \cdot \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) \\
&= (p - 1) \cdot \sum_{i = 1}^m \varphi(n \times i) + \sum_{\substack{i = 1 \\ p \mid i}}^m \varphi(n \times i) \\
&= (p - 1) \cdot \sum_{i = 1}^m \varphi(n \times i) + \sum_{i = 1}^{\lfloor m / p \rfloor} \varphi(n \times p \times i) \\
&= (p - 1) \cdot S(n, m) + S(n \times p, \lfloor m / p \rfloor) \\
\end{align*}
$$

These recurrence has base cases:

$$
S(n, 0) = 0 \\
S(1, m) = \sum_{i = 1}^m \varphi(i)
$$

where the Totient Sum can be evaluated efficiently by caching the result for small enough values, and using the recurrence proved in Hexagonal Orchards for larger values.