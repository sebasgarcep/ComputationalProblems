# Beds and Desks

At Euler University, each of the $n$ students (numbered from 1 to $n$) occupies a bed in the dormitory and uses a desk in the classroom.

Some of the beds are in private rooms which a student occupies alone, while the others are in double rooms occupied by two students as roommates. Similarly, each desk is either a single desk for the sole use of one student, or a twin desk at which two students sit together as desk partners.

We represent the bed and desk sharing arrangements each by a list of pairs of student numbers. For example, with $n=4$, if $(2,3)$ represents the bed pairing and $(1,3)(2,4)$ the desk pairing, then students 2 and 3 are roommates while 1 and 4 have single rooms, and students 1 and 3 are desk partners, as are students 2 and 4.

The new chancellor of the university decides to change the organisation of beds and desks: a permutation $\sigma$ of the numbers $1,2,\ldots,n$ will be chosen, and each student $k$ will be given both the bed and the desk formerly occupied by student number $\sigma(k)$.

The students agree to this change, under the conditions that:
<ol>
<li>Any two students currently sharing a room will still be roommates.</li>
<li>Any two students currently sharing a desk will still be desk partners.</li>
</ol>

In the example above, there are only two ways to satisfy these conditions: either take no action ($\sigma$ is the <strong>identity permutation</strong>), or reverse the order of the students.

With $n=6$, for the bed pairing $(1,2)(3,4)(5,6)$ and the desk pairing $(3,6)(4,5)$, there are 8 permutations which satisfy the conditions. One example is the mapping $(1, 2, 3, 4, 5, 6) \mapsto (1, 2, 5, 6, 3, 4)$.

With $n=36$, if we have bed pairing:<br>
$(2,13)(4,30)(5,27)(6,16)(10,18)(12,35)(14,19)(15,20)(17,26)(21,32)(22,33)(24,34)(25,28)$<br>
and desk pairing<br>
$(1,35)(2,22)(3,36)(4,28)(5,25)(7,18)(9,23)(13,19)(14,33)(15,34)(20,24)(26,29)(27,30)$<br>
then among the $36!$ possible permutations (including the identity permutation), 663552 of them satisfy the conditions stipulated by the students.

The downloadable text files <a href="https://projecteuler.net/resources/documents/0673_beds.txt">beds.txt</a> and <a href="https://projecteuler.net/resources/documents/0673_desks.txt">desks.txt</a> contain pairings for $n=500$. Each pairing is written on its own line, with the student numbers of the two roommates (or desk partners) separated with a comma. For example, the desk pairing in the $n=4$ example above would be represented in this file format as:
<pre>
1,3
2,4
</pre>
With these pairings, find the number of permutations that satisfy the students' conditions. Give your answer modulo $999\,999\,937$.

## Solution

We can think of the students as numbered nodes in a graph. If two students share a bedroom we add a blue edge between them and if two students share a desk we add a red edge between them. We want to find the number of permutations on the node labels such that the resulting graph is equivalent to the original one.

Note that the degree of each node is at most two, since each node can only connect to a single red and a single blue edge at most. That means that the graph will look like a bunch of chains of nodes (you can think of isolated nodes as chains of length $1$) and a bunch of cycles, with the edges alternating in color in both cases. This also implies that the cycles are of even length.

Suppose we have $k$ chains of length $r$. If $r = 1$ then there are $k!$ ways to swap the nodes around. If $r > 1$ is odd then every chain will have the same number of blue and red edges. Thus we can map every chain into any other chain but we cannot reverse them, since the last edge on one end of the chain will have a different color to the last edge on the other end. Thus there are $k!$ different permutations of these chains. If $r > 1$ is even then the last edge on one end of the chain will have the same color as the last edge on the other end. This means we can only map chains into other chains that end on edges with the same color. Note that we can safely reverse the chains though, leading to $2$ possible ways to map them. Suppose $k_1$ is the number of chains that end on two red edges and $k_2$ is the number of chains that end on two blue edges. Then the umber of permutations is $k_1! \cdot 2^{k_1} \cdot k_2! \cdot 2^{k_2} = k_1! \cdot k_2! \cdot 2^k$.

Suppose we have $k$ cycles of length $r$, where $r$ is even. If $r = 2$ then there are $k!$ ways to swap the cycles around and we can trade the places of both nodes freely leading to $k! \cdot 2^k$ different permutatuons. If $r > 2$ then notice we can reflect a cycle along an axis that cuts two opposite edges or rotate the cycle by two positions to generate another valid cycle. Thus the group of symmetries for a cycle is $D_{r/2}$. Since we can freely swap cycles around this implies there are $k! \cdot r^k$ different permutations of these cycles.
