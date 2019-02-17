"""
Three conditions are relevant when trying to find reversible numbers:
1. Whether the number of digits is even or odd
2. Whether the sum of two complementary digits is even or odd
3. Whether the sum of two complementary digits is less than 10 or not

The approach is to determine the resulting parity of every possible combination
of conditions and then if the parity of all digits is 1, we compute how many
possible combinations of digits can arise from those conditions. We also have to
take into account that the first (and last) digit cannot take the value of 0.

We can still improve this solution by exiting early when the parity of a digit
ends up as 0 and it can no longer change.
"""

lookup = [1]
def factorial (n):
    idx = len(lookup)
    for idx in range(len(lookup), n + 1):
        lookup.append(idx * lookup[idx - 1])
    return lookup[n]

def choose (n, k):
    return factorial(n) // (factorial(k) * factorial(n - k))

# Calculate how many solutions of each type there is
num_sols = [0] * 4
num_sols_wo_leading_zeros = [0] * 4
for a in range(0, 9 + 1):
    for b in range(0, 9 + 1):
        tot = a + b
        pos = (tot % 2) + 2 * (tot // 10)
        num_sols[pos] += 1
        if a != 0 and b != 0:
            num_sols_wo_leading_zeros[pos] += 1

result = 0
def calculate (num_digits, decs):
    global result

    total = 1
    for (idx, dec) in enumerate(decs):
        if idx == num_digits // 2:
            total = total * 5
        else:
            parity = dec[0]
            size = dec[1]
            pos = parity + 2 * size
            if idx == 0:
                total = total * num_sols_wo_leading_zeros[pos]
            else:
                total = total * num_sols[pos]

    result += total

def toggle_mod (arr, pos):
    arr[pos] = (arr[pos] + 1) % 2

def search (num_digits, mods, decs):
    k = len(decs)

    should_stop = k >= (num_digits // 2) + (num_digits % 2)
    if should_stop and sum(mods[1:]) == num_digits:
        calculate(num_digits, decs)
        return
    elif should_stop:
        return

    for size in range(2):
        for parity in range(2):
            nextmod = mods[:]

            if k == num_digits // 2:
                # When the number of digits is odd, the middle digit always has 0 parity
                if parity == 1:
                    break
                if size > 0:
                    toggle_mod(nextmod, k)
                if parity > 0:
                    toggle_mod(nextmod, k + 1)
            else:
                if size > 0:
                    toggle_mod(nextmod, -(k + 2))
                    toggle_mod(nextmod, k)
                if parity > 0:
                    toggle_mod(nextmod, -(k + 1))
                    toggle_mod(nextmod, k + 1)

            search(num_digits, nextmod, decs + [(parity, size)])

for num_digits in range(1, 9 + 1):
    mods = [0] * (num_digits + 1)
    decs = []
    search(num_digits, mods, decs)

print(result)
