# Summation of a Modular Formula

For an odd prime $p$, define $f(p) = \left\lfloor\frac{2^{(2^p)}}{p}\right\rfloor\bmod{2^p}$<br />
For example, when $p=3$, $\lfloor 2^8/3\rfloor = 85 \equiv 5 \pmod 8$ and so $f(3) = 5$. 

Further define $g(p) = f(p)\bmod p$. You are given $g(31) = 17$.

Now define $G(N)$ to be the summation of $g(p)$ for all odd primes less than $N$.<br />
You are given $G(100) = 474$ and $G(10^4) = 2819236$.

Find $G(10^7)$

## Solution

Fix an odd prime $p$. Calculate the unique integer $m$ that satisfies $0 \le m \lt p$ and $2^{2^p} \equiv m \pmod p$. This can be calculated efficiently by first computing the exponent $2^p$ modulo $\varphi(p) = p - 1$. Then $\left\lfloor \frac{2^{2^p}}{p} \right\rfloor = \frac{2^{2^p} - m}{p}$, which will simplify our following calculations.

Because $2^{p - 1} \equiv 1 \pmod p \Rightarrow 1 + (p - 1) \cdot 2^{p-1} \equiv 0 \pmod p$. Therefore there is an integer $x$ such that $px = 1 + (p - 1) \cdot 2^{p-1} = 1 + \frac{p-1}{2} \cdot 2^p \Rightarrow px \equiv 1 \pmod {2^p}$. Therefore $x$ is the inverse modulo $2^p$ of $p$. Explicitly $x = \frac{1 + (p-1) \cdot 2^{p-1}}{p}$. Note that $f(p) \equiv \frac{2^{2^p} - m}{p} \equiv (2^{2^p} - m) \cdot x \equiv -mx \pmod {2^p}$. Let's find $k_f$ such that $0 \le 2^p k_f - mx \lt 2^p$. Suppose $y$ satisfies $2^p y = mx$. Then $\left\lceil y \right\rceil = k_f$. Solving for $y$ we get

$$
y = \frac{m}{p \cdot 2^p} + \frac{m}{2} \cdot \frac{p - 1}{p}
$$

Because $0 \le m \lt p$ then as $p \rightarrow \infty, y \rightarrow m/2$ from below, which motivates using $k_f = \left\lceil \frac{m}{2} \right\rceil$. As long as this does not break for small enough $p$ (and it doesn't), we do not have to worry.

With $k_f$ known, $f(p) = 2^p k_f - mx$. Calculating $f(p)$ modulo $p$ involves calculating each part modulo $p$. First $2^p \equiv 2 \pmod p$. $x$ can be computed by solving for $xp$ in the modular equation $1 + (p-1) \cdot 2^{p-1} \equiv xp \pmod {p^2}$ and dividing the result by $p$.