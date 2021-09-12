# Pythagorean Odds

<p>Albert chooses a positive integer <var>k</var>, then two real numbers <var>a</var>, <var>b</var> are randomly chosen in the interval [0,1] with uniform distribution.<br />
The square root of the sum (<var>k</var>·<var>a</var>+1)<sup>2</sup> + (<var>k</var>·<var>b</var>+1)<sup>2</sup> is then computed and rounded to the nearest integer. If the result is equal to <var>k</var>, he scores <var>k</var> points; otherwise he scores nothing.</p>

<p>For example, if <var>k</var> = 6, <var>a</var> = 0.2 and <var>b</var> = 0.85, then (<var>k</var>·<var>a</var>+1)<sup>2</sup> + (<var>k</var>·<var>b</var>+1)<sup>2</sup> = 42.05.<br />
The square root of 42.05 is 6.484... and when rounded to the nearest integer, it becomes 6.<br />
This is equal to <var>k</var>, so he scores 6 points.</p>

<p>It can be shown that if he plays 10 turns with <var>k</var> = 1, <var>k</var> = 2, ..., <var>k</var> = 10, the expected value of his total score, rounded to five decimal places, is 10.20914.</p>

<p>If he plays 10<sup>5</sup> turns with <var>k</var> = 1, <var>k</var> = 2, <var>k</var> = 3, ..., <var>k</var> = 10<sup>5</sup>, what is the expected value of his total score, rounded to five decimal places?</p>

## Solution

Fix a value of $k$. Notice that we want to find the measure of the set $\{ (a, b) \mid a \in [0, 1], b \in [0, 1], (k - \frac{1}{2})^2 \leq (ka + 1)^2 + (kb + 1)^2 < (k + \frac{1}{2})^2 \}$ with respect to the set $[0, 1] \times [0, 1]$. The measure of $[0, 1] \times [0, 1]$ is $1$, therefore we only need to find the area of $\{ (a, b) \mid a \in [0, 1], b \in [0, 1], k^2 \leq (ka + 1)^2 + (kb + 1)^2 < (k + 1)^2 \}$. Notice that

$$
(k - \frac{1}{2})^2 \leq (ka + 1)^2 + (kb + 1)^2 < (k + \frac{1}{2})^2 \\
(k - \frac{1}{2})^2 \leq k^2 (a + \frac{1}{k})^2 + k^2 (b + \frac{1}{k})^2 < (k + \frac{1}{2})^2 \\
\frac{(k - \frac{1}{2})^2}{k^2} \leq (a + \frac{1}{k})^2 + (b + \frac{1}{k})^2 < \frac{(k + \frac{1}{2})^2}{k^2} \\
(1 - \frac{1}{2k})^2 \leq (a + \frac{1}{k})^2 + (b + \frac{1}{k})^2 < (1 + \frac{1}{2k})^2 \\
$$

Fix a distance $r$ from $(-\frac{1}{k}, -\frac{1}{k})$ to $(a,b)$. Then $(a + \frac{1}{k})^2 + (b + \frac{1}{k})^2 = r^2$. Thus

$$
(1 - \frac{1}{2k})^2 \leq r^2 < (1 + \frac{1}{2k})^2 \\
1 - \frac{1}{2k} \leq r < 1 + \frac{1}{2k} \\
$$

Let $R$ be the ring with center $(-\frac{1}{k}, -\frac{1}{k})$, inner radius of $1 - \frac{1}{2k}$ and outer radius of $1 + \frac{1}{2k}$. Then we want to find the area of $R \cap [0, 1] \times [0, 1]$. Notice that if $k = 1$, then the distance from the center to the origin is $\sqrt{2} > 1 - \frac{1}{2} = \frac{1}{2}$. Therefore $R \cap [0, 1] \times [0, 1] = R' \cap [0, 1] \times [0, 1]$ where $R'$ is a ring with same center and outer radius as $R$ and inner radius of $\sqrt{2}$. Now let $k \geq 2$. Then $d((-\frac{1}{k}, -\frac{1}{k}), (0, 0)) = \frac{\sqrt{2}}{k}$. But $\sqrt{2} + \frac{1}{2} < 2 \leq k$. Therefore $\frac{\sqrt{2}}{k} + \frac{1}{2k} < 1 \Rightarrow d((-\frac{1}{k}, -\frac{1}{k}), (0, 0)) < 1 - \frac{1}{2k}$. On the other hand $d((-\frac{1}{k}, -\frac{1}{k}), (0, 1))^2 = \frac{1}{k^2} + 1 + \frac{2}{k} + \frac{1}{k^2} = \frac{2}{k^2} + \frac{2}{k} + 1 > 1 + \frac{2}{k} > 1 + \frac{1}{2k}$. Therefore the inner and outer rings will always enter the $[0, 1] \times [0, 1]$ square from the left side and leave from the lower side. Thus, the area of the intersection equals one fourth of the area of the ring, minus two times the part of the ring with $0 \leq x < \frac{1}{k}$. Let $h = \frac{1}{k}$, $r_i$ be the inner ring of $R$ (or $R'$ when $k=1$) and $r_o$ be the outer ring of $R$. Then

$$
\begin{align*}
A(k)
&= \frac{\pi}{4} (r_o^2 - r_i^2) - 2 \int_{x=0}^{x=h} \int_{y=\sqrt{r_i^2 - x^2}}^{y=\sqrt{r_o^2 - x^2}} dy \: dx \\
&= \frac{\pi}{4} (r_o^2 - r_i^2) - 2 \int_{x=0}^{x=h} [ \sqrt{r_i^2 - x^2} - \sqrt{r_o^2 - x^2} ] dx \\
\end{align*}
$$

Finally, the integral of

$$
\int_{x=0}^{x=h} \sqrt{r^2 - x^2} dx
$$

can be solved by substituting $x = r \cos v$

$$
\begin{align*}
\int_{x=0}^{x=h} \sqrt{r^2 - x^2} dx
&= \int_{v = \pi / 2}^{v = \arccos(h/r)} \sqrt{r^2 - r^2 \cos^2 v} (-r \sin v) \ dv \\
&= -r^2 \int_{v = \pi / 2}^{v = \arccos(h/r)} \sqrt{1 - \cos^2 v} \cdot \sin v \ dv \\
&= -r^2 \int_{v = \pi / 2}^{v = \arccos(h/r)} \sin v \cdot \sin v \ dv \\
&= -r^2 \int_{v = \pi / 2}^{v = \arccos(h/r)} \sin^2 v \ dv \\
&= -r^2 \int_{v = \pi / 2}^{v = \arccos(h/r)} \frac{1 - \cos 2v}{2} \ dv \\
&= -\frac{r^2}{2} \int_{v = \pi / 2}^{v = \arccos(h/r)} 1 - \cos 2v \ dv \\
&= \frac{r^2}{2} [\frac{\sin 2v}{2} - v]_{v = \pi / 2}^{v = \arccos(h/r)} \\
\end{align*}
$$