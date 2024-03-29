# Divisors of Binomial Product

Let $B(n) = \displaystyle \prod_{k=0}^n {n \choose k}$, a product of binomial coefficients.<br />
For example, $B(5) = {5 \choose 0} \times {5 \choose 1} \times {5 \choose 2}  \times {5 \choose 3} \times {5 \choose 4} \times {5 \choose 5} = 1 \times 5 \times 10 \times 10 \times 5 \times 1 = 2500$.


Let $D(n) = \displaystyle \sum_{d|B(n)} d$, the sum of the divisors of $B(n)$.<br />
For example, the divisors of B(5) are 1, 2, 4, 5, 10, 20, 25, 50, 100, 125, 250, 500, 625, 1250 and 2500,<br />
so D(5) = 1 + 2 + 4 + 5 + 10 + 20 + 25 + 50 + 100 + 125 + 250 + 500 + 625 + 1250 + 2500 = 5467.


Let $S(n) = \displaystyle \sum_{k=1}^n D(k)$.<br />
You are given $S(5) = 5736$, $S(10) = 141740594713218418$ and $S(100)$ mod $1\,000\,000\,007 = 332792866$.


Find $S(20\,000)$ mod $1\,000\,000\,007$.

## Solution

From the factorial expression of ${n \choose k}$ it is clear that

$$
B(n) = \frac{n!^{n+1}}{\prod_{k=0}^{n} k!^2}
$$

One can also prove the following recursion

$$
B(n) = \frac{n!^{n+1}}{\prod_{k=0}^{n} k!^2} = \frac{(n-1)!^n}{\prod_{k=0}^{n-1} k!^2} \cdot \frac{(n-1)! \cdot n^{n+1}}{n!^2} = B(n-1) \cdot \frac{(n-1)! \cdot n^{n+1}}{n!^2} = B(n-1) \cdot \frac{n^n}{n!}
$$

With this, if we know the factorization for $n$, we can iteratively construct the factorizations of $n!$ and $B(n)$. Once we have the factorization of $B(n)$, we only need to calculate $\sigma(B(n)) = \prod_i \frac{p_i^{v_i + 1} - 1}{p_i - 1}$ modulo $p$.