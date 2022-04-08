# Primitive Triangles

<p>Consider the triangles with integer sides a, b and c with a ≤ b ≤ c.<br />
An integer sided triangle (a,b,c) is called primitive if <dfn title="gcd(a,b,c)=gcd(a,gcd(b,c))"> gcd(a,b,c)</dfn>=1. <br />
How many primitive integer sided triangles exist with a perimeter not exceeding 10 000 000?
</p>

## Solution

Let $S(N)$ be the number of primitive integer sided triangles with perimeter not exceeding $N$. Then

$$
S(N) = \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N \\ \gcd(a, b, c) = 1}} 1
$$

Let

$$
T(N) := \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N}} 1
$$

Then

$$
\begin{align*}
T(N)
&= \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N \\ \gcd(a, b, c) = k}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{ka \le kb \le kc \\ kc \lt ka + kb \\ ka + kb + kc \le N \\ \gcd(a, b, c) = 1}} 1 \\
&= \sum_{k \ge 1} \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N/k \\ \gcd(a, b, c) = 1}} 1 \\
&= \sum_{k \ge 1} S(N/k) \\
\end{align*}
$$

Therefore

$$
S(N) = T(N) - \sum_{k \ge 2} S(N/k)
$$

And the summation can be calculated efficiently by using the well-known trick of splitting along $\sqrt{N}$. Therefore we are left with finding an efficient formula for $T(N)$.

$$
\begin{align*}
T(N)
&= \sum_{\substack{a \le b \le c \\ c \lt a + b \\ a + b + c \le N}} 1 \\
&= \sum_{b = 1}^N \sum_{a = 1}^b \sum_{b \le c \le \min(a+b-1, N-a-b)} 1 \\
\end{align*}
$$

Let $d = a + b$. Then $d - 1 \le N - d \iff d \le (N+1)/2 \iff d \le \left\lfloor (N+1)/2 \right\rfloor$. Then

$$
\begin{align*}
T(N)
&= \sum_{b = 1}^N \sum_{a = 1}^b \sum_{b \le c \le \min(a+b-1, N-a-b)} 1 \\
&= \sum_{b = 1}^N \sum_{a = 1}^b \sum_{b \le c \le \min(d-1, N-d)} 1 \\
&= \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} \sum_{d - a \le c \le d - 1} 1
+ \sum_{d = \left\lfloor (N+1)/2 \right\rfloor + 1}^N \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} \sum_{d - a \le c \le N - d} 1 \\
\end{align*}
$$

On one hand

$$
\begin{align*}
T_1(N)
&:= \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} \sum_{d - a \le c \le d - 1} 1 \\
&= \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} a \\
&= \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \left\lfloor d / 2 \right\rfloor (\left\lfloor d / 2 \right\rfloor + 1) / 2 \\
&= \frac{1}{2} \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \left\lfloor d / 2 \right\rfloor \cdot (\left\lfloor d / 2 \right\rfloor + 1) \\
\end{align*}
$$

Notice that if $d = 1$, the associated term in the sum is zero. Furthermore, if $\left\lfloor (N+1)/2 \right\rfloor$ is odd then the $\left\lfloor d/2 \right\rfloor$ will map twice to the same integer for all positive integers that do not exceed $\left\lfloor (N+1)/4 \right\rfloor$. Therefore

$$
\begin{align*}
T_1(N)
&:= \frac{1}{2} \sum_{d = 1}^{\left\lfloor (N+1)/2 \right\rfloor} \left\lfloor d / 2 \right\rfloor \cdot (\left\lfloor d / 2 \right\rfloor + 1) \\
&= \frac{1}{2} \sum_{d = 2}^{\left\lfloor (N+1)/2 \right\rfloor} \left\lfloor d / 2 \right\rfloor \cdot (\left\lfloor d / 2 \right\rfloor + 1) \\
&= \sum_{d = 1}^{\left\lfloor (N+1)/4 \right\rfloor} \left( d^2 + d \right) \\
&= \frac{\left\lfloor (N+1)/4 \right\rfloor \cdot (\left\lfloor (N+1)/4 \right\rfloor + 1) \cdot (2 \left\lfloor (N+1)/4 \right\rfloor + 1)}{6} + \frac{\left\lfloor (N+1)/4 \right\rfloor \cdot (\left\lfloor (N+1)/4 \right\rfloor + 1)}{2} \\
&= \frac{\left\lfloor (N+1)/4 \right\rfloor \cdot (\left\lfloor (N+1)/4 \right\rfloor + 1) \cdot (2 \left\lfloor (N+1)/4 \right\rfloor + 4)}{6} \\
\end{align*}
$$

Otherwise

$$
T_1(N) = T_1(N+1) - \left\lfloor (N+1)/4 \right\rfloor \cdot (\left\lfloor (N+1)/4 \right\rfloor + 1) / 2
$$

On the other hand

$$
T_2(N)
:= \sum_{d = \left\lfloor (N+1)/2 \right\rfloor + 1}^N \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} \sum_{d - a \le c \le N - d} 1
$$

Notice that $d - a \le N - d \iff 2d - N \le a$. Because $d \ge \left\lfloor (N+1)/2 \right\rfloor + 1 \ge \left\lfloor N/2 \right\rfloor + 1 \Rightarrow 2d - N \ge 1$ we must have $\max(1, 2d - N) = 2d - N$. Now we only need to check when $2d - N \le \left\lfloor d / 2 \right\rfloor$. Notice that

$$
\begin{align*}
d \le 2N/3
&\iff 3d \le 2N \\
&\iff 4d - 2N \le d \\
&\iff 2d - N \le d/2 \\
&\iff 2d - N \le \left\lfloor d / 2 \right\rfloor
\end{align*}
$$

Therefore

$$
\begin{align*}
T_2(N)
&= \sum_{d = \left\lfloor (N+1)/2 \right\rfloor + 1}^N \sum_{a = 1}^{\left\lfloor d / 2 \right\rfloor} \sum_{d - a \le c \le N - d} 1 \\
&= \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} \sum_{a = 2d - N}^{\left\lfloor d / 2 \right\rfloor} (N - 2d + a + 1) \\
&= \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} \sum_{a = 1}^{N - 2d + \left\lfloor d / 2 \right\rfloor + 1} a \\
&= \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} \frac{(N - 2d + \left\lfloor d / 2 \right\rfloor + 1)(N - 2d + \left\lfloor d / 2 \right\rfloor + 1 + 1)}{2} \\
&= \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (N - 2d + \left\lfloor d / 2 \right\rfloor + 1)(N - 2d + \left\lfloor d / 2 \right\rfloor + 2) \\

&= \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (N+1)(N+2)
+ \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (N+1)(\left\lfloor d / 2 \right\rfloor - 2d) \\
&+ \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (N+2)(\left\lfloor d / 2 \right\rfloor - 2d)
+ \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (\left\lfloor d / 2 \right\rfloor - 2d)^2 \\

&= \frac{(N+1)(N+2)(\left\lfloor 2N/3 \right\rfloor - \left\lfloor (N+1)/2 \right\rfloor)}{2}
+ \frac{(N+1) + (N+2)}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (\left\lfloor d / 2 \right\rfloor - 2d) \\
&+ \frac{1}{2} \sum_{\left\lfloor (N+1)/2 \right\rfloor + 1 \le d \le 2N/3} (\left\lfloor d / 2 \right\rfloor - 2d)^2 \\
\end{align*}
$$

Let

$$
P(M) := \sum_{d = 1}^M (\left\lfloor d / 2 \right\rfloor - 2d) \\
Q(M) := \sum_{d = 1}^M (\left\lfloor d / 2 \right\rfloor - 2d)^2 \\
$$

Then

$$
T_2(N) = \frac{(N+1)(N+2)(\left\lfloor 2N/3 \right\rfloor - \left\lfloor (N+1)/2 \right\rfloor)}{2}
+ \frac{(2N+3) (P(\left\lfloor 2N/3 \right\rfloor) - P(\left\lfloor (N+1)/2 \right\rfloor))}{2}
+ \frac{Q(\left\lfloor 2N/3 \right\rfloor) - Q(\left\lfloor (N+1)/2 \right\rfloor)}{2}
$$

Let's compute $P(M)$. If $M$ is odd then

$$
\begin{align*}
P(M)
&= \sum_{d = 1}^M (\left\lfloor d / 2 \right\rfloor - 2d) \\
&= -2 + \sum_{d = 2}^M (\left\lfloor d / 2 \right\rfloor - 2d) \\
&= -2 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (\left\lfloor 2k / 2 \right\rfloor - 2(2k) + \left\lfloor (2k+1) / 2 \right\rfloor - 2(2k+1)) \\
&= -2 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (k - 4k + k - 4k - 2) \\
&= -2 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (-6k - 2) \\
&= -2 - 2\sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (3k + 1) \\
&= -2 - 3 \left\lfloor M/2 \right\rfloor (\left\lfloor M/2 \right\rfloor + 1) - 2 \left\lfloor M/2 \right\rfloor \\
\end{align*}
$$

If $M$ is even then

$$
P(M) = P(M+1) - (\left\lfloor M/2 \right\rfloor - 2(M + 1))
$$

Let's compute $Q(M)$. If $M$ is odd

$$
\begin{align*}
Q(M)
&= \sum_{d = 1}^M (\left\lfloor d / 2 \right\rfloor - 2d)^2 \\
&= 4 + \sum_{d = 2}^M (\left\lfloor d / 2 \right\rfloor - 2d)^2 \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (\left\lfloor 2k / 2 \right\rfloor - 2(2k))^2 + (\left\lfloor (2k+1) / 2 \right\rfloor - 2(2k+1))^2 \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (k - 4k)^2 + (k - 4k - 2)^2 \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} (-3k)^2 + (-3k - 2) \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} 9k^2 + (3k+2)^2 \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} 9k^2 + 9k^2 + 12k + 4 \\
&= 4 + \sum_{k = 1}^{\left\lfloor M/2 \right\rfloor} 18k^2 + 12k + 4 \\
&= 4 + 18 \cdot \frac{\left\lfloor M/2 \right\rfloor (\left\lfloor M/2 \right\rfloor + 1) (2 \left\lfloor M/2 \right\rfloor + 1)}{6} + 12 \cdot \frac{\left\lfloor M/2 \right\rfloor (\left\lfloor M/2 \right\rfloor + 1)}{2} + 4 \left\lfloor M/2 \right\rfloor \\
&= 4 + 3 \left\lfloor M/2 \right\rfloor (\left\lfloor M/2 \right\rfloor + 1) (2 \left\lfloor M/2 \right\rfloor + 1) + 6 \left\lfloor M/2 \right\rfloor (\left\lfloor M/2 \right\rfloor + 1) + 4 \left\lfloor M/2 \right\rfloor \\
\end{align*}
$$

If $M$ is even then

$$
Q(M) = Q(M+1) - (\left\lfloor M/2 \right\rfloor - 2(M + 1))^2
$$