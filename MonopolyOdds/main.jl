#=
Approach:
We solved the problem by building a transition matrix M, where the probability
of going from tile i to tile j is Mij, and starting with an initial condition
X0 = (1.0 0.0 0.0 ... 0.0). Clearly, if Xk is the vector where each entry is the
probability of ending in that tile after k rounds then we want to find X = lim(k -> infty) Xk.
Notice that (Xk+1)i = Mi * Xk = sum(j = 1, N) Mij * (Xk)j, i.e. the probability of
ending in state i after k+1 rounds equals the probability of ending in state j after
k rounds times the probability of going from state j to state i, and then adding over
all the j. Therefore, we only need to prove that X exists by proving that iteratively
multiplying the transition matrix to the state converges.

Lemma: Xk always adds up to 1.
Proof: Notice that this is true for X0. Assume it is true for Xk. Notice that
M_j adds up to 1, as for any initial state all its possible final states must add
to a probability of 1. Then:

(Xk+1)i = sum(j = 1, N) Mij * (Xk)j
sum(Xk+1) = sum(i = 1, N) sum(j = 1, N) Mij * (Xk)j
sum(Xk+1) = sum(j = 1, N) sum(i = 1, N) Mij * (Xk)j
sum(Xk+1) = sum(j = 1, N) (Xk)j * sum(i = 1, N) Mij
sum(Xk+1) = sum(j = 1, N) (Xk)j
sum(Xk+1) = 1

Sources:
(https://iuuk.mff.cuni.cz/~rakdver/linalg/lesson15-9.pdf)

Definition:
An irreducible matrix is a matrix M such that there is a natural number k such that
M^k > 0.

Definition:
A square matrix is stochastic if each of its columns adds up to 1.

Definition:
The spectral radius p(M) of M is the largest absolute value of the eigenvalues of
M.

Corollary: The Monopoly transition matrix is a square, stochastic, irreducible
matrix when the Go To Jail index (column and row) is removed.

Lemma 1:
If p(M) < 1 then lim(k -> infty) ||M^k|| = 0. If p(M) > 1 then lim(k -> infty) ||M^k|| = infty.
Proof:
Write M in Jordan normal form as M = C * J * C^-1. Notice that M^k = C * J^k * C^-1,
and that p(M) = p(J). If p(J) < 1, then J^k converges towards the zero matris as k
increases, and thus so does M. If p(M) > 1, then J^k has a diagonal entry (J^k)ii = l^k
for an eigenvalue l such that |l| > 1, and if v is the i-th column of C and v' is the
i-th row of C^-1, then:

v'* M^k * v = v' * C * J^k * C^-1 * v
            = ei^T * J^k * ei
            = l^k

where ei is the i-th element of the canonical base. Therefore:

lim(k -> infty) |v'* M^k * v| = infty. Because:

|v'* M^k * v| <= ||v'|| * || M^k || * ||v||

then lim(k -> infty) || M^k || = infty, as ||v'|| and ||v|| are fixed.

Lemma 2:
If M is a positive matrix, p(M) = 1, and l is an eigenvalue of M with |l| = 1,
then the real part of l is positive.
Proof:
Suppose for a contradiction that the real part of l is nonpositive. Chose eps > 0
such that Mii > eps for every i. Then |l - eps| > 1. Choose 0 < s < 1 such that
s * |l - eps| > 1. Let M1 = s * (M - eps * I) and M2 = s * M. Note that s * (l - eps)
is an eigenvalue of M1, and thus p(M1) > 1. On the other hand, p(M2) = s * p(M) < 1.
By Lemma 1, lim(k -> infty) || M2^k || = 0 and lim(k -> infty) || M1^k || = infty.
But M1 <= M2, and M1 is positive. Therefore lim(k -> infty) || M1^k || <= lim(k -> infty) || M2^k ||,
which contradicts the consequence of Lemma 1. Therefore the real part of l must be
positive.

Theorem (Perron–Frobenius):
Let M be a nonnegative square, irreducible matrix. Then p(M) is an eigenvalue of
M and p(M) has absolute value strictly larger than all other eigenvalues.
Proof:
Let p(M) = 0. Notice that M must have at least 1 eigenvalue, and because the only
number with absolute value less than or equal to 0 is effectively 0, then p(M) is
the only eigenvalue of M. Now assume p(M) > 0. Let k0 be such that M^k0 is positive.
Since M is nonnegative, M^k is positive for all k >= k0. Suppose that l is an
eigenvalue of M with |l| = p(M). Let M1 = M / p(M) and note that p(M1) = 1 and
l1 = l / p(M) is an eigenvalue of M1 with |l1| = 1. If l1 != 1, then there exists
k >= k0 such that the real part of l1^k is nonpositive. But l1^k is an eigenvalue
of the positive matrix M1^k with p(M1^k) = |l1|^k = 1, which contradicts Lemma 2.
Therefore l1 = 1, and l = p(M) is an eigenvalue of M. To see that no other eigenvalue
has absolute value equal to p(M) notice that if it did then l1 = l / p(M) != 1,
which we just proved to be impossible.

Lemma 3:
Upper triangular matrices with diagonal zero are nilpotent, i.e. some power of them
is zero.
Proof:
Let M = ( 0 a ; 0 0 ). Then M^2 = 0. Let the statement be true for all matrices
with dimensions of (N-1)x(N-1) and smaller. Let M be an NxN matrix. Pick any index
one-off from the main diagonal. Notice that multiplying its corresponding row and
column, the non-zero elements of the row match exactly with zero elements of the
column. Therefore, after multiplication with itself, the one-off elements from the
diagonal will end up as 0s. Because block multiplication is equivalent to the usual
matrix multiplication, there is some power of the upper right (N-1)x(N-1) block
that produces the desired result.

Lemma 4:
Let M be a nonnegative square, irreducible matrix, with p(M) = 1. If v is a nonnegative
vector and (M * v)i >= vi for every i, then M * v = v.
Proof:
Let k >= 1, be an integer such that M^k is positive. Suppose for a contradiction
that M * v != v. Therefore M * v - v is nonnegative and nonzero. Since M^k is positive,
we have that M^k * (M * v - v) is positive. Thus, there exists s > 1 such that
M^k * (M * v - s * v) is still positive, and thus (M^(k+1) * v)i >= (s * M^k * v)i,
for all i. Since M is nonnegative, it follows by multiplying the inequality by M
that (M^(k+2) * v)i >= (s * M^(k+1) * v)i for all i. Combining these inequalities,
(M^(k+2) * v)i >= (s^2 * M^k * v)i for all i. Similarly (M^(k+h) * v)i >= (s^h * M^k * v)i,
for all h >= 0 and for all i. Consider any b such that 1 < b < s, and let B = M / b.
Then (B^(k + h) * v)i >= ((s / b)^h * B^h * v)i for all n >= 0 and for all i. Thus
for large enough h, (s / b)^h -> infty and therefore lim(h -> infty) ||B^h|| = infty.
However p(B) = 1/b < 1, which contradicts Lemma 1. Therefore M * v = v.

Lemma 5:
Let M be a nonnegative square, irreducible matrix. Then the algebraic multiplicity
of p(M) is 1 and the eigenvector for p(M) is positive.
Proof:
That p(M) is an eigenvector is a consequence of the Perron–Frobenius theorem.
If p(M) = 0 then considering the Jordan normal form of M (a collection of upper
triangular matrices with diagonal zero) it is clear that for some k, M^k = 0, which
contradicts the irreducibility of M. Therefore p(M) > 0. Without loss of generality
we can assume p(M) = 1, as we can always divide M by p(M). Let v be an eigenvector
for 1, and let w be the vector such that wi = |vi| for i = 1, 2, ... , N. We then
have:

(M * w)i = M[i, 1] * w1 + M[i, 2] * w2 + ... + M[i, N] * wN
         = M[i, 1] * |v1| + M[i, 2] * |v2| + ... + M[i, N] * |vN|
         >= |M[i, 1] * v1 + M[i, 2] * v2 + ... + M[i, N] * vN|
         = |(M * v)i|
         = |vi| (v is an eigenvector of 1)
         = wi, i = 1, 2, ... , N

and therefore, from Lemma 4, M * w = w. Let k >= 1 be an integer such that M^k is
positive. We have M^k * w = w, and since w is nonnegative, the vector M^k * w = w
is positive.

Suppose now for contradiction that the algebraic multiplicity of p(M) is greater
than 1. By considering the Jordan normal form of M, it follows that there exists
a non-zero vector z, linearly independent on w, such that either M * z = z or M * z = z + w,
as either 1 has more than one eigenvector, or (M - I) is invertible in the space
R^N / [w] (using the isomorphism theorems). In the former case, there exists a
non-zero vector z' = w + a * z, such that z' is nonnegative, but at least one
coordinate of z' is 0. However M * z' = M * w + a * M * z = w + a * z = z', and
M^k is positive, therefore (M^k)i * z' > 0 and therefore z' is positive, which is
a contradiction. In the latter case, choose a > 0 so that w' = z + a * w is positive.
Then (M * w')i = (M * z + a * M * w)i = (z + w + a * w)i = (z + (1 + a) * w)i > w'i
for all i, which contradicts Lemma 4.

Lemma 6:
Let M be a nonnegative square, irreducible, stochastic matrix. Then there exists
an unique positive vector v with M * v = v such that v is a discrete probability
distribution vector. Furthermore for any other discrete probability distribution
vector w, lim(k -> infty) M^k * w = v.
Proof:
By the Perron–Frobenius theorem and Lemma 5, p(M) is an eigenvalue of M with algebraic
multiplicity 1, corresponding positive v eigenvector and such that all other eigenvalues
have strictly lower absolute value. Choose v so that (1 1 ... 1) * v = 1. We have
p(M) = p(M) * (1 1 ... 1) * v = (1 1 ... 1) * p(M) * v = (1 1 ... 1) * M * v.
Because M is stochastic, the sum of its columns equals 1. Therefore
p(M) = (1 1 ... 1) * M * v = (1 1 ... 1) * v = 1 and thus M * v = v and p(M) = 1.

(https://en.wikipedia.org/wiki/Jordan_normal_form#Example:_Obtaining_the_normal_form)

Write M in Jordan normal form as M = C * J * C^-1, such that J11 = 1. Notice that
from the Perron–Frobenius theorem all other diagonal entries are smaller than 1.
Also C_1 = v, as for eigenvalues with algebraic multiplicity 1, their corresponding
column in the change of basis matrix is their eigenvector. Let z be the first row of C^-1.
First notice that (1 1 ... 1) * M = (1 1 ... 1) as M is stochastic. Therefore
M^T * (1 1 ... 1)^T = (1 1 ... 1)^T, i.e. (1 1 ... 1)^T is an eigenvector of M^T
with eigenvalue 1. Because 1 has algebraic multiplicity of 1, then its jordan block
is of size 1x1, and therefore e1^T * J = e1^T. Therefore:

z * M = z * C * J * C^-1 = e1^T * J * C^-1 = e1^T * C^-1 = z

and thus M^T * z^T = z^T. Therefore z^T is an eigenvector of M^T with eigenvalue of 1.
But 1 has the same algebraic multiplicity of 1 in M and in M^T, therefore its corresponding
eigenvector is unique up to scalar multiplication. Therefore z^T is a scalar multiple of
(1 1 ... 1)^T. Since z is the first row of C^-1 and v the first column of C, then
z * v = 1, and since (1 1 ... 1) * v = 1, then z = (1 1 ... 1).

Finally, lim(k -> infty) J^k = e1 * e1^T, and thus
lim(k -> infty) A^k * w = C * e1 * e1^T * C^-1 * w = (C * e1) * (e1^T * C^-1) * w
= v * z * w = v * (1 1 ... 1) * w = v * ((1 1 ... 1) * w) = v * 1 = v.

=#

using Printf
using LinearAlgebra

start = time()
result = ""

tiles = 40
sides = 4

go = 1
r1 = 6
jail = 11
c1 = 12
e3 = 25
g2j = 31
cc3 = 34
h2 = 40

cc = [3, 18, 34]
ch = [8, 23, 37]
railways = [6, 16, 26, 36]
utilities = [13, 29]

# The transition matrix is a matrix Mij that indicate the probability of going
# from tile i to tile j
function build_transition(transition, pos)
    # The odds of a rolling doubles three times in a row
    triple_roll_odds = 1.0 / sides^3
    # Should go to jail
    transition[jail, pos] += triple_roll_odds

    # Otherwise, subtracting the odds of triple double rolls, each roll will have
    # equal odds
    prob = (1.0 - triple_roll_odds) * 1.0 / sides^2

    for i in 1:sides
        for j in 1:sides
            # For each possible roll calculate the square you'll end up in
            final = mod(pos + i + j - 1, tiles) + 1

            # If the player falls in the Go To Jail tile
            if final == g2j
                transition[jail, pos] += prob
            # If the player falls in a Community Chest tile
            elseif final in cc
                transition[go, pos] += prob * 1.0 / 16.0
                transition[jail, pos] += prob * 1.0 / 16.0
                transition[final, pos] += prob * 14.0 / 16.0
            # If the player falls in a Chance tile
            elseif final in ch
                transition[go, pos] += prob * 1.0 / 16.0
                transition[jail, pos] += prob * 1.0 / 16.0
                transition[c1, pos] += prob * 1.0 / 16.0
                transition[e3, pos] += prob * 1.0 / 16.0
                transition[h2, pos] += prob * 1.0 / 16.0
                transition[r1, pos] += prob * 1.0 / 16.0
                next_railway =
                    if railways[3] <= final && final < railways[4]
                        railways[4]
                    elseif railways[2] <= final && final < railways[3]
                        railways[3]
                    elseif railways[1] <= final && final < railways[2]
                        railways[2]
                    else
                        railways[1]
                    end
                transition[next_railway, pos] += prob * 1.0 / 8.0
                next_utility =
                    if utilities[1] <= final && final < utilities[2]
                        utilities[2]
                    else
                        utilities[1]
                    end
                transition[next_utility, pos] += prob * 1.0 / 16.0
                back_three_tiles = mod(final - 1 - 3, tiles) + 1
                # There is a special case when going back three tiles from Chest 3
                # as the player may fall in the Community Chest 3 and would need to
                # pull a new card that may send him to either Go, Jail, or leave him
                # there
                if back_three_tiles == cc3
                    transition[go, pos] += prob * 1.0 / 16.0 * 1.0 / 16.0
                    transition[jail, pos] += prob * 1.0 / 16.0 * 1.0 / 16.0
                    transition[back_three_tiles, pos] += prob * 1.0 / 16.0 * 14.0 / 16.0
                else
                    transition[back_three_tiles, pos] += prob * 1.0 / 16.0
                end
                transition[final, pos] += prob * 6.0 / 16.0
            # Otherwise add the probability to the tile the player fell on
            else
                transition[final, pos] += prob
            end
        end
    end
end

# We don't need to remove the Go To Jail index, as in every iteration the state
# vector will always have a zero in that index, so it is irrelevant for our purposes.
transition = zeros(tiles, tiles)
for pos in 1:tiles
    build_transition(transition, pos)
end

state = zeros(tiles)
state[1] = 1.0
tol = 1e-5

while true
    global state
    prev_state = state
    state = transition * prev_state
    norm(state - prev_state) <= tol && break
end

tilearr = sort(collect(1:tiles), by=idx -> state[idx], rev=true)
for idx in 1:3
    global result
    result *= @sprintf("%02d", tilearr[idx] - 1)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
