# Golden Recurrence

Consider the following recurrence relation:

$$
\begin{align*}
a_0 &= \frac{\sqrt 5 + 1}2 \\
a_{n+1} &= \dfrac{a_n(a_n^4 + 10a_n^2 + 5)}{5a_n^4 + 10a_n^2 + 1}
\end{align*}
$$

Note that $a_0$ is the <b>golden ratio</b>.

$a_n$ can always be written in the form $\dfrac{p_n\sqrt{5}+1}{q_n}$, where $p_n$ and $q_n$ are positive integers.

Let $s(n)=p_n^5+q_n^5$. So, $s(0)=1^5+2^5=33$.

The <b>Fibonacci sequence</b> is defined as: $F_1=1$, $F_2=1$, $F_n=F_{n-1}+F_{n-2}$ for $n > 2$.

Define $\displaystyle S(m)=\sum_{i=2}^{m}s(F_i)$.

Find $S(1618034)$. Submit your answer modulo $398874989$.

## Solution

We will prove the following statements simultaneously through induction:

1. $a_n$ can always be represented as $\frac{p_n \sqrt{5} + 1}{q_n}$, where $p_n$, $q_n$ are positive integers.
2. $5 p_n^2 - q_n^2 = 1$
3. $p_{n+1} = p_n \cdot (400 p_n^4 - 100 p_n^2 + 5)$
4. $q_{n+1} = q_n \cdot (400 p_n^4 - 60 p_n^2 + 1)$

First, note that $1$ and $2$ are true for $a_0$. Now assume that $1$ and $2$ are true for $a_n$. Then

$$
\begin{align*}
a_{n+1}
&= a_n \frac{a_n^4 + 10 a_n^2 + 5}{5 a_n^4 + 10 a_n^2 + 1} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{a_n^4 + 10 a_n^2 + 5}{5 a_n^4 + 10 a_n^2 + 1} \cdot \frac{q_n^4}{q_n^4} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{(a_n \cdot q_n)^4 + 10 (a_n \cdot q_n)^2 \cdot q_n^2 + 5 q_n^4}{5 (a_n \cdot q_n)^4 + 10 (a_n \cdot q_n)^2 \cdot q_n^2 + q_n^4} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{(p_n \sqrt{5} + 1)^4 + 10 (p_n \sqrt{5} + 1)^2 \cdot (5 p_n^2 - 1) + 5 (5 p_n^2 - 1)^2}{5 (p_n \sqrt{5} + 1)^4 + 10 (p_n \sqrt{5} + 1)^2 \cdot (5 p_n^2 - 1) + (5 p_n^2 - 1)^2} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{(p_n \sqrt{5} + 1)^4 + 10 (p_n \sqrt{5} + 1)^2 \cdot (p_n \sqrt{5} + 1) \cdot (p_n \sqrt{5} - 1) + 5 (p_n \sqrt{5} + 1)^2 \cdot (p_n \sqrt{5} - 1)^2}{5 (p_n \sqrt{5} + 1)^4 + 10 (p_n \sqrt{5} + 1)^2 \cdot (p_n \sqrt{5} + 1) \cdot (p_n \sqrt{5} - 1) + (p_n \sqrt{5} + 1)^2 \cdot (p_n \sqrt{5} - 1)^2} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{(p_n \sqrt{5} + 1)^2 + 10 (p_n \sqrt{5} + 1) \cdot (p_n \sqrt{5} - 1) + 5 \cdot (p_n \sqrt{5} - 1)^2}{5 (p_n \sqrt{5} + 1)^2 + 10 (p_n \sqrt{5} + 1) \cdot (p_n \sqrt{5} - 1) + (p_n \sqrt{5} - 1)^2} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{20 p_n^2 - 2 \sqrt{5} p_n - 1}{20 p_n^2 + 2 \sqrt{5} p_n - 1} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{(20 p_n^2 - 1) - 2 \sqrt{5} p_n}{(20 p_n^2 - 1) + 2 \sqrt{5} p_n} \\
&= \frac{p_n \sqrt{5} + 1}{q_n} \cdot \frac{\left[ (20 p_n^2 - 1) - 2 \sqrt{5} p_n \right]^2}{(20 p_n^2 - 1)^2 - (2 \sqrt{5} p_n)^2} \\
&= \frac{1}{q_n} \cdot \frac{\sqrt{5} p_n \cdot (400 p_n^4 - 100 p_n^2 + 5) + 1}{400 p_n^4 - 60 p_n^2 + 1} \\
\end{align*}
$$

This produces a fraction of the form $\frac{x \sqrt{5} + 1}{y}$ which is irreducible (since nothing can divide $1$ expect another unit) and where $x$ and $y$ are positive integers (which can be proven easily by graphing the quartics and noticing that, for any positive integer input, the output will be a positive integer as well). Therefore:

$$
p_{n+1} = p_n \cdot (400 p_n^4 - 100 p_n^2 + 5) \\
q_{n+1} = q_n \cdot (400 p_n^4 - 60 p_n^2 + 1) \\
$$

which proves statements $1$, $3$ and $4$ for $a_{n+1}$. Finally, to prove statement $2$, note that:

$$
\begin{align*}
5 p_{n+1}^2 - q_{n+1}^2
&= 5 p_n^2 \cdot (400 p_n^4 - 100 p_n^2 + 5)^2 - q_n^2 \cdot (400 p_n^4 - 60 p_n^2 + 1)^2 \\
&= 5 p_n^2 \cdot (400 p_n^4 - 100 p_n^2 + 5)^2 - (5 p_n^2 - 1) \cdot (400 p_n^4 - 60 p_n^2 + 1)^2 \\
&= 1 \\
\end{align*}
$$

Because we care about $(p_n \mod r, q_n \mod r)$, then after a finite amount of steps the values of this tuple will begin to repeat. Calculation shows that there exists a value $k$ such that $p_k \equiv p_0 \mod r$ and $q_k \equiv q_0 \mod r$. Therefore $p_n \equiv p_{(n \mod k)} \mod r$ and $q_n \equiv q_{(n \mod k)} \mod r$, which gives us a fast way of calculating $s(n) \mod r$.