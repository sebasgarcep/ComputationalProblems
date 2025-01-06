# Number Splitting

We define an $S$-number to be a natural number, $n$, that is a perfect square and its square root can be obtained by splitting the decimal representation of $n$ into $2$ or more numbers then adding the numbers.

For example, $81$ is an $S$-number because $\sqrt{81} = 8+1$.<br>
$6724$ is an $S$-number: $\sqrt{6724} = 6+72+4$. <br>
$8281$ is an $S$-number: $\sqrt{8281} = 8+2+81 = 82+8+1$.<br>
$9801$ is an $S$-number: $\sqrt{9801}=98+0+1$.

Further we define $T(N)$ to be the sum of all $S$ numbers $n\le N$. You are given $T(10^4) = 41333$.

Find $T(10^{12})$.

## Solution

There are $\sqrt{N}$ perfect squares to test. This means we can brute force this problem as $N$ is small enough. We only need to find if any split results in the square root of the candidate perfect square to find the candidate. We can further reduce the search space by noting that the splits can have at most the amount of digits as the square root of the number.

An optimization can be obtained by noting that $n \equiv \sqrt{n} \pmod 9$ since both have the same digit-sum. Lets prove this fact. 

Suppose $a$ and $b$ have the same digit-sum. Suppose also that $a = \sum_i a_i \cdot 10^i, b = \sum_i b_i \cdot 10^i$, where the $a_i$'s and the $b_i$'s are the digits of $a$ and $b$ respectively. Then

$$
\begin{align*}
a - b
&\equiv \left( \sum_i a_i \cdot 10^i \right) - \left( \sum_i b_i \cdot 10^i \right) \pmod 9 \\
&\equiv \left( \sum_i a_i \right) - \left( \sum_i b_i \right) \pmod 9 \\
&\equiv 0 \pmod 9
\end{align*}
$$
