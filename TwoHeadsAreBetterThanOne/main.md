# Two Heads Are Better Than One

An unbiased coin is tossed repeatedly until two consecutive heads are obtained. Suppose these occur on the $(M-1)$th and $M$th toss.<br />
Let $P(n)$ be the probability that $M$ is divisible by $n$. For example, the outcomes HH, HTHH, and THTTHH all count towards $P(2)$, but THH and HTTHH do not.

You are given that $P(2) =\frac 3 5$ and $P(3)=\frac 9  {31}$. Indeed, it can be shown that $P(n)$ is always a rational number.

For a prime $p$ and a fully reduced fraction $\frac a b$, define $Q(\frac a b,p)$ to be the smallest positive $q$ for which $a \equiv b q \pmod{p}$.<br />
For example $Q(P(2), 109) = Q(\frac 3 5, 109) = 66$, because $5 \cdot 66 = 330 \equiv 3 \pmod{109}$ and 66 is the smallest positive such number.<br />
Similarly $Q(P(3),109) = 46$.

Find $Q(P(10^{18}),1\,000\,000\,009)$.

## Solution

Let $F(x)$ be the probability that $M = x$. Then $P(n) = \sum_{k \geq 1} F(kn)$. Let's find $F(x)$ now. Clearly $F(1) = 0, F(2) = 1/4$. Assume $x \geq 3$. Then a string of length $x$ ends in $011$, which has a probability of $1/8$. Let $T(x)$ be the probability associated with a binary string of length $x$ where heads never comes up twice in a row. Then $F(x) = 1/8 \cdot T(x - 3)$. Let's find an expression for $T(x)$.

Notice that the following recurrence holds for $T(x)$:

$$
T(x) = 1/2 \cdot T(x - 1) + 1/4 \cdot T(x - 2)
$$

The first term arises from the fact that if the string starts with $0$ (which has probability $1/2$), then there are no additional restrictions on the remaining string of length $x - 1$. The second term arises from the fact that if the string starts with $1$, then it must be followed by a $0$. This prefix has probability $1/4$, but once we take out this prefix no additional restrictions are placed on the remaining string of length $x - 2$.

This is a linear recurrence relation, which are trivial to solve using the associated polynomial and initial values $T(0) = 1, T(1) = 1$:

$$
T(x) = \frac{5 + 3 \sqrt{5}}{10} \cdot (\frac{1 + \sqrt{5}}{4})^x + \frac{5 - 3 \sqrt{5}}{10} \cdot (\frac{1 - \sqrt{5}}{4})^x
$$

Setting

$$
c_1 = \frac{5 + 3 \sqrt{5}}{10} \\\
y_1 = \frac{1 + \sqrt{5}}{4} \\
c_2 = \frac{5 - 3 \sqrt{5}}{10} \\
y_2 = \frac{1 - \sqrt{5}}{4} \\
$$

we get the more manageable expression $T(x) = c_1 y_1^x + c_2 y_2^x$. Now, let's compute $P(n)$

$$
\begin{align*}
P(n)
&= \sum_{k \geq 1} F(kn) \\
&= \sum_{k \geq 1} 1/8 \cdot T(kn - 3) \\
&= 1/8 \sum_{k \geq 1} [ c_1 y_1^{kn - 3} + c_2 y_2^{kn - 3} ] \\
&= c_1 / 8 \sum_{k \geq 1}  y_1^{kn - 3} + c_2 / 8 \sum_{k \geq 1} y_2^{kn - 3} \\
&= c_1 / 8 \sum_{k \geq 1}  y_1^{(k - 1)n + n - 3} + c_2 / 8 \sum_{k \geq 1} y_2^{(k - 1)n + n - 3} \\
&= c_1 \cdot y_1^{n - 3} / 8 \sum_{k \geq 0}  y_1^{kn} + c_2 \cdot y_2^{n - 3} / 8 \sum_{k \geq 0} y_2^{kn} \\
&= \frac{c_1 \cdot y_1^{n - 3}}{8 (1 - y_1^n)} + \frac{c_2 \cdot y_2^{n - 3}}{8 (1 - y_2^n)}\\
\end{align*}
$$

Substituting back the numerical values of $c_1, y_1, c_2, y_2$ and straightforward simplification leaves us with

$$
P(n) = \frac{64}{80} \cdot \frac{4^n((5 + 3 \sqrt{5}) \cdot (1 + \sqrt{5})^{n-3} + (5 - 3 \sqrt{5}) \cdot (1 - \sqrt{5})^{n-3}) + (-4)^{n-3} \cdot 80}{4^{2n} - 4^n((1 + \sqrt{5})^n + (1 - \sqrt{5})^n) + (-4)^n}
$$

It is easy to see from the binomial theorem that $(1+\sqrt{5})^n + (1-\sqrt{5})^n \in \mathbb{Z}$ and $(1+\sqrt{5})^n - (1-\sqrt{5})^n \in \mathbb{Z}\sqrt{5}$, therefore the numerator and denominator of the previous expression are integers. In particular, if $P(n) = a/b$, where $\text{gcd}(a, b) = 1$. Then the previous expression is of the form $(ka) / (kb)$ for some integer $k$.

Finally notice that $Q(a/b, p) = a b^{-1} \: \text{(mod p)} = ka (kb)^{-1} \: \text{(mod p)}$. Therefore we can compute the numerator and denominator of the previous expression modulo $p$ to find $Q$. In our solution we will implement an algorithm that performs mathematical calculations on $\mathbb{Z}_p [\sqrt{5}]$. It can be proven that this is equivalent to calculating the value of the numerator and denominator and then applying the moduli.