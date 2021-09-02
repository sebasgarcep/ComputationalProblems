# A real recursion


For every real number $a \gt 1$ is given the sequence $g_a$ by:<br />
$g_{a}(x)=1$ for $x \lt a$<br />
$g_{a}(x)=g_{a}(x-1)+g_a(x-a)$ for $x \ge a$<br />

$G(n)=g_{\sqrt {n}}(n)$<br />
$G(90)=7564511$.

Find $\sum G(p)$ for $p$ prime and $10000000 \lt p \lt 10010000$<br />
Give your answer modulo 1000000007.

## Solution

### Lemma 1

Let $k \geq 1, r \geq 0$. Then

$$
\sum_{i = 0}^{k - 1} {i + r \choose r} = {k + r \choose r + 1 }
$$

#### Proof

Fix a value of $r$. Let $k = 1$. Then

$$
{r \choose r} = {r + 1 \choose r + 1} = 1
$$

Now let $k \geq 2$. Suppose the theorem is true for $1, \dots, k - 1$. Then

$$
\begin{align*}
\sum_{i = 0}^{k - 1} {i + r \choose r}
&= \sum_{i = 0}^{k - 2} {i + r \choose r} + {k - 1 + r \choose r} \\
&= {k - 1 + r \choose r + 1} + {k - 1 + r \choose r} \\
&= {k + r \choose r + 1} \\
\end{align*}
$$

### Redefining $g_{\sqrt{n}}(x)$

Fix a value of $n$. From the recurrence relation for $g_{\sqrt{n}}$ we can infer that the inputs to this function will be of the form $a - b \sqrt{n}$. Let's create an equivalent function $g_{\sqrt{n}}(a,b)=g_{\sqrt{n}}(a-b\sqrt{n})$ Then the base case for this function will happen when $a - b \sqrt{n} < \sqrt{n} \Rightarrow a^2 < (b + 1)^2 n$. Moreover, the recurrence relation will be $g_{\sqrt{n}}(a,b)=g_{\sqrt{n}}(a-1,b)+g_{\sqrt{n}}(a,b+1)$. Finally, $G(n) = g_{\sqrt{n}}(n,0)$.

### Calculating $G(n)$

Notice that

$$
g_{\sqrt{n}}(x,0)=g_{\sqrt{n}}(x,1)+g_{\sqrt{n}}(x-1,0)=g_{\sqrt{n}}(x,1)+g_{\sqrt{n}}(x-1,1)+g_{\sqrt{n}}(x-2,0) = \dots = 1 + \sum_{k = 0}^{L-1} g_{\sqrt{n}}(x-k,1)
$$

where $L$ is given by the number of iterations needed before reaching the base case of $g_{\sqrt{n}}(x-k,0)$. Now let's find a way to calculate $\sum_{k = 0}^{L_{b-1}-1} c(k, b) \cdot g_{\sqrt{n}}(x-k,b)$, where $L_{b-1}$ indicates the number of iterations needed to reach the base case of $g_{\sqrt{n}}(x-k,b-1)$ and $c(k,b)$ is the coefficient of $g_{\sqrt{n}}(x-k,b)$. Clearly

$$
\sum_{k = 0}^{L_{b-1}-1} c(k, b) \cdot g_{\sqrt{n}}(x-k,b) = \sum_{k = 0}^{L_{b}-1} c(k, b) \cdot g_{\sqrt{n}}(x-k,b) + \sum_{k = L_{b}}^{L_{b-1}-1} c(k,b)
$$

where $L_b$ indicates the number of iterations needed to reach the base case of $g_{\sqrt{n}}(x-k,b)$. On one hand

$$
\begin{align*}
\sum_{k = 0}^{L_{b}-1} c(k, b) \cdot g_{\sqrt{n}}(x-k,b)
&= \sum_{k = 0}^{L_{b}-1} \sum_{i = 0}^{k} c(i, b) \cdot g_{\sqrt{n}}(x-k,b+1) + \sum_{k=0}^{L_{b}-1} c(k,b) \cdot g_{\sqrt{n}}(x-L_b,b) \\
&= \sum_{k = 0}^{L_{b}-1} \sum_{i = 0}^{k} c(i, b) \cdot g_{\sqrt{n}}(x-k,b+1) + \sum_{k=0}^{L_{b}-1} c(k,b) \\
\end{align*}
$$

Therefore $c(k,b+1) = \sum_{i = 0}^{k} c(i, b)$. Notice that $c(k,1)=1={k \choose 0}$. Therefore $c(k,b)={k + b - 1 \choose b - 1}$ satisfies the initial condition and Lemma 1 shows that $c(k,b)$ satisfies the recurrence relation we just proved.

Adding both remainders we get

$$
\sum_{k = 0}^{L_{b}-1} c(k,b) + \sum_{k = L_{b}}^{L_{b-1}-1} c(k,b) = \sum_{k = 0}^{L_{b-1}-1} {k + b - 1 \choose b - 1} = {L_{b-1} + b \choose b}
$$

Therefore

$$
G(n) = 1 + \sum_b {L_{b-1} + b \choose b}
$$

### Optimization

We can memoize all values of $n!$ modulo $p$ for $n \leq N$. Then calculating the binomial coefficients can be done efficiently. An appropiate choice of $N$ will optimize the number of factorials we need to store.