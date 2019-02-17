import math

# Derived from n - 1 < math.log10(k ** n) < n
# We get n < 1 / (1 - math.log10(k)) and k < 10
result = 1 # 1 = 1^1 (1-th power and 1 digit)
for k in range(2, 10):
    n_bound = 1 / (1 - math.log10(k))
    result += int(math.floor(n_bound))

print(result)
