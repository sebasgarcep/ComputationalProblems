# Counting primitive Pythagorean triples


A <b>Pythagorean triple</b> consists of three positive integers $a, b$ and $c$ satisfying $a^2+b^2=c^2$.<br />
The triple is called primitive if $a, b$ and $c$ are relatively prime.<br />
Let P($n$) be the number of <b>primitive Pythagorean triples</b> with $a \lt b \lt c \le n$.<br />
For example P(20) = 3, since there are three triples: (3,4,5), (5,12,13) and (8,15,17).


You are given that P(10<sup>6</sup>) = 159139.<br />
Find P(3141592653589793).

## Solution

Let

$$
T(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N}} 1 \\
S(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ \gcd(u, v) = 1}} 1 \\
T_1(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \equiv v \pmod 2}} 1 \\
S_1(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ \gcd(u, v) = 1 \\ u \equiv v \pmod 2}} 1 \\
T_2(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \not\equiv v \pmod 2}} 1 \\
S_2(N) = \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ \gcd(u, v) = 1 \\ u \not\equiv v \pmod 2}} 1 \\
$$

Clearly we wish to find an efficient formulation for $S_2(N)$. Because $S(N) = S_1(N) + S_2(N), T(N) = T_1(N) + T_2(N)$. So our problem reduces to finding efficient formulations for $S(N), T(N), S_1(N), T_1(N)$. The following calculations give us efficients formulations for each.

### Calculating $T(N)$

$$
\begin{align*}
T(N)
&= \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N}} 1 \\
&= \sum_{\substack{u \ge 2 \\ u^2 + 1 \le N}} \sum_{v = 1}^{\min(u - 1, \lfloor \sqrt{N - u^2} \rfloor)} 1 \\
&= \sum_{\substack{u \ge 2 \\ u^2 + 1 \le N}} \min(u - 1, \lfloor \sqrt{N - u^2} \rfloor) \\
\end{align*}
$$

### Calculating $T_1(N)$

$$
\begin{align*}
T_1(N)
&= \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \equiv v \pmod 2}} 1 \\
&= \sum_{\substack{u \ge 2 \\ u^2 + 1 \le N}} \sum_{\substack{1 \le v \le \min(u - 1, \lfloor \sqrt{N - u^2} \rfloor) \\ u \equiv v \pmod 2}} 1 \\
&= \sum_{\substack{u \ge 2 \\ u^2 + 1 \le N}} \lfloor \min(u - 1, \lfloor \sqrt{N - u^2} \rfloor) / 2 \rfloor + \delta_u \\
\end{align*}
$$

where $\delta_u$ is a correction factor.

### Calculating $S(N)$

$$
\begin{align*}
T(N)
&= \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ \gcd(u, v) = k}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{ku > kv > 0 \\ (ku)^2 + (kv)^2 \le N \\ \gcd(ku, kv) = k}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ \gcd(u, v) = 1}} 1 \\
&= \sum_{k \ge 1} S(N / k^2) \\
&= S(N) + \sum_{k \ge 2} S(N / k^2) \\
\end{align*}
$$

Therefore

$$
S(N) = T(N) - \sum_{k \ge 2} S(N / k^2)
$$

### Calculating $S_1(N)$

$$
\begin{align*}
T_1(N)
&= \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \equiv v \pmod 2}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \equiv v \pmod 2 \\ \gcd(u, v) = k}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{ku > kv > 0 \\ (ku)^2 + (kv)^2 \le N \\ ku \equiv kv \pmod 2 \\ \gcd(ku, kv) = k}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ ku \equiv kv \pmod 2 \\ \gcd(u, v) = 1}} 1 \\
&= \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N \\ u \equiv v \pmod 2 \\ \gcd(u, v) = 1}} 1
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) = 1}} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ ku \equiv kv \pmod 2 \\ \gcd(u, v) = 1}} 1
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) \not= 1}} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ ku \equiv kv \pmod 2 \\ \gcd(u, v) = 1}} 1 \\
&= S_1(N)
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) = 1}} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ u \equiv v \pmod 2 \\ \gcd(u, v) = 1}} 1
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) \not= 1}} \sum_{\substack{u > v > 0 \\ u^2 + v^2 \le N / k^2 \\ \gcd(u, v) = 1}} 1 \\
&= S_1(N)
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) = 1}} S_1(N / k^2)
+ \sum_{\substack{k \ge 2 \\ \gcd(k, 2) \not= 1}} S(N / k^2) \\
\end{align*}
$$

Therefore

$$
S_1(N) = T_1(N)
- \sum_{\substack{k \ge 2 \\ \gcd(k, 2) = 1}} S_1(N / k^2)
- \sum_{\substack{k \ge 2 \\ \gcd(k, 2) \not= 1}} S(N / k^2)
$$