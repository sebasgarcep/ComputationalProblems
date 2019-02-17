"""
Because addition is commutative we only have to test what combination of digits
gives us a 60-length chain. We then have to calculate its permutations (using the
multi-combinatorial). The special case is when some of the digits are zero
because the leading digit cannot be zero. In that case find the possible
combinations of the non-zero digits and notice that we can place the remaining
zeros in between them or at the right end. This is equivalent to solving the
problem of finding the number of solutions to:
x_1 + x_2 + ... + x_n = k
which is (n + k - 1) choose (k). We then multiply this quantity by the number of
permutations of non-zero digits.

We also pre-compute the factorials and put them in a lookup table, because we
know that the largest factorial we will use is 9!.
"""

result = 0
threshold = 10 ** 6
digits = [1] * 10
found = [False] * (threshold + 1)
for idx in range(2, 10):
    digits[idx] = idx * digits[idx - 1]

def choose (n, k):
    return digits[n] // (digits[k] * digits[n - k])

def update (arr_with_zeros):
    global result
    global digits

    arr = []
    num_zeros = 0
    for item in arr_with_zeros:
        if item != 0:
            arr.append(item)
        else:
            num_zeros += 1

    count = digits[len(arr)]
    current = 0
    for (idx, item) in enumerate(arr):
        current += 1
        if idx == len(arr) - 1 or arr[idx + 1] != item:
            count = count // digits[current]
            current = 0

    value = count * choose(len(arr) - 1 + num_zeros, num_zeros)
    result += value

def calculate (argarr):
    global result
    global digits

    arr = list(reversed(argarr)) # prevent the zero from being ignored
    num = sum([val * (10 ** (len(arr) - pos - 1)) for (pos, val) in enumerate(arr)])
    chain = []
    while True:
        if num in chain:
            return chain
        chain.append(num)
        following = 0
        while num > 0:
            following += digits[num % 10]
            num = num // 10
        num = following

def test (arr):
    if arr[-1] <= 0:
        return
    for idx in range(len(arr)):
        subarr = arr[idx:]
        chain = calculate(subarr)
        if len(chain) == 60:
            update(subarr)
        if arr[idx] != 0:
            break

def recursive (k, arr):
    global result
    global digits

    if k >= 6:
        test(arr)
        return

    if len(arr) > 0:
        bound = arr[-1]
    else:
        bound = 0

    for idx in range(bound, 10):
        next_arr = arr[:]
        next_arr.append(idx)
        recursive(k + 1, next_arr)

recursive(0, [])

print(result)
