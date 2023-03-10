# Mex Sequence

In this problem $\oplus$ is used to represent the bitwise <strong>exclusive or</strong> of two numbers.<br />
Starting with blank paper repeatedly do the following:

- Write down the smallest positive integer $a$ which is currently not on the paper
- Find the smallest positive integer $b$ such that neither $b$ nor $(a \oplus b)$ is currently on the paper. Then write down both $b$ and $(a \oplus b)$.

After the first round $\{1,2,3\}$ will be written on the paper. In the second round $a=4$ and because $(4 \oplus 5)$, $(4 \oplus 6)$ and $(4 \oplus 7)$ are all already written $b$ must be $8$.

After $n$ rounds there will be $3n$ numbers on the paper. Their sum is denoted by $M(n)$.

For example, $M(10) = 642$ and $M(1000) = 5432148$.

Find $M(10^{18})$. Give your answer modulo $1\,000\,000\,007$.

## Solution

Let $P(n)$ be the paper after $n$ rounds, $m(S)$ be the minimum excluded positive value of the set $S$, $A(n)$ be the value of $a$ for round $n$, $B(n)$ be the value of $b$ for round $n$ and $C(n)$ be the value of $a \oplus b$ for round $n$. Then

$$
M(n) = M(n-1) + A(n) + B(n) + C(n) \\
P(n) = P(n-1) \cup \{ A(n), B(n), C(n) \} \\
A(n) = m(P(n-1)) \\
A(n) < B(n) \\
C(n) = A(n) \oplus B(n) \\
$$

Let $k$ be a positive integer and let $3n + 1 = 4^k$. We will prove that $P(n) = \{ 1, 2, \dots, 4^k - 1 \}$.

Note that this is true for $k = 1$. Now let's prove the inductive step. Suppose the statement is true for $k - 1$ and $3n + 1 = 4^k$. Let $n' = \frac{4^{k-1} - 1}{3}$. Clearly $A(i), B(i), C(i) \ge 4^{k-1}$ for all rounds $i$ after round $n'$. If we can prove that for all rounds $i$ between round $n' + 1$ and round $n$ we have $A(i), B(i), C(i) < 4^k$ then we are done as the number of elements added in these rounds is $3n - 3n' = (4^k - 1) - (4^{k-1} - 1) = 4^k - 4^{k-1}$ which is equal to the number of elements in $\{ 4^{k-1}, \dots, 4^k - 1 \}$.

Note that $A(i) < 4^k$ is trivially true, otherwise $4^k \le 3i \le 3n$ which contradicts $3n < 3n + 1 = 4^k$. Also $C(i)$ cannot have more bits than $A(i)$ and $B(i)$ so if we prove $B(i) < 4^k$ this implies $C(i) < 4^k$.

All the following calculations are to be done in base $4$. Consider the most significant digit of $A(i)$. It cannot be zero, otherwise $A(i)$ will be smaller than $4^{k-1}$. $A(i)$ also cannot share the most significant digit with $B(i)$ at the same position, otherwise $C(i) < 4^{k-1}$. Therefore $4^{k-1} \le A(i) < 2 \cdot 4^{k-1}, B(i) \ge 2 \cdot 4^{k-1}$ which implies $C(i) \ge 3 \cdot 4^{k-1}$ from bit manipulation. In particular $A(n' + 1) = 4^{k-1}, A(i) = A(i-1) + 1$ for $n' + 1 < i \le n$.

Consider the mapping

$$
0 \rightarrow 0 \\
1 \rightarrow 2 \\
2 \rightarrow 3 \\
3 \rightarrow 1 \\
$$

Apply this mapping for each digit of $A(i)$. Let the result be $\tau(A(i))$. Then one can see that $B(i) = \tau(A(i))$ by noticing that this works when $k = 2$, and if $k > 2$, start with the most significant digit and notice that digit cannot be smaller, otherwise we would create an element which is already in $P(i-1)$, and apply the same logic to each digit moving right. Because none of the digits can be changed, then $B(i) = \tau(A(i))$ must hold. This statement implies $B(i) < 4^k$, which finalizes the proof. Notice that $C(i) = \tau(B(i))$.

These statements allow us to efficiently calculate $M(n)$. Let $k = \lfloor \log_4(3n + 1) \rfloor$. Then $M(n) = \sum_{i = 1}^{4^k-1} i + \sum_{i = (4^k - 1)/3 + 1}^n \left[ A(i) + B(i) + C(i) \right]$. The first sum is trivial to calculate. To calculate the second notice that if a given digit is zero in $A(i)$ then it is zero in $B(i), C(i)$ and the sum at that position is $0$. If a given digit is non-zero then each of $A(i), B(i), C(i)$ will have a different element of the set $\{ 1, 2, 3 \}$ at that position and the sum of the digits will be $6$. Then

$$
\begin{align*}
\sum_{i = (4^k - 1)/3 + 1}^n \left[ A(i) + B(i) + C(i) \right]
&= 6 \cdot 4^k \cdot (n - (4^k - 1)/3) + \sum_{i = 0}^{n - (4^k - 1)/3 - 1} \left[ i + \tau(i) + \tau^2(i) \right]
\end{align*}
$$

where $\tau^2$ is just $\tau$ applied twice. Now let's find a way to efficiently compute the sum on the right. Let

$$
S(m) = \sum_{i = 0}^{m} \left[ i + \tau(i) + \tau^2(i) \right]
$$

Suppose $r$ is the largest integer such that $4^r \le m$. Then we can split $S$ into up to four sums, according to the digit in the $r$-th position of $i$, and extract the $r$-th digit for each subsum. Then the remaining sum after extraction will be $S$ evaluated at a smaller value. The extracted $r$-th digits either sum to $6$ or $0$, and we multiply this by the power of $4$ at that position times the number of digits we extracted.