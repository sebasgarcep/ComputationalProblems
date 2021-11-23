# Eulercoin

Leonhard Euler was born on 15 April 1707.

Consider the sequence 1504170715041707n mod 4503599627370517.

An element of this sequence is defined to be an Eulercoin if it is strictly smaller than all previously found Eulercoins.

For example, the first term is 1504170715041707 which is the first Eulercoin. The second term is 3008341430083414 which is greater than 1504170715041707 so is not an Eulercoin. However, the third term is 8912517754604 which is small enough to be a new Eulercoin.

The sum of the first 2 Eulercoins is therefore 1513083232796311.

Find the sum of all Eulercoins.

## Solution

Naively generate Eulercoins until the last generated Eulercoin is smaller than $10^8$. Now invert $1504170715041707$ mod $4503599627370517$, and use it to generate all $n$ that return each of the numbers between $1$ and the latest Eulercoin. Once we have this list we can iteratively generate the next Eulercoin using the following algorithm:

1. Let $n_k$ be the value of $n$ that generates the $k$-th Eulercoin $E_k$.
2. Then for all $x \in [1, E_k - 1]$, let $n_x$ be the value of $n$ that generates $x$.
3. Then $n_{k+1}$ is the smallest $n_x$ larger than $n_k$ for all $x \in [1, E_k - 1]$. $E_{k+1}$ is then $x$.

Repeat this procedure until you obtain $E_{k + 1} = 1$. Finally sum the value of $E_1, E_2, \dots$