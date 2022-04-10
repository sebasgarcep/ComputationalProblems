# Fractions involving the number of different ways a number can be expressed as a sum of powers of 2

Define f(0)=1 and f(<var>n</var>) to be the number of ways to write <var>n</var> as a sum of powers of 2 where no power occurs more than twice. <br /><br />

For example, f(10)=5 since there are five different ways to express 10:<br />10 = 8+2 = 8+1+1 = 4+4+2 = 4+2+2+1+1 = 4+4+1+1<br /><br />

It can be shown that for every fraction <var>p/q</var> (<var>p</var>&gt;0, <var>q</var>&gt;0) there exists at least one integer <var>n</var> such that<br /> f(<var>n</var>)/f(<var>n</var>-1)=<var>p/q</var>.<br /><br />
For instance, the smallest <var>n</var> for which f(<var>n</var>)/f(<var>n</var>-1)=13/17 is 241.<br />
The binary expansion of 241 is 11110001.<br />
Reading this binary number from the most significant bit to the least significant bit there are 4 one's, 3 zeroes and 1 one. We shall call the string 4,3,1 the <span style="font-style:italic;">Shortened Binary Expansion</span> of 241.<br /><br />
Find the Shortened Binary Expansion of the smallest <var>n</var> for which<br /> f(<var>n</var>)/f(<var>n</var>-1)=123456789/987654321.<br /><br />
Give your answer as comma separated integers, without any whitespaces.

## Solution

Define $g(0) = 0$ and $g(n) = f(n-1)$. Looking at the values of $g(n)$ it looks like $g(n)$ is the OEIS sequence A002487. Let's prove a few facts about $g(n)$ to show this.

Suppose $P$ is a partition of $2n-1$ for $n \ge 1$. Then $1$ appears exactly once in $P$ as $2n-1$ is odd. Thus $P$ without any $1$'s is a partition of $2n-2$. Therefore there must be a one-to-one correspondence between all partition of $2n-1$ and all partitions without $1$'s of $2n-2$. Because all the elements of $P$ without $1$ are even, we can divide all of them by $2$ to obtain a partition $P'$ of $n-1$. Thus there is a one-to-one correspondence between the partitions of $n-1$ and the partitions without $1$'s of $2n-2$. In other words, there is a one-to-one correspondence between the partitions of $2n-1$ and $n-1$ which implies $f(2n-1) = f(n-1)$ for $n \ge 1$ or equivalently $g(2n) = g(n)$ for $n \ge 1$.

Now suppose $P$ is a partition of $2n$ for $n \ge 1$. Then $1$ appears either $0$ or $2$ times in $P$. By the same logic of the previous argument there must be a one-to-one correspondence between the partitions of $2n$ without $1$'s and the partitions of $n$ and there must be a one-to-one correspondence between the partitions of $2n$ with $1$ appearing twice and the partitions of $n-1$. Thus $f(2n) = f(n-1) + f(n)$ for $n \ge 1$ or equivalently $g(2n+1) = g(n) + g(n+1)$ for $n \ge 1$. This suffices to show that $g(n)$ is the OEIS sequence A002487.

These two results together also show that $g(n) \not= g(n+1)$ for $n > 1$ as $g(n) > 0$ for $n \ge 1$.

Notice that the fraction in terms of $g(n)$ can be written as $f(n)/f(n-1) = g(n+1)/g(n)$. Let $L_n = (g(n), g(n+1))$. Let $\varphi$ be the "Slow Euclidean Algorithm" applied to $L_n$. Formally, if $g(n) = g(n+1)$, then $\varphi(L_n) = L_n$. If not then $g(n) \lt g(n+1) \Rightarrow \varphi(L_n) = (g(n), g(n+1)-g(n))$ and $g(n) \gt g(n+1) \Rightarrow \varphi(L_n) = (g(n)-g(n+1), g(n+1))$. Now let's prove that $\varphi(L_{2n}) = \varphi(L_{2n+1}) = L_n$. We already know that 

$$
g(2n) = g(n) \\
g(2n+1) = g(n) + g(n+1) \\
g(2n+2) = g(n+1) \\
$$

Therefore $\max(L_{2n}) = \max(L_{2n+1}) = g(2n+1) = g(n) + g(n+1)$. The desired result is obtained by substituting the $\min$ and $\max$ in each case and verifying the result. Furthermore, this result implies that succesive applications of $\varphi$ will always lead to $L_1$.

Moreover, this result implies that $\gcd(g(n), g(n+1)) = 1$. To see this, suppose that $\gcd(g(n), g(n+1)) = d$. Then $d$ divides all elements of $L_n$. But elements of $\varphi(L_n)$ are linear combinations of elements of $L_n$. Therefore $d$ must divide all elements of $\varphi(L_n)$ as well. By the same logic $d$ must divide all elements of any number applications of $\varphi$ to $L_n$. Therefore $d$ must divide all elements of $L_1$ (which is reached after a finite number of applications of $\varphi$). But $L_1 = (1, 1)$. Therefore $d = 1$.

We are now ready to solve the problem. Suppose we want to solve $g(n+1)/g(n) = p/q$. By the previous fact $g(n) = q, g(n+1) = p$. Notice that $\varphi(L_n) = L_{\left\lfloor n/2 \right\rfloor} = (g(\left\lfloor n/2 \right\rfloor), g(\left\lfloor n/2 \right\rfloor + 1)) = (q', p')$. Thus $g(\left\lfloor n/2 \right\rfloor) = q', g(\left\lfloor n/2 \right\rfloor + 1) = p'$. Suppose we know a $r$ such that $g(r) = q', g(r + 1) = p'$. Then $r = \left\lfloor n/2 \right\rfloor \iff r \le n/2 \lt r+1 \iff 2r \le n \lt 2r+2$. If $g(2r) = g(r) = q$ then $n = 2r$, otherwise $n = 2r + 1$.

Finally the recurrence relations imply that $g(n) = 1$ if and only if $n$ is a power of $2$. Suppose $n = 2^k$ for some non-negative integer $k$. Then for $k \ge 1$ we have $g(n + 1) = g(2^k + 1) = g(2^{k-1}) + g(2^{k-1}+1) = 1 + g(2^{k-1}+1)$. And by induction it can be shown that $g(n+1) = k + 1$. Similarly, for $k \ge 1$ we have $g(n - 1) = g(2^k - 1) = g(2^{k-1} - 1) + g(2^{k-1}) = g(2^{k-1} - 1) + 1$. And by induction it can be shown that $g(n - 1) = k$.

Instead of calculating $g(n)$ we are going to calculate $g(2^k + m)$ as in our calculations $m$ never grows too large. Suppose $k > 0$. If $m = 0$ then

$$
g(2^k + m) = g(2^k) = 1
$$

We already know that when $m = 1$ then

$$
g(2^k + m) = g(2^k + 1) = k + 1
$$

And when $m = -1$ then

$$
g(2^k + m) = g(2^k - 1) = k
$$

If $m \not= 0$ is even

$$
g(2^k + m) = g(2^{k-1} + m/2)
$$

If $m \not= 0$ is odd

$$
g(2^k + m) = g(2^{k-1} + (m-1)/2) + g(2^{k-1} + (m-1)/2 + 1) \\
$$

Finally, if $2^k > m$ then calculating the Shortened Binary Expansion is reduced to looking at the binary representation of $m$ and doing some case management with $2^k$.

## References

- https://sites.math.washington.edu/~morrow/336_12/papers/richard.pdf