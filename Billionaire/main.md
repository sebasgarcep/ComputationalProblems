# Billionaire

<p>You are given a unique investment opportunity.</p>
<p>Starting with £1 of capital, you can choose a fixed proportion, <var>f</var>, of your capital to bet on a fair coin toss repeatedly for 1000 tosses.</p>
<p>Your return is double your bet for heads and you lose your bet for tails.</p>
<p>For example, if <var>f</var> = 1/4,  for the first toss you bet £0.25, and if heads comes up you win £0.5 and so then have £1.5. You then bet £0.375 and if the second toss is tails, you have £1.125.</p>
<p>Choosing <var>f</var> to maximize your chances of having at least £1,000,000,000 after 1,000 flips, what is the chance that you become a billionaire?</p>
<p>All computations are assumed to be exact (no rounding), but give your answer rounded to 12 digits behind the decimal point in the form 0.abcdefghijkl.</p>

## Solution

Suppose you are betting a proportion $p$. If after $n$ flips you have a capital $C_n$ then there are two possible scenarios:

- You lose the flip, after which your capital will be $C_{n+1} = C_n \cdot (1 - p)$.

- You win the flip, after which your capital will be $C_{n+1} = C_n + 2 \cdot C_n \cdot p = C_n \cdot (1 + 2p)$.

Then it is clear that after $N$ flips, your final amount of capital will be:

$$
C_N = C_0 (1 + 2p)^W (1 - p)^{N - W}
$$

where $W$ is the number of flips you won. Then clearly:

$$
P(W) = {N \choose W} / 2^N
$$

Let $m(p)$ be the smallest integer with $0 \leq m(p) \leq N$ such that $C_N = C_0 (1 + 2p)^{m(p)} (1 - p)^{N - m(p)} \geq L$. Then the odds of having at least $L$ capital after $N$ flips is:

$$
\sum_{k = m(p)}^N P(k) = \frac{1}{2^N} \sum_{k = m(p)}^N {N \choose W}
$$

Notice that these odds are maximized when $m(p)$ is minimized.

Let's study a related equation:

$$
C_0 (1 + 2p)^m (1 - p)^{N - m} = L \\
(1 + 2p)^m (1 - p)^{N - m} = \frac{L}{C_0} \\
\ln(1 + 2p)m + \ln(1 - p)(N - m) = \ln(\frac{L}{C_0}) \\
\ln(\frac{1 + 2p}{1 - p})m = \ln(\frac{L}{C_0}) - \ln(1 - p) N \\
m = [\ln(\frac{L}{C_0}) - \ln(1 - p) N] / \ln(\frac{1 + 2p}{1 - p}) \\
m = [\ln(\frac{L}{C_0}) - \ln(1 - p) N] / [\ln(1 + 2p) - \ln(1 - p)] \\
$$

And by deriving with respect to $p$ we get:

$$
m' = ([\ln(1 + 2p) - \ln(1 - p)] \cdot [N / (1 - p)] - [\ln(\frac{L}{C_0}) - \ln(1 - p) N] \cdot [1 / (1 + 2p) + 1 / (1 - p)]) / [\ln(1 + 2p) - \ln(1 - p)]^2 \\
m' = [\ln(1 + 2p) N / (1 - p) - \ln(\frac{L}{C_0}) \cdot [1 / (1 + 2p) + 1 / (1 - p)] + \ln(1 - p)N / (1 + 2p)] / [\ln(1 + 2p) - \ln(1 - p)]^2 \\
$$

And the minimum value of $m$ is found when $m' = 0$. Therefore the numerator has to be $0$:

$$
\ln(1 + 2p) N / (1 - p) - \ln(\frac{L}{C_0}) \cdot [1 / (1 + 2p) + 1 / (1 - p)] + \ln(1 - p)N / (1 + 2p) = 0 \\
\ln(1 + 2p) / (1 - p) + \ln(1 - p) / (1 + 2p) = \frac{1}{N} \ln(\frac{L}{C_0}) \cdot [1 / (1 + 2p) + 1 / (1 - p)] \\
\ln(1 + 2p) (1 + 2p) + \ln(1 - p) (1 - p) = \frac{1}{N} \ln(\frac{L}{C_0}) \cdot [(1 + 2p) + (1 - p)] \\
\ln(1 + 2p) (1 + 2p) + \ln(1 - p) (1 - p) = \frac{2 + p}{N} \ln(\frac{L}{C_0}) \\
$$

We can assume that in the interval $p \in (0, 1)$ there is only one solution to this equation, and it can be found trivially using any root finding algorithm. Notice that this value of $p$ will produce the minimal value of $m$ and therefore should produce the minimal value of $m(p)$.

Finally, to calculate:

$$
\frac{1}{2^N} \sum_{k = m(p)}^N {N \choose W}
$$

consider the generating polynomial:

$$
(\frac{1}{2} + \frac{1}{2} x)^N
$$

Then the previous summation is the sum of the coefficients of $x^{m(p)}, x^{m(p) + 1}, \dots, x^N$.