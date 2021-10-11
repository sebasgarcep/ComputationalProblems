# GCD Sum

$G(N)=\sum_{j=1}^N\sum_{i=1}^j \text{gcd}(i,j)$. <br />
You are given: $G(10)=122$.

Find $G(10^{11})$. Give your answer modulo 998244353

## Solution

$$
\begin{align*}
G(N)
&= \sum_{j = 1}^N \sum_{i = 1}^j \text{gcd}(i, j) \\
&= \sum_{k \geq 1} \sum_{\substack{1 \leq i \leq j \leq N \\ \text{gcd}(i, j) = k}} k \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq i \leq j \leq N \\ \text{gcd}(i, j) = k}} 1 \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq ki \leq kj \leq N \\ \text{gcd}(ki, kj) = k}} 1 \\
&= \sum_{k \geq 1} k \sum_{\substack{1 \leq i \leq j \leq N / k \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{k \geq 1} k S(N / k) \\
\end{align*}
$$

where

$$
\begin{align*}
S(N)
&:= \sum_{\substack{1 \leq i \leq j \leq N / k \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{j = 1}^N \sum_{\substack{1 \leq i \leq j \\ \text{gcd}(i, j) = 1}} 1 \\
&= \sum_{j = 1}^N \varphi(j) \\
\end{align*}
$$

From Hexagonal Orchards we already know how to efficiently compute $S$. We can use the same trick of splitting the sum over the $\sqrt{N}$ to calculate $G(N)$ efficiently.