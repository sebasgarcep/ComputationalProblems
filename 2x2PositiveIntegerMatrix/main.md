# 2x2 positive integer matrix

Let $M$ be a $2 \times 2$ matrix. Let $\tau$ be the trace of $M$ and let $\delta$ be its determinant. Suppose $R$ is such that $R^2 = M$ and let $t = \text{tr}(R)$, $s = \sqrt{\delta}$. Now consider the application of the Cayley-Hamilton theorem to $R$:

$$R^2 - t R + \text{det}(R) I = 0$$
$$M - t R \pm\sqrt{\text{det}(M)} I = 0$$
$$t R = M \pm\sqrt{\text{det}(M)} I$$
$$t R = M \pm\sqrt{\delta} I$$
$$t R = M \pm s I$$

Suppose $M = c I$, for some scalar $c$. Then $\delta = c^2$. Thus $t R = (c \pm c) I$. Therefore $t R = 0$ or $t R = 2c I$. In the first case $R = 0$ or $t = 0$. Both imply $t = 0$. Thus any square root is of the form $R = ( \alpha \: \beta \: ; \: \gamma \: -\alpha )$ with $\alpha^2 + \beta\gamma = c^2$. In the second case $R = ( \alpha \: 0 \: ; \: 0 \: \beta)$ with $\alpha = \beta = 2c / (\alpha + \beta)$, which only has solutions $\alpha = \beta = \pm \sqrt{c}$. Thus $R = \pm\sqrt{c} I$.

Now suppose $M$ is not a multiple of the identity matrix. Notice that:

$$\tau = \text{tr}(M) = \text{tr}(t R \pm s I) = \text{tr}(t R) \pm \text{tr}(s I) = t \cdot \text{tr}(R) \pm 2s = t^2 \pm 2s$$

Notice that if $t = 0$ then $M = \pm s I$, which is not possible. Therefore $t \not= 0$. Thus:

$$t = \pm \sqrt{\tau \pm 2s}$$
$$R = \frac{1}{t}(M \pm s I)$$

with both $\pm$ multiplying the $s$ variable having the same sign.

## Solution

In our case, $M$ is not a multiple of the identity matrix as all its entries are strictly positive. Also $t > 0$, otherwise $R$ will have a negative entry in the top-right corner. Therefore $M$ has two positive integer square roots when $s > 0$ is an integer, $t > 0$ is an integer, $M \pm s I$ is a positive integer matrix and and $t$ divides all entries of $M \pm s I$.

Because $t$ is a positive integer, then $\tau + 2s = z_1^2$ and $\tau - 2s = z_2^2$. Thus $\tau = (z_1^2 + z_2^2) / 2$ and $s = (z_1^2 - z_2^2) / 4$, with $z_1 > z_2$. Additionally, $a - s, d - s > 0$. Because $\tau = a + d$, then $a - s, \tau - a - s > 0$, therefore $s < a < \tau - s$ or equivalently, $s + 1 \leq a \leq \tau - s - 1$. Clearly the same inequalities hold for $d$.

Let $t_1 = \sqrt{\tau + 2s}, \: t_2 = \sqrt{\tau - 2s}$. If $a$, $d$ are valid then $a + s = k_{a,1} t_1$, $a - s = k_{a,2} t_2$, $d + s = k_{d,1} t_1$, $d - s = k_{d,2} t_2$ for some $k_{a,1}, k_{a,2}, k_{d,1}, k_{d,2} > 0$. Then:

$$\tau = a + d = (a + s) + (d - s) = k_{a,1} t_1 + k_{d,2} t_2$$
$$\tau = a + d = (a - s) + (d + s) = k_{a,2} t_2 + k_{d,1} t_1$$
$$2s = (a + s) + (-a + s) = k_{a,1} t_1 - k_{a,2} t_2$$
$$2s = (d + s) + (-d + s) = k_{d,1} t_1 - k_{d,2} t_2$$

In matrix form:

$$\begin{pmatrix} t_1 & 0 & 0 & t_2 \\ 0 & t_2 & t_1 & 0 \\ t_1 & -t_2 & 0 & 0 \\ 0 & 0 & t_1 & -t_2 \end{pmatrix} \begin{pmatrix} k_{a,1} \\ k_{a,2} \\ k_{d,1} \\ k_{d,2} \end{pmatrix} = \begin{pmatrix} \tau \\ \tau \\ 2s \\ 2s \end{pmatrix}$$

This matrix is degenerate as:

$$\text{det} \begin{pmatrix} t_1 & 0 & 0 & t_2 \\ 0 & t_2 & t_1 & 0 \\ t_1 & -t_2 & 0 & 0 \\ 0 & 0 & t_1 & -t_2 \end{pmatrix} = - t_1^2 t_2^2 + t_1^2 t_2^2 = 0$$

Applying Gaussian elimination leads to:

$$\begin{pmatrix} t_1 & 0 & 0 & t_2 \\ 0 & t_2 & t_1 & 0 \\ 0 & 0 & t_1 & -t_2 \\ 0 & 0 & 0 & 0 \end{pmatrix} \begin{pmatrix} k_{a,1} \\ k_{a,2} \\ k_{d,1} \\ k_{d,2} \end{pmatrix} = \begin{pmatrix} \tau \\ \tau \\ 2s \\ 0 \end{pmatrix}$$

Thus the matrix has rank 3. Therefore all solutions will lie along a line in the four dimensional hyperspace. To find this line use the Extended Euclidean algorithm to solve $t_1 \alpha - t_2 \beta = 2s$, for integer $\alpha$, $\beta$. Then any other solution is of the form:

$$(\alpha + k \frac{-t_2}{\text{gcd}(t_1, -t_2)}, \beta - k \frac{t_1}{\text{gcd}(t_1, -t_2)})$$
$$(\alpha - k \frac{t_2}{\text{gcd}(t_1, t_2)}, \beta - k \frac{t_1}{\text{gcd}(t_1, t_2)})$$

and this tuple is precisely $(k_{d,1}, k_{d,2})$. This is subject to:

$$2(s + 1) \leq 2d = k_{d,1} t_1 + k_{d, 2} t_2 = 2d \leq 2(\tau - s- 1)$$
$$2(s + 1) \leq (\alpha - k \frac{t_2}{\text{gcd}(t_1, t_2)}) t_1 + (\beta - k \frac{t_1}{\text{gcd}(t_1, t_2)}) t_2 \leq 2(\tau - s- 1)$$
$$2(s + 1) - \alpha t_1 - \beta t_2 \leq - k \frac{t_2}{\text{gcd}(t_1, t_2)} t_1 - k \frac{t_1}{\text{gcd}(t_1, t_2)} t_2 \leq 2(\tau - s- 1) - \alpha t_1 - \beta t_2$$
$$2(s + 1) - \alpha t_1 - \beta t_2 \leq - 2k \cdot \text{lcm}(t_1, t_2) \leq 2(\tau - s- 1) - \alpha t_1 - \beta t_2$$
$$ \alpha t_1 + \beta t_2 - 2(\tau - s- 1) \leq 2k \cdot \text{lcm}(t_1, t_2) \leq \alpha t_1 + \beta t_2 - 2(s + 1)$$

Therefore:

$$2(s + 1) - 2s \leq 2d - 2s = k_{d,1} t_1 + k_{d, 2} t_2$$
$$2 \leq 2d - 2s = k_{d,1} t_1 + k_{d, 2} t_2$$
$$0 < d - s$$

and similarly for $a$.

These observations allow us to calculate $k_{a,1}, k_{a,2}, k_{d,1}, k_{d,2}$. Then:

$$a = (k_{a,1} t_1 + k_{a, 2} t_2) / 2$$
$$d = (k_{d,1} t_1 + k_{d, 2} t_2) / 2$$

Notice that $bc = ad - \delta$, and that $t_1, t_2 \: | \: b, c$. Thus $\text{lcm}(t_1, t_2) \: | \: b, c$. Therefore $b = k_b \cdot \text{lcm}(t_1, t_2)$ and $c = k_c \cdot \text{lcm}(t_1, t_2)$. Thus $bc = k_{bc} \cdot \text{lcm}(t_1, t_2)^2$. Therefore for given $t_1$, $t_2$ $\delta$, $a$, $d$, the numbers of valid matrices equals the number of divisors of $(ad - \delta) / \text{lcm}(t_1, t_2)^2$.

## Sources
- https://www.maa.org/sites/default/files/Square_Roots-Sullivan13884.pdf
