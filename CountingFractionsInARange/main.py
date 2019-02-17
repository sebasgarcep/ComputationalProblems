import math

def gcd (pa, pb):
    a = pa
    b = pb
    while b != 0:
        t = b
        b = a % b
        a = t
    return a

result = 0
for d in range(5, 12000 + 1):
    for n in range(math.floor(d // 3), math.ceil(d // 2)):
        if gcd(n, d) == 1:
            result += 1
print(result)
