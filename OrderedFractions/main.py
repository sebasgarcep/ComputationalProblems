"""
Approach:

We have a tentative solution:

3 / 7 = 0.428571... ~ 428,571 / 1,000,000 = rn / rd

Therefore, if n / d is the solution:

rn / rd <= n / d < 3 / 7

Therefore:

rn * d / rd <= n

And:

n < 3 * d / 7

Then the search space is [floor(d * rn / rd) + 1, ceil(d * 3 / 7)]. We will search
from the highest n to the lowest and go to the next iteration whenever the bounds
are inconsistent or a solution for a given n is found.
"""

import math
import time

start = time.time()

limit = 10 ** 6
result = (428571, limit)
for d in range(4, limit + 1):
    lower = int(math.floor(d * result[0] / result[1])) + 1
    upper = int(math.ceil(d * 3 / 7))
    if lower > upper:
        continue
    for n in range(upper - 1, lower - 1, -1):
        if math.gcd(n, d) == 1:
            result = (n, d)
            break

print(result[0])

end = time.time()
print('Took %.4f secs' % (end - start))
