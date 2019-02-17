"""
The number of rectangles in a given grid of size M x N is:

sum(m = 1, M) sum(n = 1, N) (M - m + 1) * (N - n + 1)

This is equivalent (under the right parametrization) to:

sum(m = 1, M) sum(n = 1) m * n = (sum(m = 1, M) m) * (sum(n = 1, N) n)
                               = M * (M + 1) / 2 * N * (N + 1) / 2
                               = T_M * T_N

Where T_K is the K-th triangular number. One reference solution is M = N = 53,
which yields E = 2,047,761 rectangles. If L = 2,000,000 and R = |E - L|, then
we can reduce the search space for solutions using the inequalities:

L - R <= T_M * T_N <= L + R
M >= N

Where the last inequality arises from the fact that if M x N is the solution to
this problem, then N x M is also a solution. Using the quadratic formula to reduce
the first inequality we obtain:

(L - R) / T_N <= T_M <= (L + R) / T_N
=> (-1 + sqrt(1 + 8 * ((L - R) / T_N))) / 2 <= M <= (-1 + sqrt(1 + 8 * ((L + R) / T_N))) / 2
"""

import math

def triangular (n):
    return n * (n + 1) // 2

l = 2 * (10 ** 6)
r = (triangular(53) ** 2) - l
sol = (53, 53, r)
n = 1
while True:
    tn = triangular(n)
    lb = math.floor((-1 + math.sqrt(1 + 8 * (l - r) / tn)) / 2)
    ub = math.ceil((-1 + math.sqrt(1 + 8 * (l + r) / tn)) / 2)
    if n > ub:
        break
    for m in range(lb, ub + 1):
        d = abs(triangular(m) * tn - l)
        if d < sol[2]:
            sol = (m, n, d)
    n += 1
print(sol[0] * sol[1])

