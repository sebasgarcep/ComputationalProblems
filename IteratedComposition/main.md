# Iterated Composition

Let $\Bbb R^2$ be the set of pairs of real numbers $(x, y)$. Let $\pi = 3.14159\cdots\ $.

Consider the function $f$ from $\Bbb R^2$ to $\Bbb R^2$ defined by $f(x, y) = (x^2 - x - y^2, 2xy - y + \pi)$, and its $n$-th iterated composition $f^{(n)}(x, y) = f(f(\cdots f(x, y)\cdots))$. For example $f^{(3)}(x, y) = f(f(f(x, y)))$. A pair $(x, y)$ is said to have period $n$ if $n$ is the smallest positive integer such that $f^{(n)}(x, y) = (x, y)$.

Let $P(n)$ denote the sum of $x$-coordinates of all points having period not exceeding $n$.
Interestingly, $P(n)$ is always an integer. For example, $P(1) = 2$, $P(2) = 2$, $P(3) = 4$.

Find $P(10^7)$ and give your answer modulo $1\,020\,340\,567$.

## Solution

First define $f_1(x, y) = x^2 - x - y^2, f_2(x, y) = 2xy - y + \pi$. Then $f(x, y) = (f_1(x, y), f_2(x, y))$. Consider the function $g: \mathbb{C} \rightarrow \mathbb{C}$ given by $g(z) = z (z - 1) + i \pi$. Then

$$
\begin{align*}
g(x + iy)
&= (x + iy) (x + iy - 1) + i \pi \\
&= x^2 - x - y^2 + i (2xy - y + \pi) \\
&= f_1(x, y) + i f_2(x, y) \\
\end{align*}
$$

Therefore $(x, y)$ is a periodic point of $f$ if and only if $z = x + iy$ is a periodic point of $g$.

Now let $Q(n)$ denote the real part of the sum of the roots of $g^{n}(z) = z$ and let $R(n)$ denote the sum of $x$-coordinates of all points having period exactly $n$. Then $P(n) = \sum_{k=1}^n R(k)$ and $Q(n) = \sum_{d \mid n} R(d) \iff R(n) = \sum_{d \mid n} \mu(n/d) \, Q(d)$. Therefore

$$
\begin{align*}
P(n)
&= \sum_{k = 1}^n R(k) \\
&= \sum_{k = 1}^n \sum_{d \mid k} \mu(k/d) \, Q(d) \\
&= \sum_{d = 1}^n Q(d) \sum_{k = 1}^{\left\lfloor n/d \right\rfloor} \mu(k) \\
\end{align*}
$$

Note that $Q(n)$ can be found by inspection of $g^{n}(z) - z$. In particular, $g^{n}(z) - z$ has degree $2^n$ and if the coefficient of $z^{2^n - 1}$ is $c_n$ then $Q(n) = \Re(-c_n)$. If $n = 1$ then $Q(n) = 2$. If $n \gt 1$ then $Q(n)$ can be obtained by inspection of $g^{n}(z)$ alone. If $n = 2$ then $c_n = -2$ and therefore $Q(n) = 2$. Now suppose $n \gt 2$ and note that $g^{n}(z) = (g^{n-1}(z))^2 - (g^{n-1}(z)) + i \pi$. Because the degree of $g^{n-1}(z)$ is $2^{n-1}$ the linear and constant terms have no impact on the term of degree $2^{n} - 1$. Suppose $g^{n-1}(z) = z^{2^{n-1}} + c_{n-1} z^{2^{n-1}-1} + \dots$ Then

$$
(g^{n-1}(z))^2 = z^{2^n} + 2 c_{n-1} z^{2^n-1} + \dots
$$

Therefore $c_n = 2 c_{n-1}$ which implies $Q(n) = 2 Q(n-1)$ for $n \gt 2$.