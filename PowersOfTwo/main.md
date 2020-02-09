# Powers of Two

Using the floating point representation of a number:

$$k \times 10^d$$

where $k$ is a real number, we can efficiently find the solution to this problem. We just need to keep multiplying by $2$ and once our number has more integer digits than $L$, we start dividing by $10$ until our number has again at most, the same number of integer digits as $L$. Any number that is in $[L, L + 1)$, will start with $L$. Therefore we just need to find the $n$-th number that satisfies this condition.
