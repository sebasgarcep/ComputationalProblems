# Hybrid Integers

An integer of the form $p^q q^p$ with prime numbers $p \neq q$ is called a <i>hybrid-integer</i>.<br />
For example, $800 = 2^5 5^2$ is a hybrid-integer.

We define $C(n)$ to be the number of hybrid-integers less than or equal to $n$.<br />
You are given $C(800) = 2$ and $C(800^{800}) = 10790$

Find $C(800800^{800800})$

## Solution

Suppose $p \lt q$. Then

$$
p^q q^p \le n^e \iff q \log p + p \log q \le e \log n
$$

which gives us a manageable upper bound on $p, q$. Suppose $p = 2$. Then

$$
q \log 2 \le q \log 2 + 2 \log q \le e \log n \Rightarrow q \le e \log n / \log 2
$$

which gives us an upper bound for the prime search. Now for each $p$ not exceeding the upper bound on $q$ we can perform binary search on $q$ to find the largest $q$ that satisfies the upper bound on $p, q$. With the index of $p, q$ in the prime list we can calculate how many primes $q$ satisfy the inequality for a fixed $p$. If this number falls to $0$ or lower, then we no longer have to keep iterating over $p$.