# Pseudo Square Root

The divisors of 12 are: 1,2,3,4,6 and 12.<br />
The largest divisor of 12 that does not exceed the square root of 12 is 3.<br />
We shall call the largest divisor of an integer <var>n</var> that does not exceed the square root of <var>n</var> the pseudo square root (PSR) of <var>n</var>.<br />
It can be seen that PSR(3102)=47.

Let <var>p</var> be the product of the primes below 190.<br />
Find PSR(<var>p</var>) mod 10<sup>16</sup>.

## Solution

Suppose $n$ is a squarefree number. Take the set of all primes that divide $n$ and split them into two sets. For each set calculate the product of all possible subsets and put them into an ordered list. Then for each element $p_l$ in one of the lists find the largest element $p_r$ from the other list such that $p_l p_r \le \sqrt{n}$. The Pseudo Square Root is the largest product of all such pairs.

Because the lists are ordered this can be efficiently done using binary search. Thus, once you have both lists the algorithm runs in $O(n \log n)$ time.