#=
Approach: (Taken from https://crypto.stanford.edu/pbc/notes/contfrac/converge.html)
A continued fraction of an irrational square root can be calculated as follows:

sqrt(D) = floor(sqrt(d)) + (sqrt(D) - floor(sqrt(D)))

If floor(sqrt(D)) = a0 and u1 = 1 / (sqrt(D) - floor(sqrt(D))), then:

sqrt(D) = a0 + 1 / u1

If a1 = floor(u1) then:

sqrt(D) = a0 + 1 / (a1 + (u1 - a1))

If u2 = 1 / (u1 - a1) then:

sqrt(D) = a0 + 1 / (a1 + 1 / u2)

And if a2 = floor(u2) then:

sqrt(D) = a0 + 1 / (a1 + 1 / (a2 + (u2 - a2)))

Notice that this process can continue indefinitely (for irrational numbers) and
thus generates a sequence [a0; a1, a2, ...] with:

- u0 = sqrt(D)
- ui = 1 / (ui-1 - ai-1), i > 0
- ai = floor(ui)

Notice that the truncated continued fraction produces a sequence of fractions that
have been proven to be the best possible rational approximations to the number,
for any other fraction with denominator equal or less. This implies that the fraction
(also known as convergent) is irreducible. This fact is useful because it allows
us to compute the numerator (or denominator) using only previous numerators (or
denominators) as we will now see.

The convergents of a continued fraction can be calculated with the formula:

p0/q0 = a0/1
p1/q1 = (a1 * a0 + 1) / a1
pk/qk = (ak * pk-1 + pk-2) / (ak * qk-1 + qk-2)

To prove this notice that this formula is true for k = 2:

p2/q2 = a0 + 1 / (a1 + 1 / a2)
      = a0 + a2 / (a2 * a1 + 1)
      = (a0 * (a2 * a1 + 1) + a2) / (a2 * a1 + 1)
      = (a2 * a1 * a0 + a0 + a2) / (a2 * a1 + 1)
      = (a2 * (a1 * a0 + 1) + a0) / (a2 * a1 + 1)
      = (a2 * p1 + p0) / (a2 * q1 + q0)

Now assume it is true for k, k-1, k-2, etc. Notice that:

[a0; a1, a2, ... , ak, ak+1] = [a0; a1, a2, ... , ak + 1 / ak+1]

And because the right hand side of the equation has up to the k-th term, then the
formula for the k-th convergent applies to it. Then:

pk+1/qk+1 = ((ak + 1 / ak+1) * pk-1 + pk-2) / ((ak + 1 / ak+1) * qk-1 + qk-2)
          = ((ak+1 * ak + 1) * pk-1 + ak+1 * pk-2) / ((ak+1 * ak + 1 / ak+1) * qk-1 + ak+1 * qk-2)
          = (ak+1 * ak * pk-1 + ak+1 * pk-2 + pk-1) / (ak+1 * ak * qk-1 + ak+1 * qk-2 + qk-1)
          = (ak+1 * (ak * pk-1 + pk-2) + pk-1) / (ak+1 * (ak * qk-1 + qk-2) + qk-1)
          = (ak+1 * pk + pk-1) / (ak+1 * qk + qk-1)

Now let's prove that qk * pk-1 - pk * qk-1 = (-1)^k-1:

Notice that for the case k = 1 the statement is true:

q1 * p0 - p1 * q0 = a1 * a0 - (a1 * a0 + 1) * 1
                  = 1

Now assume that the statement is true for k, k-1, k-2, etc. Then:

qk+1 * pk - pk+1 * qk = (ak+1 * qk + qk-1) * pk - (ak+1 * pk + pk-1) * qk
                      = ak+1 * pk * qk + pk * qk-1 - ak+1 * pk * qk - qk * pk-1
                      = pk * qk-1 - qk * pk-1
                      = -1 * (qk * pk-1 - pk * qk-1)
                      = -1 * (-1)^k-1
                      = (-1)^k

Now we will prove that if pk/qk is a convergent of sqrt(D), and k is the smallest
integer such that pk^2 - D * qk^2 = 1, then (pk, qk) is the minimal solution for
a given D. We will use (though not prove) that all continued fractions of irrational
square roots are periodic. First let's prove that if a continued fraction has period
k, then (pk, qk) is a solution to x^2 - D * y^2 = (-1)^k-1.

Let sqrt(D) = [a0; a1, a2, ...] and xi = [ai; ai+1, ...]. Clearly x1 = xi+1 which
means:

sqrt(D) = (xk+1 * pk + pk-1) / (xk+1 * qk + qk-1)
        = (x1 * pk + pk-1) / (x1 * qk + qk-1)

and x1 = 1 / (sqrt(D) - a0), therefore:

sqrt(D) = (pk / (sqrt(D) - a0) + pk-1) / (qk * (sqrt(D) - a0) + qk-1)
        = (pk + pk-1 * (sqrt(D) - a0)) / (qk + qk-1 * (sqrt(D) - a0))

Therefore:

(qk + qk-1 * (sqrt(D) - a0)) * sqrt(D) = pk + pk-1 * (sqrt(D) - a0)
(qk + qk-1 * sqrt(D) - qk-1 * a0) * sqrt(D) = pk + pk-1 * sqrt(D) - pk-1 * a0
qk * sqrt(D) + qk-1 * D - qk-1 * a0 * sqrt(D) = pk + pk-1 * sqrt(D) - pk-1 * a0
qk * sqrt(D) + qk-1 * D - qk-1 * a0 * sqrt(D) - pk - pk-1 * sqrt(D) + pk-1 * a0 = 0
sqrt(D) * (qk - qk-1 * a0 - pk-1) + (qk-1 * D - pk + pk-1 * a0) = 0

And separating the irrational and rational parts:

qk - qk-1 * a0 - pk-1 = 0
qk-1 * D - pk + pk-1 * a0 = 0

And eliminating a0:

qk * pk-1 - pk-1^2 + qk-1^2 * D - pk * qk-1 = 0
qk * pk-1 - pk * qk-1 = pk-1^2 - qk-1^2 * D
(-1)^k-1 = pk-1^2 - qk-1^2 * D

Clearly if k is even then (p(2k), q(2k)) solve Pell's equation, otherwise (pk, qk)
is a solution.

We will now prove that when p, q are coprime and a minimal solution to Pell's equation,
then p/q is a convergent of sqrt(D).

If D = 2:

The minimal solution is (p, q) = (3, 2), and 3/2 is a convergent of sqrt(2).

If D = 3:

The minimal solution is (p, q) = (2, 1), and 2/1 is a convergent of sqrt(3).

Now, let D > 4. Then:

sqrt(D) > 2 > 2 - p/q
sqrt(D) * q^2 > 2 * q^2 - p * q
p * q + sqrt(D) * q^2 > 2 * q^2
1 / (p * q + sqrt(D) * q^2) < 1 / (2 * q^2)

Therefore:

|p/q - sqrt(D)| = |(p - sqrt(D) * q) / q| * |(p + sqrt(D) * q) / (p + sqrt(D) * q)|
                = |(p^2 - D * q^2) / ((p + sqrt(D) * q) * q)|
                = |1 / ((p + sqrt(D) * q) * q)|
                = 1 / ((p + sqrt(D) * q) * q)
                = 1 / (p * q + sqrt(D) * q^2)
                < 1 / (2 * q^2)

Now let the expansion of p/q = [b0; b1, b2, ... , bj]. let xj+1 be the real number
such that sqrt(D) = [b0; b1, b2, ... , bj, xj+1]. Showing xj+1 >= 1 proves that
p/q is part of the continued fraction expansion of sqrt(D). To see this define:

x = (xj+1 * pj + pj-1) / (xj+1 * qj + qj-1)

Define also e = x - pk / qk (choose the expansion of p/q so that k is odd).
Therefore, using pk/qk - pk-1/qk-1 = (-1)^k-1 / (qk * qk-1)):

0 < e < 1 / (2 * qk^2)

Now, rewriting:

xj+1 = (qk-1 * x - pk-1) / (-qk * x + pk)

and substituting for e:

xj+1 = (1 - e * qk * qk-1) / (e * qk^2)

Now we only need to show that 1 - e * qk * qk-1 >= e * qk^2:

e (qk^2 + qk * qk-1) < (qk^2 + qk * qk-1) / (2 * qk^2) < (qk^2 + qk^@) / (2 * qk^2) = 1

That is:

1 > e (qk^2 + qk * qk-1)
1 > e * qk^2 + e * qk * qk-1
1 - e * qk * qk-1 > e * qk^2

These two statements together show that solutions to Pell's equation are in fact
a subset of the convergents of sqrt(D) and that the minimal convergent is therefore
the minimal solution to Pell's equation.

An alternative way to calculate continued fractions that applies only to square
roots is

m0 = 0
d0 = 1
a0 = floor(sqrt(D))
mk = dk-1 * ak-1 - mk-1
dk = (D - mk^2) / dk-1
ak = floor((a0 + mk) / dk)

(https://web.archive.org/web/20151221205104/http://web.math.princeton.edu/mathlab/jr02fall/Periodicity/mariusjp.pdf)
To prove this notice that in the continued fraction the remainders always take
the form of xk = (sqrt(D) + mk) / dk. Using the recurrence relation:

sqrt(D) = (xk * pk-1 + pk-2) / (xk * qk-1 + qk-2)

Therefore:

xk = (-qk-2 * sqrt(d) + pk-2) / (qk-1 * sqrt(d) - pk-1)
   = (qk-2 * sqrt(d) - pk-2) / (pk-1 - qk-1 * sqrt(d))
   = (qk-2 * sqrt(d) - pk-2) * (pk-1 + qk-1 * sqrt(d)) / (pk-1^2 - d * qk-1^2)
   = (qk-2 * sqrt(d) - pk-2) * (qk-1 * sqrt(d) + pk-1) / (pk-1^2 - d * qk-1^2)
   = ((-1)^k-1 * sqrt(d) + d * qk-1 * qk-2 - pk-1 * pk-2) / (pk-1^2 - d * qk-1^2)

Therefore:

mk = (-1)^n * (pk-1 * pk-2 - d * qk-1 * qk-2)
dk = (-1)^n * (d * qk-1^2 - pk-1^2)

Clearly:

ak = floor(xk)
   = floor((sqrt(d) + mk) / dk)
   = floor(floor(sqrt(d) + mk) / dk)
   = floor(( floor(sqrt(d)) + mk ) / dk)
   = floor((a0 + mk) / dk)

Now:

(sqrt(D) + mk-1) / dk-1 = ak-1 + 1 / xk = ak-1 + dk / (sqrt(D) + mk)
(sqrt(D) + mk-1) * (sqrt(D) + mk) = ak-1 * (sqrt(D) + mk) * dk-1 + dk * dk-1
D + mk-1 * mk + sqrt(D) * mk + sqrt(D) * mk-1 = ak-1 * sqrt(D) * dk-1 + ak-1 * mk * dk-1 + dk * dk-1
sqrt(D) * (mk + mk-1 - ak-1 * dk-1) + (D + mk-1 * mk - ak-1 * mk * dk-1 - dk * dk-1) = 0

Separating irrational and rational parts:

mk + mk-1 - ak-1 * dk-1 = 0

Therefore:

mk = ak-1 * dk-1 - mk-1

And:

D + mk-1 * mk - ak-1 * mk * dk-1 - dk * dk-1 = 0
D + mk * (mk-1 - ak-1 * dk-1) = dk * dk-1
D - mk^2 = dk * dk-1
dk = D - mk^2 / dk-1

=#

using Printf

start = time()
sq_nums = Set([i^2 for i in 1:32])

result = nothing
for d in 1:1000
    global result
    global sq_nums
    if d in sq_nums
        continue
    end
    a0 = BigInt(floor(sqrt(d)))
    mk = BigInt(0)
    dk = BigInt(1)
    ak = a0
    p_prev = BigInt(1)
    q_prev = BigInt(0)
    p = ak
    q = BigInt(1)
    while p^2 - d * q^2 != 1
        mk = ak * dk - mk
        dk = div(d - mk^2, dk)
        ak = div(a0 + mk, dk)
        p_temp = p
        q_temp = q
        p = ak * p + p_prev
        q = ak * q + q_prev
        p_prev = p_temp
        q_prev = q_temp
    end
    if result == nothing || result[2] < p
        result = (d, p)
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
