"""
Approach:
Use recursion to generate all dice, then replace 9s with 6s. Build a mask that
represents which numbers a dice covers. If a dice doesn't cover either of the
possibilities, eliminate it. Finally test whether the logical or of two masks
is all 1s.
"""

cubes = [
    [0, 1],
    [0, 4],
    [0, 6],
    [1, 6],
    [2, 5],
    [3, 6],
    [4, 6],
    [6, 4],
    [8, 1]
]
def get_mask (items):
    mask = 0
    for (idx, pair) in enumerate(cubes):
        for (pos, digit) in enumerate(pair):
            if digit in items:
                mask = mask | (2 ** (2 * idx + pos))
    return mask

dice = []
def generate (items):
    if len(items) >= 6:
        mapped_items = list(map(lambda x: 6 if x == 9 else x, items))
        mask = get_mask(mapped_items)
        for idx in range(0, len(cubes)):
            if mask & (3 * (4 ** idx)) == 0:
                return
        dice.append((mapped_items, get_mask(mapped_items)))
        return
    last = items[-1] if len(items) > 0 else -1
    for num in range(last + 1, len(items) + 5):
        generate(items + [num])

generate([])
max_mask = 4 ** len(cubes) - 1
result = 0
for idx in range(0, len(dice) - 1):
    for pos in range(idx + 1, len(dice)):
        if dice[idx][1] | dice[pos][1] == max_mask:
            result += 1
print(result)
