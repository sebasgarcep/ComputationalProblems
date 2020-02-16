# Prime Factors of $n^{15} + 1$

Let $p \leq m$ be a prime and let $x < p$, be an integer such that $x^{15} + 1 \equiv 0 \: (\text{mod} \: p)$. Then all numbers of the form $k p + x \leq n$ are divisible by $p$. Therefore our problem reduces to finding the roots of $x^{15} + 1$ modulo $p$.

If $p \leq 30$, then $p = 2, 3, 5, 7, 11, 13, 17, 23, 29$. In each case the solutions are:

$$p = 2 \Rightarrow x = 1$$
$$p = 3 \Rightarrow x = 2$$
$$p = 5 \Rightarrow x = 4$$
$$p = 7 \Rightarrow x = 3, 5, 6$$
$$p = 11 \Rightarrow x = 2, 6, 7, 8, 10$$
$$p = 13 \Rightarrow x = 4, 10, 12$$
$$p = 17 \Rightarrow x = 16$$
$$p = 23 \Rightarrow x = 22$$
$$p = 29 \Rightarrow x = 28$$

Assume now that $p > 30$. Any solution $x$ satisfies that $x^{30} \equiv 1 \: (\text{mod} \: p)$, thus the order of $x$ is either $2, 6, 10, 30$ (as the order of $x$ cannot divide $15$). If $2$ is the order of $x$, then $x^2 \equiv 1 \: (\text{mod} \: p)$ and thus $x \equiv \pm 1 \: (\text{mod} \: p)$. But $1^{15} + 1 \not\equiv 0 \: (\text{mod} \: p)$. Thus $x = -1$. Now, for there to be any solutions with orders $6, 10, 30$, these numbers must divide the order of $\mathbb{Z}_p^*$.

If only $6$ divides the order $\mathbb{Z}_p^*$, then we only need to find solutions to $x^3 + 1 \equiv 0 \: (\text{mod} \: p)$, as these solutions will also be roots of $x^{15} + 1$. Similarly, if only $10$ divides the order of $\mathbb{Z}_p^*$ then we only need to find solutions to $x^5 + 1 \equiv 0 \: (\text{mod} \: p)$. If $30$ divides the order of $\mathbb{Z}_p^*$, then we can substitute $y = x^3$ and solve $y^5 + 1 \equiv 0 \: (\text{mod} \: p)$. Then we have to solve for $x^3 \equiv y \: (\text{mod} \: p)$, to find all solutions.

These observations suggest that we need a general algorithm to solve $x^3 \equiv a \: (\text{mod} \: p)$, and a way to solve $x^5 \equiv -1 \: (\text{mod} \: p)$.

## Solving $x^3 \equiv a \: (\text{mod} \: p)$

First, let $p = 2 \: (\text{mod} \: 3)$. Then:

$$z^p \equiv z \: (\text{mod} \: p)$$
$$z^{p - 1} \equiv 1 \: (\text{mod} \: p)$$

and multiplying both equations:

$$z^{2 p - 1} \equiv z \: (\text{mod} \: p)$$

Substituting $p = 3 p' + 2$:

$$z^{2 p - 1} = z^{6 p' + 3} = (z^{2 p' + 1})^3$$

Thus:

$$(z^{2 p' + 1})^3 = z \: (\text{mod} \: p)$$

Therefore $x_1 \equiv a^{2 p' + 1} \: (\text{mod} \: p)$ is one root of the cubic polynomial. Thus, there are some coefficients $c_0, c_1$ such that:

$$x^3 - a \equiv (x - x_1) (x^2 + c_1 x + c_0) \: (\text{mod} \: p)$$

Solving for these coefficients we get:

$$c_1 \equiv x_1 \: (\text{mod} \: p)$$
$$c_0 \equiv x_1^2 \: (\text{mod} \: p)$$

Therefore we are looking to factor $x^2 + x_1 x + x_1^2$. Let $v = x_1$ if $x_1$ is even, and $v = x_1 + p$ otherwise. Thus, $v$ is even. Then:

$$x^2 + x_1 x + x_1^2 \equiv x^2 + v x + v^2 \equiv x^2 + v x + \frac{v^2}{4} - \frac{v^2}{4} + v^2 \: (\text{mod} \: p)$$

$$x^2 + x_1 x + x_1^2 \equiv (x + v)^2 - \frac{v^2}{4} + v^2 \: (\text{mod} \: p)$$

Therefore, the roots of this quadratic satisfy:

$$(x + v)^2 \equiv \frac{v^2}{4} - v^2 \equiv -3 \frac{v^2}{4} \: (\text{mod} \: p)$$

Thus, this only has solutions if there are square roots for $-3 \: (\text{mod} \: p)$. We will now prove that $-3$ is a quadratic nonresidue modulo primes of the form $p = 3p' + 2$.

## Definition: Legendre symbol

The Legendre symbol $(\frac{n}{p})$, is defined as:

$$(\frac{n}{p}) = n^\frac{p - 1}{2}$$

## Euler's Criterion: Let $n$ be coprime to an odd prime $p$. Then $(\frac{n}{p}) = 1$ if and only if $n$ is a quadratic residue. Otherwise $(\frac{n}{p}) = -1$.

$\Leftarrow]$ If there is some $z$ such that $z^2 \equiv n \: (\text{mod} \: p)$, then:

$$(\frac{n}{p}) \equiv n^\frac{p - 1}{2} \equiv z^{p - 1} \equiv 1 \: (\text{mod} \: p)$$

$\Rightarrow]$ Clearly, $1^2, 2^2, ... , (\frac{p - 1}{2})^2$ are quadratic residue. Clearly, there are only two values of $z$ for which $z^2 \equiv k^2 \: (\text{mod} \: p)$, which are $z_1 = k$ and $z_2 = p - k$. If $z_1 \leq (\frac{p - 1}{2})^2$ then $z_2 > (\frac{p - 1}{2})^2$. Thus each of the $1^2, 2^2, ... , (\frac{p - 1}{2})^2$ are distinct quadratic residue. These also happen to be solutions to:

$$n^\frac{p - 1}{2} \equiv 1 \: (\text{mod} \: p)$$

Because this polynomial can have at most $\frac{p - 1}{2}$ roots, these are all the numbers which satisfy that polynomial. Therefore, if $n$ is not a quadratic residue, then it cannot satisfy $n^\frac{p - 1}{2} \equiv 1 \: (\text{mod} \: p)$. Because $n^{p - 1} \equiv 1 \: (\text{mod} \: p)$, then $n^\frac{p - 1}{2} \equiv -1 \: (\text{mod} \: p)$.

## Property: The Legendre symbol is completely multiplicative on its top argument

$$(\frac{n_1}{p}) (\frac{n_2}{p}) = n_1^\frac{p - 1}{2} n_2^\frac{p - 1}{2} = (n_1 n_2)^\frac{p - 1}{2} = (\frac{n_1 n_2}{p})$$

## Law of Quadratic Reciprocity: Let $p$ and $q$ be distinct odd primes. Then $(\frac{p}{q}) = -(\frac{q}{p})$ if $p \equiv q \equiv 3 \: (\text{mod} \: 4)$. Otherwise $(\frac{p}{q}) = (\frac{q}{p})$.

By the Chinese Remainder Theorem, the map:

$$\sigma: k \in \mathbb{Z}_{p q}^* \rightarrow (k, k) \in \mathbb{Z}_p^* \times \mathbb{Z}_q^*$$

is a bijection. It follows that if we took half of $\mathbb{Z}_{p q}^*$ it would get mapped to half of $\mathbb{Z}_p^* \times \mathbb{Z}_q^*$. Thus, let:

$$L := \{ \: k \in \mathbb{Z}_{p q}^* \: | \: 1 \leq k < \frac{p q}{2} \: \}$$
$$R := \{ \: (a, b) \in \mathbb{Z}_p^* \times \mathbb{Z}_q^* \: | \: 1 \leq b < \frac{q}{2} \: \}$$

Clearly, for each $(a, b) \in R$, we must have that $(a, b) = \sigma(\pm k) = \pm \sigma(k)$, for some $k \in L$. Thus:

$$\prod_{(a, b) \in R} (a, b) = \epsilon \prod_{k \in L} (k, k)$$

where $\epsilon$ is the product of the $\pm 1$. For brevity, set $P := \frac{p - 1}{2}$ and $Q := \frac{q - 1}{2}$. Then:

$$\prod_{(a, b) \in R} (a, b) = \prod_{a < p} \prod_{b < q / 2} (a, b)$$
$$= \prod_{a < p} (a^Q, Q!)$$
$$= ((p - 1)!^Q, Q!^{2 P})$$
$$= ((-1)^Q, Q!^{2 P})$$
$$= ((-1)^Q, (1^2 \times 2^2 \times ... \times Q^2)^P)$$
$$= ((-1)^Q, (1 \times 2 \times ... \times Q \times -1 \times -2 \times ... \times -Q \times (-1)^Q)^P)$$
$$= ((-1)^Q, ((q - 1)! \times (-1)^Q)^P)$$
$$= ((-1)^Q, (-1 \times (-1)^Q)^P)$$
$$= ((-1)^Q, (-1)^P (-1)^{P Q})$$

On the other hand, if we consider $\mathbb{Z}_p^*$:

$$\prod_{k \in L} k = \prod_{k < \frac{p q}{2}, \: (k, p q) = 1} k$$
$$= \prod_{k < \frac{p q}{2}, \: p \nmid k} k / (\prod_{k < \frac{p q}{2}, \: q | k} k)^{-1}$$
$$= \prod_{0 < k < p} k \prod_{p < k < 2 p} k \: ... \: \prod_{(Q - 1) p < k < Q p} k \prod_{Q p < k < p q / 2} k / (\prod_{k < \frac{p q}{2}, \: q | k} k)^{-1}$$
$$= \frac{(p - 1)!^Q}{q \times 2 q \times ... \times P q} \prod_{Q p < k < p q / 2} k$$

And using the fact that $\frac{p q}{2} - p Q = p (\frac{q}{2} - \frac{q - 1}{2}) = \frac{p}{2}$:

$$= \frac{(p - 1)!^Q}{q \times 2 q \times ... \times P q} \prod_{Q p < k < p q / 2} k$$
$$= \frac{(p - 1)!^Q}{q \times 2 q \times ... \times P q} \prod_{0 < k < p / 2} k$$
$$= \frac{(p - 1)!^Q P!}{q \times 2 q \times ... \times P q}$$
$$= \frac{(p - 1)!^Q P!}{P! q^P}$$
$$= \frac{(p - 1)!^Q}{q^P}$$

Using Wilson's theorem:

$$= \frac{(p - 1)!^Q}{q^P}$$
$$= \frac{(-1)^Q}{q^P}$$
$$= \frac{(-1)^Q}{(\frac{q}{p})}$$
$$= (-1)^Q (\frac{q}{p})$$

where the last step is possible as the Legendre symbol only takes the values $\pm 1$. By symmetry, in $\mathbb{Z}_q^*$:

$$\prod_{k \in L} k = (-1)^P (\frac{p}{q})$$

Thus:

$$\prod_{(a, b) \in R} (a, b) = \epsilon \prod_{k \in L} (k, k)$$

becomes:

$$((-1)^Q, (-1)^P (-1)^{P Q}) = \epsilon ((-1)^Q (\frac{q}{p}), (-1)^P (\frac{p}{q}))$$

By equating the first component:

$$(\frac{q}{p}) \cdot \epsilon \equiv 1 \: (\text{mod} \: p)$$
$$\epsilon \equiv (\frac{q}{p}) \: (\text{mod} \: p)$$

Substituting into the second component:

$$(\frac{p}{q}) \cdot \epsilon \equiv (-1)^{P Q} \: (\text{mod} \: q)$$
$$(\frac{p}{q}) \cdot (\frac{q}{p}) \equiv (-1)^{P Q} \: (\text{mod} \: q)$$
$$(\frac{p}{q}) \equiv (-1)^{P Q} (\frac{q}{p}) \: (\text{mod} \: q)$$

The result arises from realizing that if $p \equiv 1 \: (\text{mod} \: 4)$ implies $P$ is even. Similarly if $q \equiv 1 \: (\text{mod} \: 4)$, then $Q$ is even. In both cases $(-1)^{P Q} = 1$. If $p \equiv q \equiv 3 \: (\text{mod} \: 4)$, then both $P$ and $Q$ are odd, and thus $(-1)^{P Q} = -1$.

## For an odd prime, $p \not= 3$, $(\frac{3}{p}) = 1$ if $p \equiv 1, 11 \: (\text{mod} \: 12)$, and $(\frac{3}{p}) = -1$ if $p \equiv 5, 7 \: (\text{mod} \: 12)$.

1. If $p \equiv 1 \: (\text{mod} \: 12)$. Then $(\frac{3}{p}) = (\frac{p}{3}) = (\frac{1}{3}) = 1$.
2. If $p \equiv 5 \: (\text{mod} \: 12)$. Then $(\frac{3}{p}) = (\frac{p}{3}) = (\frac{2}{3}) = -1$.
3. If $p \equiv 7 \: (\text{mod} \: 12)$. Then $(\frac{3}{p}) = -(\frac{p}{3}) = -(\frac{1}{3}) = -1$.
4. If $p \equiv 11 \: (\text{mod} \: 12)$. Then $(\frac{3}{p}) = -(\frac{p}{3}) = -(\frac{2}{3}) = 1$.

Using the previous results, $p \equiv 5, 11 \: (\text{mod} \: 12)$. If $p \equiv 5 \: (\text{mod} \: 12)$ then $3$ is a quadratic nonresidue and $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv 1 \: (\text{mod} \: p)$, thus $-1$ is a quadratic residue, and therefore $-3$ is a quadratic nonresidue. If $p \equiv 11 \: (\text{mod} \: 12)$ then $3$ is a quadratic residue and $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv -1 \: (\text{mod} \: p)$, thus $-1$ is a nonquadratic residue, and therefore $-3$ is a quadratic nonresidue.

Now let $p \equiv 1 \: (\text{mod} \: 3)$. Suppose $x_1$ is a root of the polynomial. Then by setting $v$ just like before and by the same logic, the missing roots will be given by:

$$(x + v)^2 = -3 \frac{v^2}{4}$$

Which has roots if and only if $-3$ is a quadratic residue. If $p \equiv 1 \: (\text{mod} \: 12)$, then $3$ is a quadratic residue and $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv 1 \: (\text{mod} \: p)$, therefore $-3$ is a quadratic residue. Similarly, if $p \equiv 7 \: (\text{mod} \: 12)$, then $3$ is a quadratic nonresidue. But $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv -1 \: (\text{mod} \: p)$, and thus $-3$ is a quadratic residue. Therefore the cubic will either have no solutions, or three of them. The following statement allows us to prove when this cubic is solvable, or equivalently, when $a$ is a cubic residue.

## $a$ is a cubic residue if and only if $a^{(p - 1) / 3} \equiv 1 \: (\text{mod} \: p)$.

Let $g: x \rightarrow x^3$, where $g$ acts on $\mathbb{Z}_p^*$. Notice that $g(1) \equiv 1 \: (\text{mod} \: p)$. Therefore there are three values of $x$, for which $g(x) \equiv 1 \: (\text{mod} \: p)$. Thus $|\text{ker}(g)| = 3$. Thus, by the First Isomorphism theorem $|\text{im}(g)| = |\mathbb{Z}_p^*| / |\text{ker}(g)| = (p - 1) / 3$. Take $(p - 1) / 3$ distinct cubes, $a_1^3$, $a_2^3$, ..., $a_{(p - 1) / 3}^3$. Notice that these values satisfy the equation $a^{(p - 1) / 3} \equiv 1 \: (\text{mod} \: p)$, and that at most $(p - 1) / 3$ numbers can satisfy that equation. Thus the set of cubic residues is exactly the set of solutions to $a^{(p - 1) / 3} \equiv 1 \: (\text{mod} \: p)$.

## Proof: Cubic Tonelli-Shanks

Suppose $p \equiv 1 \: (\text{mod} \: 3)$, and $a$ is a cubic residue modulo $p$. Let $p - 1 = Q3^S$, where $Q \not\equiv 0 \: (\text{mod} \: 3)$. Note that if we try:

$$R \equiv a^{(Q + 1) / 3} \: (\text{mod} \: p)$$

Then:

$$R^3 \equiv a^{Q + 1} \equiv a a^Q \: (\text{mod} \: p)$$

Let $t \equiv a^Q \: (\text{mod} \: p)$. If $t \equiv 1 \: (\text{mod} \: p)$, then $R$ is the cubic root of $a$ and we are finished. Thus, let $t \not\equiv 1 \: (\text{mod} \: p)$. Then $t$ is a $3^{S - 1}$-th root of $1$ ($t^{3^{S - 1}} \equiv a^{Q3^{S - 1}} \equiv a^{(p - 1) / 3} \equiv 1 \: (\text{mod} \: p)$).

The algorithm will then try to find values for $R'$, $t'$ such that $t'$ is a $3^{S - 2}$-th root of $1$, and the relation $R^3 \equiv at' \: (\text{mod} \: p)$ still holds. Notice that if we can repeat this procedure an arbitrary number of times, the value of the exponent of $3$ will reduce by one in each iteration, until we have found a $3^0$-th root of $1$, thus until $t' \equiv 1 \: (\text{mod} \: p)$, and thus $R'^3 \equiv a \: (\text{mod} \: p)$. That is, until $R'$ is a cubic root of $a$.

If $t^{3^{S - 2}} \equiv 1 \: (\text{mod} \: p)$, then we only need to set $R' = R$, $t' = t$. Thus, suppose $t^{3^{S - 2}} \not\equiv 1 \: (\text{mod} \: p)$.

Notice that if $w$ is a root of $x^3 - 1$, distinct from 1, then:

$$(w^2)^3 - 1 \equiv ((w^3)^2 - 1 \equiv 1^2 - 1 \equiv 0 \: (\text{mod} \: p)$$.

Thus the roots of $x^3 - 1$ are $1$, $w$, $w^2$.

Now, because $t^{3^{S - 1}} \equiv 1 \: (\text{mod} \: p)$, then $t^{3^{S - 2}} \equiv w^e \: (\text{mod} \: p)$, where $e$ is either $1$ or $2$. To find $R'$, and $t'$, we have to multiply $R$ by a factor $b$. To mantain $R'^3 \equiv at' \: (\text{mod} \: p)$, we must multiply $t$ by $b^3$. Thus we need to find a value of $b$ such that $tb^3$ is a $3^{S - 2}$-th root of $1$. Suppose $t^{3^{S - 2}} \equiv w^e \: (\text{mod} \: p)$ and $z^{3^{S - 2}} \equiv w^f \: (\text{mod} \: p)$, for some $z$ such that $f = 1$, $2$. Then $b$ is either $z$ if $e + f \equiv 0 \: (\text{mod} \: 3)$ or $z^2$ if $e + 2f \equiv 0 \: (\text{mod} \: 3)$.

To find an useful value of $z$, let $z$ be any cubic non-residue. Then $(z^Q)^{3^{S - 1}} \equiv z^{Q3^{S - 1}} \equiv z^{(p - 1) / 3} \equiv w^f \: (\text{mod} \: p)$, with $f \not= 0$.

Finally, we would like to find arbitrary $3^{i + 1}$-th roots of $1$, such that the root we find is not a $3^i$-th root of $1$. Notice that:

$$(z^{Q 3^{S - i - 1}})^{3^{i}} \equiv z^{Q 3^{S - 1}} \equiv z^{(p - 1) / 3} \equiv w^f \: (\text{mod} \: p)$$

Thus $z^{Q 3^{S - i - 1}}$ serves this purpose.

Finally, because in each iteration $i$ (the smallest number for which $t^{3^i} \equiv 1 \: (\text{mod} \: p)$) is smaller, then $S - i - 1$, becomes larger. We can therefore use a variable $M$ to store the latest value of $i$ we have found (or $S$ in the first iteration). Notice that $0 < i < M$. Therefore $(z^Q)^{3^{S - i - 1}} = ((z^Q)^{3^{S - M + M - i - 1}} = ((z^Q)^{3^{S - M}})^{3^{M - i - 1}}$. Therefore on each iteration we can store $(z^Q)^{3^{M - i}}$, as $M$ will take the place of $S$ (upper limit for $i$) in each iteration, and $i$ will take the place of $M$ (after assignment) in each iteration.

These observations lead to the following algorithm:

## Algorithm: Cubic Tonelli-Shanks

Given prime $p \equiv 1 \: (\text{mod} \: 3)$, and a cubic residue $a$:

1. Find a cubic non-residue $z$.
2. Factor $p - 1 = Q3^S$.
3. Let

$$M \leftarrow S$$
$$c \leftarrow z^Q$$
$$w \leftarrow c^{3^{S - 1}}$$
$$t \leftarrow a^Q$$
$$R \leftarrow a^{(Q + 1) / 3}$$

4. Loop:
- If $t \equiv 0 \: (\text{mod} \: p)$ return $r = 0$.
- If $t \equiv 1 \: (\text{mod} \: p)$ return $r = R$.
- Otherwise find the least $i$, $0 < i < M$, such that $t^{3^i} \equiv 1 \: (\text{mod} \: p)$.
- If $t^{3^{i - 1}} \equiv w \: (\text{mod} \: p)$, then $b \leftarrow (c^{3^{M - i - 1}})^2$. Otherwise $b \leftarrow c^{3^{M - i - 1}}$.
- Set $t \leftarrow tb^3$, $R \leftarrow Rb$, $c \leftarrow b^3$, $M \leftarrow i$.

## Solving $x^5 \equiv -1 \: (\text{mod} \: p)$

Notice that:

$$x^{15} + 1 = (x + 1) (x^4 - x^3 + x^2 - x + 1)$$

Therefore $-1$ is a root of this polynomial. The other $4$ roots will be found in the quartic term, if they exist. Suppose that the quartic can be factorized into the product of two quadratics.

$$x^4 - x^3 + x^2 - x + 1 \equiv (x^2 + ax + b) (x^2 + cx + d) \: (\text{mod} \: p)$$

Then the coefficients $a, b, c, d$ have to satisfy:

$$-1 \equiv a + c \: (\text{mod} \: p)$$
$$1 \equiv b + d + ac \: (\text{mod} \: p)$$
$$-1 \equiv ad + bc \: (\text{mod} \: p)$$
$$1 \equiv bd \: (\text{mod} \: p)$$

Substituting $d \equiv b^{-1} \: (\text{mod} \: p)$ and $c \equiv -1 - a  \: (\text{mod} \: p)$ into the third equivalence:

$$-1 \equiv ab^{-1} + b(-1 - a) \: (\text{mod} \: p)$$
$$-1 \equiv ab^{-1} - b - ab \: (\text{mod} \: p)$$
$$b - 1 \equiv a (b^{-1} - b) \: (\text{mod} \: p)$$

Clearly, a solution to this equivalence is $b = 1$. Then $d = 1$. Thus, substituting into the second equivalence:

$$1 \equiv 1 + 1 + ac \: (\text{mod} \: p)$$
$$-1 \equiv a(-1 - a) \: (\text{mod} \: p)$$
$$-1 \equiv -a - a^2 \: (\text{mod} \: p)$$
$$a^2 + a - 1 \equiv 0 \: (\text{mod} \: p)$$
$$4a^2 + 4a - 4 \equiv 0 \: (\text{mod} \: p)$$
$$4a^2 + 4a + 1 - 1 - 4 \equiv 0 \: (\text{mod} \: p)$$
$$4a^2 + 4a + 1 \equiv 5 \: (\text{mod} \: p)$$
$$(2a + 1)^2 \equiv 5 \: (\text{mod} \: p)$$

Therefore there is a solution for $a$ whenever $5$ is a quadratic residue. Using the Legendre symbol we get, and the fact that $p \equiv 1 \: (\text{mod} \: 10)$ and thus $p \equiv 1 \: (\text{mod} \: 5)$:

$$(\frac{5}{p}) \equiv (\frac{p}{5}) \equiv (\frac{1}{5}) \equiv 1 \: (\text{mod} \: p)$$

Thus there are always solutions for $a$ and thus for $c$ also. Therefore we can factorize this quartic into the product of two quadratics. The problem then reduces to finding the roots of each quadratic. For this let's use $x^2 + ax + b$, without loss of generality:

$$x^2 + ax + b \equiv 0 \: (\text{mod} \: p)$$
$$x^2 + ax + (2^{-1} a)^2 - (2^{-1} a)^2 + b \equiv  0\: (\text{mod} \: p)$$
$$(x + 2^{-1} a)^2 \equiv (2^{-1} a)^2 - b \: (\text{mod} \: p)$$
