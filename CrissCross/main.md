# Criss Cross

<p>A 4x4 grid is filled with digits d, 0 ≤ d ≤ 9.</p>

<p>It can be seen that in the grid</p>

<p class="center">
6 3 3 0<br />
5 0 4 3<br />
0 7 1 4<br />
1 2 4 5</p>

<p>the sum of each row and each column has the value 12. Moreover the sum of each diagonal is also 12.</p>

<p>In how many ways can you fill a 4x4 grid with the digits d, 0 ≤ d ≤ 9 so that each row, each column, and both diagonals have the same sum?</p>


## Solution

Assign to each slot a variable name $x_i$, for $i = 1, \dots, 16$ (where the $i$ are asigned incrementally from left-to-right) and suppose the sum of all rows, columns and diagonals is $s$. The system of equations in matrix form becomes

$$
\begin{pmatrix}
1 & 1 & 1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 \\
1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 \\
1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 \\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 \\
\end{pmatrix}
\begin{pmatrix}
x_{1} \\
x_{2} \\
x_{3} \\
x_{4} \\
x_{5} \\
x_{6} \\
x_{7} \\
x_{8} \\
x_{9} \\
x_{10} \\
x_{11} \\
x_{12} \\
x_{13} \\
x_{14} \\
x_{15} \\
x_{16} \\
\end{pmatrix}
=
\begin{pmatrix}
s \\
s \\
s \\
s \\
s \\
s \\
s \\
s \\
s \\
s \\
\end{pmatrix}
$$

This system has rank $9$. We can drop the first equation without the matrix losing rank and it is easy to prove that $x_{1}, x_{2}, x_{3}, x_{5}, x_{6}, x_{7}, x_{9}$ are free variables. Moreover, $s$ is also a free variable. Thus we are left with the following invertible system

$$
\begin{pmatrix}
0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 1 & 1 & 1 \\
1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 \\
0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 1 \\
1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 1 \\
0 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 1 & 0 & 0 & 0 \\
1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & 1 & 0 & 0 & 0 & 0 & 0 & 0 & 0 \\
\end{pmatrix}
\begin{pmatrix}
x_{1} \\
x_{2} \\
x_{3} \\
x_{4} \\
x_{5} \\
x_{6} \\
x_{7} \\
x_{8} \\
x_{9} \\
x_{10} \\
x_{11} \\
x_{12} \\
x_{13} \\
x_{14} \\
x_{15} \\
x_{16} \\
\end{pmatrix}
=
\begin{pmatrix}
s \\
s \\
s \\
s \\
s \\
s \\
s \\
s \\
s \\
x_{1} \\
x_{2} \\
x_{3} \\
x_{5} \\
x_{6} \\
x_{7} \\
x_{9} \\
\end{pmatrix}
$$

subject to the following constraints

$$
x_i \in \{ 0, 1, \dots, 9 \} \\
s \in \{ 0, 1, \dots, 40 \} \\
x_1 + x_2 + x_3 \leq x_1 + x_2 + x_3 + x_4 = s \\
x_5 + x_6 + x_7 \leq x_5 + x_6 + x_7 + x_8 = s \\
x_1 + x_5 + x_9 \leq x_1 + x_5 + x_9 + x_{13} = s \\
$$

A natural algorithm to solve this problem involves generating all possible values of the free $x_i$ and $s$, and checking that the generated $x_i$ from the system satisfy the constraints. If they do, then we add $1$ to the solution counter.