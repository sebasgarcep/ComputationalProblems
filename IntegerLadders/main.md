# Integer Ladders

Let $(x, y, h, w)$ be a solution. Clearly, $w < x < y$. Let $w_x$ be the portion of $w$ that goes from the vertex where the ladder of size $x$ begins to the point where both ladders meet. Analogously, let $w_y$ be the portion of $w$ that goes from the vertex where the ladder of size $y$ begins to the point where both ladders meet. Clearly $w = w_x + w_y$. Let $h_x$ be the distance from the floor to the point where the ladder of size $x$ meets the opposite wall. Define $h_y$ similarly, but using the ladder of size $y$. Then, using triangular congruences it is clear that $w_x / h = w / h_x$ and $w_y / h = w / h_y$. Thus:

$$w = w_x + w_y = wh / h_x + wh / h_y$$
$$1 = h / h_x + h / h_y$$
$$1 / h = 1 / h_x + 1 / h_y$$

But:

$$h_x = \sqrt{x^2 - w^2}, \: h_y = \sqrt{y^2 - w^2}$$

Clearly, these must be integers for there to be any solution at all. Therefore let:

$$x^2 - w^2 = s^2, \: y^2 - w^2 = t^2$$

Then $1 / h = 1 / s + 1/t = (s + t) / st$. Thus there is a solution if $s + t \: | \: st$. Finally, the values for $s$ and $t$ can be generated from the pythagorean triplets.

Therefore the solution is split into two parts:

1. Generate all pythagorean triples $(a, b, c)$ with $c < 10^6$ and put each triple into group $S_a$ and $S_b$.

2. For each pair of pythagorean triples in the same group, test whether $s + t \: | \: st$. If it is then save the tuple $(x, y, h)$ in a set, to cross out repeats.
