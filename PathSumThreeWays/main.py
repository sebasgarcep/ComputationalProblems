"""
The matrix can be represented as a graph where the start node is to the left of
the matrix and connects to every element in the first column, all elements of the
matrix have a directed edge upwards, downwards or rightwards (when possible), and
the last column is completely connected to a target node.

This problem can therefore be solved with single-source, single-target Dijkstra.
"""

import math

lines = open('matrix.txt').readlines()
matrix = [None] * len(lines)
for (idx, line) in enumerate(lines):
    matrix[idx] = [int(x) for x in line.split(',')]

infty = math.inf
n = len(matrix) # matrix is assumed to be square
dist = []
prev = []
used = []
for i in range(0, n):
    dist.append([])
    prev.append([])
    used.append([])
    for j in range(0, n):
        dist[i].append(infty)
        prev[i].append(None)
        used[i].append(False)
dist_target = infty
prev_target = None
curr_i = None
curr_j = None

"""
best_i = -1 and best_j = -1 => source node
best_i = n and best_j = n => target node
otherwise is an element of the matrix
"""

for iteration in range(0, n * n + 2):
    if curr_i is None and curr_j is None:
        curr_i = -1
        curr_j = -1
    else:
        curr_i = n
        curr_j = n
        d = None
        for i in range(0, n):
            for j in range(0, n):
                if not used[i][j] and (d is None or dist[i][j] < d):
                    curr_i = i
                    curr_j = j
                    d = dist[i][j]

    u = (curr_i, curr_j)
    if curr_i >= 0 and curr_i < n and curr_j >= 0 and curr_j < n:
        used[curr_i][curr_j] = True

    if curr_i == -1 and curr_j == -1:
        for i in range(0, n):
            alt = matrix[i][0]
            if alt < dist[i][0]:
                dist[i][0] = alt
                prev[i][0] = u
    elif curr_j == n - 1:
        alt = dist[curr_i][curr_j]
        if alt < dist_target:
            dist_target = alt
            prev_target = u
    elif curr_i == n and curr_j == n:
        pos = prev_target
        total = 0
        while True:
            total += matrix[pos[0]][pos[1]]
            pos = prev[pos[0]][pos[1]]
            if pos[0] == -1 and pos[1] == -1:
                print(total)
                exit()
    else:
        if curr_i > 0:
            alt = dist[curr_i][curr_j] + matrix[curr_i - 1][curr_j]
            if alt < dist[curr_i - 1][curr_j]:
                dist[curr_i - 1][curr_j] = alt
                prev[curr_i - 1][curr_j] = u
        if curr_i < n - 1:
            alt = dist[curr_i][curr_j] + matrix[curr_i + 1][curr_j]
            if alt < dist[curr_i + 1][curr_j]:
                dist[curr_i + 1][curr_j] = alt
                prev[curr_i + 1][curr_j] = u
        if curr_j < n - 1:
            alt = dist[curr_i][curr_j] + matrix[curr_i][curr_j + 1]
            if alt < dist[curr_i][curr_j + 1]:
                dist[curr_i][curr_j + 1] = alt
                prev[curr_i][curr_j + 1] = u
