# Square the Smallest

A list initially contains the numbers $2, 3, \dots, n$.<br />
At each round, the smallest number in the list is replaced by its square. If there is more than one such number, then only one of them is replaced.

For example, below are the first three rounds for $n = 5$:
$$[2, 3, 4, 5] \xrightarrow{(1)} [4, 3, 4, 5] \xrightarrow{(2)} [4, 9, 4, 5] \xrightarrow{(3)} [16, 9, 4, 5].$$

Let $S(n, m)$ be the sum of all numbers in the list after $m$ rounds.<br /><br />
For example, $S(5, 3) = 16 + 9 + 4 + 5 = 34$. Also $S(10, 100) \equiv 845339386 \pmod{1234567891}$.

Find $S(10^4, 10^{16})$. Give your answer modulo $1234567891$.

## Solution

If all elements are within $(L^k, L^{2k}]$ then after squaring they will be in the range $(L^{2k}, L^{4k}]$, which means that each element will be squared once every $n - 1$ rounds if at some point they are all in $(L^k, L^{2k}]$. Furthermore, they will mantain their relative order after each batch of exponentiation.

If we pick appropiate values for $L$ and $k$ (say $L = \lceil \sqrt{n} \rceil$ and $k = 1$) then after a few initial rounds the elements of the list will satisfy the condition of the previous paragraph. We can now use this fact to perform $r$ batches of $n - 1$ rounds by squaring each element to the power of $2^r$.

We can optimize calculating the exponential by noticing that exponents of exponentiation modulo $p$ behave modulo $\varphi(p) = p - 1$, where $p$ is prime.

The final few rounds we can compute using brute force on the result of the smallest initial elements, as we know that after each batch of exponentiation they mantain their relative order.