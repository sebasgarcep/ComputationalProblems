# Sum of digits - experience #23

<p>
For a positive integer k, define d(k) as the sum of the digits of k in its usual decimal representation.
Thus d(42) = 4+2 = 6.
</p>
<p>
For a positive integer n, define S(n) as the number of positive integers k &lt; 10<sup>n</sup> with the following properties :
</p><ul><li>k is divisible by 23 and
</li><li>d(k) = 23.
</li></ul>
You are given that S(9) = 263626 and S(42) = 6377168878570056.

<p>
Find S(11<sup>12</sup>) and give your answer mod 10<sup>9</sup>.
</p>

## Solution

Define $f_p(n, u, v)$ for a prime $p \not= 2, 5$ to be the number of positive integers $10^{n-1} \le k \lt 10^n$ such that $d(k) = u$ and $k \equiv v \pmod p$.

$$
\begin{align*}
f_p(n, u, v)
&= \sum_{\substack{0 \le r \le 9 \\ u' + r = u \\ 10v' + r \equiv v \pmod p}} f_p(n - 1, u', v') \\
\end{align*}
$$

Let $\hat{f}_p(n)$ be the vector representation of $f_p(n, \cdot, \cdot)$ and let $A_p$ be the transition matrix such that $\hat{f}_p(n) = A_p \hat{f}_p(n-1)$. Then $\hat{f}_p(n) = A^{n-1}_p \hat{f}_p(1)$. Let

$$
\hat{r}_p(n) = \sum_{k = 1}^n \hat{f}_p(k)
$$

Then $S(n)$ is equal to the entry of $\hat{r}_{23}(n)$ that corresponds to $d(k) = 23$ and $k \equiv 0 \pmod p$. So our problem reduces to efficiently computing $\hat{r}_p(n)$. Notice that

$$
\hat{r}_p(n) = \sum_{k = 1}^n \hat{f}_p(k) = \sum_{k = 1}^n A^{k - 1} \hat{f}_p(1) = \sum_{k = 0}^{n-1} A^k \hat{f}_p(1)
$$

And we can efficiently calculate $\sum_{k = 0}^{n-1} A^k$ with a recursion. Let $f_n(x) = \sum_{k = 0}^{n} x^n$. Then

$$
\begin{align*}
f_{2n + 1}(x)
&= 1 + x + x^2 + \dots + x^{2n + 1} \\
&= (1 + x^2 + \dots + x^{2n}) + (x + x^3 + \dots + x^{2n+1}) \\
&= (1 + x^2 + \dots + x^{2n}) + x (1 + x^2 + \dots + x^{2n}) \\
&= (1 + x) (1 + x^2 + \dots + x^{2n}) \\
&= (1 + x) f_n(x^2) \\
\end{align*}
$$

Thus $f_n$ satisfies the following recursion

$$
f_0(x) = 1 \\
f_1(x) = 1 + x \\
f_{2n}(x) = f_{2n-1}(x) + x^{2n} \\
f_{2n + 1}(x) = (1 + x) f_n(x^2) \\
$$

### References

- https://math.stackexchange.com/questions/1108452/singular-matrix-geometric-sum
