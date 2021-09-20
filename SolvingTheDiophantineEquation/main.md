# Solving the diophantine equation 1/a+1/b= p/10n

Consider the diophantine equation <sup>1</sup>/<sub><var>a</var></sub>+<sup>1</sup>/<sub><var>b</var></sub>= <sup><var>p</var></sup>/<sub>10<sup><var>n</var></sup></sub> with <var>a, b, p, n</var> positive integers and <var>a</var> ≤ <var>b</var>.<br />
For <var>n</var>=1 this equation has 20 solutions that are listed below:
<table><tr><td width="120"><sup>1</sup>/<sub>1</sub>+<sup>1</sup>/<sub>1</sub>=<sup>20</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>1</sub>+<sup>1</sup>/<sub>2</sub>=<sup>15</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>1</sub>+<sup>1</sup>/<sub>5</sub>=<sup>12</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>1</sub>+<sup>1</sup>/<sub>10</sub>=<sup>11</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>2</sub>+<sup>1</sup>/<sub>2</sub>=<sup>10</sup>/<sub>10</sub></td>
</tr><tr><td width="120"><sup>1</sup>/<sub>2</sub>+<sup>1</sup>/<sub>5</sub>=<sup>7</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>2</sub>+<sup>1</sup>/<sub>10</sub>=<sup>6</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>3</sub>+<sup>1</sup>/<sub>6</sub>=<sup>5</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>3</sub>+<sup>1</sup>/<sub>15</sub>=<sup>4</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>4</sub>+<sup>1</sup>/<sub>4</sub>=<sup>5</sup>/<sub>10</sub></td>
</tr><tr><td width="120"><sup>1</sup>/<sub>4</sub>+<sup>1</sup>/<sub>20</sub>=<sup>3</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>5</sub>+<sup>1</sup>/<sub>5</sub>=<sup>4</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>5</sub>+<sup>1</sup>/<sub>10</sub>=<sup>3</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>6</sub>+<sup>1</sup>/<sub>30</sub>=<sup>2</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>10</sub>+<sup>1</sup>/<sub>10</sub>=<sup>2</sup>/<sub>10</sub></td>
</tr><tr><td width="120"><sup>1</sup>/<sub>11</sub>+<sup>1</sup>/<sub>110</sub>=<sup>1</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>12</sub>+<sup>1</sup>/<sub>60</sub>=<sup>1</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>14</sub>+<sup>1</sup>/<sub>35</sub>=<sup>1</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>15</sub>+<sup>1</sup>/<sub>30</sub>=<sup>1</sup>/<sub>10</sub></td>
<td width="120"><sup>1</sup>/<sub>20</sub>+<sup>1</sup>/<sub>20</sub>=<sup>1</sup>/<sub>10</sub></td>
</tr></table>How many solutions has this equation for 1 ≤ <var>n</var> ≤ 9?

## Solution

Suppose $(a, b, p)$ is a solution to the Diophantine Equation. Then

$$
\frac{1}{a} + \frac{1}{b} = \frac{p}{10^n} \Rightarrow \frac{1}{pa} + \frac{1}{pb} = \frac{1}{10^n}
$$

Therefore $(pa, pb, 1)$ is a solution to the Diophantine Equation too. Thus, every solution can be mapped to a solution with $p = 1$. Therefore, if we solve the Diophantine equation

$$
\frac{1}{a} + \frac{1}{b} = \frac{1}{10^n}
$$

then there are exactly $\sigma_0(\text{gcd}(a, b))$ solutions to the more general equation that map to this solution, where $\sigma_0$ is the number-of-divisors function. To illustrate why this is true, notice that we can factor out an arbitrary divisor of $\text{gcd}(a, b)$ from $a$ and $b$, and move it to the other side to construct a solution to

$$
\frac{1}{a} + \frac{1}{b} = \frac{p}{10^n}
$$

Now let's find bounds on $a$ for the simpler equation. Notice that if $a \leq 10^n$ then

$$
\frac{1}{10^n} \leq \frac{1}{a} \Rightarrow \frac{1}{10^n} < \frac{1}{a} + \frac{1}{b}
$$

Therefore $10^n + 1 \leq a$. Moreover, if $a > 2 \cdot 10^n$ then $b > 2 \cdot 10^n$. Therefore

$$
\frac{1}{2 \cdot 10^n} + \frac{1}{2 \cdot 10^n} > \frac{1}{a} + \frac{1}{b} \\
\frac{1}{10^n} > \frac{1}{a} + \frac{1}{b} \\
$$

Thus $a \leq 2 \cdot 10^n$. Finally, let's figure out the structure of $a$. Suppose $(a, b)$ is a solution to the simpler equation. Then

$$
b = \frac{10^n \cdot a}{a - 10^n}
$$

Let $a' = a - 10^n$. Then $1 \leq a' \leq 10^n$. Moreover

$$
b = \frac{10^n \cdot (a' + 10^n)}{a'}
$$

Suppose $p$ is a prime such that $p \mid a'$. If $p \mid 10^n$ then $p = 2$ or $p = 5$. If $p \mid a' + 10^n$ then $p \mid 10^n$ and therefore $p = 2$ or $p = 5$. Thus $a' = 2^u 5^v$, where it is easy to see that $u \leq 2n, v \leq 2n$.

Thus an algorithm to solve this problem will:

- Construct all viable $a'$ for a given $n$
- Use that to constuct $a$ and $b$
- Calculate the number of divisors of the $\text{gcd}(a, b)$