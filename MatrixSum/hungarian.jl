#=
Preliminaries:

0. Definitions

- An alternating path is a path that begins with an unmatched vertex and whose
edges belong alternately to the matching and not to the matching.

- An augmenting path is an alternating path that starts from and ends on free
(unmatched) vertices.

1. Lemma:

(https://en.wikipedia.org/wiki/Berge%27s_lemma)

Proof:

Let G = (V, E) be a graph and M, M' be matchings in G. Let G' be the resulting
graph from taking the symmetric difference of M and M'; i.e. (M\M') U (M'\M). Then
G' will consist of connected components that are one of the following:

1. An isolated vertex.
2. An even cycle whose edges alternate between M and M'.
3. A path whose edges alternate between M and M', with distinct endpoints.

Proof:

Notice that each vertex in G' can be incident to at most 2 edges: one from M and
one from M' (because G' is the symmetric difference between M and M', no edge in
G' belongs to both). Clearly, graphs where every vertex has degree of at most 2
must be composed of either isolated vertex, cycles and paths. Notice that because
each vertex cannot be connected to two edges from M or two from M', the edges in a
path or cycle must alternate between M and M'. For this to happen any cycle must
therefore have even length.

2. Berge's Lemma:

(https://en.wikipedia.org/wiki/Matching_(graph_theory))
(https://en.wikipedia.org/wiki/Berge%27s_lemma)

Berge's
lemma states that for a graph G = (V, E) a matching M is maximum if and only if
there are no augmenting paths in G with M.

Proof:

Let us prove the contrapositive of Berge's Lemma: G has a matching larger than M
if and only if G has an augmenting path with M.

<-] Let P be an augmenting path with M. Let M' be the symmetric difference of P
and M. Notice that if P = E1 E2 ... E2k+1, then only the even-indexed edges belong
to M. Therefore the odd-indexed edges belong to M'. Notice that M' is still a
matching as the end vertex were unmatched in M and all the other vertex are adjacent
to one even-indexed and one odd-indexed edge. In M they were matched to even-indexed
ones, therefore in M' they will be matched to their adjacent odd-indexed edge. Because
there are more odd-indexed edges than there are even-indexed, M' is larger than M.

->] Let M' be a matching in G larger than M. Consider D, the symmetric difference
of M and M'. Using the previous lemma, D consists of isolated vertex, paths and
even cycles. Since M' is larger than M, D contains a component C that has more edges
from M' than M (otherwise, if no component satisfied this condition |M'| = |M|, a
contradiction). Because C must have an odd number of edges, it therefore has an
even number of vertex, and therefore C cannot be an isolated vertex or an even cycle.
Therefore C is a path that starts and ends in edges from M', so the end vertex are
unmatched in M and therefore C is an augmenting path in M.

3. Konig's theorem:

(https://math.dartmouth.edu/archive/m38s12/public_html/sources/Rizzi2000.pdf)
(https://math.stackexchange.com/questions/2029632/having-trouble-understanding-this-proof-of-k%C3%B6nigs-theorem)

A matching of a graph G(V, E) is a subset M of E such that every node of G is
incident with at most one edge of in M. A cover C of G is a set of nodes such
that G\C has no edges, i.e. no edge has both of its endpoints in G\C. Denote by
v(G) the maximum cardinality of a matching of G and by t(G) the minimum cardinality
of a cover of G. Clearly v(G) <= t(G). To see this choose a member of C. Notice
that it can cover at most one member of M, as these are pairwise edge-disjoint.
Notice also that any minimal cover C must cover at least every member of M,
otherwise there would be an edge, member of M, with endpoints that belong to G\C.
Now let G be a bipartite graph. Then v(G) = t(G).

Proof:

Separate V into sets A and B using the bipartite property. Let M be a matching in
G of maximum cardinality. From every edge in M let us choose one of its ends: its
end in B if some alternating path ends in that vertex, and its end in A otherwise.
We shall prove that the set U of these |M| vertices covers E. Since any vertex cover
of E must cover M, there can be none with fewer than |M| vertices, and so the theorem
will follow.

Let ab in E be an edge, where a in A and b in B. We will show that either a or b
lies in U. If ab in M, we are done. Let ab not in M. Since M is a maximal matching,
it contains an edge a'b' (a' in A, b' in B) with a = a' or b = b' (otherwise the
edge degree of both a' and b' in G' = (V, M) would be 0, and M U { a'b' } would be
a matching larger than M, which is a contradiction). If a is unmatched then b = b'.
Because a'b belongs to M, then either a' or b belongs to U. Because ab is an
alternating path, and because b is an an element of B and M, b belongs to U.

Now let b =/= b'. Therefore a = a'. If a is in U we are done. Therefore assume that
a = a' is not in U. Then b' is in U, and some alternating path P ends in b'. But then
there is also an alternating path P' ending in b: either P' := Pb (if b in P, we
cut it short at b) or P' := Pb'a'b (this is clearly an alternating path as the edge
connecting P to b' must not be in M, a'b' is in M and a'b = ab is not in M). By the
maximality of M, using Berge's Lemma, P' cannot be an augmenting path. So b must be
matched, and therefore belongs to U.

4. König - Egerváry Theorem:

In a 0,1 matrix the size of a maximum independent set of 0's equals the minimum
number of lines that cover all the 0's of the matrix.

Proof:

Let A be a nxn, 0,1-matrix. Let X be a set of vertex that represents the rows of
A. Let Y be a set of vertex that represents the columns of A. Let E be a set of
edges such that an edge in E exists between an element of X and Y if and only if
the correspoding row is i and corresponding row is j and A(i, j) = 0. Notice that
picking sets of independent zeroes implies picking edges such that no element from
X and Y is picked twice. Therefore a set of independent zeroes is equivalent to a
matching in E, specifically, a maximal set of independent zeroes is equivalent to
a maximal matching. Notice also any set of lines that covers all the zeroes is
equivalent to picking a set of vertex such that either of the ends of every edge
is in this set, i.e. a cover. Therefore a minimal set of lines is equivalent to
a minimal cover of the vertex.

The result follows from Konig's theorem.

Hungarian Algorithm:

A description of the hungarian algorithm is as follows:

Step 0: Create an nxm  matrix called the cost matrix in which each element
    represents the cost of assigning one of n workers to one of m jobs. Rotate
    the matrix so that there are at least as many columns as rows and let k=min(n,m).

Step 1: For each row of the matrix, find the smallest element and subtract it from
    every element in its row. Go to Step 2.

Step 2: Find a zero (Z) in the resulting matrix. If there is no starred zero in
    its row or column, star Z. Repeat for each element in the matrix. Go to Step 3.

Step 3: Cover each column containing a starred zero. If K columns are covered,
    the starred zeros describe a complete set of unique assignments. In this case,
    Go to DONE, otherwise, Go to Step 4.

Step 4: Find a noncovered zero and prime it. If there is no starred zero in the
    row containing this primed zero, Go to Step 5. Otherwise, cover this row and
    uncover the column containing the starred zero. Continue in this manner until
    there are no uncovered zeros left. Save the smallest uncovered value and Go to
    Step 6.

Step 5: Construct a series of alternating primed and starred zeros as follows.
    Let Z0 represent the uncovered primed zero found in Step 4. Let Z1 denote the
    starred zero in the column of Z0 (if any). Let Z2 denote the primed zero in the
    row of Z1 (there will always be one). Continue until the series terminates at
    a primed zero that has no starred zero in its column. Unstar each starred zero
    of the series, star each primed zero of the series, erase all primes and uncover
    every line in the matrix. Return to Step 3.

Step 6: Add the value found in Step 4 to every element of each covered row, and
    subtract it from every element of each uncovered column. Return to Step 4
    without altering any stars, primes, or covered lines.

DONE: Assignment pairs are indicated by the positions of the starred zeros in the
    cost matrix. If C(i,j) is a starred zero, then the element associated with row
    i is assigned to the element associated with column j.

Proof:

To prove that the Hungarian Algorithm works first notice that:

1. For a matrix M, if k is the maximum number of independent zeroes then there are
k lines which contain all the zero elements of M (From the König - Egerváry Theorem).

2. If we replace the matrix Mij with Mij - Ui - Vj then the solution to our problem
doesn't change. To see this notice that summing over all Ui and Vj produces a
constant which is applied to every solution, therefore the original solution is still
a solution to the reduced problem.

Justifications:

Step 0:
Trivial.

Step 1:
From (2) we can deduce that Step 1 does not alter the solution to the problem, and
allows us to transform our problem into that of finding an independent set of zeroes.
If all the entries of A are non-negative, this transformation doesn't alter that.

Step 2:
Initializes stars.

Step 3:
Stars represent independent zeroes. Therefore if there are n stars, there is a
minimal solution.

Step 4:
This step must terminate as in every iteration we are covering a previously uncovered
row. This step either creates a set of independent primes for Step 5 (as we will
prove in the next step) or uses Step 6 to create more zeroes for the next iteration
of this step.

Step 5:
Notice that at this point there is only one uncovered prime, which we will call Z0.
Let Z1 be a starred zero in Z0's column (if any). Let Z2 be a primed zero in Z1's row.
Notice because Z0 is uncovered then its column is uncovered. Notice also that before
Step 4 the column of Z1 is covered, and thus, to end in an uncovered state, there must
be a primed zero in Z1's row. Therefore Z2 exists whenever Z1 does. This same argument
can be employed to prove that whenever Z2i-1 exists then Z2i does. To prove that this
step terminates notice that the stars are column-wise independent and the primes are
row-wise independent. Therefore no two primes can connect horizontally to same star,
or two stars vertically to the same prime (as both can't be on the same row/column).
Therefore no element can repeat itself, and the sequence has to terminate. Also,
there are more primed zeroes than starred ones, therefore this step increases the
number of starred zeroes. Because there are at most n independent zeroes then this
step can only run a finite number of times. Also primes must be column-wise
independent, otherwise there are either two stars in the same column (not possible)
or the sequence ends in a prime that is in the same column of a star. Clearly this
is not possible as then every prime would be covered by a star and at least one
had to be uncovered for Step 4 to create the set of primes. Therefore when swapping
the primes for stars we get a new (larger) set of independent zeroes.

Step 6:
If we reach this step is because for every uncovered (primed) zero there is a star
in its row. From (2) adding and subtracting the minimum element doesn't change
the solution. Because the starred and primed zeroes will lie in a covered row and
an uncovered column, they will not change. Therefore this step either creates more
zeroes or the number of zeroes remains constant. Also, because the element we need
to subtract from the uncovered columns is the smallest uncovered element overall,
this operation doesn't change A's non-negative status. Now, consider the uncovered
elements. Then after this operation there is a new zero or all uncovered elements
are smaller. Notice that because elements cannot go below 0, after a certain number
of iterations this step will produce a new zero. If there is a zero then on the next
iteration of Step 4 it will be primed, increasing the overall number of primes. As
we have seen primes are row-independent are therefore Step 6 cannot produce more than
n primes. Notice also that at some point Step 4 must enter Step 5, as the number of
stars is either smaller than n and the number of primes surpasses it, or the number
of stars is n and the algorithm has ended before it even got to this step.

=#

# Hungarian Algorithm ==========================================================
# sources:
# https://stackoverflow.com/questions/23278375/hungarian-algorithm
# http://csclab.murraystate.edu/~bob.pilgrim/445/munkres.html
# https://www.math.ucdavis.edu/~saito/data/emd/munkres.pdf

DONE = -1
STEP_COVER_COLUMNS = 0
STEP_PRIME_UNCOVERED = 1
STEP_INCREMENT_SET = 2
STEP_MAKE_MORE_ZEROES = 3

# For each row, subtract its lowest element
function reduce_matrix(mat, matlen)
    for i in 1:matlen
        mat[i, :] .-= minimum(mat[i, :])
    end
end

# Star all zeros that do not share a column or row with a starred zero
function init_stars(mat, matlen, starred)
    for i in 1:matlen
        for j in 1:matlen
            if mat[i, j] == 0 && sum(starred[i, :]) == 0 && sum(starred[:, j]) == 0
                starred[i, j] = 1
            end
        end
    end
end

# Cover each column of starred zeros
function cover_columns_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines)
    for j in 1:matlen
        if sum(starred[:, j]) > 0
            vlines[j] = 1
        end
    end

    # Test whether an optimal assignment is possible
    if sum(vlines) == matlen
        return DONE
    end

    return STEP_PRIME_UNCOVERED
end

# Find a noncovered zero and prime it
function prime_some_uncovered_zero(mat, matlen, starred, primed, hlines, vlines)
    while true
        # Find a noncovered zero and prime it.
        row = -1
        col = -1
        found_noncovered = false
        for i in 1:matlen
            if hlines[i] != 0
                continue
            end
            for j in 1:matlen
                if mat[i, j] != 0 || vlines[j] != 0
                    continue
                end
                row = i
                col = j
                found_noncovered = true
                break
            end
            if found_noncovered
                break
            end
        end
        if row == -1
            return (STEP_MAKE_MORE_ZEROES, -1, -1)
        else
            primed[row, col] = 1
            # Find star in row
            coltmp = -1
            for j in 1:matlen
                if starred[row, j] == 1
                    coltmp = j
                    break
                end
            end
            if coltmp == -1
                return (STEP_INCREMENT_SET, row, col)
            else
                # Cover this row and uncover the starred column
                col = coltmp
                hlines[row] = 1
                vlines[col] = 0
            end
        end
    end
end

# Construct a series of alternating primed and starred zeros as follows.
function increment_set_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines, row, col)
    # Let Z0 represent the uncovered primed zero found in Step 4.
    path = [(row, col)]
    while true
        # Let Z1 denote the starred zero in the column of Z0 (if any).
        row = -1
        for i in 1:matlen
            if starred[i, col] == 1
                row = i
                break
            end
        end
        if row == -1
            break
        end
        push!(path, (row, col))
        # Let Z2 denote the primed zero in the row of Z1 (there will always be one).
        col = -1
        for j in 1:matlen
            if primed[row, j] == 1
                col = j
                break
            end
        end
        push!(path, (row, col))
    end
    # Continue until the series terminates at a primed zero that has no starred zero in its column.
    # Unstar each starred zero of the series, star each primed zero of the series,
    for (idx, (row, col)) in enumerate(path)
        starred[row, col] = idx % 2
    end
    # erase all primes
    for i in 1:matlen
        for j in 1:matlen
            primed[i, j] = 0
        end
    end
    # uncover every line in the matrix.
    for i in 1:matlen
        hlines[i] = 0
    end
    for j in 1:matlen
        vlines[j] = 0
    end
    return STEP_COVER_COLUMNS
end

# Add the smallest uncovered value to every element of each covered row
# Subtract it from every element of each uncovered column.
function make_more_zeroes(mat, matlen, starred, primed, hlines, vlines)
    val = 0
    found = false
    for i in 1:matlen
        if hlines[i] != 0
            continue
        end
        for j in 1:matlen
            if vlines[j] != 0
                continue
            end
            if !found || mat[i, j] < val
                val = mat[i, j]
                found = true
            end
        end
    end

    for i in 1:matlen
        if hlines[i] == 1
            mat[i, :] .+= val
        end
    end

    for j in 1:matlen
        if vlines[j] == 0
            mat[:, j] .-= val
        end
    end

    return STEP_PRIME_UNCOVERED
end

function hungarian(mat)
    mat = copy(mat)
    matlen, = size(mat)
    reduce_matrix(mat, matlen)
    starred = zeros(matlen, matlen)
    init_stars(mat, matlen, starred)
    primed = zeros(matlen, matlen)
    hlines = zeros(matlen)
    vlines = zeros(matlen)
    step = STEP_COVER_COLUMNS
    row = -1
    col = -1
    count = 0
    while step != DONE
        if step == STEP_COVER_COLUMNS
            step = cover_columns_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines)
        elseif step == STEP_PRIME_UNCOVERED
            (step, row, col) = prime_some_uncovered_zero(mat, matlen, starred, primed, hlines, vlines)
        elseif step == STEP_INCREMENT_SET
            step = increment_set_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines, row, col)
        elseif step == STEP_MAKE_MORE_ZEROES
            step = make_more_zeroes(mat, matlen, starred, primed, hlines, vlines)
        end
    end
    return starred
end
