# Right-angled triangles that share a cathetus

<p>The four right-angled triangles with sides (9,12,15), (12,16,20), (5,12,13) and (12,35,37) all have one of the shorter sides (catheti) equal to 12. It can be shown that no other integer sided right-angled triangle exists with one of the catheti equal to 12.</p>
<p>Find the smallest integer that can be the length of a cathetus of exactly 47547 different integer sided right-angled triangles.</p>

## Solution

Let $f(a)$ be the number of right-angled triangles of which $a$ is a catheti. Note that for $a, x, y > 0$ such that $a^2 + x^2 = y^2 \iff a^2 = (y - x) (y + x)$. Suppose $a = y - x = y + x \Rightarrow y = a, x = 0$, which is a contradiction. Therefore $y-x \not= a, y+x \not= a$. Suppose $p < q$ are integers such that $a^2 = pq$. Then $p = y - x, q = y + x \Rightarrow x = (q - p)/2, y = (q + p)/2$. These equations imply that $q \equiv p \pmod 2$. If $a$ is odd then $q \equiv p \equiv 1 \pmod 2$ and therefore $f(a) = (\sigma_0(a^2) - 1)/2$. If $a$ is even then $q \equiv p \equiv 0 \pmod 2$. Let $2p' = p, 2q' = q$. Then $a^2 = 4 p' q'$ which implies $f(a) = (\sigma_0(a^2 / 4) - 1)/2$.

Suppose that for a given $c$ we want to find the smallest value of $a$ such that $f(a) = c$. Then we start by factorizing $2c + 1$. In our case $c = 47547 \Rightarrow 2c + 1 = 95095 = 5 \cdot 7 \cdot 11 \cdot 13 \cdot 19$. Suppose $n = p_1^{\nu_1} \cdots p_k^{n_k}$ where $p_1, \dots, p_k$ are distinct primes. Then $\sigma_0(n) = (\nu_1 + 1) \cdots (\nu_k + 1)$. Now we need to find the smallest $a$ such that $\sigma_0(a^2) = 2c + 1$ where $a$ is odd, or the smallest $a$ such that $\sigma_0(a^2/4) = 2c + 1$, where $a$ is even. This gives us two test cases using a greedy approach.

$$
a = 3^{9} \cdot 5^{6} \cdot 7^{5} \cdot 11^{3} \cdot 13^{2} = 1162696268468109375 \\
a = 2^{10} \cdot 3^{6} \cdot 5^{5} \cdot 7^{3} \cdot 11^{2} = 96818198400000 \\
$$

Clearly the second one is the smallest and therefore must be the answer.