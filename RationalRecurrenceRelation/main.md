# Rational Recurrence Relation

The following is a function defined for all positive rational values of $x$.

$$	f(x)=\begin{cases} x  & x\text{ is integral}\\
					f(\frac 1{1-x})	& x \lt 1\\
					f\Big(\frac 1{\lceil x\rceil -x}-1+f(x-1)\Big)	& \text{otherwise}\end{cases}	$$

For example, $f(3/2)=3$, $f(1/6) = 65533$ and $f(13/10) = 7625597484985$.

Find $f(22/7)$. Give your answer modulo $10^{15}$.

## Solution

Let

$$
g(a, b)
=
\begin{cases}
a/b & \text{if } \text{mod}(a, b) = 0 \\
g(b, b - a) & \text{if } \text{mod}(a, b) \not= 0 \text{ and } b \gt a \\
g(b + \text{mod}(-a, b) \cdot (g(a - b, b) - 1), \text{mod}(-a, b)) & \text{if } \text{mod}(a, b) \not= 0 \text{ and } a \gt b \\
\end{cases}
$$

Then $g(a, b) = f(a/b)$. Let's prove some formulas for $g$.

Clearly $g(n, 1) = n$.

Let's prove now that $g(2n+1, 2) = n + 2$. The base case is $g(1, 2) = g(2, 1) = 2$. Assume the statement is true up to $2n-1$. Then

$$
\begin{align*}
g(2n+1, 2)
&= g(2 + g(2n-1, 2) - 1, 1) \\
&= g(1 + n + 1, 1) \\
&= n + 2 \\
\end{align*}
$$

Let's prove now that $g(3n+1, 3) = g(3n+2, 3) = 2n + 3$. The base cases are $g(1, 3) = g(3, 2) = 3$ and $g(2, 3) = g(3, 1) = 3$. Now assume the statement is true up to $g(3(n - 1) + 1, 3)$. Then

$$
\begin{align*}
g(3n + 1, 3)
&= g(3 + 2 \cdot (g(3(n - 1) + 1, 3) - 1), 2) \\
&= g(3 + 2 \cdot (2(n - 1) + 3 - 1), 2) \\
&= g(4n + 3, 2) \\
&= g(2 \cdot (2n + 1) + 1, 2) \\
&= 2n + 3 \\
\end{align*}
$$

Let's prove now that $g(4n+1, 4) = 2^{n + 3} - 3$. The base case is $g(1, 4) = g(4, 3) = 5$. Now assume the statement is true up to $4(n-1)+1$. Then

$$
\begin{align*}
g(4n + 1, 4)
&= g(4 + 3 \cdot (g(4(n-1)+1, 4) - 1), 3) \\
&= g(4 + 3 \cdot (2^{n+2} - 3 - 1), 3) \\
&= g(3 \cdot 2^{n+2} - 8, 3) \\
&= g(3 \cdot (2^{n+2} - 3) + 1, 3) \\
&= 2 \cdot (2^{n+2} - 3) + 3 \\
&= 2^{n + 3} - 3 \\
\end{align*}
$$

Let's prove now that $g(5n+1, 5) = 2 \uparrow^2 (n+3) - 3$. The base case is $g(1, 5) = g(5, 4) = 2^4 - 3 = 2^{2^2} - 3$. Now assume the statement is true up to $5(n-1)+1$. Then

$$
\begin{align*}
g(5n+1, 5)
&= g(5 + 4 \cdot(g(5(n-1) + 1, 5) - 1), 4) \\
&= g(4 \cdot(2 \uparrow^2 (n+2) - 3) + 1, 4) \\
&= 2^{2 \uparrow^2 (n+2) - 3 + 3} - 3 \\
&= 2^{2 \uparrow^2 (n+2)} - 3 \\
&= 2 \uparrow (2 \uparrow^2 (n+2)) - 3 \\
&= 2 \uparrow^2 (n+3) - 3 \\
\end{align*}
$$

Let's prove now that $g(6n+1, 6) = 2 \uparrow^3 (n+3) - 3$. First let's show that $2 \uparrow^n 1 = 2, 2 \uparrow^n 2 = 4$. This is clearly true for $n = 1$. Now assume it is true up to $n-1$. Then

$$
\begin{align*}
2 \uparrow^n 1
&= 2 \uparrow^{n-1} (2 \uparrow^n 0) \\
&= 2 \uparrow^{n-1} 1 \\
&= 2 \\
\end{align*}
$$

And

$$
\begin{align*}
2 \uparrow^n 2
&= 2 \uparrow^{n-1} (2 \uparrow^n 1) \\
&= 2 \uparrow^{n-1} 2 \\
&= 4 \\
\end{align*}
$$

The base case is

$$
\begin{align*}
g(1, 6)
&= g(6, 5) \\
&= 2 \uparrow^2 4 - 3 \\
&= 2 \uparrow^2 (2 \uparrow^3 2) - 3 \\
&= 2 \uparrow^3 3 - 3 \\
\end{align*}
$$

Now assume the desired statement is true up to $6(n-1)+1$. Then

$$
\begin{align*}
g(6n+1, 6)
&= g(6 + 5 \cdot (g(6(n-1) + 1, 6) - 1), 5) \\
&= g(5 \cdot (g(6(n-1) + 1, 6)) + 1, 5) \\
&= 2 \uparrow^2 (g(6(n-1) + 1, 6) + 3) - 3 \\
&= 2 \uparrow^2 (2 \uparrow^3 (n+2) - 3 + 3) - 3 \\
&= 2 \uparrow^2 (2 \uparrow^3 (n+2)) - 3 \\
&= 2 \uparrow^3 (n+3) - 3 \\
\end{align*}
$$

Let's prove now that $g(7n+1, 7) = 2 \uparrow^4 (n+3) - 3$. The base case is

$$
\begin{align*}
g(1, 7)
&= g(7, 6) \\
&= 2 \uparrow^3 4 - 3 \\
&= 2 \uparrow^3 (2 \uparrow^4 2) - 3 \\
&= 2 \uparrow^4 3 - 3 \\
\end{align*}
$$

Assume the statement is true up to $7(n-1)+1$. Then

$$
\begin{align*}
g(7n+1, 7)
&= g(7 + 6 \cdot (g(7(n-1) + 1, 7) - 1), 6) \\
&= g(6 \cdot (g(7(n-1) + 1, 7)) + 1, 6) \\
&= 2 \uparrow^3 (g(7(n-1) + 1, 7) + 3) - 3 \\
&= 2 \uparrow^3 (2 \uparrow^4 (n+2) - 3 + 3) - 3 \\
&= 2 \uparrow^3 (2 \uparrow^4 (n+2)) - 3 \\
&= 2 \uparrow^4 (n+3) - 3 \\
\end{align*}
$$

Therefore $g(22, 7) = 2 \uparrow^4 6 - 3$, which can be computed modulo $10^{15}$ using the same method as in The Ackermann Function.
