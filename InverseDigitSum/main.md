# Inverse Digit Sum

Notice that for a given digit sum $n$, $s(n)$ must have exactly $\lceil \frac{n}{9} \rceil$, as no number with a digit sum $n$ can possibly have less digits. Notice also, that for two consecutive digits $d_1$, $d_2$, replacing them with $d_1 - \text{min}(d_1, 9 - d_2)$, $d_2 + \text{min}(d_1, 9 - d_2)$ produces a smaller number. Therefore the smallest number is built by greedily assigning $9$'s to each of the rightmost digits, until we have exhausted the digit sum, or we are left with a remaining sum less than $9$. If the latter is the case, then the leftmost digit equals this value. Thus:

$$s(n) = 10^{\lfloor \frac{n}{9} \rfloor} - 1 + \text{mod}(n, 9) \cdot 10^{\lfloor \frac{n}{9} \rfloor}$$

where $10^{\lfloor \frac{n}{9} \rfloor} - 1$ corresponds to our assignment of $9$'s, and $\text{mod}(n, 9) \cdot 10^{\lfloor \frac{n}{9} \rfloor}$ corresponds to our assignment of the last remaining digit. Notice that $s(0) = 0$ and:

$$\sum_{n = 9r}^{9r + 8} s(n)$$
$$\sum_{n = 9r}^{9r + 8} 10^{\lfloor \frac{n}{9} \rfloor} - 1 + \text{mod}(n, 9) \cdot 10^{\lfloor \frac{n}{9} \rfloor}$$
$$\sum_{n = 9r}^{9r + 8} 10^r - 1 + \text{mod}(n, 9) \cdot 10^r$$
$$\sum_{n = 9r}^{9r + 8} (1 + \text{mod}(n, 9)) \cdot 10^r - 1$$
$$(9 + 36) \cdot 10^r - 9$$
$$45 \cdot 10^r - 9$$

Therefore:

$$S(k) = \sum_{n = 1}^k s(n)$$
$$= \sum_{n = 0}^k s(n)$$
$$= s(k) + s(k - 1) + ... + s(9 \lfloor \frac{k}{9} \rfloor) + \sum_{r = 0}^{\lfloor \frac{k}{9} \rfloor - 1} \sum_{n = 9r}^{9r + 8} s(n)$$
$$= s(k) + s(k - 1) + ... + s(9 \lfloor \frac{k}{9} \rfloor) + \sum_{r = 0}^{\lfloor \frac{k}{9} \rfloor - 1} 45 \cdot 10^r - 9$$
$$= s(k) + s(k - 1) + ... + s(9 \lfloor \frac{k}{9} \rfloor) + 45 \cdot \frac{10^{\lfloor \frac{k}{9} \rfloor} - 1}{10 - 1} - 9 \lfloor \frac{k}{9} \rfloor$$
$$= s(k) + s(k - 1) + ... + s(9 \lfloor \frac{k}{9} \rfloor) + 5 (10^{\lfloor \frac{k}{9} \rfloor} - 1) - 9 \lfloor \frac{k}{9} \rfloor$$
