# Delphi Flip

A and B play a game. A has originally $1$ gram of gold and B has an unlimited amount.
Each round goes as follows:


- A chooses and displays, $x$, a nonnegative real number no larger than the amount of gold that A has.
- Either B chooses to TAKE. Then A gives B $x$ grams of gold.
- Or B chooses to GIVE. Then B gives A $x$ grams of gold.

B TAKEs $n$ times and GIVEs $n$ times after which the game finishes.

Define $g(X)$ to be the smallest value of $n$ so that A can guarantee to have at least $X$ grams of gold at the end of the game. You are given $g(1.7) = 10$.

Find $g(1.9999)$.

## Solution

Let $f(G, T)$ be the maximum amount of gold you can guarantee to have after $G$ gives and $T$ takes if you start with $1$ gold. Then $g(X) = \min \{ n \in \mathbb{N}_0 : f(n, n) \ge X \}$. Notice that

- $f(0, 0) = 1$
- $f(G, 0) = 2^G$
- $f(0, T) = 1$

Furthermore, $f$ must satisfy the following for $G, T > 0$

$$
f(G, T) = \max_{x \in [0, 1]} \min((1 - x) \cdot f(G, T - 1), (1 + x) \cdot f(G - 1, T))
$$

Firstly, $f(G, T - 1)$ and $f(G - 1, T)$ are independent of the choice of $x$ as this variable only scales the input gold to the next step. Then for a fixed $G, T$, we have that $f(G, T - 1), f(G - 1, T)$ are constants. This implies that the input to the $\min$ function is a pair of linear functions, one increasing and the other decreasing. Therefore, the minimum of both functions is maximum at their intersection (or at $0$ or $1$ if the intersection lies outside the range for $x$). Then

$$
(1 - x') \cdot f(G, T - 1) = (1 + x') \cdot f(G - 1, T) \\
\Rightarrow x' = \frac{f(G, T - 1) - f(G - 1, T)}{f(G, T - 1) + f(G - 1, T)}
$$

Because one can end with $1$ gold if one chooses to always bet $0$, then $f(G, T) \ge 1$. Therefore

$$
\begin{align*}
f(G, T - 1) - f(G - 1, T)
&\le f(G, T - 1) \\
&\le f(G, T - 1) + f(G - 1, T)
\end{align*}
$$

which implies that $x' \le 1$. Notice that proving that $x' \in [0, 1]$ implies that the intersection $x'$ is always the maximum, in which case we can substitute the value of $x'$ to compute $f(G, T)$ as

$$
f(G, T) = \frac{2 \cdot f(G, T - 1) \cdot f(G - 1, T)}{f(G, T - 1) + f(G - 1, T)}
$$

Now let's prove that $0 \le x'$. Suppose we want to prove this for a given $G, T$ and we have already proven it for all $G', T'$ such that $1 \le G' \le G, 1 \le T' \le T$ and either $G' \not= G$ or $T' \not= T$. Then

$$
0 \le x' \iff 0 \le f(G, T - 1) - f(G - 1, T)
$$

If $T = 1$ then $f(G, T - 1) = f(G, 0) = 2^G$. But $f(G - 1, T) \le 2^{G-1} \lt 2^G$, which proves our statement. If $G = 1$ then $f(G - 1, T) = f(0, T) = 1$, but $f(G, T - 1) \ge 1$ which again proves our statement. Now suppose that neither of these is the case. Then

$$
\begin{align*}
&\iff 0 \le f(G, T - 1) - f(G - 1, T) \\
&\iff 0 \le \frac{2 \cdot f(G, T - 2) \cdot f(G - 1, T - 1)}{f(G, T - 2) + f(G - 1, T - 1)} - \frac{2 \cdot f(G - 1, T - 1) \cdot f(G - 2, T)}{f(G - 1, T - 1) + f(G - 2, T)} \\
&\iff 0 \le f(G, T - 2) \cdot (f(G - 1, T - 1) + f(G - 2, T)) - f(G - 2, T) \cdot (f(G, T - 2) + f(G - 1, T - 1)) \\
&\iff 0 \le f(G, T - 2) - f(G - 2, T) \\
&\iff 0 \le f(G, T - 2) - f(G - 1, T - 1) + f(G - 1, T - 1) - f(G - 2, T) \\
\end{align*}
$$

But both $f(G, T - 2) - f(G - 1, T - 1)$ and $f(G - 1, T - 1) - f(G - 2, T)$ must be nonnegative as these are the preconditions for the intersections of $f(G, T - 1)$ and $f(G - 1, T)$, respectively, to be in the range $[0, 1]$.

This concludes our proof for $0 \le x'$, which implies the formula for $f(G, T)$. Note that the formula for $f(G, T)$ can be rewritten as

$$
f(G, T) = \frac{2}{\frac{1}{f(G, T - 1)} + \frac{1}{f(G - 1, T)}}
$$

Let $h(G, T)$ be the reciprocal of $f(G, T)$. Then

- $h(0, 0) = 1$
- $h(G, 0) = 2^{-G}$
- $h(0, T) = 1$
- $h(G, T) = \frac{h(G, T - 1) + h(G - 1, T)}{2}$

Let's prove that the closed form for $h$ is

$$
h(G, T) = \frac{\sum_{i = G}^{G + T} \binom {G + T} i}{2^{G + T}}
$$

If $G = T = 0$ then

$$
h(0, 0) = \frac{\binom 0 0}{2^0} = 1
$$

If $T = 0$ then

$$
h(G, 0) = \frac{\binom G G}{2^G} = 2^{-G}
$$

If $G = 0$ then

$$
h(0, T) = \frac{\sum_{i = 0}^T \binom T i}{2^T} = \frac{2^T}{2^T} = 1
$$

Finally, if $G, T \gt 0$ then by induction one can prove

$$
\begin{align*}
h(G, T)
&= \frac{h(G, T - 1) + h(G - 1, T)}{2} \\
&= \frac{\frac{\sum_{i = G}^{G + T - 1} \binom {G + T - 1} i}{2^{G + T - 1}} + \frac{\sum_{i = G - 1}^{G + T - 1} \binom {G + T - 1} i}{2^{G + T - 1}}}{2} \\
&= \frac{\sum_{i = G}^{G + T - 1} \binom {G + T - 1} i + \sum_{i = G - 1}^{G + T - 1} \binom {G + T - 1} i}{2^{G + T}} \\
&= \frac{\sum_{i = G}^{G + T - 1} \binom {G + T - 1} i + \sum_{i = G}^{G + T} \binom {G + T - 1} {i - 1}}{2^{G + T}} \\
&= \frac{\sum_{i = G}^{G + T - 1} \left[ \binom {G + T - 1} i + \binom {G + T - 1} {i - 1} \right] + \binom {G + T - 1} {G + T - 1}}{2^{G + T}} \\
&= \frac{\sum_{i = G}^{G + T - 1} \binom {G + T} i + 1}{2^{G + T}} \\
&= \frac{\sum_{i = G}^{G + T} \binom {G + T} i}{2^{G + T}} \\
\end{align*}
$$

which proves the formula for $h$. Setting $G = T = n$ we get

$$
\begin{align*}
h(n, n)
&= \frac{\sum_{i = n}^{2n} \binom {2n} i}{2^{2n}} \\
&= \frac{2 \sum_{i = n}^{2n} \binom {2n} i}{2^{2n+1}} \\
&= \frac{2 \sum_{i = n+1}^{2n} \binom {2n} i + 2 \binom {2n} n}{2^{2n+1}} \\
&= \frac{\sum_{i = 0}^{n-1} \binom {2n} i + \sum_{i = n+1}^{2n} \binom {2n} i + 2 \binom {2n} n}{2^{2n+1}} \\
&= \frac{\sum_{i = 0}^{2n} \binom {2n} i + \binom {2n} n}{2^{2n+1}} \\
&= \frac{2^{2n} + \binom {2n} n}{2^{2n+1}} \\
\end{align*}
$$

Which proves that

$$
\begin{align*}
f(n, n)
&= \frac{2^{2n+1}}{2^{2n} + \binom {2n} n} \\
&= \frac{2}{1 + \frac{\binom {2n} n}{2^{2n}}} \\
\end{align*}
$$


Let $t(n) = \frac{\binom {2n} n}{2^{2n}}$. Then for $n \ge 1$

$$
\begin{align*}
t(n + 1)
&= \frac{\binom {2n+2} {n+1}}{2^{2n+2}} \\
&= \frac{\frac{(2n + 2) \cdots (n+2)}{1 \cdots n \cdot (n + 1)}}{2^{2n}} \cdot \frac{1}{4} \\
&= \frac{\frac{(2n) \cdots (n+1)}{1 \cdots n}}{2^{2n}} \cdot \frac{\frac{(2n + 2) \cdot (2n + 1)}{(n+1)^2}}{4} \\
&= \frac{\binom {2n} n}{2^{2n}} \cdot \frac{(2n + 2) \cdot (2n + 1)}{4(n+1)^2} \\
&= t(n) \cdot \frac{(2n + 2) \cdot (2n + 1)}{4(n+1)^2} \\
\end{align*}
$$

and $t(0) = 1$. Then $g(X)$ can be found by using $t(n-1)$ and $n-1$ to construct $t(n)$. With $t(n)$ we can compute $f(n, n)$. If $f(n, n) \ge X$ then we stop. Otherwise we keep iterating on $n$.