# Modified Sum Of Fibonacci Numbers

Define the <strong>Fibonacci numbers</strong> as $F_0 = 0, F_1 = 1, F_{k}=F_{k-1}+F_{k-2}\text{ for }k\ge 2$.

Let $s(k)$ be the number of 1s in the binary representation of $k$.

Define $\displaystyle S(N) = \sum_{k=0}^N F_{k+s(k)} $.

You are given $S(10) = 369$ and $S(50) = 161052232733$.

Find $S(10^{18})$. Give your answer modulo $10^9+7$.

## Solution

Let $W = \begin{pmatrix} 1 & 1 \\ 1 & 0 \end{pmatrix}$. Then $\begin{pmatrix} F_{n+1} \\ F_n \end{pmatrix} = W^n \begin{pmatrix} F_1 \\ F_0 \end{pmatrix}$. Also let

$$
\begin{align*}
T(N) &= \sum_{k=0}^N F_{k+s(k)+1} \\
X(N) &= \begin{pmatrix} T(N) \\ S(N) \end{pmatrix} \\
\end{align*}
$$

Then

$$
\begin{align*}
X(N)
&= \begin{pmatrix} T(N) \\ S(N) \end{pmatrix} \\
&= \begin{pmatrix} \sum_{k=0}^N F_{k+s(k)+1} \\ \sum_{k=0}^N F_{k+s(k)} \end{pmatrix} \\
&= \sum_{k=0}^N \begin{pmatrix} F_{k+s(k)+1} \\ F_{k+s(k)} \end{pmatrix} \\
&= \sum_{k=0}^N W^{k+s(k)} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} \\
\end{align*}
$$

Note that any integer $N \ge 1$ can be written of the form $2^M + K$ where $M \ge 0$ and $0 \le K \lt 2^M$. Thus, for $K > 0$ we get the following reduction

$$
\begin{align*}
X(N)
&= X(2^M + K) \\
&= \sum_{k=0}^{2^M-1} W^{k+s(k)} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} + \sum_{k=2^M}^{2^M+K} W^{k+s(k)} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} \\
&= X(2^M-1) + \sum_{k=0}^{K} W^{(k+2^M)+s(k+2^M)} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} \\
&= X(2^M-1) + \sum_{k=0}^{K} W^{k+s(k)+2^M+1} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} \\
&= X(2^M-1) + W^{2^M+1} \sum_{k=0}^{K} W^{k+s(k)} \begin{pmatrix} F_1 \\ F_0 \end{pmatrix} \\
&= X(2^M-1) + W^{2^M+1} X(K) \\
\end{align*}
$$

The base cases being:

$$
\begin{align*}
X(0) &= \begin{pmatrix} 1 \\ 0 \end{pmatrix} \\
X(1) &= \begin{pmatrix} 1 \\ 0 \end{pmatrix} + \begin{pmatrix} 2 \\ 1 \end{pmatrix} = \begin{pmatrix} 3 \\ 1 \end{pmatrix} \\
\end{align*}
$$

Calculating $X(N)$ then gives us $S(N)$.
