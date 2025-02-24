# Squarefree Fibonacci Numbers

The first $15$ Fibonacci numbers are:<br>
$1,1,2,3,5,8,13,21,34,55,89,144,233,377,610$.<br>
It can be seen that $8$ and $144$ are not squarefree: $8$ is divisible by $4$ and $144$ is divisible by $4$ and by $9$.<br> 
So the first $13$ squarefree Fibonacci numbers are:<br>
$1,1,2,3,5,13,21,34,55,89,233,377$ and $610$.

The $200$-th squarefree Fibonacci number is:
$971183874599339129547649988289594072811608739584170445$.<br>
The last sixteen digits of this number are: $1608739584170445$ and in scientific notation this number can be written as $9.7\mathrm e53$.

Find the $100\,000\,000$-th squarefree Fibonacci number.<br>
Give as your answer its last sixteen digits followed by a comma followed by the number in scientific notation (rounded to one digit after the decimal point).<br>
For the $200$th squarefree number the answer would have been: 1608739584170445,9.7e53

Note:<br> 
For this problem, assume that for every prime $p$, the first fibonacci number divisible by $p$ is not divisible by $p^2$ (this is part of <strong>Wall's conjecture</strong>). This has been verified for primes $\le 3 \cdot 10^{15}$, but has not been proven in general.<br>

If it happens that the conjecture is false, then the accepted answer to this problem isn't guaranteed to be the $100\,000\,000$-th squarefree Fibonacci number, rather it represents only a lower bound for that number.

## Solution

We want to find the position of the $N$-th squarefree number. For this we first make a guess about the upper bound for this position $G(N)$. We will use the guess $G(N) = 1.5 N$.

Suppose the position of the first $0$ in the sequence $F_n$ modulo $p$ is $k$. Note that the period for $p^2$ is either $kp$ or $k$, since $F_k \mod p^2 \equiv rp$. If $r \equiv 0 \pmod p$ then the period is $k$, otherwise it is $kp$ since $r \cdot x \equiv 0 \pmod p \Rightarrow x \equiv 0 \pmod p$. Then by the assumption in the problem, the period for $0$'s modulo $p^2$ is $kp$, since it cannot be $k$. Because of this we only need to consider primes up to $G(N)$. Furthermore we can ignore primes with periods larger than $G(N)/p$.

Once we know the period for each prime (and hence the period for $p^2$) we sieve the positions. We return the Fibonacci number for the $N$-th position that we didn't sieve through this process.
