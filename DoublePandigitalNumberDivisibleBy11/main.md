# Double pandigital number divisible by 11

<p>We call a positive integer <i>double pandigital</i> if it uses all the digits 0 to 9 exactly twice (with no leading zero). For example, 40561817703823564929 is one such number.</p>

<p>How many double pandigital numbers are divisible by 11?</p>
 
## Solution

Let $p \not= 2, 5$ be a prime number and let $f_p(k, d_0, d_1, \dots, d_9)$ the amount of positive integers $t$ that use the digit $0$ $d_0$ times, the digit $1$ $d_1$ times and so forth, that also satisfy $t \equiv k \pmod p$. We therefore want to calculate $f_{11}(0, 2, \dots, 2)$. To achieve this notice that

$$
f_p(k, d_0, d_1, \dots, d_9) = \sum_{\substack{0 \le r \le 9 \\ 10k' + r \equiv k \pmod p \\ d_i' \ge 0, \: i = 0, \dots, 9 \\ d_i' + 1_{i = r} = d_i, \: i = 0, \dots, 9}} f_p(k', d_0', \dots, d_9')
$$

with base cases

$$
f_p(k, 0, \dots, 0) = 0 \\
f_p(k, 1, 0, \dots, 0) = 0 \\
f_p(k, 0, d_1, \dots, d_9) = 1_{k \equiv i \pmod p}, \text{with } d_j = 1_{j = i} \text{ for } i, j = 1, \dots, 9 \\
$$