# 2011 nines

First:

$$(\sqrt{p} + \sqrt{q})^{2n} = (p + q + 2 \sqrt{pq})^n$$

Therefore we would like to know under which circumstances the fractional part of $(p + q + 2 \sqrt{pq})^n$ converges to $1$. Notice that:

$$(p + q + 2 \sqrt{pq})^n + (p + q - 2 \sqrt{pq})^n = \sum_{k = 0}^n C_{n, k} (p + q)^{n - k} (2 \sqrt{pq})^k + \sum_{k = 0}^n C_{n, k} (p + q)^{n - k} (-2 \sqrt{pq})^k$$
$$= \sum_{k = 0}^n C_{n, k} (p + q)^{n - k} ((2 \sqrt{pq})^k + (-2 \sqrt{pq})^k)$$

When $k$ is even, then $(2 \sqrt{pq})^k = (-2 \sqrt{pq})^k$ is an integer and therefore the respective term is an integer too. On the other hand, when $k$ is odd, $(2 \sqrt{pq})^k + (-2 \sqrt{pq})^k = (2 \sqrt{pq})^k - (2 \sqrt{pq})^k = 0$. Therefore $(p + q + 2 \sqrt{pq})^n + (p + q - 2 \sqrt{pq})^n$ is an integer.

Assume, without proof, that $|p + q - 2 * \sqrt{pq}| < 1$ is a necessary condition. Then $(p + q - 2 \sqrt{pq})^n \rightarrow 0$ monotonically and thus the fractional part of $(p + q + 2 \sqrt{pq})^n$ converges to $0$ or $1$. Because $p < q$, then:

$$\sqrt{q} - \sqrt{p} > 0$$
$$(\sqrt{q} - \sqrt{p})^2 > 0^2$$
$$p + q - 2 * \sqrt{pq} > 0$$
$$(p + q - 2 * \sqrt{pq})^n > 0$$

Thus the fractional part of $(p + q - 2 \sqrt{pq})^n$ converges to $0$ and therefore the fractional part of $(p + q + 2 \sqrt{pq})^n$ converges to $1$.

The fractional part of $(p + q + 2 \sqrt{pq})^n$ will have $k$ nines when $(p + q - 2 \sqrt{pq})^n$ is in the order of $10^{-k}$. Thus we need to solve:

$$(p + q - 2 \sqrt{pq})^n = 10^{-k}$$
$$n = \lceil \text{ln}(10^{-k}) / \text{ln}(p + q - 2 \sqrt{pq}) \rceil$$
$$n = \lceil -k * \text{ln}(10) / \text{ln}(p + q - 2 \sqrt{pq}) \rceil$$
