# Chinese leftovers II

We are interested in calculating $A_k$, using $A_{k - 1}$. Notice that:

$$A_{k-1} \equiv 1 \: (\text{mod} \: 2)$$
$$A_{k-1} \equiv 2 \: (\text{mod} \: 3)$$
$$...$$
$$A_{k-1} \equiv k - 1 \: (\text{mod} \: p_{k - 1})$$

And $A_k$ only has one more restriction:

$$A_k \equiv k \: (\text{mod} \: p_k)$$

Clearly $A_k = A_{k - 1} + m_k p_1 p_2 ... p_{k - 1}$, where $m_k$ is some integer. Thus:

$$A_k \equiv k \: (\text{mod} \: p_k)$$
$$A_{k - 1} + m_k p_1 p_2 ... p_{k - 1} \equiv k \: (\text{mod} \: p_k)$$
$$m_k p_1 p_2 ... p_{k - 1} \equiv k - A_{k - 1} \: (\text{mod} \: p_k)$$
$$m_k \equiv (k - A_{k - 1}) (p_1 p_2 ... p_{k - 1})^{-1} \: (\text{mod} \: p_k)$$

Notice that the value of $m_k$ we are looking for is the smallest one in the range $[0, p_k)$. Thus, solving for $m_k \: (\text{mod} \: p_k)$ gives us the value for $m_k$.

Suppose we know the values for $m_1$, $m_2$, ... , $m_{k-1}$. Then we can obtain $A_{k-1}$ using:

$$A_{k-1} = m_1 + m_2 p_1 + m_3 p_1 p_2 + ... + m_{k - 1} p_1 p_2 ... p_{k - 2}$$

which is obtained by expanding $A_k = A_{k - 1} + m_k p_1 p_2 ... p_{k - 1}$. Then finding the value for $m_k$ reduces to substituting the different elements in the equation $m_k \equiv (k - A_{k - 1}) (p_1 p_2 ... p_{k - 1})^{-1} \: (\text{mod} \: p_k)$.

Finally, notice that if $p_k$ will not divide $A_j$ if $j \geq k$, as $A_j \equiv k \: (\text{mod} \: p_k)$. Therefore for each prime, we only need to test divisibility up to $A_{k - 1}$.

These observations lead to the following algorithm:

## Approach

1. Find all primes up to $n$ using a prime sieve.
2. For each prime $p_k$:
    1. Generate all values of $A_j \: (\text{mod} \: p_k)$, $j = 1, 2, ... , k - 1$ using the known values of $m_j$.
    2. If any of these $A_j \equiv 0 \: (\text{mod} \: p_k)$, mark $p_k$.
    3. Generate $m_k$ and save it.
3. Sum all the marked primes and return the value of the sum.
