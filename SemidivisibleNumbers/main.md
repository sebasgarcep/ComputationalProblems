# Semidivisible Numbers

Let $p_1$, $p_2$, ... , $p_n$, ... be the primes. The set of all $n$ for which $\text{lps}(n) = p_n$ satisfies:

$$p_n \leq \sqrt{n} < p_{n + 1}$$
$$p_n^2 \leq n < p_{n + 1}^2$$
$$p_n^2 \leq n \leq p_{n + 1}^2 - 1$$

and of these numbers, the ones divisible by $p_n$ are $p_n^2$, $p_n^2 + p_n$, $p_n^2 + 2 p_n$, ... , $p_n^2 + \lfloor (p_{n + 1}^2 - 1 - p_n^2 + 1) / p_n \rfloor p_n = p_n^2 + \lfloor (p_{n + 1}^2 - p_n^2 - 1) / p_n \rfloor p_n$.

Similarly, let $\text{ups}(n) = p_n$. Then $n$ satisfies:

$$p_{n - 1} < \sqrt{n} \leq p_n$$
$$p_{n - 1}^2 + 1 \leq n \leq p_n^2$$

Again, the numbers divisible by $p_n$ in this range are $p_n^2$, $p_n^2 - p_n$, $p_n^2 - 2 p_n$, ... , $p_n^2 - \lfloor (p_n^2 - p_{n - 1}^2 - 1) / p_n \rfloor p_n$. If $n = 1$, then there are no previous primes. In this case $n \leq 4$. But a precondition for a number to be semidivisible is that $n \geq 4$. Thus $n = 4$, and we have to remove it from the final list of numbers.

Finally, it is clear that we don't need much more primes than those less than or equal to $\sqrt{N}$, where $N$ is the upper limit for the semidivisible numbers.
