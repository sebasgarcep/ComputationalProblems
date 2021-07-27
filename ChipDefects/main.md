# Chip Defects

<p>
<var>k</var> defects are randomly distributed amongst <var>n</var> integrated-circuit chips produced by a factory (any number of defects may be found on a chip and each defect is independent of the other defects).
</p>
<p>
Let p(<var>k,n</var>) represent the probability that there is a chip with at least 3 defects.<br />
For instance p(3,7) ≈ 0.0204081633.
</p>
<p>
Find p(20 000, 1 000 000) and give your answer rounded to 10 decimal places in the form 0.abcdefghij
</p>

## Solution

The generating function for this problem is:

$$
(\frac{1}{n} y_1 + \frac{1}{n} y_2 + \dots + \frac{1}{n} y_n)^k = \sum_{z_1 + z_2 + \dots + z_n = k} \frac{1}{n^k} { k \choose z_1, z_2, \dots, z_n } y_1^{z_1} y_2^{z_2} \dots y_n^{z_n}
$$

where the right-hand side is a result of the multinomial theorem. The result is the sum of the coefficients where at least one $y_i$ has exponent greater than $3$. It is easy to see that all coefficients add up to $1$. Therefore we can calculate only the coefficients for the terms where all $y_i$ have exponent equal to $2$ or less and then compute the complement.

Suppose that $x_1$ is the number of $z_i = 1$ and $x_2$ is the number of $z_i = 2$. Then $x_1 + 2 x_2 = k$. Then there are

$$
{n \choose x_1, x_2, n - x_1 - x_2}
$$

terms for a given $(x_1, x_2)$. Additionally, for a given $(x_1, x_2)$ we have

$$
{ k \choose z_1, z_2, \dots, z_n } = \frac{k!}{1!^{x_1} 2!^{x_2}} = \frac{k!}{2^{x_2}}
$$

Combining everything we get:

$$
\sum_{x_1 + 2 x_2 = k} {n \choose x_1, x_2, n - x_1 - x_2} \frac{k!}{2^{x_2}} \frac{1}{n^k}
$$

Let

$$
t_{n,k}(x_1, x_2) = {n \choose x_1, x_2, n - x_1 - x_2} \frac{k!}{2^{x_2}} \frac{1}{n^k}
$$

Then the sum reduces to

$$
\sum_{x_1 + 2 x_2 = k} t_{n,k}(x_1, x_2)
$$

Finally, to optimize this calculation note that we will calculate the terms in the following order:

$$
t_{n,k}(k, 0) \rightarrow t_{n,k}(k - 2, 1) \rightarrow \dots \rightarrow t_{n,k}(x_1, x_2) \rightarrow t_{n,k}(x_1 - 2, x_2 + 1) \rightarrow \dots
$$

Therefore if we can find a recurrence relation between these terms, we can compute the next one, from the previous one in constant time. Notice that:

$$
t_{n,k}(k, 0) = { n \choose k } \frac{k!}{n^k} = \frac{n!}{(n - k)! n^k} = \prod_{i = n - k + 1}^n \frac{i}{n}
$$

And the recurrence relation is given by:

$$
\begin{align*}
t_{n,k}(x_1 - 2, x_2 + 1) &= {n \choose x_1 - 2, x_2 + 1, n - (x_1 - 2) - (x_2 + 1)} \frac{k!}{2^{x_2 + 1}} \frac{1}{n^k} \\
&= \frac{n!}{(x_1 - 2)! (x_2 + 1)! (n - x_1 - x_2 + 1)!} \frac{k!}{2^{x_2 + 1}} \frac{1}{n^k} \\
&= \frac{n!}{x_1! x_2! (n - x_1 - x_2)!} \frac{k!}{2^{x_2}} \frac{1}{n^k} \frac{(x_1 - 1) x_1}{2 \cdot (x_2 + 1) \cdot (n - x_1 - x_2 + 1)} \\
&= {n \choose x_1, x_2, n - x_1 - x_2} \frac{k!}{2^{x_2}} \frac{1}{n^k} \frac{(x_1 - 1) x_1}{2 \cdot (x_2 + 1) \cdot (n - x_1 - x_2 + 1)} \\
&= t_{n,k}(x_1, x_2) \frac{(x_1 - 1) x_1}{2 \cdot (x_2 + 1) \cdot (n - x_1 - x_2 + 1)} \\
\end{align*}
$$
