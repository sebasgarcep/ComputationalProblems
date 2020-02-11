# Prime Factors of $n^{15} + 1$ (FIXME: not finished yet)

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

Therefore we are looking to factor $x^2 + x_1 x + x_1^2$. Let $w = x_1$ if $x_1$ is even, and $w = x_1 + p$ otherwise. Thus, $w$ is even. Then:

$$x^2 + x_1 x + x_1^2 \equiv x^2 + w x + w^2 \equiv x^2 + w x + \frac{w^2}{4} - \frac{w^2}{4} + w^2 \: (\text{mod} \: p)$$

$$x^2 + x_1 x + x_1^2 \equiv (x + w)^2 - \frac{w^2}{4} + w^2 \: (\text{mod} \: p)$$

Therefore, the roots of this quadratic satisfy:

$$(x + w)^2 \equiv \frac{w^2}{4} - w^2 \equiv -3 \frac{w^2}{4} \: (\text{mod} \: p)$$

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

Now let $p \equiv 1 \: (\text{mod} \: 3)$. Suppose $x_1$ is a root of the polynomial. Then by setting $w$ just like before and by the same logic, the missing roots will be given by:

$$(x + w)^2 = -3 \frac{w^2}{4}$$

Which has roots if and only if $-3$ is a quadratic residue. If $p \equiv 1 \: (\text{mod} \: 12)$, then $3$ is a quadratic residue and $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv 1 \: (\text{mod} \: p)$, therefore $-3$ is a quadratic residue. Similarly, if $p \equiv 7 \: (\text{mod} \: 12)$, then $3$ is a quadratic nonresidue. But $(\frac{-1}{p}) \equiv (-1)^\frac{p - 1}{2} \equiv -1 \: (\text{mod} \: p)$, and thus $-3$ is a quadratic residue. Therefore the cubic will either have no solutions, or three of them.

FIXME: show how to find $x_1$, and use Tonelli-Shanks to solve for the other two roots.

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
