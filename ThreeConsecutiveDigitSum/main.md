# Numbers for which no three consecutive digits have a sum greater than a given value

How many 20 digit numbers n (without any leading zero) exist such that no three consecutive digits of n have a sum greater than 9?

## Solution

Notice that one can think of any $n$ which satisfies this condition as a walk of lenth $20 - 3 = 17$ on a directed graph where each node is a three digit number with digit sum not greater than $9$ and an edge exists between two nodes if the last two digits of the source node equal the first two digits of the target node. Suppose that the adjaceny matrix of this graph is $A$. It is known that the number of walks from node $i$ to node $j$ of length $k$ is given by $A_{j,i}^k$. Therefore the solution is the sum of the entries of $A_{j,i}^k$ such that node $i$ doesn't have leading $0$s (i.e. its value is greater than or equal to $100$).