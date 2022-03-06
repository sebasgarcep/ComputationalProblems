# Exploring the number of different ways a number can be expressed as a sum of powers of 2

<p>Define f(0)=1 and f(<var>n</var>) to be the number of different ways <var>n</var> can be expressed as a sum of integer powers of 2 using each power no more than twice.</p>
<p>For example, f(10)=5 since there are five different ways to express 10:</p>
<p class="margin_left">1 + 1 + 8<br />
1 + 1 + 4 + 4<br />1 + 1 + 2 + 2 + 4<br />
2 + 4 + 4<br />
2 + 8</p>
<p>What is f(10<sup>25</sup>)?</p>

## Solution

Suppose $c_0, \dots, c_k \in \{ 0, 1, 2 \}$ is a representation of $n$. Then

$$
n = c_0 + c_1 2 + \dots + c_k 2^k \\
n = c_0 + 2 \cdot (c_1 2^0 + \dots + c_k 2^{k-1}) \\
\frac{n - c_0}{2} = c_1 2^0 + \dots + c_k 2^{k-1} \\
$$

which implies $c_1, \dots, c_k \in \{ 0, 1, 2 \}$ is a representation of $\frac{n-c_0}{2}$. Thus if we fix $c_0$ there is a bijection between the representations of $n$ and $\frac{n-c_0}{2}$. Thus if $n$ is even we get $f(n) = f(n/2) + f((n-2)/2)$ and if $n$ is odd we get $f(n) = f((n-1)/2)$.