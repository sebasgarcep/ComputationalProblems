# Fleeting Medians

We define two sequences $S = \{S(1), S(2), ..., S(n)\}$ and $S_2 = \{S_2(1), S_2(2), ..., S_2(n)\}$:

$S(k) = (p_k)^k$ mod $10007$ where $p_k$ is the $k$th prime number.

$S_2(k) = S(k) + S(\lfloor\frac{k}{10000}\rfloor + 1)$ where $\lfloor \cdot \rfloor$ denotes the floor function.

Then let $M(i, j)$ be the median of elements $S_2(i)$ through $S_2(j)$, inclusive. For example, $M(1, 10) = 2021.5$ and $M(10^2, 10^3) = 4715.0$.

Let $F(n, k) = \sum_{i=1}^{n-k+1} M(i, i + k - 1)$. For example, $F(100, 10) = 463628.5$ and $F(10^5, 10^4) = 675348207.5$.

Find $F(10^7, 10^5)$. If the sum is not an integer, use $.5$ to denote a half. Otherwise, use $.0$ instead.

## Solution

Suppose $k$ is an even number. Then the median will always be the average of two values. Take the first $k$ values of $S_2$, sort them and split the resulting list in half. Add the first half to a Max-Heap and the second half to a Min-Heap. Then the root of both trees are the values to be used to calculate the first median.

The list for the next median uses almost the same elements as the first list, except that we need to remove the first element of the previous list and append the last element of the current one. Deciding to which heap the insert and delete operations should be applied to can be determined easily by comparing against the root nodes. If both operations are done to the same heap, then the heaps remain the same size and nothing else needs to be done. If the operations are done to different heaps, then one heap ends up larger than the other by exactly $2$ elements. To balance them again we need to remove the root node from the larger heap and add it to the other.

After these manipulations the heaps will have the same size and calculating the median can be done using the root nodes.

Note that we do not need two implementations of the heap. A Min-Heap can be obtained from a Max-Heap by multiplying all values by $-1$ when all the input values are non-negative (as is our case).

Finally, to optimize the search for a given node when deleting it, we can keep an index of where each value occurs in the heap.