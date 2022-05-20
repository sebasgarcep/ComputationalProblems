# Powers With Trailing Digits

Let f(n) be the largest positive integer x less than 10<sup>9</sup> such that the last 9 digits of n<sup>x</sup> form the number <i>x</i> (including leading zeros), or zero if no such integer exists.

For example:

<ul><li>f(4) = 411728896 (4<sup>411728896</sup> = ...490<u>411728896</u>) </li>
<li>f(10) = 0</li>
<li>f(157) = 743757 (157<sup>743757</sup> = ...567<u>000743757</u>)</li>
<li><span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> f(n), 2 ≤ n ≤ 10<sup>3</sup> = 442530011399</li>
</ul>Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> f(n), 2 ≤ n ≤ 10<sup>6</sup>.

## Solution

Fix a value of $n$ and suppose $f(n) = x$. Let $g_n(y) = n^y \pmod {10^9}$. Then $g_n(x) = x$. Note that repeated applications of $g_n$ will generate distinct values until we reach a fixed point or a cycle. The following fact will help us prove our implementation's correctness.

### Lemma 1

$f(10n) = 0$

### Proof

Note that $g_{10n}(y) = 0$ for $y \ge 9$. On the other hand, if $y \lt 9$ then $g_{10n}(y) \gt y$ and therefore $g_{10n}(y) \not= y$ for all $y$, i.e. $f(10n) = 0$.