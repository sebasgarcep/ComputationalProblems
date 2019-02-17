"""
Idea: Use the sieve but instead of marking True or False, add 1 for every factor.
"""

n = 10 ** 6
slots = [0] * (n + 1)
slots[0] = 1
slots[1] = 1
idx = 2
while idx < len(slots):
    if slots[idx] == 0:
        for ptr in range(2 * idx, n + 1, idx):
            slots[ptr] += 1
    if idx - 3 > 644 and \
        slots[idx - 0] == 4 and slots[idx - 1] == 4 and \
        slots[idx - 2] == 4 and slots[idx - 3] == 4:
        print(idx - 3)
        exit()
    idx += 1
