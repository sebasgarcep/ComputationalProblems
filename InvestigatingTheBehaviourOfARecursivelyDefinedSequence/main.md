# Investigating the behaviour of a recursively defined sequence

<p>Given is the function <var>f</var>(<var>x</var>) = ⌊2<sup>30.403243784-<var>x</var><sup>2</sup></sup>⌋ × 10<sup>-9</sup> ( ⌊ ⌋ is the floor-function),<br />
the sequence <var>u<sub>n</sub></var> is defined by <var>u</var><sub>0</sub> = -1 and <var>u</var><sub><var>n</var>+1</sub> = <var>f</var>(<var>u<sub>n</sub></var>).</p>

<p>Find <var>u<sub>n</sub></var> + <var>u</var><sub><var>n</var>+1</sub> for <var>n</var> = 10<sup>12</sup>.<br />
Give your answer with 9 digits after the decimal point.</p>

## Solution

Examination of the sequence of values of $u_n + u_{n + 1}$ shows that they converge. To find this value, keep iterating until the difference between $u_n + u_{n + 1}$ and $u_{n - 1} + u_n$ is less than $10^{-10}$.