import itertools

limit = 9

powers = [10 ** idx for idx in range(limit)]
def list_to_num (arr, beg, end):
    num_pow = end - beg
    num = 0
    for idx in range(beg, end):
        num += arr[idx] * powers[end - 1 - idx]
    return num

items = set()
for arrangement in itertools.permutations(range(1, limit + 1)):
    for i in range(limit - 1):
        for j in range(i + 1, limit - 1):
            multiplicand = list_to_num(arrangement, 0, i + 1)
            multiplier = list_to_num(arrangement, i + 1, j + 1)
            product = list_to_num(arrangement, j + 1, len(arrangement))
            if multiplicand * multiplier == product:
                items.add(product)

print(sum(items))
