# Remainders of Polynomial Division

<p>For positive integers <var>n</var> and <var>m</var>, we define two polynomials F<sub><var>n</var></sub>(<var>x</var>) = <var>x</var><sup><var>n</var></sup> and G<sub><var>m</var></sub>(<var>x</var>) = (<var>x</var>-1)<sup><var>m</var></sup>.<br />
We also define a polynomial R<sub><var>n</var>,<var>m</var></sub>(<var>x</var>) as the remainder of the division of F<sub><var>n</var></sub>(<var>x</var>) by G<sub><var>m</var></sub>(<var>x</var>).<br />
For example, R<sub>6,3</sub>(<var>x</var>) = 15<var>x</var><sup>2</sup> - 24<var>x</var> + 10.</p>

<p>Let C(<var>n</var>, <var>m</var>, <var>d</var>) be the absolute value of the coefficient of the <var>d</var>-th degree term of R<sub><var>n</var>,<var>m</var></sub>(<var>x</var>).<br />
We can verify that C(6, 3, 1) = 24 and C(100, 10, 4) = 227197811615775.</p>

<p>Find C(10<sup>13</sup>, 10<sup>12</sup>, 10<sup>4</sup>) mod 999999937.</p>

## Solution

### Lemma 1

Suppose $1 \leq m \leq n - 1$. Then

$$
{n \choose m} = {n - 1 \choose m - 1} + {n - 1 \choose m}
$$

#### Proof

$$
\begin{align*}
{n - 1 \choose m - 1} + {n - 1 \choose m}
&= \frac{(n - 1)!}{(m - 1)! (n - m)!} + \frac{(n - 1)!}{m! (n - m - 1)!} \\
&= \frac{(n - 1)!}{(m - 1)! (n - m - 1)!} [ \frac{1}{n - m} + \frac{1}{m} ] \\
&= \frac{(n - 1)!}{(m - 1)! (n - m - 1)!} \cdot \frac{n - m + m}{(n - m) m} \\
&= \frac{(n - 1)!}{(m - 1)! (n - m - 1)!} \cdot \frac{n}{(n - m) m} \\
&= \frac{n!}{m! (n - m)!} \\
&= {n \choose m} \\
\end{align*}
$$

### Lemma 2

Suppose $0 \leq m \leq n - 1$. Then

$$
\sum_{i = 0}^m {n \choose i} (-1)^i = (-1)^m \cdot {n - 1 \choose m}
$$

#### Proof

Fix $n$. Let $m = 0$. Then ${n \choose 0} = {n - 1 \choose 0} = 1$. Now suppose $m > 0$ and that the theorem is true for $0, \dots, m - 1$. Then

$$
\begin{align*}
\sum_{i = 0}^m {n \choose i} (-1)^i
&= \sum_{i = 0}^{m-1} {n \choose i} (-1)^i + {n \choose m} (-1)^{m} \\
&= (-1)^{m-1} \cdot {n - 1 \choose m - 1} + {n \choose m} (-1)^{m} \\
&= (-1)^{m-1} \cdot [ {n - 1 \choose m - 1} - {n \choose m} ] \\
&= (-1)^{m-1} \cdot [ - {n - 1 \choose m} ] \\
&= (-1)^{m} \cdot {n - 1 \choose m} \\
\end{align*}
$$

### Calculating $C(n, m, d)$

Let's calculate $x^n$ modulo $(x-1)^m$

$$
\begin{align*}
x^n
&\equiv ((x - 1) + 1)^n \\
&\equiv \sum_{i = 0}^n {n \choose i} (x - 1)^i \\
&\equiv \sum_{i = 0}^{m - 1} {n \choose i} (x - 1)^i \\
&\equiv \sum_{i = 0}^{m - 1} {n \choose i} \sum_{d = 0}^i {i \choose d} x^d (-1)^{i - d} \\
&\equiv \sum_{i = 0}^{m - 1} \sum_{d = 0}^i {n \choose i} {i \choose d} x^d (-1)^{i - d} \\
&\equiv \sum_{d = 0}^{m - 1} \sum_{i = d}^{m - 1} {n \choose i} {i \choose d} x^d (-1)^{i - d} \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d \sum_{i = d}^{m - 1} \frac{n!}{i! (n - i)!} \cdot \frac{i!}{d! (i - d)!} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d \sum_{i = d}^{m - 1} \frac{n!}{(n - i)!} \cdot \frac{1}{d! (i - d)!} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d \sum_{i = d}^{m - 1} \frac{n!}{d! (n - d)!} \cdot \frac{(n - d)!}{(n - i)! (i - d)!} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d \sum_{i = d}^{m - 1} {n \choose d} \cdot {n - d \choose i - d} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d {n \choose d} \sum_{i = d}^{m - 1} {n - d \choose i - d} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^d {n \choose d} \sum_{i = 0}^{m - d - 1} {n - d \choose i} (-1)^{i+d} \\
&\equiv \sum_{d = 0}^{m - 1} x^d (-1)^{2d} {n \choose d} \sum_{i = 0}^{m - d - 1} {n - d \choose i} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d {n \choose d} \sum_{i = 0}^{m - d - 1} {n - d \choose i} (-1)^i \\
&\equiv \sum_{d = 0}^{m - 1} x^d {n \choose d} (-1)^{m - d - 1} {n - d - 1 \choose m - d- 1} \\
\end{align*}
$$

where the last transformation depends on Lemma 2. Thus $C(n, m, d) = {n \choose d} {n - d - 1 \choose m - d- 1}$. Finally, the binomial coefficient modulo $p$ can be calculated efficiently using Lucas' Theorem.