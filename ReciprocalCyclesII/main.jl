#=
Approach:
Clearly if 1/n has a finite decimal representation then n = 2^i * 5^j,  with 10^max(i, j)
decimal places. Now, suppose 1 / n has a repeating decimal expansion 0.(d1 d2 ... dk).
Then d1 d2 ... dk / 9 9 ... 9 = 1 / n, where the denominator has exactly k 9's. Now suppose:

1 / n = 0.d1' d2' ... dm' (d1 d2 ... dk)

Notice that:

0.d1' d2' ... dm' = 1 / (2^i * 5^j)
0.(d1 d2 ... dk) = d1 d2 ... dk / 9 9 ... 9

Therefore:

1 / n = 0.d1' d2' ... dm' + 0.(d1 d2 ... dk) / 10^m
      = 0.d1' d2' ... dm' + 0.(d1 d2 ... dk) / 10^max(i, j)
      = d1' d2' ... dm' / 10^max(i, j) + 0.(d1 d2 ... dk) / 10^max(i, j)
      = d1' d2' ... dm' / 10^max(i, j) + d1 d2 ... dk / ( 10^max(i, j) * 9 9 ... 9 )
      = ( d1' d2' ... dm' * 9 9 ... 9 + d1 d2 ... dk ) / ( 10^max(i, j) * 9 9 ... 9 )

Therefore n | 10^max(i, j) * 9 9 ... 9. Notice that if n = 2^i' * 5^j' * q, then
either max(i, j) = i' or max(i, j) = j', otherwise the numerator has to have at
least an extra factor of 10. Thus:

d1' d2' ... dm' * 9 9 ... 9 + d1 d2 ... dk = 0 (mod 10)
d1' d2' ... dm' * (-1) + d1 d2 ... dk = 0 (mod 10)
d1' d2' ... dm' = d1 d2 ... dk (mod 10)
dm' = dk (mod 10)

But this implies that the repeated fraction starts one digit earlier, which
contradicts the definition of 1 / n. Thus the number of decimal places after
which the repeated decimal expansion starts is given by max(i, j). Therefore:

1 / n = 0.d1' d2' ... dm' + 0.(d1 d2 ... dk) / 10^max(i, j)
10^max(i, j) / n = d1' d2' ... dm' + 0.(d1 d2 ... dk)
10^max(i, j) / n - floor(10^max(i, j) / n) = 0.(d1 d2 ... dk)

Assume p / q = 0.(d1 d2 ... dk), for the previous value of q we defined and
and some value of p. Notice that p / q = d1 d2 ... dk / 9 9 ... 9. Then
p | d1 d2 ... dk. Therefore 1 / q = (d1 d2 ... dk / p) / 9 9 ... 9. Thus we can
find the length of the repeated decimal of 1 / n, by finding the length of
1 / q.

Notice also that q | 9 9 ... 9 = 10^k - 1. Therefore 10^k = 1 (mod q), i.e. the
period is the smallest k for which 10^k = 1.

Definition
----------

If x, coprime to n, is a primitive root modulo n then phi(n) is the order of x, i.e.
it is the smallest number k such that x^k = 1 (mod n)

-------------------------------------------------------------------------------

Definition
----------

The Carmichael function l(n) is the smallest positive integer m such that for all
a coprime to n a^m = 1 (mod n).

-------------------------------------------------------------------------------

Therefore the period of any fraction is a divisor of l(q). Let's prove some properties
of the Carmichael function.

Lemma 1
-------

If n = p1^r1 * p2^r2 * ... * pk^rk, then:

l(n) = lcm(l(p1^r1), l(p2^r2), ... , l(pk^rk))

Proof:
------

Let wi = l(pi^ri), for i = 1, 2, ... , k. Therefore, for any integer a:

a^wi = 1 (mod pi^ri)

And each wi is the smallest number that satisfies this condition. Therefore
for any integer si:

a^(si * wi) - 1 = 0 (mod pi^ri)

And thus for some si we must have that:

a^(si * wi) - 1 = 0 (mod n)

Then to find the values for si such that:

s1 * w1 = s2 * w2 = ... = sk * wk =: t

and t is the smallest possible. Because all wi must be divisors of t,
then by definition t must be the lcm(w1, w2, ... , wn).

Lemma 2
-------

Let p be a prime. Then if d | p - 1, x^d - 1 has exactly d roots modulo n.

Proof:
------

By Euler's theorem theorem the polynomial x^(p - 1) - 1 has p - 1 distinct roots. Now let
e = (p - 1) / d. Then:

x^(p - 1) - 1 = x^(d * e) - 1
              = (x^d)^e - 1
              = (x^d - 1) * ((x^d)^(e - 1) + (x^d)^(e - 2) + ... + (x^d)^2 + (x^d) + 1)

Because (x^d)^(e - 1) + (x^d)^(e - 2) + ... + (x^d)^2 + (x^d) + 1 can have at most d * (e - 1)
roots, x^d - 1 can have at most d roots, and the product must have p - 1 roots, then x^d - 1 has:

p - 1 - d * (e - 1) = p - 1 - d * e + d = d

roots.

Lemma 3
-------

If p is prime then there is a primitive root modulo p.

Proof:
------

Factorize p - 1 as q1^k1 * q2^k2 * ... * qr^kr where each qi is a distinct prime. Then x^(qi^ki) - 1
has qi^ki distinct roots. Similarly, x^(qi^(ki - 1)) has qi^(ki - 1) distinct roots. Therefore there
are qi^ki - qi^(ki - 1) numbers of order qi^ki. Let ai be such a number and let a be a1 * a2 * ... * ar.
Therefore a cannot have order less than the least common denominator of all the qi^ki. Thus a has order
p - 1.

Lemma 4
-------

Let g be a primitive root modulo an odd prime p, such that g^(p - 1) != 1 (mod p^2).
Then g^phi(p^n) != 1 (mod p^(n + 1)).

Proof:
------

If n = 1, then the statement is true by hypothesis. Assume it is true for 1, 2, ... , n.
By Euler's theorem g^phi(p^n) = 1 + m * p^n, for some m. Since phi(p^(n + 1)) = phi(p^n) * p,
then we have that:

g^phi(p^(n + 1)) = (g^phi(p^n))^p
                 = (1 + m * p^n)^p
                 = 1 + p * m * p^n + p * (p - 1) / 2 * m^2 * p^(2 * n) + ...
                 = 1 + m * p^(n + 1) (mod p^(n + 2))

Because g^phi(p^n) != 1 (mod p^(n + 1)), then p does not divide m. Therefore:

g^phi(p^(n + 1)) = 1 + m * p^(n + 1) != 1 (mod p^(n + 2))

as desired.

Lemma 5
-------

There exists a primitive root modulo p^n, where p is an odd prime. In fact, if g is
a primitive root modulo p, then either g or g + p is a primitive root modulo p^n.

Proof:
------

Let g^(p - 1) != (mod p^2). Then let's prove by induction that the order of g modulo
p^n is phi(p^n). By hypothesis, this is the case for n = 1. Assume the statement to
be true for 1, 2, ... , n. Let the order of g modulo p^(n + 1) to be m. Then, by Euler's
theorem, m | phi(p^(n + 1)) = p^n * (p - 1). Also, g^m = 1 (mod p^(n + 1)) implies
g^m = 1 (mod p^n). Therefore p^(n - 1) * (p - 1) = phi(p^n) | m. Therefore m is either
phi(p^n) or phi(p^(n + 1)). By Lemma 4, we have that m = phi(p^(n + 1)). Thus the statement
is true for n + 1.

Now if g^(p - 1) = 1 (mod p^2), then:

(g + p)^(p - 1) = g^(p - 1) + (p - 1) * g^(p - 2) * p
                = 1 - g^(p - 2) * p != 1 (mod p^2)

the same argument as before but applied to g + p proves our result.

Lemma 6
-------

Let p be a prime number with p > 2 and n = p^r. Then:

l(n) = phi(p^r)

If n = 2^r, then, if r <= 2:

l(n) = phi(p^r)

otherwise (r > 2):

l(n) = 1/2 * phi(p^r)

where phi is the Euler's totient function.

Proof:
------

For p > 2, the result follows immediately from Lemma 5.

Let p = 2. The cases n = 2 and n = 4 are trivial to check. Let r > 2. Notice
that x^2 = 1 (mod 8) for all odd integers (the rest are not coprime to 2^r).
Let's prove that x^(2^(r - 2)) = 1 (mod 2^r). Assume that this is true for
r (we've already proven it true for r = 3). Then either:

x^(2^(r - 2)) = 1 (mod 2^(r + 1)) or x^(2^(r - 2)) = 1 + 2^r (mod 2^(r + 1))

Square both sides of both equations and we get the same result for each equality:

x^(2^(r - 1)) = 1 (mod 2^(r + 1))

This implies that l(n) | 2^(r - 2).

Assume by induction that x^(2^(r - 4)) = 1 (mod 2^(r - 2)) and
x^(2^(r - 3)) = 1 (mod 2^(r - 1)). Therefore x^(2^(r - 4)) != 1 (mod 2^(r - 1)),
which implies:

x^(2^(r - 4)) = 1 + 2^(r - 2) (mod 2^(r - 1))

Thus:

x^(2^(r - 4)) = 1 + 2^(r - 2) (mod 2^r) or x^(2^(r - 4)) = 1 + 2^(r - 2) + 2^(r - 1) (mod 2^r)

Squaring both results gives us:

x^(2^(r - 3)) = 1 + 2^(r - 1) != 1 (mod 2^r).

Therefore l(n) != 2^(r - 3). In particular l(n) cannot be smaller than 2^(r - 3),
otherwise at some point we would've gotten a 1 and repeated squarings of 1 yield 1.
Thus, l(n) < 2^(r - 3). Because l(n) | 2^(r - 2), then l(n) = 2^(r - 2).

-----------------------------------------------------------------------------------------

The strategy for this problem will be the following:

1. Factorize all numbers that are not multiples of 2 and 5 using a prime sieve.

2. A number's corresponding power r for a prime p is a value such that p^r divides it but
p^(r + 1) does not. Once we've found this power we need to use the multiplicative order of
10 modulo p^r and perform the lcm of that value with the corresponding accumulator for our
number.

3. The order of a number modulo a prime power p^r is a divisor of phi(p^r) = p^(r - 1) * (p - 1).
Therefore for each divisor d of phi(p^r), we can test whether d divides it and use the lowest value
we find that satisfies this condition.

4. Use the fact that if x^d = 1, then x^(d * e) = (x^d)^e = 1^e = 1 (mod n) to make the calculation
faster. Notice that phi(p^r) must be a multiple of the order. Therefore we can find the order by removing
prime factors from phi(p^r) until we are left with a number x such that b^x = 1 (mod n) but for any prime
factor p of x b^(x/p) != 1 (mod n).

=#

include("factorize.jl")

using Printf

function primeorder(base, prime, expo)
    moduli = prime^expo
    result = prime^(expo - 1) * (prime - 1)

    next = Factorize.get_next(result)
    while next !== nothing
        divisor_prime, divisor_expo, next_remaining = next
        for _ in 1:divisor_expo
            next_result = fld(result, divisor_prime)
            if powermod(base, next_result, moduli) != 1
                break
            end
            result = next_result
        end
        next = Factorize.get_next(next_remaining)
    end
    return result
end

function main()
    start = time()
    result = 0

    bound = 10^8
    slots = [k % 2 != 0 && k % 5 != 0 for k in 1:bound]
    slots[1] = false
    cycle_length = [1 for _ in 1:bound]
    cycle_length[1] = 0
    for k in 3:2:bound
        if slots[k]
            s = k
            for r::Int64 in 1:floor(log(k, bound))
                next_s = s * k
                order = primeorder(10, k, r)
                for t in s:s:bound
                    if r == 1
                        slots[t] = false
                    end
                    if t % 5 !== 0 && mod(t, next_s) != 0
                        cycle_length[t] = lcm(cycle_length[t], order)
                    end
                end
                s = next_s
            end
        end
    end

    for k in 3:bound
        q = k
        while q & 1 == 0
            q = q >> 1
        end
        while q % 5 == 0
            q = fld(q, 5)
        end
        result += cycle_length[q]
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
