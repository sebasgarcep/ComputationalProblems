# Largest Roots Of Cubic Polynomials

Let $n = 1$. Then:

$$g_1(x) = x^3 - 2x + 1 = (x - 1) (x^2 - x - 1)$$

Thus the roots of $g_1$ are $\frac{1}{2} - \frac{\sqrt{5}}{2}$, $1$, $\frac{1}{2} + \frac{\sqrt{5}}{2}$.

Now let $n \geq 2$. The derivatives of $g_n$ are:

$$g_n'(x) = 3x^2 - 2^{n + 1}x$$
$$g_n''(x) = 6x - 2^{n + 1}$$

Therefore the critical points are:

$$x = 0, \: \frac{2^{n + 1}}{3}$$

But $g(0) = n > 0$ and:

$$g_n(\frac{2^{n + 1}}{3}) = (\frac{2^{n + 1}}{3})^3 - 2^n (\frac{2^{n + 1}}{3})^2 + n$$
$$= (\frac{2^{n + 1}}{3})^2 (\frac{2^{n + 1}}{3} - 2^n) + n$$
$$= 2^n (\frac{2^{n + 1}}{3})^2 (2/3 - 1) + n$$
$$= -\frac{2^n}{3} (\frac{2^{n + 1}}{3})^2 + n$$
$$= -4(\frac{2^n}{3})^3 + n$$
$$= -\frac{4}{27} 2^{3n} + n < 0$$

Therefore there is a root in $(0, \frac{2^{n + 1}}{3})$. Because $g_n$ tends to $-\infty$ when $x \rightarrow -\infty$ and to $\infty$ when $x \rightarrow \infty$, there is a root in $(-\infty, 0)$ and another root in $(\frac{2^{n + 1}}{3}, \infty)$.

Additionally $g_n(-1) = -1 - 2^n + n < 0$. Therefore the smallest root of the polynomial is in $(-1, 0)$. Similarly $g_n(1) = 1 - 2^n + n < 0$. Thus the middle root of the polynomial is in $(0, 1)$.

Clearly, the smallest and middle roots vanish for large enough powers of $k$. Therefore the Newton Sum gives us an approximation of the $k$-th power of the largest root for $n \geq 2$. In particular, because the sum of the $k$-th power of the other two roots is some small value $\epsilon > 0$, then $\lfloor a_i^k \rfloor$ is going to be one less than the result of the Newton Sum.

Now suppose $n = 1$. The smallest root is $\frac{1}{2} - \frac{\sqrt{5}}{2} \in (-1, 0)$, therefore it vanishes for large enough powers. The middle root is $1$, which stays constant for any arbitrary power. Thus, in this case, the Newton Sum gives us the $k$-th power of the largest root plus $1$.

Let's prove the Newton's Sums:

## Newton's Sums

Consider a polynomial $p(x) = a_n x^n + a_{n - 1} x^{n - 1} + ... + a_1 x + a_0$, with roots $x_1$, $x_2$, ... , $x_n$. Let:

$$P_k = x_1^k + x_2^k + ... + x_n^k$$

Then:

$$a_n P_1 + a_{n - 1} = 0$$
$$a_n P_2 + a_{n - 1} P_1 + 2 a_{n - 2} = 0$$
$$a_n P_3 + a_{n - 1} P_2 + a_{n - 2} P_1 + 3 a_{n - 3}= 0$$
$$...$$

with $a_j = 0$, for $j < 0$.

### Proof:

Clearly:

$$p(x) = a_n (x - x_1) (x - x_2) ... (x - x_n)$$

Define:

$$q(t) := a_n (1 - t x_1) (1 - t x_2) ... (1 - t x_n) = t^n p(1/t)$$

Then:

$$\frac{q'(t)}{q(t)} = \frac{d}{dt} \text{ln} |q(t)|$$
$$\frac{q'(t)}{q(t)} = \frac{d}{dt} (\text{ln} |a_n| + \text{ln} |1 - t x_1| + \text{ln} |1 - t x_2| + ... + \text{ln} |1 - t x_n|)$$
$$- \frac{x_1}{1 - t x_1} - \frac{x_2}{1 - t x_2} - \frac{x_n}{1 - t x_n}$$

And for small enough $t$, the Taylor expansion at $0$ gives:

$$\frac{q'(t)}{q(t)} = - \sum_{k = 0}^\infty x_1^{k + 1} t^k - \sum_{k = 0}^\infty x_2^{k + 1} t^k - ... - \sum_{k = 0}^\infty x_n^{k + 1} t^k$$
$$= - P_1 - P_2 t - P_3 t^2 - ...$$

Therefore:

$$q'(t) = - q(t) (P_1 + P_2 t + P_3 t^2 + ...)$$
$$a_{n - 1} + 2 a_{n - 2} t + ... + (n - 1) a_1 t^{n - 2} + n a_0 t^{n - 1} = - (a_n + a_{n - 1} t + ... + a_1 t^{n - 1} + a_0 t^n) (P_1 + P_2 t + P_3 t^2 + ...)$$

Comparing coefficients we arrive at the required expressions.

## Applying Newton's Sums

Clearly:

$$P_1 = 2^n$$
$$P_2 - 2^n P_1 = 0 \Rightarrow P_2 = 4^n$$
$$P_3 - 2^n P_2 + 3n = 0 \Rightarrow P_3 = 8^n - 3n$$

And:

$$P_k - 2^n P_{k - 1} + n P_{k - 3} = 0 \Rightarrow P_k = 2^n P_{k - 1} - n P_{k - 3}$$,

for $k \geq 4$. Finally, this linear recurrence can be calculated efficiently expressing it as a matrix and calculating the corresponding power of the matrix using binary exponentiation.
