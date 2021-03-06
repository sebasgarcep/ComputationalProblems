#=
Approach:
Let S(p) be the sum of all n, so that T(n) is p-smooth. Notice that T(n) = n * (n + 1) / 2.
Thus T(n) is p-smooth if n and n+1 are p-smooth, for p > 2.

Using Stormer's theorem with Lehmer's method we can solve this problem.

---------------------------------------------------------------------------------------------------

                        PROOF OF LEHMER'S METHOD FOR STORMER'S PROBLEM

Definition: Unit of a ring
--------------------------

A unit of a ring R is an element a such that there is an element b where a * b = 1.

Definition: Norm of Z[sqrt(D)]
------------------------------

The norm N in the ring Z[sqrt(D)] is a multiplicative function defined as:

N(x + sqrt(D) * y) = (x + sqrt(D) * y) * (x - sqrt(D) * y)

Clearly, solutions to Pell's equation have norm 1, and are therefore units of this ring.

Properties of the Lucas Function Un
-----------------------------------

Let x^2 - D * y^2 = 1 be Pell's equation. Let (xn, yn) be the nth solution to this equation. Then:

1. xn + sign(n) * sqrt(D) * yn = (x1 + sqrt(D) * y1)^n, where x1 + sqrt(D) * y1 is the smallest solution
to the problem.

Proof:
------

First let us prove the case for n >= 0.

Clearly, x1 + sqrt(D) * y1 is an unit of the ring Z[sqrt(D)]. Notice that because the norm is multiplicative
then N((x1 + sqrt(D) * y1)^n) = N(x1 + sqrt(D) * y1)^n = 1^n = 1. Thus (x1 + sqrt(D) * y1)^n is a solution
to Pell's equation. Let (x1 + sqrt(D) * y1)^n = xn' + sqrt(D) * yn'. We will show that all solutions are of
this form. Suppose xn + sqrt(D) * yn is not of the form (x1 + sqrt(D) * y1)^n. Let m be the largest integer
such that xn + sqrt(D) * yn > (x1 + sqrt(D) * y1)^m. Notice that (x1 + sqrt(D) * y1)^-1 = x1 - sqrt(D) * y1.
Let a = (xn + sqrt(D) * yn) * (x1 + sqrt(D) * y1)^-m = (xn + sqrt(D) * yn) * (x1 - sqrt(D) * y1)^m. Let
a = xn~ + sqrt(D) * yn~. Notice that a has a norm of 1, by the multiplicativity of N, thus it is a solution
to Pell's equation. Also, it is clear that a > 1. Therefore xn~ and yn~ are positive. Also:

xn + sqrt(D) * yn < (x1 + sqrt(D) * y1)^(m + 1)
a < x1 + sqrt(D) * y1

But this contradicts the fact that x1 + sqrt(D) * y1 is the smallest solution, which must exists as all solutions
are convergents of the sqrt(D) and can therefore be ordered.

Finally notice that:

xn - sqrt(D) * yn = (xn - sqrt(D) * yn) * (xn + sqrt(D) * yn) / (xn + sqrt(D) * yn)
                  = (xn^2 - D * yn^2) / (xn + sqrt(D) * yn)
                  = 1 / (xn + sqrt(D) * yn)
                  = 1 / (x1 + sqrt(D) * y1)^n
                  = (x1 + sqrt(D) * y1)^-n

-------------------------------------------------------------------------------------------------------------

2. Let a = x1 + sqrt(D) * y1, b = x1 - sqrt(D) * y1, so that a + b = 2 * x1, a * b = 1, a - b = 2 * sqrt(D) * y1,
and 2 * xn = a^n + b^n, 2 * sqrt(D) * yn = a^n - b^n. We also introduce Un = yn / y1 = (a^n - b^n) / (a - b).
Also define Q to be the set of numbers generated by multiplying the primes q1, q2, ... , qt, with q1 < q2 < ... < qt
and let M = max(3, (qt + 1) / 2). Then:

a. x2n = 2 * xn^2 - 1
b. U2n = 2 * xn * Un
c. xm+-n = xm * xn +- D * ym * yn
d. Um+-n = xn * Um +- xm * Un
e. Un = sum(i >= 0) (n choose 2 * i + 1) * D^i * y1^(2 * i) * x1^(n - 1 - 2 * i)
f. xn = sum(i >= 0) (n choose 2 * i) * D^i * y1^(2 * i) * x1^(n - 2 * i)
g. Umn = sum(i >= 0) (n choose 2 * i + 1) * D^i * Um^(2 * i + 1) * y1^(2 * i) * xm^(n - 1 - 2 * i)

Proof:
------

a. x2n + sqrt(D) * y2n = (x1 + sqrt(D) * y1)^(2 * n)
                       = ((x1 + sqrt(D) * y1)^n)^2
                       = (xn + sqrt(D) * yn)^2
                       = xn^2 + sqrt(D) * 2 * xn * yn + D * yn^2

Thus, x2n = xn^2 + D * yn^2 = 2 * xn^2 + D * yn^2 - xn^2 = 2 * xn^2 - 1.

b. Due to the previous proof y2n = 2 * xn * yn, thus: 2 * xn = y2n / yn = (y2n / y1) / (yn / y1) = U2n / Un,
and therefore U2n = 2 * xn * Un.

c. Without loss of generality, assume all signs are positive:

xm+n + sqrt(D) * ym+n = (x1 + sqrt(D) * y1)^(m + n)
                      = (xm + sqrt(D) * ym) * (xn + sqrt(D) * yn)
                      = xm * xn + sqrt(D) * ym * xn + sqrt(D) * yn * xm + D * ym * yn

Thus: xm+n = xm * xn +- D * ym * yn.

d. By the previous proof ym+n = xn * ym + xm * yn. Thus:

ym+n / y1 = xn * ym / y1 + xm * yn / y1
Um+n = xn * Um + xm * Un

e. xn + sqrt(D) * yn = (x1 + sqrt(D) * y1)^n
                     = sum(k = 0, n) (n choose k) sqrt(D)^k * y1^k * x1^(n - k)

Thus:

yn = sum(k >= 0) (n choose 2 * k + 1) D^k * y1^(2 * k + 1) * x1^(n - 2 * k - 1)
yn / y1 = sum(k >= 0) (n choose 2 * k + 1) D^k * y1^(2 * k) * x1^(n - 2 * k - 1)
Un = sum(k >= 0) (n choose 2 * k + 1) D^k * y1^(2 * k) * x1^(n - 2 * k - 1)

f. By the previous proof:

xn = sum(k >= 0) (n choose 2 * k) D^k * y1^(2 * k) * x1^(n - 2 * k)

g. xmn + sqrt(D) * ymn = (x1 + sqrt(D) * y1)^(m * n)
                       = ((x1 + sqrt(D) * y1)^m)^n
                       = (xm + sqrt(D) * ym)^n
                       = sum(k = 0, n) (n choose k) sqrt(D)^k * ym^k * xm^(n - k)

Thus:

ymn = sum(k >= 0) (n choose 2 * k + 1) D^k * ym^(2 * k + 1) * xm^(n - 2 * k - 1)
ymn / y1 = sum(k >= 0) (n choose 2 * k + 1) D^k * ym^(2 * k + 1s) * xm^(n - 2 * k - 1) / y1
Umn = sum(k >= 0) (n choose 2 * k + 1) D^k * ym^(2 * k + 1) * xm^(n - 2 * k - 1) / y1
Umn = sum(k >= 0) (n choose 2 * k + 1) D^k * ym^(2 * k + 1) / y1^(2 * k + 1) * y1^(2 * k + 1) * xm^(n - 2 * k - 1) / y1
Umn = sum(k >= 0) (n choose 2 * k + 1) D^k * ym^(2 * k + 1) / y1^(2 * k + 1) * y1^(2 * k) * xm^(n - 2 * k - 1)
Umn = sum(k >= 0) (n choose 2 * k + 1) D^k * Um^(2 * k + 1) * y1^(2 * k) * xm^(n - 2 * k - 1)

-------------------------------------------------------------------------------------------------------------

Definition: Rank of Apparition
------------------------------

Let p >= 2 be a prime, and let w(p) be the least positive j for which Uj is divisible by p.

-------------------------------------------------------------------------------------------------------------

Lemma 1 (Law of Apparition)
---------------------------

Let p >= 2 be a prime number. Then:

1. w(2) = 2.
2. w(p) = p if p divides D * y1.
3. For any other prime p, w(p) divides (p - e) / 2, where e = D^((p - 1) / 2) (mod p).

Proof:
------

1. U1 = 1. U2 = 2 * x1 * U1 = 2 * x1 (using b). Thus 2 | U2.

2. If p divides D * y1, then (using e):

Un = sum(i >= 0) (n choose 2 * i + 1) * D^i * y1^(2 * i) * x1^(n - 1 - 2 * i) (mod p)

when i > 0, the term is a factor of D * y1, therefore it equals 0 mod p. Thus i = 0. Using this:

Un = (n choose 1) * x1^(n - 1) = n * x1^(n - 1) (mod p)

Also, because x1^2 - D * y1^2 = 1, then x1^2 = 1 (mod p). Because Zp has no zero divisors, this
equation has only two solutions x1 = -1 and x1 = 1. Thus p does not divide x1 and therefore can only
divide n. Thus w(p) = p.

3. If p > 2 and p does not divide D * y1, then (using e):

Up = sum(i >= 0) (p choose 2 * i + 1) * D^i * y1^(2 * i) * x1^(p - 1 - 2 * i) (mod p)

Note that (p choose k) = p! / (k! * (p - k)!). Clearly, p | p!, therefore p | (p choose k),
as p cannot divide k! nor (p - k)!, except when k = p or p - k = p (k = 0). Thus 2 * i + 1 = p,
as 2 * i + 1 > 0. Therefore:

Up = D^((p - 1) / 2) * y1^(p - 1) = D^((p - 1) / 2) = e (mod p)

Similarly, using f, we get:

xp = sum(i >= 0) (p choose 2 * i) * D^i * y1^(2 * i) * x1^(p - 2 * i) (mod p)
xp = x1^p = x1 (mod p)

Notice that p does not divide D * y1, and thus it can't divide D. Therefore:

e = D^((p - 1) / 2) = +- 1 (mod p).

Using d, if e = 1 (mod p):

Up-e = xe * Up - xp * Ue (mod p)
     = x1 * e - x1 * U1 (mod p)
     = x1 * (e - 1) (mod p)
     = 0 (mod p)

If e = -1 (mod p), then:

Up-e = Up+1 = x1 * Up + xp * U1 (mod p)
            = x1 * e + x1 (mod p)
            = x1 * (e + 1) (mod p)
            = 0 (mod p)

And using c, if e = 1 (mod p):

xp-e = xp * xe - D * yp * ye (mod p)
     = xp * x1 - D * yp * y1 (mod p)
     = x1^2 - D * yp * y1 (mod p)
     = x1^2 - D * (yp / y1) * y1^2 (mod p)
     = x1^2 - D * Up * y1^2 (mod p)
     = x1^2 - D * e * y1^2 (mod p)
     = x1^2 - D * y1^2 (mod p)
     = 1 (mod p)

Similarly, if e = -1 (mod p):

xp-e = xp+1 (mod p)
     = xp * x1 + D * yp * y1 (mod p)
     = x1^2 + D * yp * y1 (mod p)
     = x1^2 + D * (yp / y1) * y1^2 (mod p)
     = x1^2 + D * Up * y1^2 (mod p)
     = x1^2 + D * e * y1^2 (mod p)
     = x1^2 - D * y1^2 (mod p)
     = 1 (mod p)

Now, using a:

xp-e = 2 * x((p - e) / 2)^2 - 1

Thus, because xp-e = 1 (mod p):

2 * x((p - e) / 2)^2 - 1 = 1 (mod p)
2 * x((p - e) / 2)^2 - 2 = 0 (mod p)
2 * (x((p - e) / 2)^2 - 1) = 0 (mod p)
2 * (x((p - e) / 2) - 1) * (x((p - e) / 2) + 1) = 0 (mod p)

Thus p does not divide x((p - e) / 2). But using b:

Up-e = 2 * x((p - e) / 2) * U((p - e) / 2)

Because Up-e = 0 (mod p), p must divide U((p - e) / 2). Thus w(p) is at most (p - e) / 2.

Let Un be such that p | Un. Let v = n - w(p). Thus:

Un = Uw(p)+v = xv * Uw(p) + xw(p) * Uv

Notice that Un = xw(p) * Uv (mod p), as p | Uw(p). If v >= w(p), we can keep subtracting w(p) from it,
and cancelling terms until v < w(p). In the case v < w(p) then either p | xw(p) or p | Uv. Notice that
if we let p | xw(p) then Uw(p)-1 = x1 * Uw(p) - xw(p) * U1 = 0 (mod p), as p | Uw(p), which is a
contradiction. Thus p cannot divide xw(p) and must divide Uv. But v being smaller than w(p) and positive
contradicts the definition of w(p). Thus v = 0. That is, n is evenly divisible by w(p).

In particular, w(p) divides (p - e) / 2.

-------------------------------------------------------------------------------------------------------------

Lemma 2
-------

Let p > 3 be a prime dividing D * y1. Then Up = p (mod p^2)

Proof:
------

Using e:

Up = sum(i >= 0) (p choose 2 * i + 1) * D^i * y1^(2 * i) * x1^(p - 1 - 2 * i) (mod D^2 * y1^2)
   = (p choose 1) * x1^(p - 1) + (p choose 3) * D * y1^2 * x1^(p - 3) (mod D^2 * y1^2)
   = p * x1^(p - 1) + (p choose 3) * D * y1^2 * x1^(p - 3) (mod D^2 * y1^2)

Since p | D * y1 and p | (p choose 3), then Up = p * x1^(p - 1) (mod p^2). Since x1^(p - 1) = 1 (mod p), then
x1^(p - 1) = (1 + k * p) (mod p^2), for some k. Thus Up = p * x1^(p - 1) = p * (1 + k * p) = p (mod p^2).

-------------------------------------------------------------------------------------------------------------

Lemma 3 (Law of Repetition)
---------------------------

Let l >= 0, and let k be an integer not divisible by the prime p. Let p^a, a > 0, be the highest power of p
dividing Um. Then the highest power of p dividing U(k * m * p^l) is p^(a + l).

Proof:
------

Let l = 0. Then, using g:

Ukm = sum(i >= 0) (k choose 2 * i + 1) * D^i * Um^(2 * i + 1) * y1^(2 * i) * xm^(k - 1 - 2 * i) (mod Um^3)
    = k * Um * xm^(k - 1) (mod Um^3)

Therefore Ukm = k * Um * xm^(k - 1) + r * Um^3, for some integer r. Therefore p^a clearly divides Ukm. To
see that no higher power of p divides Ukm notice that by hypothesis p does not divide k. Also, because
p | Um = ym / y1, then p | ym. Therefore:

xm^2 - D * ym^2 = 1 (mod p)
xm^2 = 1 (mod p)

Therefore p does not divide xm, and therefore the largest power of p that divides Ukm must be p^a.

Let l = 1. Then, using g:

Ukmp = sum(i >= 0) (k * p choose 2 * i + 1) * D^i * Um^(2 * i + 1) * y1^(2 * i) * xm^(k * p - 1 - 2 * i) (mod Um^3)
    = k * p * Um * xm^(k * p - 1) (mod Um^3)

Using a similar argument to the one before we can prove that the largest power of p that divides Ukmp must
be p^(a + 1).

Let l > 1. Assume that the statement is true for 0, 1, 2, ... , l - 1. Then the highest power of p dividing
U(k * m * p^(l - 1)) is p^(a + l - 1). Then, using g:

U(k * m * p^l) = sum(i >= 0) (p choose 2 * i + 1) * D^i * U(k * m * p^(l - 1))^(2 * i + 1) * y1^(2 * i) * x(k * m * p^(l - 1))^(p - 1 - 2 * i) (mod U(k * m * p^(l - 1))^3)
    = p * U(k * m * p^(l - 1)) * x(k * m * p^(l - 1))^(p - 1) (mod U(k * m * p^(l - 1))^3)
    = p * U(k * m * p^(l - 1)) * x(k * m * p^(l - 1))^(p - 1) (mod U(k * m * p^(l - 1))^3)

The highest power of p that divides U(k * m * p^(l - 1)) is p^(a + l - 1). As p does not divide x(k * m * p^(l - 1))
the highest power of p that can divide U(k * m * p^l) is p^(a + l).

-------------------------------------------------------------------------------------------------------------

Definition (Galois conjugate)
-----------------------------

The Galois conjugates of a from a field K are the roots of the minimal polynomial of a in a field F contained in K.

Definition (Algebraic integers)
-------------------------------

Let K be a finite field extension of Q. Let a belong to K. Then a is an algebraic integer if there exists a monic
polynomial f(x) in Z[x] such that f(a) = 0.

Proposition
-----------

If an algebraic integer is rational, then it is also an integer.

Proof:
------

Let a be a rational, algebraic integer. By the rational root test a = p/q where p and q are coprime, p is an integer
factor of the constant term of the polynomial and q is a factor of the leading term of the polynomial. But the leading
term of the polynomial is 1. Therefore q = 1 and a is an integer.

Definition
----------

Let Un = (a^n - b^n) / (a - b). Then we will define Gn to be a subset of factors of Un, in terms of a and b.
Specifically:

Gn = prod(h = 1, n - 1, h coprime to n) [ a - b * e^(2 * pi * i * h / n) ]

Also, a prime factor of Gn which divides n is called intrinsic. Otherwise it is called extrinsic.

Corollaries:
------------

1. Gn is an integer. To see this notice that:

a. Gn is symmetric with respect to a and b. If n = 2, then G2 = a + b = b + a. If n > 2, then, letting
w(n) = e^(2 * pi * i / n) (if n is clear we will just write w = w(n)) and Gn' be the sequence where a and b are swapped
around, we get:

Gn = prod(h = 1, n - 1, h coprime to n) (a - b * w^h)
   = prod(h = 1, n - 1, h coprime to n) (a - b * w^h) * -w^(n - h) / -w^(n - h)
   = prod(h = 1, n - 1, h coprime to n) (b - a * w^(n - h)) / -w^(n - h)
   = [ prod(h = 1, n - 1, h coprime to n) (b - a * w^(n - h)) ] / [ prod(h = 1, n - 1, h coprime to n) -w^(n - h) ]
   = [ prod(h = 1, n - 1, h coprime to n) (b - a * w^(n - h)) ] / [ (-1)^phi(n) * prod(h = 1, n - 1, h coprime to n) w^(n - h) ]

Notice that phi(n) is even for n > 2, thus:

Gn = [ prod(h = 1, n - 1, h coprime to n) (b - a * w^(n - h)) ] / [ prod(h = 1, n - 1, h coprime to n) w^(n - h) ]

Notice also that a product over n - h can be swapped around into a product over h as there is a one-to-one mapping
between n - h and h, as both are coprime or both aren't. Thus:

Gn = [ prod(h = 1, n - 1, h coprime to n) (b - a * w^(n - h)) ] / [ prod(h = 1, n - 1, h coprime to n) w^(n - h) ]
   = [ prod(h = 1, n - 1, h coprime to n) (b - a * w^h) ] / [ prod(h = 1, n - 1, h coprime to n) w^h ]
   = Gn' / [ prod(h = 1, n - 1, h coprime to n) w^h ]
   = Gn' / w^( sum( h = 1, n - 1, h coprime to n ) h )

We claim that sum( h = 1, n - 1, h coprime to n ) h is a multiple of n and thus the denominator equals 1. To see
this notice that:

sum( h = 1, n - 1, h coprime to n ) h = sum( h = 1, n - 1, h coprime to n ) n - h
2 * sum( h = 1, n - 1, h coprime to n ) h = sum( h = 1, n - 1, h coprime to n ) n
2 * sum( h = 1, n - 1, h coprime to n ) h = n * sum( h = 1, n - 1, h coprime to n ) 1
2 * sum( h = 1, n - 1, h coprime to n ) h = n * phi(n)
sum( h = 1, n - 1, h coprime to n ) h = n * phi(n) / 2

b. It is clear that if you reorder the primitive roots of unity in Gn = prod(h = 1, n - 1, h coprime to n) (a - b * w^pi(h))
you still get Gn. Therefore Gn is symmetric with respect to the primitive roots of unity.

c. First, Notice that Gn is in Q(sqrt(D), w). Also a and b are Galois conjugates of each other. Therefore, any field
homomorphism f: Q(sqrt(D), w) -> C will at most map one onto the other. Also, the primitive roots of unity are Galois
conjugates of each other, so any field homomorphism will map one unto the others (notice that the non-primitive elements
have a minimal polynomial of lesser degree, therefore they are not Galois conjugates of these elements, and thus we don't
have to worry about them being in the image of the field homomorphism).

Since any field homomorphism will only permute a with b, and the primitive roots of unity with each other, and since Gn is
symmetric with respect to these two possible permutations, Gn is fixed by any field homomorphism. But any field homomorphism
is defined by the mappings of the generators 1, sqrt(D), w. Therefore Gn can only be fixed if it is in the subfield generated
by 1, which is Q. Therefore Gn is rational.

Moreover Gn is an algebraic integer as algebraic integers are closed under addition and multiplication. But this implies
Gn is an integer by a previous proposition.

2. Un = prod(s | n) Gs. Clearly, the roots of x^n - b^n are b * w^k, for 0 <= k < n, therefore:

x^n - b^n = prod(k = 0, n - 1) (x - b * w^k).

Substituting a into x and dividing by a - b we get (a^n - b^n) / (a - b) = prod(k = 1, n - 1) (a - b * w^k).

Let a - b * w^k, with 0 < k < n. Suppose w / n = w' / n', in simplest terms. Then a - b * w^k | Gn'. Because all a - b * w^k
are different for different k, we get that Un | prod(s | n) Gs. Now let s | n. Then:

Gs = prod(k = 1, s, k coprime to s) a - b * w(s)^k
   = prod(k = 1, s, k coprime to s) a - b * w^(k * m / s)

Now we need to ask whether the factor a - b * w^(k * m / s) can appear more than once. Clearly, all factors of Gs are different,
so it cannot repeat itself in the same Gs. Assume that the factor repeats itself in some other Gs. Therefore there is another
pair k', s' such that k' is coprime to s', 0 < k' < s', and k * m / s = k' * m / s' (This is clear from the fact that 0 < k < s
implies 0 < k * m / s < m and similarly 0 < k' * m / s' < m). Then k / s = k' / s'. But because k and s are coprime they are in
simpliest terms. Similarly, k' and s' are coprime. Therefore they are simplest terms too. This implies k = k' and s = s', which
is a contradiction. Therefore no term repeats more than once, and since Un has all possible a - b * w^k, except for k = 0 which
is not in any Gs, Un = prod(s | n) Gs.

-------------------------------------------------------------------------------------------------------------

Definition
----------

A prime factor of Gn which divides n is called intrinsic. The other prime factors of Gn are called extrinsic.

Lemma 4
-------

If Gn has an intrinsic prime factor p, then p is the largest prime factor of n. If n > 3, Gn is not divisible
by p^2.

Proof:
------

Let d be the greatest common divisor of Gn and n. If d = 1, there is nothing to prove. If d > 1, let p be any prime factor
of d, and let w = w(p) be the rank of apparition of p in the sequence U. Since p divides Gn and hence Un, it follows that
w divides n. Let

n = k * w * p^l (l >= 0, p | k)

We first show that k = 1. In fact if k > 1, the integer

Un / Un/k = prod(s | n, s does not divide n / k) Gs

is divisible by Gn and hence by p. But by the Law of Repetition, Un / Un/k is not divisible by p. Hence k = 1, and

n = wp^l

By Lemma 1, p >= w (either w = p or w <= (p - e) / 2 <= p). Thus p is the largest prime factor of n. It remains to show
that if n > 3, Gn is not divisible by p^2. Suppose the contrary, and suppose that l > 0. Then the ratio

Uwp^l / Uwp^(l-1)

would be divisible by Gn and hency by p^2. But the Law of Repetition forbids this. Hence l = 0 and n = w. Since p | n,
p <= w. But p >= w. Hence p = w = n > 3. By Lemma 2, Gn = Gp = Up is not divisible by p^2. This establishes the lemma.

Lemma 5
-------

If n > 3, yn is divisible by a prime >= 2n - 1.

Proof:
------

Let n = prod(j = 1, t) pj^aj be the factorization of n into its prime factors of which the prime pt is the largest. Then:

phi(n) = prod(j = 1, t) pj^(aj - 1) * (pj - 1)

Hence

| Gn | = prod(h coprime to n) | a - b * e^(2 * pi * i * h / n) | > (a - b)^phi(n) = (2 * y1 * sqrt(D))^phi(n) > 2^(pt - 1) >= p^t.

By Lemma 4, Gn can be divides by at most p, but because Gn > p^t >= p, it must have at least another prime factor. By
Lemma 4, Gn can only have one intrinsic prime factor, therefore Gn has an extrinsic prime factor p*. Let w = w(p*) be
the rank of apparition of p*. Since p* divides Gn and hence Un, w divides n. Suppose, if possible, that w < n, so that
Gn divides the integer

Un / Uw = prod(s | n, s does not divide w) Gs

Then p* divides this ratio. But p* being extrinsic, does not divide n or w and so, by Lemma 3, Un / Uw is not divisible
by p*. This contradiction prove that w = n. But then p* != w since p* does not divide n. Therefore by Lemma 1, w, and
hence n, divides 1/2 * (p* +- 1). Thus p* >= 2n - 1. But p* divides Gn, which divides Un, which in turn divides yn = Un * y1.
This proves the lemma.

Lehmer's method
---------------

Let 2 = q1 < q2 < ... < qt be a given set of t primes. Let Q be the set of numbers of the form q1^a1 * q2^a2 * ... * qt^at
and let Q' be the subset of all 2^t - 1 square-free members of Q with the exception of 2. Let S be an integer such that
both S and S+1 belongs to Q. Then S = (xn - 1) / 2 where (xn, yn) is a solution of the Pell equation

x^2 - 2 * D * y^2 = 1 (12)

in which

D belongs to Q', 1 <= n <= M = max(3, (qt + 1) / 2), yn belongs to Q (13)

Conversely, if (xn, yn) is a solution of (12) subject to conditions (13), then S = (xn - 1) / 2 and S+1 both belong to Q.

Proof:
------

Suppose first that (xn, yn) satisfies (12) and (13). Then, since xn is odd and yn is even,

S * (S+1) = (xn^2 - 1) / 4 = 2 * D * (yn / 2)^2 belongs to Q.

On the other hand, suppose that S(S + 1) belongs to Q, so that

S * (S + 1) = 2 * q1^a1 * q2^a2 * ... * qt^at

where ai = ei + 2bi, ei = 0, 1. Furthermore let x = 2 * S + 1, y = 2 * q1^b1 * q2^b2 * ... * qt^bt, D = q1^e1 * q2^e2 * ... * qt^et.
Then:

4 * S * (S + 1) = 4 * S^2 + 4 * S = x^2 - 1 = 2 * D * y^2

Hence each S leads to some solution (x, y) of (12) in which y and D belong to Q and Q' respectively. It remains to show
that n <= M. Suppose, instead, that n > M. Applying the Lemma 5 we conclude that yn is divisible by a prime p such that
p >= 2n - 1 > 2M - 1 >= qt. Hence yn is not a member of Q, as it is divisible by a prime larger than the largest prime
in Q. By contradiction we get n <= M, which implies the finiteness of the possible solution space.

-------------------------------------------------------------------------------------------------------------

Finally, from OEIS A117581, the largest p-smooth number for p = 47 is 1109496723125. Thus,
we can stop searching when we go over this value.

Sources:
https://en.wikipedia.org/wiki/St%C3%B8rmer%27s_theorem
https://projecteuclid.org/download/pdf_1/euclid.ijm/1256067456

=#

using Printf

function is_smooth(primes, x)
    xv = x
    for p in primes
        while xv % p == 0
            xv = fld(xv, p)
        end
    end
    return xv == 1
end

function solve(primes, v, s)
    r = 0
    n = 0
    d = 2 * v
    ul = BigInt(2)^65 + 1 # (p - 1) / 2 < 2^64
    # Solve Pell's equation
    a0 = BigInt(floor(sqrt(d)))
    mk = BigInt(0)
    dk = BigInt(1)
    ak = a0
    p_prev = BigInt(1)
    q_prev = BigInt(0)
    p = ak
    q = BigInt(1)
    while n < s && p < ul
        mk = ak * dk - mk
        dk = div(d - mk^2, dk)
        ak = div(a0 + mk, dk)
        p_temp = p
        q_temp = q
        p = ak * p + p_prev
        q = ak * q + q_prev
        p_prev = p_temp
        q_prev = q_temp
        if p^2 - d * q^2 == 1
            # Generate result
            x1 = fld(p - 1, 2)
            x2 = fld(p + 1, 2)
            if is_smooth(primes, x1) && is_smooth(primes, x2)
                r += x1
            end
            n += 1
        end
    end
    return r
end

function search(result, primes, s, i, q)
    if i > length(primes)
        if q != 2
            result += solve(primes, q, s)
        end
        return result
    end
    result = search(result, primes, s, i + 1, q)
    result = search(result, primes, s, i + 1, q * primes[i])
    return result
end

start = time()
result = 0

p = 47

primes = []
slots = [true for _ in 1:p]
slots[1] = false
for k in 2:p
    global slots
    if slots[k]
        push!(primes, k)
        for t in (2 * k):k:p
            slots[t] = false
        end
    end
end

pmax = last(primes)
s = max(3, fld(pmax + 1, 2))
result = search(result, primes, s, 1, 1)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
