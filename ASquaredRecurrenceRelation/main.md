# A Squared Recurrence Relation

The function $f$ is defined for all positive integers as follows:
\begin{align*}
f(1) &amp;=  1\\
f(2n) &amp;= 2f(n)\\
f(2n+1) &amp;= 2n+1 + 2f(n)+\tfrac 1n f(n)
\end{align*}
It can be proven that $f(n)$ is integer for all values of $n$.

The function $S(n)$ is defined as $S(n) = \displaystyle \sum_{i=1}^n f(i) ^2$.
For example, $S(10)=1530$ and $S(10^2)=4798445$.

Find $S(10^{16})$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Let $\gamma(n)$ be the number of $1$'s in the binary representation of $n$. Then

$$
\gamma(2n) = \gamma(n) \\
\gamma(2n + 1) = \gamma(n) + 1 \\
$$

Then it is easy to prove that $f(n) = n \gamma(n)$. Then

$$
S(N) = \sum_{n = 1}^N f(n)^2 = \sum_{n = 1}^N n^2 \gamma(n)^2
$$

Define auxiliary functions

$$
f_{i,j}(n) = n^i \gamma(n)^j \\
R_{i,j}(N) = -\mathbb{1}_{\text{$N$ is even}} \cdot f_{i,j}(N + 1) \\
S_{i, j}(N) = \sum_{n = 1}^N f_{i,j}(n) \\
$$

Then $S(N) = S_{2, 2}(N)$. Clearly $S_{i,j}(1) = 1$. Now let's compute the following functions for $N \geq 2$:

$$
S_{0,0}(N) = \sum_{n = 1}^N 1 = N \\
S_{1,0}(N) = \sum_{n = 1}^N n = N (N + 1) / 2 \\
S_{2,0}(N) = \sum_{n = 1}^N n^2 = N (N + 1) (2N + 1) / 6 \\
$$

$$
\begin{align*}
S_{0,1}(N)
&= \sum_{n = 1}^N \gamma(n) \\
&= \gamma(1) + \sum_{n = 2}^N \gamma(n) \\
&= 1 + R_{0,1}(N) + \sum_{n = 1}^{N/2} [ \gamma(2n) + \gamma(2n + 1) ] \\
&= 1 + R_{0,1}(N) + \sum_{n = 1}^{N/2} [ \gamma(n) + \gamma(n) + 1 ] \\
&= 1 + R_{0,1}(N) + \sum_{n = 1}^{N/2} [ 2\gamma(n) + 1 ] \\
&= 1 + R_{0,1}(N) + 2 S_{0,1}(N / 2) + S_{0,0}(N / 2) \\
\end{align*}
$$

$$
\begin{align*}
S_{1,1}(N)
&= \sum_{n = 1}^N n \gamma(n) \\
&= 1 \cdot \gamma(1) + \sum_{n = 2}^N n \gamma(n) \\
&= 1 + R_{1,1}(N) + \sum_{n = 1}^{N/2} [ 2n \gamma(2n) + (2n + 1) \gamma(2n + 1) ] \\
&= 1 + R_{1,1}(N) + \sum_{n = 1}^{N/2} [ 2n \gamma(n) + (2n + 1) (\gamma(n) + 1) ] \\
&= 1 + R_{1,1}(N) + \sum_{n = 1}^{N/2} [ 2n \gamma(n) + 2n \gamma(n) + 2n + \gamma(n) + 1 ] \\
&= 1 + R_{1,1}(N) + \sum_{n = 1}^{N/2} [ 4n \gamma(n) + 2n + \gamma(n) + 1 ] \\
&= 1 + R_{1,1}(N) + 4 S_{1,1}(N / 2) + 2 S_{1,0}(N / 2) + S_{0,1}(N / 2) + S_{0,0}(N / 2) \\
\end{align*}
$$

$$
\begin{align*}
S_{2,1}(N)
&= \sum_{n = 1}^N n^2 \gamma(n) \\
&= 1^2 \cdot \gamma(1) + \sum_{n = 2}^N n^2 \gamma(n) \\
&= 1 + R_{2,1}(N) + \sum_{n = 1}^{N/2} [ (2n)^2 \gamma(2n) + (2n + 1)^2 \gamma(2n + 1) ] \\
&= 1 + R_{2,1}(N) + \sum_{n = 1}^{N/2} [ 4n^2 \gamma(2n) + (4n^2 + 4n + 1) \gamma(2n + 1) ] \\
&= 1 + R_{2,1}(N) + \sum_{n = 1}^{N/2} [ 4n^2 \gamma(n) + 4n^2 \gamma(n) + 4n \gamma(n) + \gamma(n) + 4n^2 + 4n + 1 ] \\
&= 1 + R_{2,1}(N) + \sum_{n = 1}^{N/2} [ 8n^2 \gamma(n) + 4n \gamma(n) + \gamma(n) + 4n^2 + 4n + 1 ] \\
&= 1 + R_{2,1}(N) + 8 S_{2,1}(N / 2) + 4 S_{1,1}(N / 2) + S_{0,1}(N / 2) + 4 S_{2,0}(N / 2) + 4 S_{1,0}(N / 2) + S_{0,0}(N / 2) \\
\end{align*}
$$

$$
\begin{align*}
S_{0,2}(N)
&= \sum_{n = 1}^N \gamma(n)^2 \\
&= \gamma(1)^2 + \sum_{n = 2}^N \gamma(n)^2 \\
&= 1 + R_{0,2}(N) + \sum_{n = 1}^{N/2} [ \gamma(2n)^2 + \gamma(2n + 1)^2 ] \\
&= 1 + R_{0,2}(N) + \sum_{n = 1}^{N/2} [ \gamma(n)^2 + (\gamma(n) + 1)^2 ] \\
&= 1 + R_{0,2}(N) + \sum_{n = 1}^{N/2} [ \gamma(n)^2 + \gamma(n)^2 + 2\gamma(n) + 1 ] \\
&= 1 + R_{0,2}(N) + 2 S_{0,2}(N / 2) + 2 S_{0,1}(N / 2) + S_{0,0}(N / 2) \\
\end{align*}
$$

$$
\begin{align*}
S_{1,2}(N)
&= \sum_{n = 1}^N n \gamma(n)^2 \\
&= 1 \cdot \gamma(1)^2 + \sum_{n = 2}^N n \gamma(n)^2 \\
&= 1 + R_{1,2}(N) + \sum_{n = 1}^{N/2} [ (2n) \gamma(2n)^2 + (2n + 1) \gamma(2n + 1)^2 ] \\
&= 1 + R_{1,2}(N) + \sum_{n = 1}^{N/2} [ (2n) \gamma(n)^2 + (2n + 1) (\gamma(n) + 1)^2 ] \\
&= 1 + R_{1,2}(N) + \sum_{n = 1}^{N/2} [ (2n) \gamma(n)^2 + (2n + 1) (\gamma(n)^2 + 2 \gamma(n) + 1) ] \\
&= 1 + R_{1,2}(N) + \sum_{n = 1}^{N/2} [ 2n \gamma(n)^2 + 2n \gamma(n)^2 + 4n \gamma(n) + 2n + \gamma(n)^2 + 2 \gamma(n) + 1 ] \\
&= 1 + R_{1,2}(N) + \sum_{n = 1}^{N/2} [ 4n \gamma(n)^2 + 4n \gamma(n) + 2n + \gamma(n)^2 + 2 \gamma(n) + 1 ] \\
&= 1 + R_{1,2}(N) + 4 S_{1,2}(N / 2) + 4 S_{1,1}(N / 2) + 2 S_{1,0}(N / 2) + S_{0,2}(N / 2) + 2 S_{0,2}(N / 2) + S_{0, 0}(N / 2) \\
\end{align*}
$$

$$
\begin{align*}
S_{2,2}(N)
&= \sum_{n = 1}^N n^2 \gamma(n)^2 \\
&= 1^2 \cdot \gamma(1)^2 + \sum_{n = 2}^N n^2 \gamma(n)^2 \\
&= 1 + R_{2,2}(N) + \sum_{n = 1}^{N/2} [ (2n)^2 \gamma(2n)^2 + (2n + 1)^2 \gamma(2n + 1)^2 ] \\
&= 1 + R_{2,2}(N) + \sum_{n = 1}^{N/2} [ (2n)^2 \gamma(n)^2 + (2n + 1)^2 (\gamma(n) + 1)^2 ] \\
&= 1 + R_{2,2}(N) + \sum_{n = 1}^{N/2} [ 4n^2 \gamma(n)^2 + (4n^2 + 4n + 1) (\gamma(n)^2 + 2 \gamma(n) + 1) ] \\
&= 1 + R_{2,2}(N) + \sum_{n = 1}^{N/2} [ 4n^2 \gamma(n)^2 + 4n^2 \gamma(n)^2 + 8n^2 \gamma(n) + 4n^2 + 4n\gamma(n)^2 + 8n \gamma(n) + 4n + \gamma(n)^2 + 2 \gamma(n) + 1 ] \\
&= 1 + R_{2,2}(N) + \sum_{n = 1}^{N/2} [ 8n^2 \gamma(n)^2 + 8n^2 \gamma(n) + 4n^2 + 4n\gamma(n)^2 + 8n \gamma(n) + 4n + \gamma(n)^2 + 2 \gamma(n) + 1 ] \\
&= 1 + R_{2,2}(N) + 8 S_{2,2}(N / 2) + 8 S_{2,1}(N / 2) + 4 S_{2,0}(N / 2) + 4 S_{1,2}(N / 2) + 8 S_{1,1}(N / 2) + 4 S_{1,0}(N / 2) + S_{0,2}(N / 2) + 2 S_{0,1}(N / 2) + S_{0,0}(N / 2) \\
\end{align*}
$$