# The Ackermann Function

For non-negative integers $m$, $n$, the Ackermann function $A(m,n)$ is defined as follows:

$$
A(m,n) =
\begin{cases}
n+1 & \text{ if  } m=0 \\
A(m-1,1) & \text{ if   } m > 0 \text{  and  } n=0 \\
A(m-1,A(m,n-1)) & \text{ if   }m > 0 \text{  and  } n > 0 \\
\end{cases}
$$

For example $A(1,0) = 2$, $A(2,2) = 7$ and $A(3,4) = 125$.

Find $\displaystyle\sum_{n=0}^6 A(n,n)$ and give your answer mod $14^8$.

## Solution

The Knuth up-arrow is the following operation:

$$
a \uparrow^n b
=
\begin{cases}
a^b & \text{if } n = 1 \\
1 & \text{if } n > 1 \text{ and } b = 0 \\
a \uparrow^{n-1} (a \uparrow^n (b - 1)) & \text{otherwise} \\
\end{cases}
$$

Clearly $A(0, n) = n + 1$.

Let's prove $A(1, n) = n + 2$. Note that $A(1, 0) = A(0, 1) = 2$ which proves the base case. Assume the statement is true for $n-1$. Then $A(1, n) = A(0, A(1, n-1)) = A(0, n+1) = n + 2$.

Let's prove $A(2, n) = 2n + 3$. Note that $A(2, 0) = A(1, 1) = 3$ which proves the base case. Assume the statement is true for $n-1$. Then $A(2, n) = A(1, A(2, n-1)) = A(1, 2n+1) = 2n + 3$.

Let's prove $A(3, n) = 2^{n+3} - 3$. Note that $A(3, 0) = A(2, 1) = 5$ which proves the base case. Assume the statement is true for $n-1$. Then $A(3, n) = A(2, A(3, n-1)) = A(2, 2^{n+2}-3) = 2^{n+3} - 3$.

Let's prove $A(4, n) = 2 \uparrow \uparrow (n+3) - 3$. Note that $A(4, 0) = A(3, 1) = 2^4 - 3 = 13$ which proves the base case. Assume the statement is true for $n-1$. Then $A(4, n) = A(3, A(4, n-1)) = A(3, 2 \uparrow \uparrow (n+2) - 3) = 2^{2 \uparrow \uparrow (n+2) - 3 + 3} - 3 = 2 \uparrow (2 \uparrow \uparrow (n+2)) - 3 = 2 \uparrow \uparrow (n + 3) - 3$.

Same strategy can be used to prove that

$$
A(5, n) = 2 \uparrow \uparrow \uparrow (n+3) - 3 \\
A(6, n) = 2 \uparrow \uparrow \uparrow \uparrow (n+3) - 3 \\
$$

Note that if we can calculate $A(n, n) \pmod{2^8}$ and $A(n, n) \pmod{7^8}$ we can use the chinese remainder theorem to calculate $A(n, n) \pmod{14^8}$.

Suppose $\gcd(m, 2) = 1$. Note that $2 \uparrow^2 x \pmod{m}$ can be computed by calculating $2 \uparrow^2 x-1 \pmod{\phi(m)}$ thanks to Euler's theorem. If $\gcd(m, 2) \not= 1$ then we can factorize $m = 2^f \cdot g$ where $g$ is odd and solve $2^x \pmod{g}$. Note that in our calculations $x \ge f$ (otherwise it would be easier to compute the number directly) and thus $2^x \equiv 0 \pmod{2^f}$. Using the chinese remainder theorem we can calculate $2^x \pmod{m}$ from these parts. This gives us a recursive way of computing tetration that stops when the value of $x$ is small enough or when the modulus is $1$ (which will happen at some point since $\phi(n) \lt n$).

This allows us to calculate $A(4, 4)$. We can also calculate $A(5, 5), A(6, 6)$ by noticing that both of these are just tetrations with very large values of $x$ and that the recursion will reach the $\phi(m) = 1$ case way before it ever gets to a small value of $x$, so we don't need to know $x$ (The final value will not depend on the value of $x$). We can just keep doing the recursion until we reach the $\phi(m) = 1$ case.
