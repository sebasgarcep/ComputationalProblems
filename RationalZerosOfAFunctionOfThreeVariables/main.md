# Rational zeros of a function of three variables

<p>For any integer <var>n</var>, consider the three functions</p>
<p class="margin_left"><var>f</var><sub>1,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) = <var>x</var><sup><var>n</var>+1</sup> + <var>y</var><sup><var>n</var>+1</sup> − <var>z</var><sup><var>n</var>+1</sup><br /><var>f</var><sub>2,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) = (<var>xy</var> + <var>yz</var> + <var>zx</var>)*(<var>x</var><sup><var>n</var>-1</sup> + <var>y</var><sup><var>n</var>-1</sup> − <var>z</var><sup><var>n</var>-1</sup>)<br /><var>f</var><sub>3,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) = <var>xyz</var>*(<var>x</var><sup><var>n</var>-2</sup> + <var>y</var><sup><var>n</var>-2</sup> − <var>z</var><sup><var>n</var>-2</sup>)</p>
<p>and their combination</p>
<p class="margin_left"><var>f</var><sub><var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) = <var>f</var><sub>1,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) + <var>f</var><sub>2,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) − <var>f</var><sub>3,<var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>)</p>
<p>We call (<var>x</var>,<var>y</var>,<var>z</var>) a golden triple of order <var>k</var> if <var>x</var>, <var>y</var>, and <var>z</var> are all rational numbers of the form <var>a</var> / <var>b</var> with<br />
0 &lt; <var>a</var> &lt; <var>b</var> ≤ <var>k</var> and there is (at least) one integer <var>n</var>, so that <var>f</var><sub><var>n</var></sub>(<var>x</var>,<var>y</var>,<var>z</var>) = 0.</p>
<p>Let <var>s</var>(<var>x</var>,<var>y</var>,<var>z</var>) = <var>x</var> + <var>y</var> + <var>z</var>.<br />
Let <var>t</var> = <var>u</var> / <var>v</var> be the sum of all distinct <var>s</var>(<var>x</var>,<var>y</var>,<var>z</var>) for all golden triples (<var>x</var>,<var>y</var>,<var>z</var>) of order 35.<br /> All the <var>s</var>(<var>x</var>,<var>y</var>,<var>z</var>) and <var>t</var>  must be in reduced form.</p>
<p>Find <var>u</var> + <var>v</var>.</p>


## Solution

It is very easy to show that

$$
f_n(x, y, z) = (x + y + z) (x^n + y^n - z^n)
$$

Therefore $(x, y, z)$ is a root of $f_n$ if and only if $x + y + z = 0$ or $x^n + y^n - z^n = 0$. Because $x, y, z > 0$ the first condition can't hold. Therefore let the second condition hold for a triple $(x, y, z)$. It is clear that $n \not= 0$. Assume that $n > 0$. Moreover, suppose

$$
x' = px \\
y' = py \\
z' = pz \\
$$

where $p$ is the smallest positive integer such that $x', y', z' \in \mathbb{N}$. Then

$$
x^n + y^n = z^n \\
\Rightarrow p^n (x^n + y^n) = p^n z^n \\
\Rightarrow (px)^n + (py)^n = (pz)^n \\
\Rightarrow (x')^n + (y')^n = (z')^n \\
$$
 
But due to Fermat's last theorem the last equation is only solvable in the positive integers if $n = 1$ or $n = 2$. Now suppose $n < 0$. Apply the mapping $n \rightarrow -n$. Then the following holds

$$
x^{-n} + y^{-n} = z^{-n} \\
\Rightarrow (\frac{1}{x})^n + (\frac{1}{y})^n = (\frac{1}{z})^n
$$

Now let

$$
x' = p / x \\
y' = p / y \\
z' = p / z \\
$$

where $p$ is the smallest positive integer such that $x', y', z' \in \mathbb{N}$. Then by a similar logic as before we can show that $n$ is either 1 or 2. Thus $f_n(x, y, z) = 0$ is only possible when $n \in \{ -2, -1, 1, 2 \}$. Because $k$ is small enough, we can brute force our way to the solution.