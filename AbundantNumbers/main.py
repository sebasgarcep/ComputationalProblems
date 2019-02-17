limit = 28123

abundant_nums = []
for n in range(12, limit + 1):
    total = 1
    for k in range(2, n // 2 + 1):
        if n % k == 0:
            total += k
        if total > n:
            abundant_nums.append(n)
            break

sum_set = set()
for i in abundant_nums:
    for j in abundant_nums:
        val = i + j
        if val > limit:
            break
        sum_set.add(val)

result = 0
for x in range(1, limit + 1):
    if x not in sum_set:
        result += x

print(result)
