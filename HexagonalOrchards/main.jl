#=
Approach:

We want to find when two points lie on the same ray from the origin. This is equivalent
to asking whether two points are colinear with respect to the origin. Clearly, two points
are colinear when you can go from one point to the other by scaling either of them.

Notice that all points can be represented using the formula:

x * (1, 0) + y * (1/2, sqrt(3)/2)

where x and y are integers. Therefore any two points (x, y) and (x', y') are colinear when
(x, y) / gcd(x, y) = (x', y') / gcd(x', y'). Therefore we can create equivalency classes
which we will represent using the point in that class that satisfies x > 0, y > 0 and
gcd(x, y) = 1.

Because we no longer care about the hexagonal arrangement of the points, we can map the
points to their respective grid points in the plane using a proper bijection. This linear
transformation must preserve colinearity and will leave the points in the following shape:

.....x
.....x.
.....x..
.....x...
.....x....
xxxxxxxxxxx
 ....x.....
  ...x.....
   ..x.....
    .x.....
     x.....

Therefore, for a given n, using the symmetry of the square, we only need to calculate the
number of equivalency classes representatives for the upper half that lie within each quadrant.
Notice that the second quadrant maps to two slices of the hexagon, therefore, we can find the
total by finding the corresponding value for the second quadrant and multipliying it by 3.

Thus the number of coprime pairs in this quadrant is the number of coprime pairs of order n
times two (once above the y = x line and once below), minus two (one to subtract for the case
y = x which we should only count once, and once for the case x = 0).

The number of coprime pairs can be calculated with the following statements:

Lemma 1
-------

If Fn is the Farey sequence of order n, then:

|F1| = 2
|Fn| = |Fn-1| + phi(n)

and therefore:

|Fn| = 1 + sum(k = 1, n) phi(n)

Proof:
------

Clearly F1 = (0/1, 1/1), thus |F1| = 2. Notice that |Fn| - |Fn-1| is the number
of new terms in Fn, that are not in Fn-1. These are the fractions such that their
lowest term representation has denominator n. Thus the numerator and the denominator
are coprime. Notice that phi(n) is the amount of numbers less than n coprime to n,
and each of these numbers corresponds exactly to one the fractions in Fn that are not
in Fn-1.

To illustrate, if d is coprime to n, then d/n cannot be reduced and thus it is in Fn
but not in Fn-1. Similarly, if d/n cannot be reduced then it is coprime to n. and is
counted by phi(n).

Lemma 2
-------

Let s(n) = sum(k = 1, n) phi(k). Then:

s(n) = n * (n + 1) / 2 - sum(m = 2, n) s(floor(n / m))
     = n * (n + 1) / 2 - sum(m = 2, sqrt(n)) s(floor(n / m)) - sum(d = 1, sqrt(n), d != floor(n / d)) (floor(n / d) - floor(n / (d + 1))) * s(d)

Proof:
------

Notice that:

sum(k = 1, n) phi(k) = sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 1) 1

Clearly:

n * (n + 1) / 2 = sum(k = 1, n) sum(r = 1, k) 1
                = sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 1) 1 +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 2) 1 +
                  ... +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = n) 1
                = sum(k = 1, n) phi(k) +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 2) 1 +
                  ... +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = n) 1
                = s(n) +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 2) 1 +
                  ... +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = n) 1

Also notice that if gcd(k, r) = m, for m = 2, 3, ... , n, then k = m * k' and
r = m * r', with gcd(k', r') = 1.  Therefore we can reduce the problem of counting
pairs that satisfy gcd(k, r) = m with 1 <= r <= k <= n to the problem of finding
1 <= r' <= k' <= n / m with gcd(k', r') = 1. This has s(floor(n / m)) solutions.
Because the previous extra sums after s(n) are counting such pairs, then:

n * (n + 1) / 2 = s(n) +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = 2) 1 +
                  ... +
                  sum(k = 1, n) sum(r = 1, k, gcd(k, r) = n) 1
                  = s(n) +
                  s(n / 2) +
                  ... +
                  s(n / n)

The first equation arises by isolating s(n).

To prove the second equation notice that terms of the form floor(n / m) are constant
over large intervals. Specifically:

floor(n / m) = d  <=>  m * d <= n <= m * (d + 1)  <=>  n / (d + 1) < m <= n / d

We can split the sum over the ranges that contain more than one integer (on these
we will run over d and only calculate s(d) once, multipliying it by the number of
integers in that range), and the ranges that contain only one integer (on these we
will run over m).

The interval [ n / (d + 1), n / d ] contains more than one integer, when
n / d - n / (d + 1) = n / (d * (d + 1)) >= 1. Thus:

n / d^2 >= n / (d * (d + 1)) >= 1

Therefore d <= sqrt(n). So d runs from 1 to sqrt(n). Therefore m must run for the values
wehere sqrt(n) < d <= n, then 1 < m <= n / sqrt(n) = sqrt(n). Therefore in the other sum
m must run from 2 to sqrt(n).

Finally, to prevent repeated terms in the sum we must avoid the case d = floor(n / d).

Source:
https://mathproblems123.wordpress.com/2018/05/10/sum-of-the-euler-totient-function/

=#

using Printf
using Memoize

@memoize function totientsum(n)
    if n == 1
        return 1
    end
    s = (n * (n + 1)) >> 1
    sqrtn = isqrt(n)
    for m in 2:sqrtn
        s -= totientsum(fld(n, m))
    end
    for d in 1:sqrtn
        r = fld(n, d)
        if d == r
            continue
        end
        s -= (r - fld(n, d + 1)) * totientsum(d)
    end
    return s
end

function main()
    start = time()
    result = 0

    n = 100000000
    result += 3 * n * (n + 1) + 1 # Number of points in the hexagon
    result -= 6 * (totientsum(n) + 1) # Number of coprime pairs
    result += 5 # We subtracted the origin 5 extra times, let's add them back up

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

# println(totientsum(10^6))
main()
