# $2^{w(n)}$

Notice that, if $p$ is prime, then:

$$S(p^a) = \sum_{d | p^a} 2^{w(d)}$$
$$= 2^{w(1)} + 2^{w(p)} + 2^{w(p^2)} + ... + 2^{w(p^a)}$$
$$=2^0 + 2^1 + 2^1 + ... + 2^1$$
$$=1 + 2a$$

Let $a$, $b$ satisfy $\text{gcd}(a, b) = 1$. Then:

$$S(a) S(b) = (\sum_{d | a} 2^{w(d)}) (\sum_{d' | b} 2^{w(d')})$$
$$= \sum_{d | a, \: d' | b} 2^{w(d)} \cdot 2^{w(d')}$$
$$= \sum_{d | p^a, \: d' | q^b} 2^{w(d) + w(d')}$$

Because $\text{gcd}(d, d') = 1$, then $w(d) + w(d') = w(d d')$. Thus:

$$= \sum_{d | a, \: d' | b} 2^{w(d) + w(d')}$$
$$= \sum_{d | a, \: d' | b} 2^{w(d d')}$$
$$= \sum_{d | a b} 2^{w(d)}$$
$$= S(ab)$$

Therefore, if $n = p_1^{r_1} p_2^{r_2} ... p_s^{r_s}$ and $(n - 1)! = p_1^{k_1} p_2^{k_2} ... p_s^{k_s} \cdot t$, then:

$$\frac{S(n!)}{S((n - 1)!)} = \frac{S(p_1^{k_1 + r_1}) S(p_2^{k_2 + r_2}) ... S(p_s^{k_s + r_s}) S(t)}{S(p_1^{k_1}) S(p_2^{k_2}) ... S(p_s^{k_s}) S(t)}$$
$$\frac{S(n!)}{S((n - 1)!)} = \frac{S(p_1^{k_1 + r_1})}{S(p_1^{k_1})} \cdot \frac{S(p_2^{k_2 + r_2})}{S(p_2^{k_2})} \cdot ... \cdot \frac{S(p_s^{k_s + r_s})}{ ... S(p_s^{k_s})}$$
$$\frac{S(n!)}{S((n - 1)!)} = \frac{1 + 2 k_1 + 2 r_1}{1 + 2 k_1} \cdot \frac{1 + 2 k_2 + 2 r_2}{1 + 2 k_2} \cdot ... \cdot \frac{1 + 2 k_s + 2 r_s}{1 + 2 k_s}$$

We can therefore use a prime sieve to factorize all numbers from $1$ to $n$, and this factorization can be used to calculate each of the products in the above equation. This would also require us to save the values of $k_i$, and to update them after each iteration. Thus $S(n!)$ can be calculated iteratively.
