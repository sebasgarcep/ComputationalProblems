# Prime Factor and Exponent


For a positive integer $n \gt 1$, let $p(n)$ be the smallest prime dividing $n$, and let $\alpha(n)$ be its $p$-adic order, i.e. the largest integer such that $p(n)^{\alpha(n)}$ divides $n$.


For a positive integer $K$, define the function $f_K(n)$ by:
$$f_K(n)=\frac{\alpha(n)-1}{(p(n))^K}.$$

Also define $\overline{f_K}$ by:
$$\overline{f_K}=\lim_{N \to \infty} \frac{1}{N}\sum_{n=2}^{N} f_K(n).$$

It can be verified that $\overline{f_1} \approx 0.282419756159$.


Find $\displaystyle \sum_{K=1}^{\infty}\overline{f_K}$. Give your answer rounded to $12$ digits after the decimal point.

## Solution

Let $p_1 \lt p_2 \lt \dots$ be the primes. Note that

$$
\begin{align*}
\sum_{K=1}^\infty \overline{f_K}
&= \sum_{K=1}^\infty \lim_{N \to \infty} \frac{1}{N}\sum_{n=2}^{N} f_K(n) \\
&= \lim_{N \to \infty} \frac{1}{N}\sum_{n=2}^{N} \sum_{K=1}^\infty \frac{\alpha(n)-1}{p(n)^K} \\
&= \lim_{N \to \infty} \frac{1}{N}\sum_{n=2}^{N} (\alpha(n)-1) \sum_{K=1}^\infty \frac{1}{p(n)^K} \\
&= \lim_{N \to \infty} \frac{1}{N}\sum_{n=2}^{N} \frac{\alpha(n)-1}{p(n) - 1} \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(N)} \sum_{\substack{2 \le n \le N \\ p_1, \dots, p_{i-1} \nmid n \\ p_i \mid n}} \frac{\nu_{p_i}(n)-1}{p_i - 1} \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(N)} \frac{1}{p_i - 1} \sum_{\substack{2 \le n \le N \\ p_1, \dots, p_{i-1} \nmid n \\ p_i \mid n}} (\nu_{p_i}(n)-1) \\
\end{align*}
$$

Note that if $n$ is prime then $\alpha(n) = 1$ and the term corresponding to $n$ cancels out, therefore we only need to consider composite $n$. If $n \le N$ is composite then $p(n) \le \sqrt{N}$. Furthermore, $\alpha(n) \gt 1$ so that the term doesn't cancel out, which implies that $p(n)^2 \mid n$. Thus the sum reduces to

$$
\begin{align*}
\sum_{K=1}^\infty \overline{f_K}
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(N)} \frac{1}{p_i - 1} \sum_{\substack{2 \le n \le N \\ p_1, \dots, p_{i-1} \nmid n \\ p_i \mid n}} (\nu_{p_i}(n)-1) \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(\sqrt{N})} \frac{1}{p_i - 1} \sum_{\substack{2 \le n \le N \\ p_1, \dots, p_{i-1} \nmid n \\ p_i^2 \mid n}} (\nu_{p_i}(n)-1) \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(\sqrt{N})} \frac{1}{p_i - 1} \sum_{\substack{r \ge 2 \\ p_i^r \le N}} \sum_{\substack{2 \le n \le N \\ p_1, \dots, p_{i-1} \nmid n \\ p_i^r \mid n \\ p_i^{r+1} \nmid n}} (r-1) \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(\sqrt{N})} \frac{1}{p_i - 1} \sum_{\substack{r \ge 2 \\ p_i^r \le N}} (r-1) \sum_{\substack{2 \le n \le N / p_i^r \\ p_1, \dots, p_i \nmid n}} 1 \\
\end{align*}
$$

Let $\phi(x,a) = \sum_{\substack{1 \le n \le x \\ p_1, \dots, p_a \nmid n}} 1$. Then

$$
\begin{align*}
\sum_{K=1}^\infty \overline{f_K}
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(\sqrt{N})} \frac{1}{p_i - 1} \sum_{\substack{r \ge 2 \\ p_i^r \le N}} (r-1) \sum_{\substack{2 \le n \le N / p_i^r \\ p_1, \dots, p_i \nmid n}} 1 \\
&= \lim_{N \to \infty} \frac{1}{N} \sum_{i=1}^{\pi(\sqrt{N})} \frac{1}{p_i - 1} \sum_{\substack{r \ge 2 \\ p_i^r \le N}} (r-1) \cdot (\phi(N / p_i^r, i) - 1) \\
\end{align*}
$$
