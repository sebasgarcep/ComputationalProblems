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

1. xn + sqrt(D) * yn = (x1 + sqrt(D) * y1)^n, where x1 + sqrt(D) * y1 is the smallest solution to the problem.

Proof:
------

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

FIXME: Prove this.

-------------------------------------------------------------------------------------------------------------

Lemma 1 (Law of Apparition)
---------------------------

Proof:
------

FIXME: missing proof for Stormer's theorem.
---------------------------------------------------------------------------------------------------

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