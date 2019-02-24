"""
Approach:
- Generate all sum triplets
- Discard all sum triples with a sum that appears less than 5 times
- Generate all combinations of sum triples
- 5 of the numbers need to appear twice and the other 5 need to appear once.
    Discard all sets of triples that do not conform to this rule.
- A triple needs to have two numbers that appear twice and one that appears once.
    Discard all sets of triples that do not conform to this rule.
- Because we don't want 17 digit solutions we must exclude solutions where 10
    appears twice.
- Any set of triples that conforms to the previous rules generates two solutions
    (and the solutions obtained by rotating the ring around). To prove this note
    that the elements with 1-degree will appear on the exterior of the ring and
    are determined by the two elements it connects to in the interior. On the
    other hand the 2-degree elements form a cycle. To see this note that no
    element is connected to any other one more than once as only one third element
    can generate the required sum. Therefore the smallest graph that can be formed
    with 2-degree elements has 3 nodes. But then either 1 node or 2 nodes are left
    alone, which contradicts what we just proved. Then, all elements are part of
    the same connected component, and the only connected graph that can be formed
    by 2-degree nodes is a cycle.
- The best solution of the two is the one that placest the largest 2-degree number
    in the middle of the triple. Because our triples are sorted this already
    happens.
- To find the next item, find the other item with the lowest of the current 2-degree
    elements.
"""

def build_number (item_set, counts):
    number = ''
    meta = None
    used = [False] * len(item_set)
    for k in range(0, len(item_set)):
        search = {}
        for i in range(0, len(item_set)):
            if used[i]:
                continue
            if meta is None:
                for j in range(1, len(item_set[i])):
                    if counts[item_set[i][j] - 1] != 1:
                        continue
                    if 'index' not in search or item_set[search['index']][search['external']] > item_set[i][j]:
                        search['index'] = i
                        search['external'] = j
                        if item_set[i][j % 3 + 1] < item_set[i][(j - 2) % 3 + 1]:
                            search['current'] = (j - 2) % 3 + 1
                            search['next'] = j % 3 + 1
                        else:
                            search['current'] = j % 3 + 1
                            search['next'] = (j - 2) % 3 + 1
            else:
                for j in range(1, len(item_set[i])):
                    if counts[item_set[i][j] - 1] == 2:
                        if item_set[meta['index']][meta['next']] == item_set[i][j]:
                            search['index'] = i
                            search['current'] = j
                        else:
                            search['next'] = j
                    else:
                        search['external'] = j
                if 'index' in search:
                    break
        used[search['index']] = True
        item = item_set[search['index']]
        number += str(item[search['external']]) + \
            str(item[search['current']]) + \
            str(item[search['next']])
        meta = search
    number = int(number)
    return number

result = None
def test (item_set):
    global result
    counts = [0] * 10
    for item in item_set:
        for i in range(1, len(item)):
            counts[item[i] - 1] += 1
    if counts[-1] == 2:
        return
    if len(list(filter(lambda x: x == 1, counts))) != 5 or \
        len(list(filter(lambda x: x == 2, counts))) != 5:
        return
    for item in item_set:
        total = 0
        for i in range(1, len(item)):
            total += counts[item[i] - 1]
        if total != 5:
            return
    number = build_number(item_set, counts)
    if result is None or number > result:
        result = number


def search (item_set, positions):
    if len(positions) >= 5:
        test([item_set[idx] for idx in positions])
    else:
        last = positions[-1] if len(positions) > 0 else -1
        for i in range(last + 1, len(item_set) - 5 + len(positions) + 1):
            search(item_set, positions + [i])

three_sums = []
for i in range(1, 10 + 1):
    for j in range(i + 1, 10 + 1):
        for k in range(j + 1, 10 + 1):
            three_sums.append([i + j + k, i, j, k])

lower = min([item[0] for item in three_sums])
upper = max([item[0] for item in three_sums])

for elem in range(lower, upper + 1):
    item_set = []
    for item in three_sums:
        if item[0] == elem:
            item_set.append(item)
    if len(item_set) >= 5:
        search(item_set, [])

print(result)
