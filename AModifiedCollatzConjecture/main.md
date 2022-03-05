# A Modified Collatz sequence


A modified Collatz sequence of integers is obtained from a starting value $a_1$ in the following way:

$a_{n+1} = \, \,\, \frac {a_n} 3 \quad$ if $a_n$ is divisible by $3$. We shall denote this as a large downward step, "D".

$a_{n+1} = \frac {4 a_n+2} 3 \, \,$ if $a_n$ divided by $3$ gives a remainder of $1$. We shall denote this as an upward step, "U".


$a_{n+1} = \frac {2 a_n -1} 3 \, \,$ if $a_n$ divided by $3$ gives a remainder of $2$. We shall denote this as a small downward step, "d".




The sequence terminates when some $a_n = 1$.


Given any integer, we can list out the sequence of steps.<br />
For instance if $a_1=231$, then the sequence $\{a_n\}=\{231,77,51,17,11,7,10,14,9,3,1\}$ corresponds to the steps "DdDddUUdDD".


Of course, there are other sequences that begin with that same sequence "DdDddUUdDD....".<br />
For instance, if $a_1=1004064$, then the sequence is DdDddUUdDDDdUDUUUdDdUUDDDUdDD.<br />
In fact, $1004064$ is the smallest possible $a_1 \gt 10^6$ that begins with the sequence DdDddUUdDD.


What is the smallest $a_1 \gt 10^{15}$ that begins with the sequence "UDDDUdddDDUDDddDdDddDDUDDdUUDd"?

## Solution

Suppose we have a prefix string $s$ of length $k$. Then the last character of $s$ gives us the last transformation that occurred which took us from $a_k$ to $a_{k+1}$. This transformation implies $a_k \equiv r \pmod 3$ for some $r$ that depends on the last character of $s$. For example if the last character is $U$, then $a_k \equiv 1 \pmod 3$. Then we can replace $a_k$ with $a_{k-1}$ by using the transformation rule given by the next-to-last character of $s$. For example, if the next-to-last character is $d$ then $a_k = \frac{2a_{k-1} - 1}{3}$. Thus

$$
a_k \equiv r \pmod 3 \\
\Rightarrow \frac{2a_{k-1} - 1}{3} \equiv r \pmod 3 \\
\Rightarrow 2a_{k-1} - 1 \equiv 3r \pmod {3^2} \\
\Rightarrow a_{k-1} \equiv r' \pmod {3^2}
$$

for some constant $r'$. This procedure can be repeated for the remaining characters in $s$, until we exhaust it. This gives us a condition of the form $a_1 \equiv r'' \pmod {3^k}$ for some constant $r''$. Then solving the problem involves finding the smallest $a_1$ larger than the lower bound that satisfies the resulting modular equation.