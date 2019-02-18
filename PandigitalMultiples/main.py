"""
- The integer cannot have more than 4 digits.
"""

sol = None
for i in range(1, 10 ** 5):
    p = [0] * 9
    n = 1
    keep_on = True
    t = 0
    while keep_on:
        u = i * n
        v = u
        k = 0
        while v > 0:
            k += 1
            d = v % 10
            if d == 0:
                keep_on = False
                break
            elif p[d - 1] == 1:
                keep_on = False
                break
            else:
                p[d - 1] = 1
            v = v // 10
        t = t * (10 ** k) + u
        if keep_on and sum(p) == 9:
            if sol is None or sol[2] < t:
                sol = (i, n, t)
            keep_on = False
        n += 1
print(sol)
