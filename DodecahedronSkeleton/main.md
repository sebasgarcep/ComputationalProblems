# Dodecahedron Skeleton

We define a <dfn>skeleton</dfn> of a polyhedron as a <strong class="tooltip">connected</strong>
, nonempty subset of its edges.<br>
Two skeletons are considered the same if they only differ by a rotation in the space.

The regular tetrahedron has $10$ different skeletons, as shown in the image below.
<img src="https://projecteuler.net/resources/images/1019_DodecahedronSkeletons.png?6af9948d8008a" width="600" alt="1019_DodecahedronSkeletons.png">

Find the number of different skeletons of the regular <strong>dodecahedron</strong>.

## Solution

Let $E$ be the set of edges of a polyhedron and let $G$ be its group of rotational symmetries. Let $X := \{ U \in \mathcal{P}(E) : U \text{ is a skeleton} \}$. Then by Burnside's Lemma

$$
\begin{align*}
|X / G|
&= \frac{1}{|G|} \sum_{g \in G} |X^g| \\
&= \frac{1}{|G|} (|X| + \sum_{g \in G, \: g \not= \text{Id}} |X^g|) \\
\end{align*}
$$

We can find all elements of $X$ by starting with any edge and adding touching edges, making sure to keep track of which subsets of the graph we have already seen.

The second sum is easier to find than the one with the term $g = \text{Id}$ since all you have to do is find the cycles in $g$ and either pick all the edges in the cycle or not, then test whether this subset forms a skeleton.

Finally, the group of rotational symmetries of the dodecaheron can be obtained from two different permutations (for example, changing the face that is facing you for the one that shares one of the edges and rotating that face by one fifth of a turn). There are 12 faces and 5 ways to rotate it, so there are 60 rotational symmetries.
