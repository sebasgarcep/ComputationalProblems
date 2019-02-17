def rollout (a, n, k, p, t):
    if p >= n:
        a[t] += 1
        return
    for i in range(1, k + 1):
        rollout(a, n, k, p + 1, t + i)

peter = [0] * (9 * 4 + 1)
rollout(peter, 9, 4, 0, 0)

colin = [0] * (6 * 6 + 1)
rollout(colin, 6, 6, 0, 0)

result = 0
for i in range(0, len(peter)):
    for j in range(0, i):
        result += peter[i] * colin[j]
result = result / ((4 ** 9) * (6 ** 6))

print('%.7f' % result)
