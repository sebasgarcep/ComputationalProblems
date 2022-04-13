# Polynomials with at least one integer root

<p>A root or zero of a polynomial P(<var>x</var>) is a solution to the equation P(<var>x</var>) = 0. <br />
Define P<sub><var>n</var></sub> as the polynomial whose coefficients are the digits of <var>n</var>.<br />
For example, P<sub>5703</sub>(<var>x</var>) = 5<var>x</var><sup>3</sup> + 7<var>x</var><sup>2</sup> + 3.</p>

<p>We can see that:</p><ul><li>P<sub><var>n</var></sub>(0) is the last digit of <var>n</var>,</li>
<li>P<sub><var>n</var></sub>(1) is the sum of the digits of <var>n</var>,</li>
<li>P<sub><var>n</var></sub>(10) is <var>n</var> itself.</li></ul><p>Define Z(<var>k</var>) as the number of positive integers, <var>n</var>, not exceeding <var>k</var> for which the polynomial P<sub><var>n</var></sub> has at least one integer root.</p>

<p>It can be verified that Z(100 000) is 14696.</p>

<p>What is Z(10<sup>16</sup>)?</p>

## Solution

Let $F(k) = Z(10^k)$. This is an easier function to compute so let's focus on it.

Suppose $d$ is a root of $P_n(x)$. Notice that if $d > 0$ then $P_n(d) > 0$. Therefore $d \le 0$. Furthermore, if $n = a_r a_{r-1} \dots a_0$ then by the rational root theorem $d \mid a_0$. Therefore $-9 \le d \le 0$. Moreover, this motivates considering each of the different cases for $a_0$ separately.

If $a_0 = 0$ then $d = 0$ is a root. Therefore this case contributes $10^{k-1}$ to $F(k)$.

Now suppose $a_0 \not= 0$ and $-d$ is an integer root of $P_n(x)$. Then

$$
a_0 - d a_1 + d^2 a_2 - \dots = 0 \\
\Rightarrow \frac{a_0}{d} + d a_2 + d^3 a_4 + \dots = a_1 + d^2 a_3 + \dots \\
$$

If $d^2 \ge 10$ then $a_{2r+1}\dots a_3 a_1$ is the unique base $d^2$ representation of $\frac{a_0}{d} + d a_2 + d^3 a_4$. Therefore, if $d^2 \ge 10$ we can iterate over all values $a_2, a_4, \dots$, generate the base $d^2$ representation of the LHS of the equation and check two things:

- The number of digits is not larger $r+1$
- Each digits is in the range $[0, 9]$

If $d^2 \lt 10$ then we can manually find all solutions by counting how many times a given value is generated by the LHS and how many times it is generated by the RHS. If both the LHS and RHS generate a given value, then the product of both counts gives the number of solutions. Now let's

Finally, when we find all polynomials that are divisible by a given root, we will overcount those which are divisible by more than one of the roots. Therefore we need to use the inclusion-exclusion principle to correct for this.