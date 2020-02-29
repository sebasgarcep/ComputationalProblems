# Minimum of Subsequences

Notice that after a certain number of iterations $S_n$ is either periodic with period $p$ or reaches $1$ and thus all the following values in the sequence must be $1$. A quick calculation shows that with our initial $S_0$, the sequence is periodic. Suppose that the values $S_1$, $S_2$, ... , $S_t$ are not part of the period. Then our sequence satisfies $t = 0$, and thus every element of the sequence is part of the period. Let $r$ be the minimum value of $S_{t + 1}$, $S_{t + 2}$, ... , $S_{t + p}$.

Fix a value of $i$. Let $e$ satisfy $i < e$ and $S_i \geq S_e$, such that $e$ is the smallest number with these properties. Similarly let $f$ satisfy $f < i$ and $S_i \geq S_f$, such that $f$ is the largest number with these properties. Then there are $(i - f) \times (e - i)$ intervals that contain $i$ such that $A(i, j) = S_i$. Because the sequence is periodic, $i - f, e - i \leq p$. Also there are $k = \lceil N / p \rceil$ periodic segments. With the segments $2$, $3$, ... , $k - 2$, there is always a complete segment before and after it, so they will behave ideally. Special care needs to be taken with segments $1$, $k - 1$, $k$ using proper bound checking to make sure invalid intervals are not counted.

Clearly, $\sum A(i, j)$ has ${N \choose 2} + N= N (N + 1) / 2$ terms. Therefore if we know that the total amount of terms for all the cases in the previous paragraph is $c$, then the sum over the remaining cases is:

$$r \cdot (N (N + 1) / 2 - c)$$

As $j - i > p$, and therefore $A(i, j) = r$.
