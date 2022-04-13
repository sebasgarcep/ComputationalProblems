# Totient Stairstep Sequences

Let {a<sub>1</sub>, a<sub>2</sub>,..., a<sub><var>n</var></sub>} be an integer sequence of length <var>n</var> such that:
<ul><li>a<sub>1</sub> = 6</li>
<li>for all 1 ≤ <var>i</var> &lt; <var>n</var> : φ(a<sub><var>i</var></sub>) &lt; φ(a<sub><var>i</var>+1</sub>) &lt; a<sub><var>i</var></sub> &lt; a<sub><var>i</var>+1</sub><sup>1</sup></li>
</ul>Let S(<var>N</var>) be the number of such sequences with a<sub><var>n</var></sub> ≤ <var>N</var>.<br />
For example, S(10) = 4: {6}, {6, 8}, {6, 8, 9} and {6, 10}.<br />
We can verify that S(100) = 482073668 and S(10 000) mod 10<sup>8</sup> = 73808307.

Find S(20 000 000) mod 10<sup>8</sup>.

<sup>1</sup> φ denotes <b>Euler's totient function</b>.

## Solution

Let $C(k)$ be the number of sequences ending in $k$. Clearly $C(k) = 1$. Then $S(N) = \sum_{k=6}^N C(k)$. Then

$$
\begin{align*}
C(k)
&= \sum_{\substack{6 \le i \le k-1 \\ \varphi(i) \lt \varphi(k) \lt i}} C(i) \\
&= \sum_{\substack{6 \le i \le k-1 \\ \varphi(k) \lt i}} C(i) - \sum_{\substack{6 \le i \le k-1 \\ \varphi(k) \le \varphi(i)}} C(i) \\
&= \sum_{6 \le i \le k-1} C(i)
- \sum_{\substack{6 \le i \le \varphi(k)}} C(i)
- \sum_{\substack{6 \le i \le k-1 \\ \varphi(k) \le \varphi(i)}} C(i) \\
\end{align*}
$$

The first and second sums can be computed using a list of running totals. The third sum can be computed by building a Fenwick tree similar to the one used in Ascending Subsequences.