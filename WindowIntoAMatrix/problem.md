# Window Into A Matrix

## Problem
A window into a matrix is a contiguous sub matrix.

Consider a $2\times n$ matrix where every entry is either 0 or 1. Let $A(k,n)$ be the total number of these matrices such that the sum of the entries in every $2\times k$ window is $k$.

You are given that $A(3,9) = 560$ and $A(4,20) = 1060870$.

Find $A(10^8,10^{16})$. Give your answer modulo $1\,000\,000\,007$.

## Solution
Let $W_{k,n}(l)$ be the $2 \times k$ window into a $2 \times n$ matrix starting from the $l$-th column. Notice that the sum of the $(l + k)$-th column must equal the sum of the $l$-th column, as the sum over the entries of $W_{k,n}(l + 1)$ must be equal to the sum over the entries of $W_{k,n}(l)$, and these two windows only differ by these two columns.

Thus if the sum of the $l$-th column is $0$ or $2$, then there is only one choice for the $(l + k)$-th column. On the other hand, if the sum of the $l$-th column is $1$, then there are two possible choices for the $(l + k)$-th column, given by the number of ways you can choose $1$ place from $2$ spots.

Let's assume from now on that $n$ is a multiple of $k$. Suppose you have a valid window $W_{k,n}(1)$. If there are $a$ columns that sum to $1$ and $b$ columns that sum to $2$, then $k = a + 2b$. Then by sliding $W_{k,n}(1)$ across you can generate all possible solutions that start with that window. The caveat is that once you cross a column that adds to $1$ you have to multiply by the two possible choices. Because $n$ is a multiple of $k$, we know that we will slide across each column exactly $\frac{n}{k}$ times. Therefore, from $W_{k,n}(1)$ we get $2^{an / k}$ possible solutions. Finally, you can generate $\frac{k!}{(k - a - b)! a! b!}$, different initial windows by permuting the columns of $W_{k,n}(1)$.

With all of these in mind it is very easy to see that:

$$
A(k, n) = \sum_{b = 0}^{k / 2} 2^{an / k} \frac{k!}{a! b!^2} = k! \cdot \sum_{b = 0}^{k / 2} (2^{n / k})^a \frac{1}{a! b!^2}
$$

using $a = k - 2b$.