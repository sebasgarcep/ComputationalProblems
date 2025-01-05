# Step Numbers

Consider the number $45656$. <br>
It can be seen that each pair of consecutive digits of $45656$ has a difference of one.<br>
A number for which every pair of consecutive digits has a difference of one is called a step number.<br>
A pandigital number  contains every decimal digit from $0$ to $9$ at least once.<br>

How many pandigital step numbers less than $10^{40}$ are there?

## Solution

Let $S(n)$ be the number of pandigital step numbers with $n$ digits or less. Let $H(k, d, f_0, f_1, \dots, f_9)$ be the number of $k$-digit step numbers such that the last digit is $d$ and where $f_i$ is a binary flag that indicates whether the $i$-th digit has appeared in the decimal representation of the step number.

Then

$$
H(1, d, f_0, f_1, \dots, f_9) =
\begin{cases}
1 & \text{if } d > 0 \text{ and } \: f_i = \mathbb{1}_{i = d}, \: 0 \le i \le 9 \\
0 & \text{otherwise}
\end{cases}
$$

There is a clear recursion that springs from this definition for $k \ge 2$:

$$
H(k, d, f_0, f_1, \dots, f_9) =
\begin{cases}
0 & \text{if } f_d = 0 \\
\sum_{g = 0}^1 H(k - 1, d + 1, g, f_1, \dots, f_9) & \text{if } d = 0 \text{ and } f_d = 1 \\
\sum_{g = 0}^1 H(k - 1, d - 1, f_0, f_1, f_2, \dots, f_8, g) & \text{if } d = 9 \text{ and } f_d = 1 \\
\sum_{g = 0}^1 H(k - 1, d + 1, \dots, f_{d-1}, g, f_{d+1}, \dots) + \sum_{g = 0}^1 H(k - 1, d - 1, \dots, f_{d-1}, g, f_{d+1}, \dots) & \text{otherwise}
\end{cases}
$$

Finally

$$
S(n) = \sum_{k = 1}^n \sum_{d = 0}^9 H(k, d, 1, 1, \dots, 1)
$$

As an optimization, we can represent $(f_0, \dots, f_9)$ using a $10$ bit number.
