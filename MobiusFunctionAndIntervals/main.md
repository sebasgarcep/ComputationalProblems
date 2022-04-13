# Möbius function and intervals

The <b>Möbius function</b>, denoted <var>μ</var>(<var>n</var>), is defined as:
<ul><li><var>μ</var>(<var>n</var>) = (-1)<sup><var>ω</var>(<var>n</var>)</sup> if <var>n</var> is squarefree (where <var>ω</var>(<var>n</var>) is the number of distinct prime factors of <var>n</var>)</li>
<li><var>μ</var>(<var>n</var>) = 0 if <var>n</var> is not squarefree.</li>
</ul>
Let P(<var>a</var>,<var>b</var>) be the number of integers <var>n</var> in the interval [<var>a</var>,<var>b</var>] such that <var>μ</var>(<var>n</var>) = 1.<br />
Let N(<var>a</var>,<var>b</var>) be the number of integers <var>n</var> in the interval [<var>a</var>,<var>b</var>] such that <var>μ</var>(<var>n</var>) = -1.<br />
For example, P(2,10) = 2 and N(2,10) = 4.

Let C(<var>n</var>) be the number of integer pairs (<var>a</var>,<var>b</var>) such that:
<ul><li> 1 ≤ <var>a</var> ≤ <var>b</var> ≤ <var>n</var>,</li>
<li> 99·N(<var>a</var>,<var>b</var>) ≤ 100·P(<var>a</var>,<var>b</var>), and</li>
<li> 99·P(<var>a</var>,<var>b</var>) ≤ 100·N(<var>a</var>,<var>b</var>).</li>
</ul>
For example, C(10) = 13, C(500) = 16676 and C(10 000) = 20155319.

Find C(20 000 000).

## Solution

Fix a value of $b$. Therefore

$$
\begin{align*}
b
&= \sum_{1 \le a \le b} 1 \\
&= \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \le 100 P(a, b) \\ 99 P(a, b) \le 100 N(a, b)}} 1
+ \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \gt 100 P(a, b) \\ 99 P(a, b) \le 100 N(a, b)}} 1 \\
&+ \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \le 100 P(a, b) \\ 99 P(a, b) \gt 100 N(a, b)}} 1
+ \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \gt 100 P(a, b) \\ 99 P(a, b) \gt 100 N(a, b)}} 1 \\
\end{align*}
$$

Notice that

$$
99 N(a, b) \gt 100 P(a, b) \\
99 P(a, b) \le 100 N(a, b) \\
\Rightarrow \\
100 P(a, b) \lt 99 N(a, b) \\
99 P(a, b) \le 100 N(a, b) \\
\Rightarrow \\
100 P(a, b) \lt 99 N(a, b) \\
$$

because the first inequality implies the second. Similarly

$$
99 N(a, b) \le 100 P(a, b) \\
99 P(a, b) \gt 100 N(a, b) \\
\Rightarrow \\
99 N(a, b) \le 100 P(a, b) \\
100 N(a, b) \lt 99 P(a, b) \\
\Rightarrow \\
100 N(a, b) \lt 99 P(a, b) \\
$$

Finally

$$
99 N(a, b) \gt 100 P(a, b) \\
99 P(a, b) \gt 100 N(a, b) \\
\Rightarrow \\
99 N(a, b) / 100 \gt P(a, b) \\
P(a, b) \gt 100 N(a, b) / 99 \\
\Rightarrow \\
100 N(a, b) / 99 \lt P(a, b) \lt 99 N(a, b) / 100 \\
\Rightarrow \\
100 / 99 \lt 99 / 100 \\
$$

a contradiction, therefore this last sum is empty. Therefore

$$
\begin{align*}
C(b)
&= C(b-1)
+ \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \le 100 P(a, b) \\ 99 P(a, b) \le 100 N(a, b)}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \gt 100 P(a, b) \\ 99 P(a, b) \le 100 N(a, b)}} 1
- \sum_{\substack{1 \le a \le b \\ 99 N(a, b) \le 100 P(a, b) \\ 99 P(a, b) \gt 100 N(a, b)}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 100 P(a, b) \lt 99 N(a, b)}} 1
- \sum_{\substack{1 \le a \le b \\ 100 N(a, b) \lt 99 P(a, b)}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 100 P(a, b) \le 99 N(a, b) - 1}} 1
- \sum_{\substack{1 \le a \le b \\ 100 N(a, b) \le 99 P(a, b) - 1}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 100 (P(b) - P(a - 1)) \le 99 (N(b) - N(a - 1)) - 1}} 1
- \sum_{\substack{1 \le a \le b \\ 100 (N(b) - N(a - 1)) \le 99 (P(b) - P(a - 1)) - 1}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 99 N(a - 1) - 100 P(a - 1) \le 99 N(b) - 100 P(b) - 1}} 1
- \sum_{\substack{1 \le a \le b \\ 99 P(a - 1) - 100 N(a - 1) \le 99 P(b) - 100 N(b) - 1}} 1 \\
&= C(b-1)
+ b
- \sum_{\substack{1 \le a \le b \\ 99 N(a - 1) - 100 P(a - 1) \le 99 N(b) - 100 P(b) - 1}} 1
- \sum_{\substack{1 \le a \le b \\ 99 P(a - 1) - 100 N(a - 1) \le 99 P(b) - 100 N(b) - 1}} 1 \\
\end{align*}
$$

where $P(x) = P(1, x), N(x) = N(1, x)$. Note that the last sums can be computed efficiently using a Fenwick Tree as in "Ascending Subsequences", with the slight modification: We need to add an offset to the indexes of the Fenwick tree to prevent them from being negative.