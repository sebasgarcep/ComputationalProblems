# Platonic Dice

<p>
An unbiased single 4-sided die is thrown and its value, <var>T</var>, is noted.<br /><var>T</var> unbiased 6-sided dice are thrown and their scores are added together. The sum, <var>C</var>, is noted.<br /><var>C</var> unbiased 8-sided dice are thrown and their scores are added together. The sum, <var>O</var>, is noted.<br /><var>O</var> unbiased 12-sided dice are thrown and their scores are added together. The sum, <var>D</var>, is noted.<br /><var>D</var> unbiased 20-sided dice are thrown and their scores are added together. The sum, <var>I</var>, is noted.<br />
Find the variance of <var>I</var>, and give your answer rounded to 4 decimal places.
</p>

## Solution

Suppose you have a discrete probability function $P_n$ for $n = 1, \dots, k$. Consider the generating function

$$
G(x) = \sum_{n = 1}^k P_n x^n
$$

therefore

$$
G'(x) = \sum_{n = 1}^k n P_n x^{n - 1} \Rightarrow E[n] = G'(1) \\
G''(x) = \sum_{n = 2}^k n (n - 1) P_n x^{n - 2} = \sum_{n = 2}^k (n^2 - n) P_n x^{n - 2} \Rightarrow E[n^2] = G''(1) + G'(1) \\
\text{Var}[n] = E[n^2] - E[n]^2 = G''(1) + G'(1) - G'(1)^2 \\
$$

Let the generating function for a $t$-sided platonic dice be

$$
G_t(x) = \sum_{n = 1}^t x^n \\
$$

Then the generating function for the process defined in the problem is

$$
G_p(x) = G_{20}(G_{12}(G_{8}(G_{6}(G_{4}(x)))))
$$

and the result will be $G_p''(1) + G_p'(1) - G_p'(1)^2$.