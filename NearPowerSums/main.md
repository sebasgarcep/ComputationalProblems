# Near Power Sums


A positive integer, $n$, is a <i>near power sum</i> if there exists a positive integer, $k$, such that the sum of the $k$th powers of the digits in its decimal representation is equal to either $n+1$ or $n-1$. For example 35 is a near power sum number because $3^2+5^2 = 34$.


Define $S(d)$ to be the sum of all near power sum numbers of $d$ digits or less. 
Then $S(2) = 110$ and $S(6) = 2562701$.


Find $S(16)$.

## Solution

Let's find $S(N)$. Generate all solutions to the system:

$$
d_0, \dots, d_9 \in \mathbb{N} \\
d_0 + \dots d_9 = N \\
d_0 \not= N \\
$$

Now for a given $k$ let $v_k = \sum_{i = 0}^9 d_i i^k$. If $n := v_k \pm 1$ has a $d_0$ number of $0$ digits, a $d_1$ number of $1$ digit and so forth all the way up to $d_9$ then $n$ is a near power sum. Moreover, this method allows us to generate all near power sums. Now we need to iterate over all possible values of $k$ until $v_k$ is too large. If $d_0 + d_1 = N$, then $v_k$ is constant, so we only need to perform one iteration in that case.