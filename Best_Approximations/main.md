# Best Approximations

## Definition

To construct the Farey Sequence, start with $F_1 = \{ \frac{0}{1}, \frac{1}{1} \}$. Then take all consecutive numbers in the last row that haven't been completely used and compute their mediants. Add them to the row corresponding to their denominator in lowest terms. All the elements from the first row to the nth row in ascending order form the Farey sequence of order $n$, abbreviated to $F_n$.

## Lemma 0

If $a, b, c, d \in \mathbb{N}_{0}$ and $\frac{a}{b} < \frac{c}{d}$ then $\frac{a}{b} < \frac{a+c}{b+d} < \frac{c}{d}$.

Proof:

First:

$$
b (a + c) - a (b + d) = bc - ad > 0 \\
\: \\
b (a + c) > a (b + d) \\
\: \\
\frac{a+c}{b+d} > \frac{a}{b} \\
$$

Finally:

$$
c (b + d) - d (a + c) = bc - ad > 0 \\
\: \\
c (b + d) > d (a + c) \\
\: \\
\frac{c}{d} > \frac{a+c}{b+d} \\
$$

## Theorem 1

If $\frac{a}{b}$ and $\frac{c}{d}$ are consecutive terms in a Farey sequence of order $n$, then $bc - ad = 1$.

Proof: For $F_1 = \{ \frac{0}{1}, \frac{1}{1} \}$ this is clearly true. Now assume that this is true for $F_1, F_2, \dots, F_n$. Let $\frac{a}{b}$ and $\frac{c}{d}$ be consecutive terms in a $F_n$. Therefore $|bc - ad| = 1$. If $\frac{a}{b}$ and $\frac{c}{d}$ are consecutive in $F_{n + 1}$ then we are done. Otherwise, between them lies $\frac{a + c}{b + d}$. Notice that
$(b + d) c - (a + c) d = bc - ad = 1$ and $b (a + c) - a (b + d) = bc - ad = 1$, which prove the theorem.

## Corollary 2

Every fraction is in reduced form.

Proof: Suppose $\frac{a}{b}$ and $\frac{c}{d}$ are consecutive terms of $F_n$ and that $\frac{a}{b}$ is not in lowest terms. Suppose $r$ is a common divisor of both $a$ and $b$. Then $bc - ad \equiv 0 \: \text{(mod r)}$, which contradicts that $bc - ad = 1$.

## Corollary 3

The fractions are listed in order of their size.

Proof: Suppose $\frac{a}{b}$ and $\frac{c}{d}$ are consecutive terms of $F_n$. Then $bc - ad = 1 > 0$. Thus $\frac{c}{d} > \frac{a}{b}$.

## Theorem 4

If $\frac{a}{b}$ and $\frac{c}{d}$ are two consecutive fractions in $F_n$, then among all rational numbers between these two, $\frac{a + c}{b + d}$ x`is the unique fraction with the smallest denominator.

Proof: First, from the recursion process to construct the Farey sequences we must have that $\frac{a + c}{b + d}$ must appear first in $F_{b + d}$. Now consider any fraction $\frac{x}{y}$ between $\frac{a}{b}$ and $\frac{c}{d}$. Then:

$$
\frac{1}{bd} = \frac{c}{d} - \frac{a}{b} = (\frac{c}{d} - \frac{x}{y}) + (\frac{x}{y} - \frac{a}{b}) \\
\: \\
\frac{c}{d} - \frac{a}{b} = \frac{cy - dx}{dy} + \frac{bx - ay}{by} \geq \frac{1}{dy} + \frac{1}{by} = \frac{b + d}{bdy} \\
$$

Thus $\frac{b + d}{bdy} \leq \frac{1}{bd}$ or $b + d \leq y$. If $y > b + d$, then $\frac{x}{y}$ does not have least denominator among fractions between $\frac{a}{b}$ and $\frac{c}{d}$. If $y = b + d$ The inequality must become equality and  we get:

$$
\frac{cy - dx}{dy} + \frac{bx - ay}{by} = \frac{1}{dy} + \frac{1}{by} \\
$$

which implies $cy - dx = 1$ and $bx - ay = 1$. Thus:

$$
cy - dx = 1 \: \: \: \: \: \: bx - ay = 1 \\
acy - adx = a \: \: \: \: \: \: bcx - acy = c \\
bcx - adx = a + c \\
(bc - ad) x = a + c \\
x = a + c \\
$$

and hence $\frac{a + c}{b + d}$ is the unique rational fraction lying between $\frac{a}{b}$ and $\frac{c}{d}$ with denominator $b + d$.

## Theorem 5

If $0 \leq x \leq y$ with $\text{gcd}(x, y) = 1$ then the fraction $\frac{x}{y}$ appears in $F_y$ and all other Farey sequences of larger order.

Proof: This is clear if $y = 1$. Suppose it is true for $y = y_0 - 1$ with $y_0 > 1$. Then if $y = y_0$, the fraction $\frac{x}{y}$ cannot be in $F_{y - 1}$ by definition, and so it must lie between two consecutive fractions $\frac{a}{b}$ and $\frac{c}{d}$ of $F_{y - 1}$. Because $\frac{a + c}{b + d}$ is not in $F_{y - 1}$, then $b + d > y - 1$. But by Theorem 4 it must be that $y \geq b + d$. Thus $y = b + d$. Then the uniqueness part of Theorem 4 shows that $x = a + c$. Therefore $\frac{x}{y} = \frac{a + c}{b + d}$.

## Corollary 6

$F_n$ consists of all reduced fractions $\frac{a}{b}$ such that $0 \leq \frac{a}{b} \leq 1$ and $1 \leq b \leq n$. The fractions are listed in order of their size.

## Algorithm

Let $x$ be an irrational number. Let $F_n$ be the Farey sequence of order $n$, and let $\frac{a}{b}$ and $\frac{c}{d}$ be consecutive terms of $F_n$ such that $\frac{a}{b} < x < \frac{c}{d}$. That is, that $\frac{a}{b}$ is the best rational approximation below $x$ and $\frac{c}{d}$ is the best rational approximation above $x$. Then $\frac{a + c}{b + d}$ is the only element with least denominator in the range $\frac{a}{b} < x < \frac{c}{d}$. Then $\frac{a + c}{b + d}$ must be a better approximation of $x$ than either $\frac{a}{b}$ or $\frac{c}{d}$. And thus either $\frac{a}{b}$ or $\frac{c}{d}$ must be the other best approximation (either from above or below) in $F_r$. Using this we can perform Binary Search with bounded denominators, and the solution must be either the lower or the upper best approximation.

## Sources

- MNZ = I. Niven, H. S. Zuckerman, H. L. Montgomery, ”An Introduction
to the Theory of Numbers”, fifth edition, John Wiley & Sons, Inc., 1991, [http://www.fuchs-braun.com/media/532896481f9c1c47ffff8077fffffff0.pdf]
