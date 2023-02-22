# Shortest distance among points

We create an array of points  $P_n$ in a two dimensional plane using the following random number generator:<br />
$s_0=290797$<br />
$s_{n+1}={s_n}^2 \bmod 50515093$
<br /> <br />
$P_n=(s_{2n},s_{2n+1})$

Let $d(k)$  be the shortest distance of any two (distinct) points among $P_0, \cdots, P_{k - 1}$.<br />
E.g. $d(14)=546446.466846479$


Find $d(2000000)$. Give your answer rounded to 9 places after the decimal point.

## Solution

Let $S$ be a set of points, and $d(S)$ be the shortest distance between any two points in the set. Pick $x$ and divide $S$ into points left of the $x$-coordinate ($L$) and points rights of the $x$-coordinate ($R$). Let $t = \min(d(L), d(R))$ and pick all the points with $x$-coordinate in the range $[x-t/2,x+t/2]$ (which can be done in logarithmic time). Let that set be $M$. Note that if you pick a point from $L \setminus M$ and another from $R \setminus M$ their distance will be at least larger than $t$. Then $d(S) = \min(t, d(M))$.

One optimization that can be done is to keep track of the smallest $r := d(S)$ found yet and using $t = \min(r, d(L), d(R))$ instead of the original definition of $t$.