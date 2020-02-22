# A Lagged Fibonacci Sequence

Let $l \geq 2$ be an integer. Then we can define the $l$-lagged Fibonacci sequence as:

- $g_k = 1$, for $0 \leq k \leq l - 1$.
- $g_k = g_{k - l} + g_{k - l + 1}$, for $k \geq l$.

Notice that this is a linear recurrence and thus can be rewritten as:

$$(g_{k + 1} \: g_k \: ... \: g_{k - l + 2} \: g_{k - l + 1})^T = M (g_k \: g_{k - 1} \: ... \: g_{k - l + 1} \: g_{k - l})^T$$

where $M$ is a matrix. Using the recurrence relations it is clear that the top row of $M$ is:

$$(0 \: 0 \: ... \: 0 \: 1 \: 1)$$

And the lower-left block is $I_{l \times l}$. Everywhere else $M$ is zero.

Now, for every element of the sequence $g_k$ define $\hat{g}_k := (g_k \: g_{k - 1} \: ... \: g_{k - l + 2} \: g_{k - l + 1})^T$. Then:

$$\hat{g}_k = M^{k - l + 1} \hat{g}_{l - 1}$$

Therefore the recurrence relation can be reduced to:

$$\hat{g}_k = \hat{g}_{k - l} + \hat{g}_{k - l + 1}$$
$$M^{k - l + 1} \hat{g}_{l - 1} = M^{k - 2l + 1} \hat{g}_{l - 1} + M^{k - 2l + 2} \hat{g}_{l - 1}$$
$$(M^{k - l + 1} - M^{k - 2l + 1} - M^{k - 2l + 2}) \hat{g}_{l - 1} = 0$$

And because $\hat{g}_{l - 1} \not= 0$:

$$M^{k - l + 1} - M^{k - 2l + 1} - M^{k - 2l + 2} = 0$$
$$M^{k - 2l + 1}(M^l - I - M) = 0$$

Setting $k = 2l - 1$ we get that $M$ satisfies the characteristic equation $M^l - M - I = 0$.

Notice that we want to calculate $g_k$ for some very large $k$. To avoid calculating expensive matrix multiplications, we can use the characteristic equation to reduce the exponent of the matrix (by replacing $M^l = M + I$). Notice that the final result of this is a polynomial $a_0 + a_1 M + a_2 M^2 + ... + a_{l - 1} M^{l - 1}$. Thus if we wanted to calculate $\hat{g}_{k + l - 1}$, we would get:

$$\hat{g}_{k + l - 1} = M^k \hat{g}_{l - 1}$$
$$\hat{g}_{k + l - 1} = (a_0 I + a_1 M + a_2 M^2 + ... + a_{l - 1} M^{l - 1}) \hat{g}_{l - 1}$$
$$\hat{g}_{k + l - 1} = a_0 \hat{g}_{l - 1} + a_1 \hat{g}_l + a_2 \hat{g}_{l + 1} + ... + a_{l - 1} \hat{g}_{2l - 2}$$

Comparing the elements at the bottom of each vector we get:

$$g_k = a_0 \cdot 1 + a_1 \cdot 1 + a_2 \cdot 1 + ... + a_{l - 1} \cdot 1$$
$$g_k = a_0 + a_1 + a_2 + ... + a_{l - 1}$$

Therefore the solution to the problem is the addition of all coefficients in the reduced polynomial of $M^k$. This reduction is equivalent to calculating the polynomial $x^k$ modulo $x^l - x - 1$, or calculating the polynomial in $\mathbb{Z}[x] / (x^l - x - 1)$.

## Calculate $x^k$ modulo $x^l - x - 1$.

We can use binary multiplication to calculate $x^k$, making sure to properly reduce the polynomial on each step. The following algorithm arises naturally:

### $\text{polynomial\_reduce}(x^k)$
1. $e \leftarrow 1$
2. $\text{base} \leftarrow x$
3. $\text{result} \leftarrow 1$
4. Loop:
    1. If $e \: \& \: k \not= 0$, then $\text{result} \leftarrow \text{multiply\_reduce}(\text{result}, \text{base})$
    2. $e \leftarrow 2e$
    3. If $e > k$, exit loop
    4. $\text{base} \leftarrow \text{multiply\_reduce}(\text{base}, \text{base})$
5. Return $\text{result}$

The function $\text{multiply\_reduce}$ uses the fact that $x^{l + r} = x^r + x^{r + 1}$  to reduce each term in the polynomial multiplication. Therefore:

### $\text{multiply\_reduce}(a_0 + a_1 x + a_2 x^2 + ... + a_{l - 1} x^{l - 1}, b_0 + b_1 x + b_2 x^2 + ... + b_{l - 1} x^{l - 1})$
1. $\text{result} \leftarrow 0$
2. For each $a_i$:
    1. For each $b_j$:
        1. If $i + j < l$, then $\text{result} \leftarrow \text{result} + a_i b_j x^{i + j}$
        2. Otherwise, $\text{result} \leftarrow \text{result} + a_i b_j x^{i + j - l} + a_i b_j x^{i + j - l + 1}$
3. Return $\text{result}$
