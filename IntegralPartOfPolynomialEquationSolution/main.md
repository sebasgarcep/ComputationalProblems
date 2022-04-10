# Integer part of polynomial equation's solutions

<p>
For an <var>n</var>-tuple of integers <var>t</var> = (<var>a</var><sub>1</sub>, ..., <var>a</var><sub><var>n</var></sub>), let (<var>x</var><sub>1</sub>, ..., <var>x</var><sub><var>n</var></sub>) be the solutions of the polynomial equation <var>x</var><sup><var>n</var></sup> + <var>a</var><sub>1</sub><var>x</var><sup><var>n</var>-1</sup> + <var>a</var><sub>2</sub><var>x</var><sup><var>n</var>-2</sup> + ... + <var>a</var><sub><var>n</var>-1</sub><var>x</var> + <var>a</var><sub><var>n</var></sub> = 0.
</p>
<p>
Consider the following two conditions:
</p><ul><li><var>x</var><sub>1</sub>, ..., <var>x</var><sub><var>n</var></sub> are all real.
</li><li>If <var>x</var><sub>1</sub>, ..., <var>x</var><sub><var>n</var></sub> are sorted, ⌊<var>x</var><sub><var>i</var></sub>⌋ = <var>i</var> for 1 ≤ <var>i</var> ≤ <var>n</var>. (⌊·⌋: floor function.)
</li></ul><p>
In the case of <var>n</var> = 4, there are 12 <var>n</var>-tuples of integers which satisfy both conditions.<br />
We define S(<var>t</var>) as the sum of the absolute values of the integers in <var>t</var>.<br />
For <var>n</var> = 4 we can verify that <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> S(<var>t</var>) = 2087 for all <var>n</var>-tuples <var>t</var> which satisfy both conditions.
</p>
<p>
Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> S(<var>t</var>) for <var>n</var> = 7.
</p>

## Solution

Fix a value of $n$. Call all polynomials that satisfy the conditions for $n$ *compliant*. Suppose $g(x)$ is a compliant polynomial. Then, because $g$ must have exactly $n$ roots and each root must lie in the mutually exclusive ranges $[k, k+1)$ for all $k \in \{1, 2, \dots, n\}$ we must have

$$
\begin{align*}
g(n+1) &\gt 0 \\
g(n)   &\le 0 \\
g(n-1) &\ge 0 \\
\end{align*} \\
\vdots \\
$$

This gives us the following set of inequalities

$$
\begin{align*}
(n+1)^n + (n+1)^{n-1} a_1 + \dots + (n+1) a_{n-1} + a_n &\ge 0 \\
n^n + n^{n-1} a_1 + \dots + n a_{n-1} + a_n             &\le 0 \\
(n-1)^n + (n-1)^{n-1} a_1 + \dots + (n-1) a_{n-1} + a_n &\ge 0 \\
\end{align*} \\
\vdots \\
$$

Furthermore from Vieta's formulas we have $a_k = (-1)^k e_k(x_1, \dots, x_n)$ where $e_k$ is the $k$-th degree elementary symmetric polynomial in $n$ variables. Because $x_1, \dots, x_n \gt 0$ then

$$
a_1 \lt 0 \\
a_2 \gt 0 \\
\vdots \\
$$

This gives a set of inequalities that can be expressed as $Ax \le b$. Refer to Appendix $A$ for how to enumerate all possible solutions to such a system.

Notice that these bounds give necessary but not sufficient conditions for $g$ to be compliant. To check that $g$ is compliant we must check a few things.

First $g(n+1) \not= 0$.

Second we must check that no root has multiplicity $2$ or more. Notice that only the integer roots can appear repeated times ($g$ can satisfy all inequalities by taking a root in $[k, k+1)$ and moving it to $k+1$, and if $k+1$ is already a root it will appear with multiplicity $2$ in $g$). Suppose a root $r$ has multiplicity $k > 0$ in $g$. Then $g(x) = (x-r)^k h(x)$ for some polynomial $h(x)$ with $h(r) \not= 0$. Therefore $g'(x) = k (x-r)^{k-1} h(x) + (x-r)^k h'(x) = (x-r)^{k-1} (kh(x) + (x-r)h'(x))$. But $kh(x) + (x-r)h'(x)$ evaluated at $r$ gives us $kh(r) \not= 0$. Therefore the multiplicity of $r$ in $g'$ is $k-1$ which implies that $k \ge 2$ if and only if $r$ is a root of $g'$.

Finally we need to count how many roots there are in a range $[k, k+1)$. At most there can be two roots: one at $k$ and another in $(k, k+1)$. Suppose $h(x)$ is the polynomial $g(x)$ with all integer roots factored out. Thus if there is a root of $h(x)$ in the range $[k, k+1)$ it is in $(k, k+1)$. Because $h(k), h(k+1) \not= 0$ there is a root of $h(x)$ in $(k, k+1)$ if and only the signs of $h(k), h(k+1)$ are different. Thus $h(x)$ allows us to count non-integer roots, which allows us to determine if $g(x)$ is compliant.

## Appendix A: Fourier–Motzkin elimination - Finding the feasible solutions to a linear integer program (Anton_Lunyov approach)

Suppose we want to find all possible solutions to $Ax \le b$ where $x \in \R^n, b \in \R^m, A \in \R^{m \times n}$ and $n \geq 2$. Then for all $1 \le i \le m$ such that $A_{i, n} \not= 0$ we have

$$
A_{i,n} x_n \le b_i - \sum_j A_{i, j} x_j
$$

If $A_{i,n} \not= 0$ then add the expression $U_t(x_1, \dots, x_{n-1}) = b_i - \sum_j A_{i, j} x_j$ to a sequence $U$. Otherwise add the expression $L_s(x_1, \dots, x_{n-1}) = \sum_j A_{i, j} x_j - b_i$ to a sequence $L$. Then for all $s, t$ that go from $1$ to the length of the sequences $L, U$ respectively we have

$$
L_s(x_1, \dots, x_{n-1}) / |A_{i_s,n}| \le a_n \le U_t(x_1, \dots, x_{n-1}) / |A_{i_t,n}| \\
\Rightarrow L_s(x_1, \dots, x_{n-1}) / |A_{i_s,n}| \le U_t(x_1, \dots, x_{n-1}) / |A_{i_t,n}| \\
\Rightarrow L_s(x_1, \dots, x_{n-1}) \cdot \frac{\text{lcm}(|A_{i_s,n}|, |A_{i_t,n}|)}{|A_{i_s,n}|} \le U_t(x_1, \dots, x_{n-1}) \cdot \frac{\text{lcm}(|A_{i_s,n}|, |A_{i_t,n}|)}{|A_{i_t,n}|} \\
$$

which defines $|L| \cdot |U|$ new inequalities in the variables $x_1, \dots, x_{n-1}$. Notice that all $A_{i,n} = 0$ imply an inequality in the variables $x_1, \dots, x_{n-1}$. Therefore we can use these two sets of inequalities to build a new system of inequalities $A' x' \le b'$ where $x \in \R^{n-1}, b \in \R^{m'}, A \in \R^{m' \times (n-1)}$. All feasible solutions in the restricted problem will generate bounds for $x_n$.

If $n = 1$ then we simply need to check all the bounds and find the most restrictive ones for $x_1$. This can be done efficiently using the `max`, `cld` functions for the lower bounds $A_{i,1} \lt 0$ and the `min`, `fld` functions for the upper bounds $A_{i,1} \gt 0$.

One implementation aspect to take into account is that with each reduction the number of additional constraints grows exponentially. To avoid this issue, we can have hard bounds for all variables and if we have reduced enough variables the number of manual cases to check is not much and going this route is preferable to creating more constraints. One can also implement an algorithm that identifies redundant constraints, but that is non-trivial.

## Appendix B: Factoring roots from a polynomial

Suppose $r$ is a root of $f(x) = A_n x^n + A_{n-1} x^{n-1} + \dots + A_1 x + A_0$. Then there is a polynomial $g(x) = B_{n-1} x^{n-1} + B_{n-2} x^{n-2} + \dots + B_1 x + B_0$ such that $f(x) = (x-r) g(x)$. Then one can prove the following formulas by matching coefficients:

- $A_0 = -r B_0$
- $A_n = B_{n-1}$
- $A_i = B_{i-1} - rB_i$ for $1 \le i \lt n$

which can be rewritten as follows such that an implementation is obvious

- $B_0 = -A_0/r$
- $B_i = -(A_i - B_{i-1})/r$ for $1 \le i \lt n$
- $B_{n-1} = A_n$

## Appendix C: Using polymake to solve the system of equations

I originally used polymake to solve the system of linear inequalities. The script can be run by installing polymake and using the following command

```
polymake --script main.pl > lattice_points.txt
```

Then we can read the output file line by line and verify if the resulting polynomial is compliant using

```
julia polymake.jl
```

We need to make sure that the system of inequalities in `main.pl` and the value of $n$ in `polymake.jl` match each other.