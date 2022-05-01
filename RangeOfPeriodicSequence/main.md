# Range of periodic sequence

Consider the sequence of real numbers $a_n$ defined by the starting value $a_0$ and the recurrence
$\displaystyle a_{n+1}=a_n-\frac 1 {a_n}$ for any $n  \ge 0$.

For some starting values $a_0$ the sequence will be periodic. For example, $a_0=\sqrt{\frac 1 2}$ yields the sequence:
$\sqrt{\frac 1 2},-\sqrt{\frac 1 2},\sqrt{\frac 1 2}, \dots$

We are interested in the range of such a periodic sequence which is the difference between the maximum and minimum of the sequence. For example, the range of the sequence above would be $\sqrt{\frac 1 2}-(-\sqrt{\frac 1 2})=\sqrt{ 2}$.

Let $S(P)$ be the sum of the ranges of all such periodic sequences with a period not exceeding $P$.<br />
For example, $S(2)=2\sqrt{2} \approx 2.8284$, being the sum of the ranges of the two sequences starting with $a_0=\sqrt{\frac 1 2}$ and $a_0=-\sqrt{\frac 1 2}$. <br />
You are given $S(3) \approx 14.6461$ and $S(5) \approx 124.1056$.

Find $S(25)$, rounded to 4 decimal places.

## Solution

Suppose $x$ has period $P$. Then $x = a_0 = a_P$. This fact can be used to find a polynomial expression in terms of $x$ as follows

$$
\begin{align*}
x
&= a_P \\
&= a_{P-1} - \frac{1}{a_{P-1}} \\
&= a_{P-2} - \frac{1}{a_{P-2}} - \frac{1}{a_{P-2} - \frac{1}{a_{P-2}}} \\
&\dots \\
\end{align*}
$$

and we can keep going until we reach an expression that uses only $a_0$ at which point we can substitute $a_0$ with $x$, which leaves a rational expression in terms of $x$. This expression can be simplified into a polynomial equation in terms of $x$, and solving this polynomial (taking into account some restrictions) gives us all real numbers with period $P$.

Let $f_0(x) = x, f_{n+1}(x) = f_n(x) - \frac{1}{f_n(x)}$. Then we want to find all solutions to $x = f_P(x)$. Let $f_n(x) = \frac{g_n(x)}{h_n(x)}$ for some coprime polynomials $g_n(x), h_n(x) \in \mathbb{Z}[x]$. Then $g_0(x) = x, h_0(x) = 1$. Furthermore

$$
\begin{align*}
& \: f_{n+1}(x) = f_n(x) - \frac{1}{f_n(x)} \\
\Rightarrow & \: \frac{g_{n+1}(x)}{h_{n+1}(x)} = \frac{g_n(x)}{h_n(x)} - \frac{h_n(x)}{g_n(x)} \\
\Rightarrow & \: \frac{g_{n+1}(x)}{h_{n+1}(x)} = \frac{g_n^2(x) - h_n^2(x)}{g_n(x) h_n(x)} \\
\end{align*}
$$

Suppose $d(x)$ is an irreducible polynomial such that it divides both $g_n^2(x) - h_n^2(x) = (g_n(x) - h_n(x)) (g_n(x) + h_n(x))$ and $g_n(x) h_n(x)$. Because $\mathbb{Z}$ is an unique factorization domain, then $\mathbb{Z}[x]$ must be too. This implies that $d(x)$ divides either $g_n(x)$ or $h_n(x)$ and also that it must divide either $g_n(x) - h_n(x)$ or $g_n(x) + h_n(x)$. Suppose that $d(x)$ divides $g_n(x)$ and $g_n(x) - h_n(x)$. Then it must also divide $h_n(x)$ which implies $d(x) = 1$, as $g_n(x)$ and $h_n(x)$ are coprime. The remaining three cases use an analogous argument. This proves that $g_n^2(x) - h_n^2(x)$ and $g_n(x) h_n(x)$ are coprime, which allows us to state that

$$
g_{n+1}(x) = g_n^2(x) - h_n^2(x) \\
h_{n+1}(x) = g_n(x) h_n(x) \\
$$

Now notice that $x = f_n(x) \Rightarrow  x h_n(x) - g_n(x) = 0$. Let $r_n(x) = x h_n(x) - g_n(x)$. Then we want to find the roots $y$ of $r_n(x)$ for which $h_n(y) \not= 0$. Let's prove that any root of $r_n(x)$ satisfies the second condition. This is clearly true for $n = 0$. Assume it is true for $n-1$ and let $y$ be a root of $r_n(x)$ such that $h_n(y) = 0$. Then $y h_n(y) - g_n(y) = 0 \Rightarrow g_n(y) = 0$. The fact that $h_n(y) = 0$ implies that either $g_{n-1}(y) = 0$ or $h_{n-1}(y) = 0$. But $g_n(y) = 0 \Rightarrow g_{n-1}^2(y) = h_{n-1}^2(y)$ and therefore if one of those is zero, the other must be. But $h_{n-1}(y) = g_{n-1}(y) = 0$ implies $r_{n-1}(y) = 0$, which is a contradiction as the induction hypothesis assumes that this can never be the case for $n-1$. Therefore any root of $r_n(x)$ will not be a root of $h_n(x)$.

For $s(x) \in \mathbb{Z}[x]$ let $s_O(x)$ be the sum of the terms of $s(x)$ for which the exponent of $x$ is odd and let $s_E(x)$ be the sum of the terms of $s(x)$ for which the exponent of $x$ is even. Let's prove that $h_{n, E}(x) = 0$ and $g_{n, O}(x) = 0$ for all $n \ge 0$. This is clearly true for $n = 0$. Now assume it is true for $n-1$. Then

$$
\begin{align*}
h_{n, E}(x)
&= g_{n-1, E}(x) h_{n-1, E}(x) + g_{n-1, O}(x) h_{n-1, O}(x) \\
&= g_{n-1, E}(x) \cdot 0 + 0 \cdot h_{n-1, O}(x) \\
&= 0 \\
\end{align*}
$$

and

$$
\begin{align*}
g_{n, O}(x)
&= g_{n-1, O}(x) g_{n-1, E}(x) - h_{n-1, O}(x) h_{n-1, E}(x) \\
&= 0 \cdot g_{n-1, E}(x) - h_{n-1, O}(x) \cdot 0 \\
&= 0 \\
\end{align*}
$$

Therefore $r_{n,O}(x) = x h_{n, E}(x) - g_{n, O}(x) = 0$, which implies the existence of a polynomial $r_n'(x)$ such that $r_n(x) = r_n'(x^2)$. This implies that if $y$ is a root of $r_n(x)$ then so is $-y$, which allows us to reduce the search time for roots of $r_n(x)$ by half.

## Notes

- Apparently all roots of $r_n(x)$ that belong to the same irreducible factor have the same range??? Could this be related to the minimal polynomial of a root???
- If $0 \lt a_n$ then $a_{n+1} = a_n - \frac{1}{a_n} \lt a_n$, otherwise $a_{n+1} \gt a_n$.