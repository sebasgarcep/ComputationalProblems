# Pizza Toppings

<p>You are given a pizza (perfect circle) that has been cut into <var>m</var>·<var>n</var> equal pieces and you want to have exactly one topping on each slice.</p>

<p>Let <var>f</var>(<var>m</var>,<var>n</var>) denote the number of ways you can have toppings on the pizza with <var>m</var> different toppings (<var>m</var> ≥ 2), using each topping on exactly <var>n</var> slices (<var>n</var> ≥ 1). <br />Reflections are considered distinct, rotations are not. </p>

<p>Thus, for instance, <var>f</var>(2,1) = 1, <var>f</var>(2,2) = <var>f</var>(3,1) = 2 and <var>f</var>(3,2) = 16. <br /><var>f</var>(3,2) is shown below:</p>

<div align="center"><img src="https://projecteuler.net/project/images/p281_pizza.gif" class="dark_img" alt="p281_pizza.gif" /></div>

<p>Find the sum of all <var>f</var>(<var>m</var>,<var>n</var>) such that <var>f</var>(<var>m</var>,<var>n</var>) ≤ 10<sup>15</sup>.</p>

## Solution

### Lemma

The number of arrangements around a circle of $n$ items belonging to $k$ distinct types is

$$
\frac{1}{n} \sum_{d \mid \gcd(n_1, \dots, n_k)} \varphi(d) {\binom {n/d} {n_1/d, \dots, n_k/d}}
$$

where $n_i$ is the number of items of type $i$ for $1 \le i \le k$ and $n = n_1 + \dots + n_k$.

### Proof

Let $X$ be the set of all colourings of the circle (rotations are considered distinct) and let $G$ be the group of all rotations generated by the rotation $2 \pi/ n$. Then $|G| = n$ and by Burnside's Lemma

$$
|X/G| = \frac{1}{|G|} \sum_{g \in G} |X^g| = \frac{1}{n} \sum_{g \in G} |X^g|
$$

and $|X/G|$ is the quantity we are trying to compute. Let's compute the summation to finish the proof.

Take a rotation of $2 \pi r / n$. Suppose it fixes an element $x \in X$. Then all the elements of type $i$ must map unto an element of type $i$ after rotation. This implies that the elements of type $i$ are symmetric under this rotation and $n_i$ rotations must return us to the initial element. In other words $r \cdot n_i \equiv 0 \pmod n \iff r \equiv 0 \pmod {n/\gcd(n, n_i)}$. By the Chinese Remainder Theorem

$$
r \equiv 0 \pmod {\text{lcm}(\frac{n}{\gcd(n, n_1)}, \dots, \frac{n}{\gcd(n, n_k)})}
$$

But it can be easily shown that

$$
\text{lcm}(\frac{n}{\gcd(n, n_1)}, \dots, \frac{n}{\gcd(n, n_k)}) = \frac{n}{\gcd(n_1, \dots, n_k)}
$$

Therefore

$$
r = s \frac{n}{\gcd(n_1, \dots, n_k)}
$$

for some $s$ such that $0 \le s \le \gcd(n_1, \dots, n_k) - 1$. Then any compliant rotation is (uniquely) of the form $2 \pi s / \gcd(n_1, \dots, n_k)$.

Equivalently, all compliant rotations are (uniquely) of the form $2 \pi t/d$ where $d \mid \gcd(n_1, \dots, n_k)$, $0 \le t \le d-1$ and $\gcd(t, d) = 1$. Notice that $t^{-1}$ modulo $d$ exists which implies that $t^{-1}$ (modulo $d$) applications of $2 \pi t/d$ end up being equivalent to a single application of $2 \pi/d$. On the other hand, $t$ applications of $2 \pi/d$ are clearly equivalent to a single application $2 \pi t/d$. Therefore for a given $d$, all compliant $t$ produce rotations with the same set of fixed elements, and there are $\varphi(d)$ such $t$.

Finally, for a given a $d$ pick $x \in X$ fixed by any rotation with denominator $d$. Because $d \mid n$, we can partition the circle into $d$ slices. Because the circle is fixed by a rotation of $2 \pi/d$, each slice has to be colored the same. Therefore we only free to choose the colors of one slice. By symmetry, this slice must have $n_i/d$ items of type $i$ for each $i = 1, \dots, k$. Thus there are

$$
\binom {n/d} {n_1/d, \dots, n_k/d}
$$

ways to color the slice. Which means that the rotation by $2 \pi/d$ fixes exactly that many elements from $X$. Putting everything together we get the desired result.

---

Applying the above formula, we get
$$
\begin{align*}
f(m, n)
&= \frac{1}{mn} \sum_{d \mid n} \varphi(d) {\binom {mn/d} {n/d, \dots, n/d}} \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) {\binom {md} {d, \dots, d}} \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \frac{(md)!}{d!^m} \\
\end{align*}
$$

And a lower bound can be found for $f(m, n)$

$$
\begin{align*}
f(m, n)
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \frac{(md)!}{d!^m} \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \prod_{k = 1}^m \prod_{i = 1}^d \frac{d(k - 1) + i}{i} \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \prod_{k = 1}^m \prod_{i = 1}^d \left[ \frac{d}{i} \cdot (k - 1) + 1 \right] \\
&\ge \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \prod_{k = 1}^m \prod_{i = 1}^d k \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \prod_{k = 1}^m k^d \\
&= \frac{1}{mn} \sum_{d \mid n} \varphi(n/d) \cdot m!^d \\
&\ge \frac{m!^n}{mn} \\
\end{align*}
$$

which gives us a stopping criteria when searching over the $n$ for a given $m$. We stop searching over the $m$ when $f(m, 1) = (m - 1)! \gt L$.