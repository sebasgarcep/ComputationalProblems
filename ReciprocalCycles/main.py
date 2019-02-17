def calc_cycle_len (d):
    n = 1
    r = []
    while True:
        r.append(n)
        while n < d:
            n = n * 10
        n = n % d
        if n == 0:
            return 0
        try:
            return len(r) - r.index(n)
        except:
            pass

max_d = None
max_len = 0
for d in range(2, 1000):
    curr_len = calc_cycle_len(d)
    if max_d is None or curr_len > max_len:
        max_d = d
        max_len = curr_len

print(max_d)
print(max_len)
