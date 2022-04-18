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

Suppose $y_i$ is the fraction of the pie left after the $i$-th step, relative to how it was in the previous step. So if we have $1/2$ pie at step $i-1$ and $y_i = 1/4$ then we are left with $1/8$ pie after step $i$. Let $z_i$ be the fraction of the pie left after the $i$-th step, relative to the initial, complete pie. Thus $z_0 = 1$, $z_i = y_1 \dots y_i$. Let $y_i \sim Y_i, z_i \sim Z_i$, where $Y_i, Z_i$ are random variables. Then

$$
E(x) = \sum_{i = 1}^{\infty} i \cdot P(Z_{i-1} \ge \frac{1}{x}) \cdot P(Z_i \lt \frac{1}{x})
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

---
FIXME:  PROVE THIS

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
\frac{d}{dy} \left[ \frac{\log^{k+1}(y)}{k+1} \right] = \frac{\log^k(y)}{y} \iff \frac{\log^{k+1}(y)}{k+1} + K = \int \frac{\log^k(y)}{y}
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

### CDF of $Z_i$

With this

$$
\begin{align*}
P(Z_i \le z)
&= \int_0^z f_{Z_i}(x) \, dx \\
&= \int_0^z 2^i \sum_{k = 0}^{i-1} (A_{i,k} x + B_{i,k}) \log^k(x) \, dx \\
&= 2^i \sum_{k = 0}^{i-1} A_{i,k} \int_0^z x \log^k(x) \, dx + 2^i \sum_{k = 0}^{i-1} B_{i,k} \int_0^z \log^k(x) \, dx \\
\end{align*}
$$

where

$$
\begin{align*}
\int x \log^k(x)
&= \frac{x^2}{2} \cdot \log^k(x) - \int \frac{x^2}{2} \cdot k \cdot \log^{k-1}(x) / x \, dx \\
&= \frac{x^2}{2} \cdot \log^k(x) - \frac{k}{2} \int x \cdot \log^{k-1}(x) \, dx \\
&= x^2 \log^k(x) / 2 - k x^2 \log^{k-1}(x) / 4 + k(k-1) x^2 \log^{k-2}(x) / 8 - \dots \\
&= \frac{x^2 \cdot k!}{2^{k+1}} \sum_{r=0}^k (-1)^{k-r} \cdot 2^r \cdot \frac{\log^r(x)}{r!} + K
\end{align*}
$$

Therefore

$$
\begin{align*}
P(Z_i \le z)
&= 2^i \sum_{k = 0}^{i-1} A_{i,k} \int_0^z x \log^k(x) \, dx \\
&+ 2^i \sum_{k = 0}^{i-1} B_{i,k} \int_0^z \log^k(x) \, dx \\

&= 2^i \sum_{k = 0}^{i-1} A_{i,k} \left[ \frac{x^2 \cdot k!}{2^{k+1}} \sum_{r=0}^k (-1)^{k-r} \cdot 2^r \cdot \frac{\log^r(x)}{r!} \right]_0^z \\
&+ 2^i \sum_{k = 0}^{i-1} B_{i,k} \left[ x \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(x)}{r!} \right]_0^z \\
\end{align*}
$$

This is clearly an improper integral due to the lower bound, so we need to verify that the lower limit exists. Let's prove that for any $s \ge 1$ and any $r \ge 0$ then

$$
\lim_{x \rightarrow 0^+} x^s \log^r(x) = 0
$$

The identity clearly holds when $r = 0$. Notice that

$$
\begin{align*}
\lim_{x \rightarrow 0^+} x^s \log^r(x)
&= \lim_{x \rightarrow 0^+} \frac{\log^r(x)}{\frac{1}{x^s}} \\
&= \lim_{x \rightarrow 0^+} \frac{r \cdot \log^{r-1}(x) \cdot (1/x)}{\frac{-s}{x^{s+1}}} \\
&= \lim_{x \rightarrow 0^+} \frac{r \cdot \log^{r-1}(x)}{\frac{-s}{x^s}} \\
&= -\frac{r}{s} \cdot \lim_{x \rightarrow 0^+} \frac{\log^{r-1}(x)}{\frac{1}{x^s}} \\
&= -\frac{r}{s} \cdot \lim_{x \rightarrow 0^+} x^s \log^{r-1}(x) \\
\end{align*}
$$

and by induction one can prove the general case. Applying this limit to the integral above we get

$$
\begin{align*}
P(Z_i \le z)
&= 2^i \sum_{k = 0}^{i-1} A_{i,k} \left[ \frac{x^2 \cdot k!}{2^{k+1}} \sum_{r=0}^k (-1)^{k-r} \cdot 2^r \cdot \frac{\log^r(x)}{r!} \right]_0^z \\
&+ 2^i \sum_{k = 0}^{i-1} B_{i,k} \left[ x \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(x)}{r!} \right]_0^z \\

&= 2^i \sum_{k = 0}^{i-1} A_{i,k} \left[ \frac{z^2 \cdot k!}{2^{k+1}} \sum_{r=0}^k (-1)^{k-r} \cdot 2^r \cdot \frac{\log^r(z)}{r!} \right] \\
&+ 2^i \sum_{k = 0}^{i-1} B_{i,k} \left[ z \cdot k! \sum_{r=0}^k (-1)^{k-r} \frac{\log^r(z)}{r!} \right] \\
\end{align*}
$$

## Notes

A few test values for the PDF of $Z_i$

$$
\begin{align*}
f_{Z_1}(z) &= -2(z-1) \\
f_{Z_2}(z) &= 4 (2(z-1) -(z+1)\log(z)) \\
f_{Z_3}(z) &= -8 (6z-6 -(3z+3)\log(z) + (\frac{1}{2}z-\frac{1}{2})\log^2(z)) \\
\end{align*}
$$