# Eating pie

<p>
Jeff eats a pie in an unusual way.<br />
The pie is circular. He starts with slicing an initial cut in the pie along a radius.<br />
While there is at least a given fraction <var>F</var> of pie left, he performs the following procedure:<br />
- He makes two slices from the pie centre to any point of what is remaining of the pie border, any point on the remaining pie border equally likely. This will divide the remaining pie into three pieces.<br /> 
- Going counterclockwise from the initial cut, he takes the first two pie pieces and eats them.<br />
When less than a fraction <var>F</var> of pie remains, he does not repeat this procedure. Instead, he eats all of the remaining pie.
</p>
<p align="center">
<img src="https://projecteuler.net/project/images/p394_eatpie.gif" alt="p394_eatpie.gif" /></p>


<p>
For <var>x</var> ≥ 1, let E(<var>x</var>) be the expected number of times Jeff repeats the procedure above with <var>F</var> = <sup>1</sup>/<sub><var>x</var></sub>.<br />
It can be verified that  E(1) = 1, E(2) ≈ 1.2676536759, and E(7.5) ≈ 2.1215732071.
</p>
<p>
Find E(40) rounded to 10 decimal places behind the decimal point.
</p>

## Solution

Notice that the area of the pie taken is proportional to arc length of the pie taken. Therefore the proportion of the pie taken on each cut is uniformly distributed.

Suppose $y_i$ is the fraction of the pie left after the $i$-th step, relative to how it was in the previous step. So if we have $1/2$ pie at step $i-1$ and $y_i = 1/4$ then we are left with $1/8$ pie after step $i$. Let $z_i$ be the fraction of the pie left after the $i$-th step, relative to the initial, complete pie. Thus $z_0 = 1$, $z_i = y_1 \dots y_i$. Let $y_i \sim Y_i, z_i \sim Z_i$, where $Y_i, Z_i$ are random variables. Then

$$
\begin{align*}
E(x) = \sum_{i = 1}^{\infty} i \cdot P(Z_{i-1} \ge \frac{1}{x} \cap Z_i \lt \frac{1}{x})
\end{align*}
$$

where $P(Z_0 \ge \frac{1}{x}) = 1$, as $z_0 = 1 \ge \frac{1}{x} \iff x \ge 1$.

### CDF and PDF of $Y_i$

Notice that the $Y_i$ are independent and identically distributed. Therefore, take any of them and call it $Y$. Suppose $X$ is the uniform distribution from $0$ to $1$. Then $Y = \min(X, X)$ which implies for $y \in (0, 1)$ that

$$
\begin{align*}
P(Y \ge y)
&= P(X \ge y, X \ge y) \\
&= P(X \ge y) \cdot P(X \ge y) \\
&= P(X \ge y)^2 \\
&= (1-y)^2 \\
\end{align*}
$$

which gives a probability density function for $Y$ in the same interval of

$$
f_Y(y) = -\frac{d}{dy} P(Y \ge y) = 2-2y
$$

where the negative sign comes from the fact that

$$
\int_0^y f_Y(y)\, dy = P(Y \le y) = 1 - P(Y \ge y)
$$

### PDF of $Z_i$

First let's prove a theorem about the PDF of products of independent random variables.

### Lemma: PDF of product of independent random variables

If $X$ and $Y$ are two independent, continuous random variables, described by probability density functions $f_X$ and $f_Y$, respectively, then the probability density function of $Z = XY$ is

$$
f_Z(z) = \int_{-\infty}^\infty f_X(x) f_Y(y) \frac{1}{|x|} \, dx
$$

### Proof:

$$
\begin{align*}
P(Z \le z)
&= P(XY \le z) \\
&= P(Y \le \frac{z}{X}, X \gt 0) + P(Y \ge \frac{z}{X}, X \lt 0) \\
&= \int_0^\infty f_X(x) \int_{-\infty}^{z/x} f_Y(y) \, dy \, dx
+ \int_{-\infty}^0 f_X(x) \int_{z/x}^\infty f_Y(y) \, dy \, dx \\
\end{align*}
$$

Taking the derivative with respect to $Z$ of both sides (applying the fundamental theorem of calculus and the chain rule) gives us

$$
\begin{align*}
f_Z(z)
&= \int_0^\infty f_X(x) f_Y(z/x) \frac{1}{x} \, dx
- \int_{-\infty}^0 f_X(x) f_Y(z/x) \frac{1}{x} \, dx \\
&= \int_0^\infty f_X(x) f_Y(z/x) \frac{1}{|x|} \, dx
+ \int_{-\infty}^0 f_X(x) f_Y(z/x) \frac{1}{|x|} \, dx \\
&= \int_{-\infty}^\infty f_X(x) f_Y(z/x) \frac{1}{|x|} \, dx
\end{align*}
$$

---

Now let's study the structure of $Z_i$. Because $Z_1 = Y_1$, then $f_{Z_1}(z) = 2(1-z)$. From the previous theorem the following must hold

$$
\begin{align*}
f_{Z_i}(z)
&= \int_z^1 f_{Z_{i-1}}(y) f_{Y_i}(z/y) \cdot \frac{1}{y}\, dy \\
&= \int_z^1 f_{Z_{i-1}}(y) (2-2z/y) \cdot \frac{1}{y}\, dy \\
&= 2 \int_z^1 f_{Z_{i-1}}(y) (1-z/y) \cdot \frac{1}{y}\, dy \\
\end{align*}
$$

Now we will prove that $f_{Z_i}$ is of the following form:

$$
f_{Z_i}(z) = 2^i \sum_{k = 0}^{i-1} (A_{i,k} z + B_{i,k}) \log^k(z)
$$

Proof: 
$$
\begin{align*}
f_{Z_i}(z)
&= 2 \int_z^1 f_{Z_{i-1}}(y) \cdot (1-z/y) \cdot \frac{1}{y}\, dy \\
&= 2 \int_z^1 \left( 2^{i-1} \sum_{k = 0}^{i-2} (A_{i-1,k} y + B_{i-1,k}) \log^k(y) \right) \cdot (1-z/y) \cdot \frac{1}{y}\, dy \\
&= 2^i \sum_{k = 0}^{i-2} \int_z^1 (A_{i-1,k} y + B_{i-1,k}) \log^k(y) \cdot (1-z/y) \cdot \frac{1}{y}\, dy \\
&= 2^i \sum_{k = 0}^{i-2} \int_z^1 (A_{i-1,k} + B_{i-1,k} / y) \log^k(y) \cdot (1-z/y) \, dy \\

&= 2^i \sum_{k = 0}^{i-2} \int_z^1 A_{i-1,k} \log^k(y) + B_{i-1,k} \log^k(y) / y - z A_{i-1,k} \log^k(y) / y - z B_{i-1,k} \log^k(y) / y^2 \, dy \\

&= 2^i \sum_{k = 0}^{i-2} \int_z^1 A_{i-1,k} \log^k(y) \, dy
+ 2^i \sum_{k = 0}^{i-2} \int_z^1 B_{i-1,k} \log^k(y) / y  \, dy \\
&- 2^i \sum_{k = 0}^{i-2} \int_z^1 z A_{i-1,k} \log^k(y) / y  \, dy
- 2^i \sum_{k = 0}^{i-2} \int_z^1 z B_{i-1,k} \log^k(y) / y^2 \, dy \\

&= 2^i \sum_{k = 0}^{i-2} A_{i-1,k} \int_z^1 \log^k(y) \, dy \\
&+ 2^i \sum_{k = 0}^{i-2} (B_{i-1,k} - z A_{i-1,k}) \int_z^1 \log^k(y) / y  \, dy \\
&- 2^i \sum_{k = 0}^{i-2} z B_{i-1,k} \int_z^1 \log^k(y) / y^2 \, dy \\
\end{align*}
$$

Notice that

$$
\frac{d}{dy} \left[ \frac{\log^{k+1}(y)}{k+1} \right] = \frac{\log^k(y)}{y} \iff \frac{\log^{k+1}(y)}{k+1} + K = \int \frac{\log^k(y)}{y} \, dy
$$

On the other hand

$$
\begin{align*}
\int \log^k(y) \, dy
&= y \log^k(y) - \int y \cdot k \cdot \log^{k-1}(y) \cdot \frac{1}{y} \, dy \\
&= y \log^k(y) - k \int \log^{k-1}(y) \, dy \\
&= y \log^k(y) - k y \log^{k-1}(y) + k (k-1) y \log^{k-2}(y) - \dots \\
&= y \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(y)}{r!} + K \\
\end{align*}
$$

Finally

$$
\begin{align*}
\int \log^k(y) / y^2 \, dy
&= - \log^k(y) / y + \int k \log^{k-1}(y) / y^2 \, dy \\
&= - \log^k(y) / y + k \int \log^{k-1}(y) / y^2 \, dy \\
&= - \log^k(y) / y - k \log^{k-1}(y)/y - k(k-1) \log^{k-2}(y)/y - \dots \\
&= -\frac{k!}{y} \sum_{r=0}^k \frac{\log^r(y)}{r!} + K \\
\end{align*}
$$

Substituting these integrals back into the formula for $f_{Z_i}(z)$ proves the statement about the form of $f_{Z_i}(z)$. Now we need to find the coefficients of $f_{Z_i}(z)$ in terms of the coefficients of $f_{Z_{i-1}}(z)$.

$$
\begin{align*}
f_{Z_i}(z)
&= 2^i \sum_{k = 0}^{i-2} A_{i-1,k} \int_z^1 \log^k(y) \, dy \\
&+ 2^i \sum_{k = 0}^{i-2} (B_{i-1,k} - z A_{i-1,k}) \int_z^1 \log^k(y) / y  \, dy \\
&- 2^i \sum_{k = 0}^{i-2} z B_{i-1,k} \int_z^1 \log^k(y) / y^2 \, dy \\

&= 2^i \sum_{k = 0}^{i-2} A_{i-1,k} \left[ y \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(y)}{r!} \right]_z^1 \\
&+ 2^i \sum_{k = 0}^{i-2} (B_{i-1,k} - z A_{i-1,k}) \left[ \frac{\log^{k+1}(y)}{k+1} \right]_z^1 \\
&- 2^i \sum_{k = 0}^{i-2} z B_{i-1,k} \left[ -\frac{k!}{y} \sum_{r=0}^k \frac{\log^r(y)}{r!} \right]_z^1 \\

&= 2^i \sum_{k = 0}^{i-2} A_{i-1,k} \left[(-1)^k k! - z \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(z)}{r!} \right] \\
&+ 2^i \sum_{k = 1}^{i-1} \frac{A_{i-1,k-1}z - B_{i-1,k-1}}{k} \cdot \log^{k}(z) \\
&- 2^i \sum_{k = 0}^{i-2} z B_{i-1,k} \left[ \frac{k!}{z} \sum_{r=0}^k \frac{\log^r(z)}{r!} - k! \right] \\
\end{align*}
$$

Now let us group the terms by the exponent $r$ of the logarithm to find the coefficients. If $r=0$ then

$$
\begin{align*}
&= \sum_{k = 0}^{i-2} A_{i-1,k} \left[(-1)^k k! - z \cdot k! (-1)^k \right]
- \sum_{k = 0}^{i-2} z B_{i-1,k} \left[ \frac{k!}{z} - k! \right] \\
&= \sum_{k = 0}^{i-2} k! \left( B_{i-1,k} - (-1)^k A_{i-1,k} \right) z + k! \left( (-1)^k A_{i-1,k} - B_{i-1,k} \right) \\
\end{align*}
$$

Therefore

$$
A_{i, r} = \sum_{k = 0}^{i-2} k! \left( B_{i-1,k} - (-1)^k A_{i-1,k} \right) \\
B_{i, r} = \sum_{k = 0}^{i-2} (-1)^k k! \left( (-1)^k A_{i-1,k} - B_{i-1,k} \right) = -A_{i, r} \\
$$

If $r = i - 1$ then

$$
A_{i, r} = \frac{A_{i-1,i-2}}{i - 1} \\
B_{i, r} = -\frac{B_{i-1,i-2}}{i - 1}
$$

If $1 \le r \le i - 2$ then

$$
\begin{align*}
&= \sum_{k = r}^{i-2} A_{i-1,k} \left[ - z \cdot k! (-1)^{k-r} \frac{1}{r!} \right]
- \sum_{k = r}^{i-2} z B_{i-1,k} \left[ \frac{k!}{z} \cdot \frac{1}{r!} \right]
+ \frac{A_{i-1,r-1}z - B_{i-1,r-1}}{r} \\

&= \sum_{k = r}^{i-2} A_{i-1,k} \left[ - z \cdot k! (-1)^{k-r} \frac{1}{r!} \right]
- \sum_{k = r}^{i-2} B_{i-1,k} \left[ k! \cdot \frac{1}{r!} \right]
+ \frac{A_{i-1,r-1}z - B_{i-1,r-1}}{r} \\

&= \frac{A_{i-1,r-1}z - B_{i-1,r-1}}{r}
- \sum_{k = r}^{i-2} A_{i-1,k} \left[ k! \cdot (-1)^{k-r} \frac{1}{r!} \right] z
- \sum_{k = r}^{i-2} B_{i-1,k} \left[ k! \cdot \frac{1}{r!} \right] \\
\end{align*}
$$

Therefore

$$
A_{i, r} = \frac{A_{i-1,r-1}}{r} - \sum_{k = r}^{i-2} (-1)^{k-r} \frac{k!}{r!} A_{i-1,k} \\
B_{i, r} = -\frac{B_{i-1,r-1}}{r} - \sum_{k = r}^{i-2} \frac{k!}{r!} B_{i-1,k} \\
$$

### Joint Probability

Suppose $i = 1$. Then

$$
\begin{align*}
P(Z_0 \ge z \cap Z_1 \lt z)
&= P(Z_1 \lt z) \\
&= P(Y \lt z) \\
&= 2z - z^2 \\
\end{align*}
$$

Now suppose $i \ge 2$

$$
\begin{align*}
P(Z_{i-1} \ge z \cap Z_i \lt z)
&= P(Z_{i-1} \ge z \cap Y Z_{i-1} \lt z) \\
&= P(Z_{i-1} \ge z \cap Y \lt z / Z_{i-1}) \\
&= \int_z^1 f_{Z_{i-1}}(x) \int_0^\frac{z}{x} f_Y(y) \, dy \, dx \\
&= \int_z^1 f_{Z_{i-1}}(x) \int_0^\frac{z}{x} 2 - 2y \, dy \, dx \\
&= \int_z^1 f_{Z_{i-1}}(x) \left[ 2y - y^2 \right]_0^\frac{z}{x} \, dx \\
&= \int_z^1 f_{Z_{i-1}}(x) \left[ \frac{2z}{x} - \frac{z^2}{x^2} \right] \, dx \\
&= 2z \int_z^1 \frac{f_{Z_{i-1}}(x)}{x} \, dx \\
&- z^2 \int_z^1 \frac{f_{Z_{i-1}}(x)}{x^2} \, dx \\
\end{align*}
$$

Let $S_i$ be the indefinite version of the first integral and $T_i$ be the indefinite version second one. Then

$$
\begin{align*}
S_i
&= \int \frac{f_{Z_{i-1}}(x)}{x} \, dx \\
&= \int 2^{i-1} \sum_{k = 0}^{i-2} (A_{i-1,k} x + B_{i-1,k}) \log^k(x) \frac{1}{x} \, dx \\
&= 2^{i-1} \sum_{k = 0}^{i-2} A_{i-1,k} \int \log^k(x) \, dx \\
&+ 2^{i-1} \sum_{k = 0}^{i-2} B_{i-1,k} \int \frac{\log^k(x)}{x} \, dx \\
\end{align*}
$$

and we have already computed the inner integrals. $T_i$ gives us a similar result

$$
\begin{align*}
T_i
&= \int f_{Z_{i-1}}(x) \frac{1}{x^2} \, dx \\
&= \int 2^{i-1} \sum_{k = 0}^{i-2} (A_{i-1,k} x + B_{i-1,k}) \log^k(x) \frac{1}{x^2} \, dx \\
&= 2^{i-1} \sum_{k = 0}^{i-2} A_{i-1,k} \int \frac{\log^k(x)}{x} \, dx \\
&+ 2^{i-1} \sum_{k = 0}^{i-2} B_{i-1,k} \int \frac{\log^k(x)}{x^2} \, dx \\
\end{align*}
$$

and we have already computed the inner integrals. The result follows from putting everything together.