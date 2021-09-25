# Fibonacci paths

Alice walks on a lattice grid. She can step from one lattice point $A (a,b)$ to another $B (a+x,b+y)$ providing distance $AB = \sqrt{x^2+y^2}$ is a Fibonacci number $\{1,2,3,5,8,13,\ldots\}$ and $x\ge 0,$  $y\ge 0$.

In the lattice grid below Alice can step from the blue point to any of the red points.<br />
<p align="center"><img src="https://projecteuler.net/project/images/p662_fibonacciwalks.png" alt="p662_fibonacciwalks.png" />

Let $F(W,H)$ be the number of paths Alice can take from $(0,0)$ to $(W,H)$.<br />
You are given $F(3,4) = 278$ and $F(10,10) = 215846462$.

Find $F(10\,000,10\,000) \bmod 1\,000\,000\,007$.

## Solution

Suppose that $P$ is the set of all admissible moves. Then, the last move of each path must be admissible. Therefore

$$
F(W, H) = \sum_{(x, y) \in P} F(W - x, H - y)
$$

with base cases $F(0, 0) = 1$ and $F(W, H) = 0$ if $W < 0, H < 0$. Also notice that if $(x, y) \in P \Rightarrow (y, x) \in P$. Therefore $F$ must be symmetric with respect to its arguments, namely, $F(W, H) = F(H, W)$. Now, notice that all $F(W - x, H - y)$ have diagonal value $W - x + H - y$ strictly smaller than the diagonal value of $F(W, H)$ which is $W + H$. Therefore we can calculate $F(W, H)$ starting from the $0$-th diagonal up towards the $W + H$-th diagonal. Finally notice that the diagonal value can never go below $0$. Therefore $0 \leq W - x + H - y \Rightarrow x + y \leq W + H$.

Using all of these insights one can efficiently compute $F$ using Dynamic Programming.