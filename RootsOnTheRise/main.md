# Roots on the Rise

First, notice that the equation can rewritten as:

$$x = k^2 (k + x^2) - kx^3$$
$$kx^3 - k^2 x^2 + x - k^3 = 0$$
$$x^3 - k x^2 + (1 / k) x - k^2 = 0$$

Therefore if this polynomial has roots $a_k$, $b_k$, $c_k$, the it can be rewritten as:

$$(x - a_k) (x - b_k) (x - c_k) = x^3 - k x^2 + (1 / k) x - k^2$$

Thus:

$$a_k b_k c_k = k^2$$
$$a_k b_k + b_k c_k + a_k c_k = 1/k$$
$$a_k + b_k + c_k = k$$

Notice that:

$$S(n) = \sum_{p = 1}^n \sum_{k = 1}^n (a_k + b_k)^p (b_k + c_k)^p (c_k + a_k)^p$$
$$= \sum_{k = 1}^n \sum_{p = 1}^n (a_k + b_k)^p (b_k + c_k)^p (c_k + a_k)^p$$
$$= \sum_{k = 1}^n \sum_{p = 1}^n [(a_k + b_k) (b_k + c_k) (c_k + a_k)]^p$$
$$= \sum_{k = 1}^n \frac{[(a_k + b_k) (b_k + c_k) (c_k + a_k)]^{n + 1} - 1}{(a_k + b_k) (b_k + c_k) (c_k + a_k) - 1} - 1$$

Now:

$$(a_k + b_k) (b_k + c_k) (c_k + a_k) = 2 a_k b_k c_k + a_k^2 b_k + a_k b_k^2 + a_k^2 c_k + a_k c_k^2 + b_k^2 c_k + b_k c_k^2$$

But:

$$1 = k \cdot 1/k = (a_k + b_k + c_k) (a_k b_k + b_k c_k + a_k c_k)$$
$$= 3 a_k b_k c_k + a_k^2 b_k + a_k b_k^2 + a_k^2 c_k + a_k c_k^2 + b_k^2 c_k + b_k c_k^2$$
$$= k^2 + (a_k + b_k) (b_k + c_k) (c_k + a_k)$$

Thus:

$$(a_k + b_k) (b_k + c_k) (c_k + a_k) = 1 - k^2$$

Therefore:

$$S(n) = \sum_{k = 1}^n \frac{[1 - k^2]^{n + 1} - 1}{1 - k^2 - 1} - 1$$
$$= \sum_{k = 1}^n \frac{1 - [1 - k^2]^{n + 1}}{k^2} - 1$$
