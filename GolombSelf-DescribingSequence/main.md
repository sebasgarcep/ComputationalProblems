# Golomb's self-describing sequence

Because $G$ is monotonically increasing then $G^{-1}(n) = [a, b]$, for some $a, b \in \mathbb{N}$, with $a \leq b$. Suppose we already know $G^{-1}(k)$ for $k < n$ and we wish to find $G^{-1}(n) = [a, b]$. Suppose $G^{-1}(n - 1) = [a', b']$. Then $a = b' + 1$. Therefore we only need to find the value of $b$. Notice the values of $x \in [a, b]$ are the ones such that $G(x) = n$. Because $n$ appears $G(n)$ times in the sequence, then $G(n) = b - a + 1$ or equivalently $b = G(n) + a - 1$. Clearly, we already know $G(n)$, as $n < a$ for $n \geq 3$.

Notice that a number $x$ repeats itself $k$ times if $G(x) = k$. Clearly, $k$ repeats itself $G(k)$ times, therefore there are $G(k)$ numbers such that $G(x) = k$. Thus the total size of the groups that repeat themselves $k$ times is $k \cdot G(k)$. Therefore if we know that the groups of size $k$ are contained in $[c, d]$, and we know $G(c)$, then for $x \in [c, d]$, $G(x) = G(c) + \lfloor (x - c) / k \rfloor$.

Then the algorithm to solve this problem is:

1. Use the formulas for $G^{-1}(n)$ to calculate the intervals for smaller values of $n$.
2. Use the $k * G(k)$ groupings to calculate $G(n)$ for large enough $n$.
