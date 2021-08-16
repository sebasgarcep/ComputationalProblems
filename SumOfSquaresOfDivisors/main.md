# Sum Of Squares Of Divisors

The divisors of 6 are 1,2,3 and 6.<br />
The sum of the squares of these numbers is 1+4+9+36=50.

Let sigma2(n) represent the sum of the squares of the divisors of n.
Thus sigma2(6)=50.

Let SIGMA2 represent the summatory function of sigma2, that is SIGMA2(n)=<span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> sigma2(i) for i=1 to n.<br />
The first 6 values of SIGMA2 are: 1,6,16,37,63 and 113.

Find SIGMA2(10<sup>15</sup>) modulo 10<sup>9</sup>.

## Solution

Let $\sigma_{2}(n) = \sum_{d \mid n} d^2$ and $S(N) = \sum_{n = 1}^N \sigma_{2}(n)$. Then

$$
\begin{align*}
S(N)
&= \sum_{n = 1}^N \sigma_{2}(n) \\
&= \sum_{n = 1}^N \sum_{d \mid n} d^2 \\
&= \sum_{d = 1}^N \sum_{n = 1}^{\lfloor N / d \rfloor} d^2 \\
&= \sum_{d = 1}^N d^2 \sum_{n = 1}^{\lfloor N / d \rfloor} 1 \\
&= \sum_{d = 1}^N d^2 \lfloor N / d \rfloor \\
\end{align*}
$$

This sum can be computed in $O(N^{1/2})$ using the standard optimization for these types of sums

$$
S(N)
= \sum_{d = 1}^N d^2 \lfloor N / d \rfloor
= \sum_{d = 1}^{\lfloor \sqrt{N} \rfloor} d^2 \lfloor N / d \rfloor
+ \sum_{d = \lfloor \sqrt{N} \rfloor + 1}^N d^2 \lfloor N / d \rfloor
$$

And the second sum can be rewritten as

$$
\begin{align*}
\sum_{d = \lfloor \sqrt{N} \rfloor + 1}^N d^2 \lfloor N / d \rfloor
&= \sum_{u} u \sum_{N / (u + 1) < d \leq N / u} d^2 \\
&= \sum_{u} u \cdot [ T_{2}(N / u) - T_{2}(N / (u + 1)) ] \\
\end{align*}
$$

where $T_{2}(N) = \sum_{n = 1}^N n^2$. The sum over $u$ goes from $1$ to $\lfloor \sqrt{N} \rfloor$, excluding the case $u = \lfloor N / u \rfloor$. Finally, it is well known that $T_{2}(N) = N (N + 1) (2N + 1) / 6$.