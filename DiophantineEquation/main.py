"""
Idea: x^2 - D y^2 = 1 implies that x is coprime to D and y
"""

count = 0
sols = [None] * 1000
x = 2
while count < 1000:
    powx = x ** 2
    for y in range(1, x):
        if count >= 1000:
            break
        powy = y ** 2
        diff = powx
        for d in range(1, min([powx // powy, 1000]) + 1):
            diff -= powy
            if diff <= 0:
                break
            if diff == 1 and sols[d - 1] is None:
                count += 1
                sols[d - 1] = (d, x)
                print('count = %d, x = %d, d = %d, y = %d' % (count, x, d, y))
            if count >= 1000:
                break
    x += 1

result = max(sols, key=lambda tuple: tuple[1])[0] + 1
print(result)
