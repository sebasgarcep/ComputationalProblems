# Finding numbers for which the sum of the squares of the digits is a square

For a positive integer <var>n</var>, let f(<var>n</var>) be the sum of the squares of the digits (in base 10) of <var>n</var>, e.g.
<p class="margin_left">f(3) = 3<sup>2</sup> = 9,<br />
f(25) = 2<sup>2</sup> + 5<sup>2</sup> = 4 + 25 = 29,<br />
f(442) = 4<sup>2</sup> + 4<sup>2</sup> + 2<sup>2</sup> = 16 + 16 + 4 = 36
Find the last nine digits of the sum of all <var>n</var>, 0 &lt; <var>n</var> &lt; 10<sup>20</sup>, such that f(<var>n</var>) is a perfect square.

## Solution

First, let's abstract the problem and set $N = 20$ (the maximum number of digits $n$) can have.

The order of the digits do not matter, so let's suppose a number $n$ has a $d_0$ number $0$ digits (including leading zeroes up to $N$-th digit), a $d_1$ number of $1$ digits, and so forth all the way up to $d_9$. Suppose $\sum_{i = 0}^9 d_i \cdot i^2$ is a square. Then $f(n)$ is a square. Thus we need to find all $d_0, \dots, d_9$ such that $d_0 + \dots + d_9 = N$, $0 \le d_0, \dots, d_9$ and the associated value of $\sum_{i = 0}^9 d_i \cdot i^2$ is a square.

Now we need to know for a given $d_0, \dots, d_9$, the sum of all values of $n$ with that number of $0$'s, $1$'s, $\dots$, and $9$'s. There are in total ${\frac{N!}{d_0! \dots d_9!}}$ possible values of $n$. Pick arbitrary $0 \le i \le 9$. Then we need to find how many times $d_i$ occurs in a given position. Notice that by symmetry this quantity (Let's call it $c_i$) must be the same for all positions. Thus the digit $i$ will contribute $d_i c_i (1 + 10 + \dots + 10^{N-1}) = d_i c_i \cdot \frac{10^N - 1}{9}$ to the overall sum.

If $d_i = 0$ then that digit does not contribute anything to the sum. Suppose $d_i > 0$. To find $c_i$, suppose the first digit is $i$. There are a total of $\frac{(N-1)!}{d_0! \dots (d_i - 1)! \dots d_9!}$ numbers that start with $i$. Thus $c_i = \frac{(N-1)!}{d_0! \dots (d_i - 1)! \dots d_9!}$.