match = 200
vals = [200, 100, 50, 20, 10, 5, 2, 1]
result = 0

def calc_sum (pos, tot):
    global result
    for k in range(0, (match - tot) // vals[pos] + 1):
        curr = tot + k * vals[pos]
        if curr == match:
            result += 1
        elif pos < len(vals) - 1:
            calc_sum(pos + 1, curr)

calc_sum(0, 0)

print(result)
