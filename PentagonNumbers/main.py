def pentagon (n):
    return n * (3 * n - 1) // 2

pentagon_set = set()
pentagon_lst = []
pentagon_max = 0
def calculate_pentagon ():
    global pentagon_set
    global pentagon_lst
    global pentagon_max
    """
    n = len(pentagon_lst) + 1
    p = pentagon(n)
    """
    n = len(pentagon_lst)
    if n == 0:
        p = 1
    else:
        p = pentagon_lst[n - 1] + 3 * n + 1
    pentagon_set.add(p)
    pentagon_lst.append(p)
    pentagon_max = p

"""
Search in the upper triangle (sum is commutative, difference is anti-commutative).
When a tentaive solution is found use it to upper bound the search space, using
the identity:

    P_n+1 - P_n = 3n + 1, solve for n

In fact, that same identity can be used to compute succesive values of the pentagon
numbers. When the diagonal number is greater than the computed threshold stop searching.
"""
def calculate ():
    min_d = None
    threshold = None
    diag = 0
    while threshold is None or diag <= threshold:
        calculate_pentagon()
        for idx in range(diag // 2 + 1, diag + 1):
            p1 = pentagon_lst[idx]
            p2 = pentagon_lst[diag - idx]
            if min_d is not None and min_d <= p1 - p2:
                break
            if p1 - p2 not in pentagon_set:
                continue
            search = p1 + p2
            while pentagon_max < search:
                calculate_pentagon()
            if search not in pentagon_set:
                continue
            if min_d is None or min_d > p1 - p2:
                min_d = p1 - p2
                n = (min_d - 1) // 3 + 1
                threshold = 2 * n - 1
                if diag > threshold:
                    break
        diag += 1
    return min_d

print(calculate())
